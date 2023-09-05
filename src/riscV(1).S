
#Thread::contextSwitch
.global _ZN7_thread13contextSwitchEPNS_7ContextES1_Pv
.type _ZN7_thread13contextSwitchEPNS_7ContextES1_Pv, @function
_ZN7_thread13contextSwitchEPNS_7ContextES1_Pv:
    .irp index 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(a0)
    .endr
    sd sp, 0 * 8(a0)
    csrr a3, sepc
    sd a3, 32 * 8(a0)
    csrr a3, sstatus
    sd a3, 33 * 8(a0)

    .irp index 1, 3, 4, 5, 6, 7, 8, 9, 10, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ld x\index, \index * 8(a1)
    .endr
    ld sp, (a2)
    ld a3, 32 * 8(a1)
    csrw sepc, a3
    ld a3, 33 * 8(a1)
    csrw sstatus, a3
    ld x12, 12 * 8(a1)
    ld a1, 11 * 8(a1)
    ret


