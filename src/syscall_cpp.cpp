#include "../h/syscall_cpp.hpp"
#include "../h/Scheduler.hpp"
#include "../h/syscall_c.hpp"


void* operator new (size_t size)
{
    return __mem_alloc(size);
}

void operator delete (void* ptr)
{
    __mem_free(ptr);
}

Thread::Thread(void (*body)(void *), void *arg)
{
    this->body = body;
    this->arg = arg;
}

Thread::~Thread()
{
    if (!myHandle->isFinished())
        thread_join(myHandle);
}

int Thread::start() {
    int res = thread_create(&myHandle, &runWrapper, this);
    if (res < 0)
        return res;
    return res;
}

void Thread::join()
{
    thread_join(myHandle);
}

void Thread::dispatch()
{
    thread_dispatch();
}

void Thread::run()
{
    if (body)
        body(arg);
}

Thread::Thread()
{
    body = nullptr;
    arg = nullptr;
}

int Thread::sleep(time_t t) {
    int res = time_sleep(t);
    return res;
}

void Thread::runWrapper(void *arg)
{
    Thread* thread = (Thread*)arg;
    if (!thread)
        return;
    thread->run();
}

Semaphore::Semaphore(unsigned int init)
{
    sem_open(&myHandle, init);
}

int Semaphore::wait()
{
    int res = sem_wait(myHandle);
    return res;
}

int Semaphore::signal()
{
    int res = sem_signal(myHandle);
    return res;
}

Semaphore::~Semaphore()
{
    sem_close(myHandle);
}


char Console::getc() {
    return ::getc();
}

void Console::putc(char c) {
    ::putc(c);
}

PeriodicThread::PeriodicThread(time_t period)
{
    flag = false;
    this->period = period;
}

void PeriodicThread::periodicActivation()
{

}

void PeriodicThread::run()
{
    disable_interrupt();
    flag = true;
    enable_interrupt();
    while (1)
    {
        disable_interrupt();
        if (!flag)
        {
            enable_interrupt();
            return;
        }
        enable_interrupt();
        periodicActivation();
        time_sleep(period);
    }
}

void PeriodicThread::terminate()
{
    disable_interrupt();
    flag = false;
    enable_interrupt();
}
