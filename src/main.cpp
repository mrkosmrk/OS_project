#include "../h/_thread.hpp"
#include "../h/syscall_c.hpp"
#include "../h/_buffer.hpp"
#include "../h/console.h"
#define LEVEL_1_IMPLEMENTED 1
#define LEVEL_2_IMPLEMENTED 1
#define LEVEL_3_IMPLEMENTED 1
#define LEVEL_4_IMPLEMENTED 1

void userMain();

void fun(void*)
{
    while(1)
    {
        putc('c');
    }
}

void doNothing(void*)
{
    while(1)
    {
        thread_dispatch();
    }
}

void userMainThread(void*)
{
    userMain();
}

int main()
{
    /*
    thread_t threads[2];

    threads[0] = _thread::thread_create(&fun3, nullptr);
    threads[1] = _thread::thread_create(nullptr, nullptr);


    _thread::running = threads[1];

    __asm__ volatile("csrw stvec, %0" : : "r"(&interruptHandler));
    __asm__ volatile("csrs sstatus, %0" : : "r"(1 << 1));  // interrupt enable
    */

    thread_t thread = _thread::thread_create(nullptr, nullptr, false, true);
    _thread::running = thread;
    _thread::running->context.x[1] = 0;
    thread_t thread1 = _thread::thread_create(&userMainThread, nullptr, true, false);
    thread_t thread2 = _thread::thread_create(&doNothing, nullptr, true, false);
    (void)thread2;

    /*thread_t thread1 = _thread::thread_create(&fun, nullptr, true, false);
    (void)thread1;*/

    _buffer::putcBuffer = _buffer::buffer_create(1000);
    _buffer::getcBuffer = _buffer::buffer_create(1000);
    _thread::putcThread = _thread::thread_create(&__putcWrapper, nullptr, true, true);


    __asm__ volatile("csrw stvec, %0" : : "r"((size_t)(&interruptHandler) + 1)); // interrupt vector table
    __asm__ volatile("csrs sstatus, %0" : : "r"(1 << 1));  // interrupt enable


    thread_join(thread1);

    disable_interrupt();

    while (!_buffer::isEmpty(_buffer::putcBuffer) && _thread::putcThread->currentState == _thread::BLOCKED)
    {
        thread_dispatch();
    }


    return 0;
}