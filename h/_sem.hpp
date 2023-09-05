#pragma once
#include "List.hpp"
#include "_thread.hpp"

class _sem;
typedef _sem* sem_t;

class _sem {
public:

    static sem_t semaphore_create(unsigned init);

    static int close(sem_t semaphore, _thread::semReturnValue returnValue);

    static int wait(sem_t semaphore);

    static int signal(sem_t semaphore);

private:

    int value;
    List<_thread>* blocked;
};
