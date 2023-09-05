#include "../lib/hw.h"
#include "../h/MemoryAllocator.hpp"
#include "../h/_thread.hpp"
#include "../h/console.h"
#include "../h/_sem.hpp"
#include "../h/_buffer.hpp"


enum sys_call {
    MEM_ALLOC = 0x01,
    MEM_FREE = 0x02,
    THREAD_CREATE = 0x11,
    THREAD_EXIT = 0x12,
    THREAD_DISPATCH = 0x13,
    THREAD_JOIN = 0x14,
    SEM_OPEN = 0x21,
    SEM_CLOSE = 0x22,
    SEM_WAIT = 0x23,
    SEM_SIGNAL = 0x24,
    SLEEP = 0x31,
    GETC = 0x41,
    PUTC = 0x42,
    DISABLE_INTERRUPT = 0x60,
    ENABLE_INTERRUPT = 0x61
};

inline void setSEPC()
{
    uint64 sepc;
    __asm__ volatile("csrr %0, sepc" : "=r"(sepc));
    sepc += 4;
    __asm__ volatile("csrw sepc, %0" : : "r"(sepc));
}

#ifdef __cplusplus
extern "C"
#endif
void ecall_handler()
{
    uint64 volatile a0, a1, a2, a3;
    __asm__ volatile("mv %0, a0" : "=r"(a0));
    __asm__ volatile("mv %0, a1" : "=r"(a1));
    __asm__ volatile("mv %0, a2" : "=r"(a2));
    __asm__ volatile("mv %0, a3" : "=r"(a3));
    uint64 scause;
    __asm__ volatile("csrr %0, scause": "=r"(scause));
    if (scause == 0x0000000000000008UL || scause == 0x0000000000000009UL)
    {
        uint64 sys_callID;
        __asm__ volatile("mv %0, a0" : "=r"(sys_callID));
        if (sys_callID == MEM_ALLOC)
        {
            uint64 size = a1;

            uint64 sepc;
            __asm__ volatile("csrr %0, sepc" : "=r"(sepc));
            sepc += 4;
            __asm__ volatile("csrw sepc, %0" : : "r"(sepc));

            void* ptr = MemoryAllocator::__get_instance()->__mem_alloc(size);
            (void)ptr;    // to remove warning "unused variable ptr"
            __asm__ volatile("sd a0, 10 * 8(fp)");  // this is good because compiler sets fp to beginning of stack frame
        }
        else if (sys_callID == MEM_FREE)
        {
            void* ptr = (void*)a1;

            setSEPC();

            int res = MemoryAllocator::__get_instance()->__mem_free(ptr);
            (void)res;
            __asm__ volatile("sd a0, 10 * 8(fp)");
        }
        else if (sys_callID == THREAD_CREATE)
        {
            thread_t* handle = (thread_t*)a1;
            _thread::Body routine = (_thread::Body)a2;
            void* arg = (void*)a3;

            setSEPC();

            *handle = _thread::thread_create((_thread::Body)routine, arg, true, false);
            int res = 0;
            (void)res;
            if (!(*handle))
                res = -1;

            __asm__ volatile("mv a0, %0": : "r"(res));
            __asm__ volatile("sd a0, 10 * 8(fp)");
        }
        else if (sys_callID == THREAD_DISPATCH)
        {
            setSEPC();

            _thread::dispatch();
        }
        else if (sys_callID == THREAD_JOIN)
        {
            setSEPC();

            thread_t thread = (thread_t)a1;
            _thread::thread_join(thread);
        }
        else if (sys_callID == THREAD_EXIT)
        {
            setSEPC();

            int res = _thread::thread_exit();
            (void)res;
            __asm__ volatile("sd a0, 10 * 8(fp)");
        }
        else if (sys_callID == SEM_OPEN)
        {
            setSEPC();

            sem_t* semaphore = (sem_t*)a1;
            uint64 init = a2;
            *semaphore = _sem::semaphore_create(init);
            int res = 0;
            (void)res;
            if (!(*semaphore))
                res = -1;
            __asm__ volatile("mv a0, %0": : "r"(res));
            __asm__ volatile("sd a0, 10 * 8(fp)");
        }
        else if (sys_callID == SEM_CLOSE)
        {
            setSEPC();

            sem_t semaphore = (sem_t)a1;
            int res = _sem::close(semaphore, _thread::SEMCLOSED);
            (void)res;
            __asm__ volatile("sd a0, 10 * 8(fp)");
        }
        else if (sys_callID == SEM_WAIT)
        {
            setSEPC();

            sem_t semaphore = (sem_t)a1;
            int res = _sem::wait(semaphore);
            (void)res;
            __asm__ volatile("sd a0, 10 * 8(fp)");
        }
        else if (sys_callID == SEM_SIGNAL)
        {
            setSEPC();

            sem_t semaphore = (sem_t)a1;
            int res = _sem::signal(semaphore);
            (void)res;
            __asm__ volatile("sd a0, 10 * 8(fp)");
        }
        else if (sys_callID == SLEEP)
        {
            setSEPC();

            time_t t = (time_t)a1;
            int res = _thread::thread_sleep(t);
            (void)res;
            __asm__ volatile("sd a0, 10 * 8(fp)");
        }
        else if (sys_callID == GETC)
        {
            setSEPC();

            char c = _buffer::consume(_buffer::getcBuffer, true);
            (void)c;
            __asm__ volatile("sd a0, 10 * 8(fp)");
        }
        else if (sys_callID == PUTC)
        {
            setSEPC();

            char c = (char)a1;
            _buffer::produce(_buffer::putcBuffer, c, true);
        }
        else if (sys_callID == DISABLE_INTERRUPT)
        {
            setSEPC();

            uint64 volatile sstatus;
            __asm__ volatile("csrr %0, sstatus" : "=r"(sstatus));
            sstatus &= ~(1ULL << 5);
            __asm__ volatile("csrw sstatus, %0" : : "r"(sstatus));
        }
        else if (sys_callID == ENABLE_INTERRUPT)
        {
            setSEPC();

            uint64 volatile sstatus;
            __asm__ volatile("csrr %0, sstatus" : "=r"(sstatus));
            sstatus |= (1ULL << 5);
            __asm__ volatile("csrw sstatus, %0" : : "r"(sstatus));
        }
    }
}

