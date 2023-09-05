#include "../h/console.h"
#include "../h/_buffer.hpp"
#include "../lib/hw.h"
#include "../h/Scheduler.hpp"
#include "../h/syscall_c.hpp"

#ifdef __cplusplus
extern "C"
#endif
void __putc(char chr)
{
    while (1)
    {
        __asm__ volatile("li a0, 2");
        __asm__ volatile ("csrc sstatus, a0");
        uint64 volatile statusReg = (uint64)(*((char*)CONSOLE_STATUS));
        __asm__ volatile("li a0, 2");
        __asm__ volatile ("csrs sstatus, a0");
        if (statusReg & CONSOLE_TX_STATUS_BIT)
        {
            char volatile c = _buffer::consume(_buffer::putcBuffer, false);
            __asm__ volatile("li a0, 2");
            __asm__ volatile ("csrc sstatus, a0");
            if (c == '\r')
                c = '\n';
            *((char*)CONSOLE_TX_DATA) = c;
            __asm__ volatile("li a0, 2");
            __asm__ volatile ("csrs sstatus, a0");
        }
    }
}


#ifdef __cplusplus
extern "C"
#endif
void __putcWrapper(void*)
{
    __putc(0);
}