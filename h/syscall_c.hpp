#pragma once
#include "../lib/hw.h"
#include "_thread.hpp"
#include "_sem.hpp"

#ifdef __cplusplus
extern "C"
{
#endif

    void __ecall_interrupt(int sys_call_id, ...);

    void* __mem_alloc(size_t size);

    int __mem_free(void* ptr);

    int thread_create(thread_t* handle, _thread::Body routine, void*arg);

    int thread_create_only(thread_t* handle, _thread::Body routine, void*arg);

    int thread_create_kernel(thread_t* handle, _thread::Body routine, void*arg);

    void thread_dispatch();

    int thread_exit();

    void thread_join(thread_t handle);

    int sem_open(sem_t* handle, unsigned init);

    int sem_close(sem_t handle);

    int sem_wait(sem_t id);

    int sem_signal(sem_t id);

    int time_sleep(time_t t);

    void putc(char chr);

    void disable_interrupt();

    void enable_interrupt();

    char getc();


#ifdef __cplusplus
}
#endif
