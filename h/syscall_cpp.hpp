#pragma once
#include "../lib/hw.h"


class _thread;
class _sem;


void* operator new (size_t);
void operator delete (void*);
class Thread {
public:
    typedef _thread* thread_t;

    Thread (void (*body)(void*), void* arg);
    virtual ~Thread ();
    int start ();
    void join();
    static void dispatch ();
    static int sleep (time_t);

    static void runWrapper(void*);
protected:
    Thread ();
    virtual void run ();

private:
    thread_t myHandle;
    void (*body)(void*); void* arg;

};

class Semaphore {
public:
    typedef _sem* sem_t;

    Semaphore (unsigned init = 1);
    virtual ~Semaphore ();
    int wait ();
    int signal ();
private:
    sem_t myHandle;
};

class PeriodicThread : public Thread {
public:
    void terminate ();
protected:
    PeriodicThread (time_t period);
    virtual void periodicActivation ();
private:
    void run() override;

    time_t period;
    bool flag;
};

class Console {
public:
    static char getc ();
    static void putc (char c);
};