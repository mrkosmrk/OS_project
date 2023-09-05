#include "../h/Scheduler.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../h/_thread.hpp"
#include "../h/List.hpp"
#include "../h/_sem.hpp"
#include "../h/syscall_c.hpp"

thread_t _thread::running = nullptr;
time_t _thread::timeCounter = 0;
List<_thread::SleepingThread>* _thread::sleepingThreads = nullptr;
time_t _thread::relativeSleepTimer = 0;
thread_t _thread::putcThread = nullptr;


void _thread::dispatch()
{
    thread_t old = running;
    if (running->currentState == ACTIVE)
        running->currentState = READY;
    if (running->currentState != BLOCKED && !running->finished)
        Scheduler::put(running);
    running = Scheduler::get();
    running->currentState = ACTIVE;
    void* stack = (void*)(&running->context.x[0]);
    if (running->context.x[1] == (uint64)(&threadWrapper) && running->body)
    {
        __asm__ volatile("csrr %0, sstatus" : "=r"(running->context.x[33]));
        stack = (void*)(&running->context.x[2]);
    }
    contextSwitch(&old->context, &running->context, stack);
}


void _thread::threadWrapper()
{
    __asm__ volatile("mv ra, x0");
    setNewThread();
    if (running->body)
        running->body(running->arguments);
    ::thread_exit();
}


void _thread::setNewThread()
{
    if (!running->isKernelThread)
    {
        uint64 sstatus;
        __asm__ volatile("csrr %0, sstatus": "=r"(sstatus));
        sstatus &= ~(1ULL << 8);
        sstatus |= (1ULL << 5);
        __asm__ volatile("csrw sstatus, %0": : "r"(sstatus));
    }
    else
    {
        uint64 sstatus;
        __asm__ volatile("csrr %0, sstatus": "=r"(sstatus));
        sstatus |= (1ULL << 5);
        sstatus |= (1ULL << 8);
        __asm__ volatile("csrw sstatus, %0": : "r"(sstatus));
    }
    __asm__ volatile("csrw sepc, ra");
    __asm__ volatile("sret");
}


bool _thread::isFinished()
{
    return finished;
}


thread_t _thread::thread_create(Body routine, void *arg, bool start, bool isKernelThread)
{
    thread_t thread = (thread_t)MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(sizeof(_thread)));

    if (!thread)
        return nullptr;

    thread->stack = routine ? (uint64*)MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(DEFAULT_STACK_SIZE)) : 0;  // check if thread is main
    thread->kernelStack = (uint64*) MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(DEFAULT_STACK_SIZE));
    thread->finished = false;
    thread->body = routine;
    for(int i = 0; i < 34; ++i)
        thread->context.x[i] = 0;
    thread->context.x[2] = (uint64)thread->stack + DEFAULT_STACK_SIZE - (((size_t)thread->stack + DEFAULT_STACK_SIZE) % 16);
    thread->context.x[0] = (size_t)thread->kernelStack + DEFAULT_STACK_SIZE - (((size_t)thread->kernelStack + DEFAULT_STACK_SIZE) % 16);
    thread->context.x[1] = (uint64)(&threadWrapper);
    thread->arguments = arg;
    if (routine && start)
        thread->currentState = READY;
    else if (routine && !start)
        thread->currentState = BLOCKED;
    else if (!routine)
        thread->currentState = ACTIVE;

    if (!sleepingThreads)
    {
        sleepingThreads = List<SleepingThread>::list_create();
        if (!sleepingThreads)
            return nullptr;
    }

    if (routine)
        thread->threadsToActivate = _sem::semaphore_create(0);

    thread->isKernelThread = isKernelThread;

    if (start)
    {
        int res = Scheduler::put(thread);
        if (res < 0)
            return nullptr;
    }

    return thread;

}


int _thread::thread_exit()
{
    running->finished = true;
    if (running->body == nullptr)
        return -1;
    int res;
    res = MemoryAllocator::__get_instance()->__mem_free(running->stack);
    if (res < 0)
        return -1;
    res = MemoryAllocator::__get_instance()->__mem_free(running->kernelStack);
    if (res < 0)
        return -1;

    res = _sem::close(running->threadsToActivate, ZERO);
    if (res < 0)
        return -1;
    running->currentState = BLOCKED;
    dispatch();

    return 0;
}

void _thread::thread_join(thread_t thread)
{
    _sem::wait(thread->threadsToActivate);
}

bool _thread::cmpSleepingThreads(_thread::SleepingThread *threadInList, _thread::SleepingThread *threadToAdd)
{
    if (threadInList->sleepingTime  <= threadToAdd->sleepingTime)
        return true;
    return false;
}

int _thread::thread_sleep(time_t t)
{
    SleepingThread* newSleepingThread = (SleepingThread*)MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(sizeof(SleepingThread)));
    if (!newSleepingThread)
        return -1;
    newSleepingThread->thread = running;
    newSleepingThread->sleepingTime = t + relativeSleepTimer;
    int res = sleepingThreads->putInOrder(&cmpSleepingThreads, newSleepingThread);
    if (res < 0)
        return -2;
    running->currentState = BLOCKED;
    dispatch();

    return 0;
}

void _thread::thread_wake()
{
    if (sleepingThreads->empty())
        return;
    SleepingThread* head = sleepingThreads->peek();
    if (head->sleepingTime == relativeSleepTimer)
    {
        while (!(sleepingThreads->empty()) && sleepingThreads->peek()->sleepingTime == relativeSleepTimer)
        {
            SleepingThread* awakeThread = sleepingThreads->get();
            awakeThread->thread->currentState = READY;
            Scheduler::put(awakeThread->thread);
        }
        for(sleepingThreads->setBegin(); !sleepingThreads->isEnd(); sleepingThreads->nextElem())
        {
            SleepingThread* t = sleepingThreads->getCurrent();
            t->sleepingTime -= relativeSleepTimer;
        }
        relativeSleepTimer = 0;
    }
}

void _thread::thread_block()
{
    _thread::running->currentState = BLOCKED;
    dispatch();
}


