#ifdef __cplusplus
extern "C"
#endif
void timer_handler()
{
    uint64 scause;
    __asm__ volatile("csrr %0, scause": "=r"(scause));
    if (scause == 0x8000000000000001)
    {
        ++_thread::timeCounter;
        ++_thread::relativeSleepTimer;
        _thread::thread_wake();
        uint64 sip;
        __asm__ volatile("csrr %0, sip": "=r"(sip));
        sip &= ~(1ULL << 1);
        __asm__ volatile("csrw sip, %0": : "r"(sip));
        if (_thread::timeCounter >= DEFAULT_TIME_SLICE)
        {
            _thread::timeCounter = 0;
            _thread::dispatch();
        }
    }
}


#ifdef __cplusplus
extern "C"
#endif
void console_handler()
{
    uint64 sip;
    __asm__ volatile("csrr %0, sip": "=r"(sip));
    sip &= ~(1ULL << 9);
    __asm__ volatile("csrw sip, %0": : "r"(sip));
    uint64 scause;
    __asm__ volatile("csrr %0, scause": "=r"(scause));
    if (scause == 0x8000000000000009)
    {
        int irq = plic_claim();
        if (irq != CONSOLE_IRQ)
        {
            plic_complete(irq);
            return;
        }
        while (!_buffer::isFull(_buffer::getcBuffer) && ((*((char*)CONSOLE_STATUS)) & CONSOLE_RX_STATUS_BIT))
        {
            char c = *((char*)CONSOLE_RX_DATA);
            if(c != 0)
                _buffer::produce(_buffer::getcBuffer, c, true);
        }
        if (!_buffer::isFull(_buffer::getcBuffer))
            plic_complete(CONSOLE_IRQ);
    }
}


