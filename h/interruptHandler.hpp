#pragma once

#ifdef __cplusplus
extern "C"
{
#endif

    void handle(...);

    void ecall_handler();

    void timer_handler();

    void console_handler();

    void interruptHandler();

    void other_handler();

#ifdef __cplusplus
}
#endif