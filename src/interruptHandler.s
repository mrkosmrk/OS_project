# 1 "src/interruptHandler.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 31 "<command-line>"
# 1 "/usr/riscv64-linux-gnu/include/stdc-predef.h" 1 3
# 32 "<command-line>" 2
# 1 "src/interruptHandler.S"
.extern ecall_handler
.extern timer_handler
.extern console_handler
.extern _ZN7_thread7runningE

.align 4
.global interruptHandler
.type interruptHandler, @function
interruptHandler:
    j ecall_interrupt
    j timer_interrupt
    j other_interrupt
    j other_interrupt
    j other_interrupt
    j other_interrupt
    j other_interrupt
    j other_interrupt
    j other_interrupt
    j console_interrupt
    sret

.global ecall_interrupt
.type ecall_interrupt, @function
ecall_interrupt:
    csrw sscratch, s0
    ld s0, _ZN7_thread7runningE
    sd sp, 16(s0)
    ld sp, 0(s0)
    csrr s0, sscratch

    addi sp, sp, -256
    .irp index 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(sp)
    .endr

    call ecall_handler

    .irp index 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ld x\index, \index * 8(sp)
    .endr
    addi sp, sp, 256

    csrw sscratch, s0
    ld s0, _ZN7_thread7runningE
    sd sp, 0(s0)
    ld sp, 16(s0)
    csrr s0, sscratch

    sret

.global timer_interrupt
.type timer_interrupt, @function
timer_interrupt:
    csrw sscratch, s0
    ld s0, _ZN7_thread7runningE
    sd sp, 16(s0)
    ld sp, 0(s0)
    csrr s0, sscratch

    addi sp, sp, -256
    .irp index 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(sp)
    .endr

    call timer_handler

    .irp index 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ld x\index, \index * 8(sp)
    .endr
    addi sp, sp, 256

    csrw sscratch, s0
    ld s0, _ZN7_thread7runningE
    sd sp, 0(s0)
    ld sp, 16(s0)
    csrr s0, sscratch

    sret


.global console_interrupt
.type console_interrupt, @function
console_interrupt:
    csrw sscratch, s0
    ld s0, _ZN7_thread7runningE
    sd sp, 16(s0)
    ld sp, 0(s0)
    csrr s0, sscratch

    addi sp, sp, -256
    .irp index 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(sp)
    .endr

    call console_handler

    .irp index 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ld x\index, \index * 8(sp)
    .endr
    addi sp, sp, 256

    csrw sscratch, s0
    ld s0, _ZN7_thread7runningE
    sd sp, 0(s0)
    ld sp, 16(s0)
    csrr s0, sscratch

    sret

.global other_interrupt
.type other_interrupt, @function
other_interrupt:
    sret