#ifdef __cplusplus
extern "C"
#endif
void __ecall_interrupt(int sys_call_id, ...)
{
    __asm__ volatile ("ecall");
}

#ifdef __cplusplus
extern "C"
#endif
void* __mem_alloc(size_t size)
{
    int numOfBlocks = (size + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE;

    void* ptr;
    __ecall_interrupt(MEM_ALLOC, numOfBlocks);
    __asm__ volatile("mv %0, a0": "=r"((uint64)ptr));
    return ptr;
}

#ifdef __cplusplus
extern "C"
#endif
int __mem_free(void* ptr)
{
    __ecall_interrupt(MEM_FREE, ptr);

    uint64 res;
    __asm__ volatile("mv %0, a0": "=r"(res));
    return res;
}

#ifdef __cplusplus
extern "C"
#endif
int thread_create(thread_t* handle, _thread::Body routine, void*arg)
{
    __ecall_interrupt(THREAD_CREATE, handle, routine, arg);

    uint64 res;
    __asm__ volatile("mv %0, a0": "=r"(res));
    return (int)res;
}

#ifdef __cplusplus
extern "C"
#endif
void thread_dispatch()
{
    __ecall_interrupt(THREAD_DISPATCH);
}

#ifdef __cplusplus
extern "C"
#endif
int thread_exit()
{
    __ecall_interrupt(THREAD_EXIT);

    uint64 res;
    __asm__ volatile("mv %0, a0": "=r"(res));
    return (int)res;
}

#ifdef __cplusplus
extern "C"
#endif
int sem_open(sem_t* handle, unsigned init)
{
    __ecall_interrupt(SEM_OPEN, handle, init);
    uint64 res;
    __asm__ volatile("mv %0, a0": "=r"(res));
    return (int)res;
}

#ifdef __cplusplus
extern "C"
#endif
int sem_close (sem_t handle)
{
    __ecall_interrupt(SEM_CLOSE, handle);
    uint64 res;
    __asm__ volatile("mv %0, a0": "=r"(res));
    return (int)res;
}

#ifdef __cplusplus
extern "C"
#endif
int sem_wait (sem_t handle)
{
    __ecall_interrupt(SEM_WAIT, handle);

    uint64 res;
    __asm__ volatile("mv %0, a0": "=r"(res));
    return (int)res;
}

#ifdef __cplusplus
extern "C"
#endif
int sem_signal (sem_t handle)
{
    __ecall_interrupt(SEM_SIGNAL, handle);
    uint64 res;
    __asm__ volatile("mv %0, a0": "=r"(res));
    return (int)res;
}

#ifdef __cplusplus
extern "C"
#endif
void thread_join(thread_t handle)
{
    __ecall_interrupt(THREAD_JOIN, handle);
}

#ifdef __cplusplus
extern "C"
#endif
void putc(char chr)
{
    __ecall_interrupt(PUTC, chr);
}

#ifdef __cplusplus
extern "C"
#endif
char getc()
{
    __ecall_interrupt(GETC);

    uint64 res;
    __asm__ volatile("mv %0, a0": "=r"(res));
    return (char)res;
}

#ifdef __cplusplus
extern "C"
#endif
int time_sleep(time_t t)
{
    if (t == 0)
        return 0;
    __ecall_interrupt(SLEEP, t);

    uint64 res;
    __asm__ volatile("mv %0, a0": "=r"(res));
    return (int)res;
}

#ifdef __cplusplus
extern "C"
#endif
void disable_interrupt()
{
    __ecall_interrupt(DISABLE_INTERRUPT);
}

#ifdef __cplusplus
extern "C"
#endif
void enable_interrupt()
{
    __ecall_interrupt(ENABLE_INTERRUPT);
}

