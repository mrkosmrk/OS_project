#pragma once
#include "../lib/hw.h"
#include "interruptHandler.hpp"
#include "console.h"
#include "Scheduler.hpp"

class _sem;
typedef _sem* sem_t;
class _thread;
template<class _thread> class List;
typedef _thread* thread_t;


class _thread {
public:
    enum semReturnValue {ZERO, SEMCLOSED};

    enum threadState {ACTIVE, READY, BLOCKED};

    struct Context
    {
        uint64 x[34]; // x[0] - kernel stack pointer, x[32] - sepc, x[33] - sstatus
    };

    struct SleepingThread {
        thread_t thread;
        time_t sleepingTime;
    };

    using Body = void (*) (void*);

    static thread_t thread_create(Body body, void* arg, bool start, bool isKernelThread);

    static int thread_exit();

    static void thread_join(thread_t thread);

    static int thread_sleep(time_t t);

    static void thread_wake();

    static bool cmpSleepingThreads(SleepingThread* threadInList, SleepingThread* threadToAdd);

    static void thread_block();

    bool isFinished();

    static thread_t running;

    static thread_t putcThread;

private:

    Context context;
    uint64 *stack;
    uint64 *kernelStack;
    bool finished;
    Body body;
    void* arguments;
    semReturnValue state;
    threadState currentState;
    sem_t threadsToActivate;
    bool isKernelThread;

    static List<SleepingThread>* sleepingThreads;

    static time_t timeCounter;

    static time_t relativeSleepTimer;

    static void threadWrapper();

    static void setNewThread();

    static void dispatch();

    static void contextSwitch(Context* oldContext, Context* newContext, void* sp);


    friend void ecall_handler();
    friend void timer_handler();
    friend void interruptHandler();
    friend class _sem;
    friend int main();
    friend int Scheduler::put(thread_t);


};

