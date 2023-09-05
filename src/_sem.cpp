#include "../h/_sem.hpp"
#include "../h/Scheduler.hpp"
#include "../h/_thread.hpp"

sem_t _sem::semaphore_create(unsigned init) {
    sem_t semaphore = (sem_t)MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(sizeof(_sem)));
    if (!semaphore)
        return nullptr;

    semaphore->value = (int)init;
    semaphore->blocked = List<_thread>::list_create();
    if (!semaphore->blocked)
        return nullptr;

    return semaphore;
}

int _sem::close(sem_t semaphore, _thread::semReturnValue returnValue) {
    while (!semaphore->blocked->empty())
    {
        thread_t thread = semaphore->blocked->get();
        if (!thread)
            return -1;
        thread->currentState = _thread::READY;
        thread->state = returnValue;
        int res = Scheduler::put(thread);
        if (res < 0)
            return -2;
    }
    int res = MemoryAllocator::__get_instance()->__mem_free(semaphore);
    if (res < 0)
        return -3;

    return 0;
}

int _sem::wait(sem_t semaphore) {
    _thread::running->state = _thread::ZERO;
    --semaphore->value;
    if (semaphore->value < 0)
    {
        _thread::running->currentState = _thread::BLOCKED;
        int res = semaphore->blocked->put(_thread::running);
        if (res < 0)
            return -1;
        _thread::dispatch();
    }
    if (_thread::running->state == _thread::SEMCLOSED)
        return -2;

    return 0;
}

int _sem::signal(sem_t semaphore) {
    ++semaphore->value;
    if (semaphore->value <= 0 && !semaphore->blocked->empty()) {
        thread_t thread = semaphore->blocked->get();
        thread->currentState = _thread::READY;
        int res = Scheduler::put(thread);
        if (res < 0)
            return -1;
    }

    return 0;
}

