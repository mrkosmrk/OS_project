
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000d117          	auipc	sp,0xd
    80000004:	9d013103          	ld	sp,-1584(sp) # 8000c9d0 <_GLOBAL_OFFSET_TABLE_+0x38>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	270070ef          	jal	ra,8000728c <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001004:	00b29a63          	bne	t0,a1,80001018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000100c:	fe029ae3          	bnez	t0,80001000 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001010:	00000513          	li	a0,0
    jr ra                  # Return.
    80001014:	00008067          	ret

0000000080001018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001018:	00100513          	li	a0,1
    8000101c:	00008067          	ret

0000000080001020 <interruptHandler>:

.align 4
.global interruptHandler
.type interruptHandler, @function
interruptHandler:
    j ecall_interrupt
    80001020:	02c0006f          	j	8000104c <ecall_interrupt>
    j timer_interrupt
    80001024:	1580006f          	j	8000117c <timer_interrupt>
    j other_interrupt
    80001028:	3b40006f          	j	800013dc <other_interrupt>
    j other_interrupt
    8000102c:	3b00006f          	j	800013dc <other_interrupt>
    j other_interrupt
    80001030:	3ac0006f          	j	800013dc <other_interrupt>
    j other_interrupt
    80001034:	3a80006f          	j	800013dc <other_interrupt>
    j other_interrupt
    80001038:	3a40006f          	j	800013dc <other_interrupt>
    j other_interrupt
    8000103c:	3a00006f          	j	800013dc <other_interrupt>
    j other_interrupt
    80001040:	39c0006f          	j	800013dc <other_interrupt>
    j console_interrupt
    80001044:	2680006f          	j	800012ac <console_interrupt>
    sret
    80001048:	10200073          	sret

000000008000104c <ecall_interrupt>:

.global ecall_interrupt
.type ecall_interrupt, @function
ecall_interrupt:
    csrw sscratch, s0
    8000104c:	14041073          	csrw	sscratch,s0
    ld s0, _ZN7_thread7runningE
    80001050:	0000c417          	auipc	s0,0xc
    80001054:	a1043403          	ld	s0,-1520(s0) # 8000ca60 <_ZN7_thread7runningE>
    sd sp, 16(s0)
    80001058:	00243823          	sd	sp,16(s0)
    ld sp, 0(s0)
    8000105c:	00043103          	ld	sp,0(s0)
    csrr s0, sscratch
    80001060:	14002473          	csrr	s0,sscratch

    addi sp, sp, -256
    80001064:	f0010113          	addi	sp,sp,-256
    .irp index 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(sp)
    .endr
    80001068:	00113423          	sd	ra,8(sp)
    8000106c:	00313c23          	sd	gp,24(sp)
    80001070:	02413023          	sd	tp,32(sp)
    80001074:	02513423          	sd	t0,40(sp)
    80001078:	02613823          	sd	t1,48(sp)
    8000107c:	02713c23          	sd	t2,56(sp)
    80001080:	04813023          	sd	s0,64(sp)
    80001084:	04913423          	sd	s1,72(sp)
    80001088:	04a13823          	sd	a0,80(sp)
    8000108c:	04b13c23          	sd	a1,88(sp)
    80001090:	06c13023          	sd	a2,96(sp)
    80001094:	06d13423          	sd	a3,104(sp)
    80001098:	06e13823          	sd	a4,112(sp)
    8000109c:	06f13c23          	sd	a5,120(sp)
    800010a0:	09013023          	sd	a6,128(sp)
    800010a4:	09113423          	sd	a7,136(sp)
    800010a8:	09213823          	sd	s2,144(sp)
    800010ac:	09313c23          	sd	s3,152(sp)
    800010b0:	0b413023          	sd	s4,160(sp)
    800010b4:	0b513423          	sd	s5,168(sp)
    800010b8:	0b613823          	sd	s6,176(sp)
    800010bc:	0b713c23          	sd	s7,184(sp)
    800010c0:	0d813023          	sd	s8,192(sp)
    800010c4:	0d913423          	sd	s9,200(sp)
    800010c8:	0da13823          	sd	s10,208(sp)
    800010cc:	0db13c23          	sd	s11,216(sp)
    800010d0:	0fc13023          	sd	t3,224(sp)
    800010d4:	0fd13423          	sd	t4,232(sp)
    800010d8:	0fe13823          	sd	t5,240(sp)
    800010dc:	0ff13c23          	sd	t6,248(sp)

    call ecall_handler
    800010e0:	424000ef          	jal	ra,80001504 <ecall_handler>

    .irp index 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ld x\index, \index * 8(sp)
    .endr
    800010e4:	00813083          	ld	ra,8(sp)
    800010e8:	01813183          	ld	gp,24(sp)
    800010ec:	02013203          	ld	tp,32(sp)
    800010f0:	02813283          	ld	t0,40(sp)
    800010f4:	03013303          	ld	t1,48(sp)
    800010f8:	03813383          	ld	t2,56(sp)
    800010fc:	04013403          	ld	s0,64(sp)
    80001100:	04813483          	ld	s1,72(sp)
    80001104:	05013503          	ld	a0,80(sp)
    80001108:	05813583          	ld	a1,88(sp)
    8000110c:	06013603          	ld	a2,96(sp)
    80001110:	06813683          	ld	a3,104(sp)
    80001114:	07013703          	ld	a4,112(sp)
    80001118:	07813783          	ld	a5,120(sp)
    8000111c:	08013803          	ld	a6,128(sp)
    80001120:	08813883          	ld	a7,136(sp)
    80001124:	09013903          	ld	s2,144(sp)
    80001128:	09813983          	ld	s3,152(sp)
    8000112c:	0a013a03          	ld	s4,160(sp)
    80001130:	0a813a83          	ld	s5,168(sp)
    80001134:	0b013b03          	ld	s6,176(sp)
    80001138:	0b813b83          	ld	s7,184(sp)
    8000113c:	0c013c03          	ld	s8,192(sp)
    80001140:	0c813c83          	ld	s9,200(sp)
    80001144:	0d013d03          	ld	s10,208(sp)
    80001148:	0d813d83          	ld	s11,216(sp)
    8000114c:	0e013e03          	ld	t3,224(sp)
    80001150:	0e813e83          	ld	t4,232(sp)
    80001154:	0f013f03          	ld	t5,240(sp)
    80001158:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    8000115c:	10010113          	addi	sp,sp,256

    csrw sscratch, s0
    80001160:	14041073          	csrw	sscratch,s0
    ld s0, _ZN7_thread7runningE
    80001164:	0000c417          	auipc	s0,0xc
    80001168:	8fc43403          	ld	s0,-1796(s0) # 8000ca60 <_ZN7_thread7runningE>
    sd sp, 0(s0)
    8000116c:	00243023          	sd	sp,0(s0)
    ld sp, 16(s0)
    80001170:	01043103          	ld	sp,16(s0)
    csrr s0, sscratch
    80001174:	14002473          	csrr	s0,sscratch

    sret
    80001178:	10200073          	sret

000000008000117c <timer_interrupt>:

.global timer_interrupt
.type timer_interrupt, @function
timer_interrupt:
    csrw sscratch, s0
    8000117c:	14041073          	csrw	sscratch,s0
    ld s0, _ZN7_thread7runningE
    80001180:	0000c417          	auipc	s0,0xc
    80001184:	8e043403          	ld	s0,-1824(s0) # 8000ca60 <_ZN7_thread7runningE>
    sd sp, 16(s0)
    80001188:	00243823          	sd	sp,16(s0)
    ld sp, 0(s0)
    8000118c:	00043103          	ld	sp,0(s0)
    csrr s0, sscratch
    80001190:	14002473          	csrr	s0,sscratch

    addi sp, sp, -256
    80001194:	f0010113          	addi	sp,sp,-256
    .irp index 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(sp)
    .endr
    80001198:	00113423          	sd	ra,8(sp)
    8000119c:	00313c23          	sd	gp,24(sp)
    800011a0:	02413023          	sd	tp,32(sp)
    800011a4:	02513423          	sd	t0,40(sp)
    800011a8:	02613823          	sd	t1,48(sp)
    800011ac:	02713c23          	sd	t2,56(sp)
    800011b0:	04813023          	sd	s0,64(sp)
    800011b4:	04913423          	sd	s1,72(sp)
    800011b8:	04a13823          	sd	a0,80(sp)
    800011bc:	04b13c23          	sd	a1,88(sp)
    800011c0:	06c13023          	sd	a2,96(sp)
    800011c4:	06d13423          	sd	a3,104(sp)
    800011c8:	06e13823          	sd	a4,112(sp)
    800011cc:	06f13c23          	sd	a5,120(sp)
    800011d0:	09013023          	sd	a6,128(sp)
    800011d4:	09113423          	sd	a7,136(sp)
    800011d8:	09213823          	sd	s2,144(sp)
    800011dc:	09313c23          	sd	s3,152(sp)
    800011e0:	0b413023          	sd	s4,160(sp)
    800011e4:	0b513423          	sd	s5,168(sp)
    800011e8:	0b613823          	sd	s6,176(sp)
    800011ec:	0b713c23          	sd	s7,184(sp)
    800011f0:	0d813023          	sd	s8,192(sp)
    800011f4:	0d913423          	sd	s9,200(sp)
    800011f8:	0da13823          	sd	s10,208(sp)
    800011fc:	0db13c23          	sd	s11,216(sp)
    80001200:	0fc13023          	sd	t3,224(sp)
    80001204:	0fd13423          	sd	t4,232(sp)
    80001208:	0fe13823          	sd	t5,240(sp)
    8000120c:	0ff13c23          	sd	t6,248(sp)

    call timer_handler
    80001210:	62c000ef          	jal	ra,8000183c <timer_handler>

    .irp index 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ld x\index, \index * 8(sp)
    .endr
    80001214:	00813083          	ld	ra,8(sp)
    80001218:	01813183          	ld	gp,24(sp)
    8000121c:	02013203          	ld	tp,32(sp)
    80001220:	02813283          	ld	t0,40(sp)
    80001224:	03013303          	ld	t1,48(sp)
    80001228:	03813383          	ld	t2,56(sp)
    8000122c:	04013403          	ld	s0,64(sp)
    80001230:	04813483          	ld	s1,72(sp)
    80001234:	05013503          	ld	a0,80(sp)
    80001238:	05813583          	ld	a1,88(sp)
    8000123c:	06013603          	ld	a2,96(sp)
    80001240:	06813683          	ld	a3,104(sp)
    80001244:	07013703          	ld	a4,112(sp)
    80001248:	07813783          	ld	a5,120(sp)
    8000124c:	08013803          	ld	a6,128(sp)
    80001250:	08813883          	ld	a7,136(sp)
    80001254:	09013903          	ld	s2,144(sp)
    80001258:	09813983          	ld	s3,152(sp)
    8000125c:	0a013a03          	ld	s4,160(sp)
    80001260:	0a813a83          	ld	s5,168(sp)
    80001264:	0b013b03          	ld	s6,176(sp)
    80001268:	0b813b83          	ld	s7,184(sp)
    8000126c:	0c013c03          	ld	s8,192(sp)
    80001270:	0c813c83          	ld	s9,200(sp)
    80001274:	0d013d03          	ld	s10,208(sp)
    80001278:	0d813d83          	ld	s11,216(sp)
    8000127c:	0e013e03          	ld	t3,224(sp)
    80001280:	0e813e83          	ld	t4,232(sp)
    80001284:	0f013f03          	ld	t5,240(sp)
    80001288:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    8000128c:	10010113          	addi	sp,sp,256

    csrw sscratch, s0
    80001290:	14041073          	csrw	sscratch,s0
    ld s0, _ZN7_thread7runningE
    80001294:	0000b417          	auipc	s0,0xb
    80001298:	7cc43403          	ld	s0,1996(s0) # 8000ca60 <_ZN7_thread7runningE>
    sd sp, 0(s0)
    8000129c:	00243023          	sd	sp,0(s0)
    ld sp, 16(s0)
    800012a0:	01043103          	ld	sp,16(s0)
    csrr s0, sscratch
    800012a4:	14002473          	csrr	s0,sscratch

    sret
    800012a8:	10200073          	sret

00000000800012ac <console_interrupt>:


.global console_interrupt
.type console_interrupt, @function
console_interrupt:
    csrw sscratch, s0
    800012ac:	14041073          	csrw	sscratch,s0
    ld s0, _ZN7_thread7runningE
    800012b0:	0000b417          	auipc	s0,0xb
    800012b4:	7b043403          	ld	s0,1968(s0) # 8000ca60 <_ZN7_thread7runningE>
    sd sp, 16(s0)
    800012b8:	00243823          	sd	sp,16(s0)
    ld sp, 0(s0)
    800012bc:	00043103          	ld	sp,0(s0)
    csrr s0, sscratch
    800012c0:	14002473          	csrr	s0,sscratch

    addi sp, sp, -256
    800012c4:	f0010113          	addi	sp,sp,-256
    .irp index 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(sp)
    .endr
    800012c8:	00113423          	sd	ra,8(sp)
    800012cc:	00313c23          	sd	gp,24(sp)
    800012d0:	02413023          	sd	tp,32(sp)
    800012d4:	02513423          	sd	t0,40(sp)
    800012d8:	02613823          	sd	t1,48(sp)
    800012dc:	02713c23          	sd	t2,56(sp)
    800012e0:	04813023          	sd	s0,64(sp)
    800012e4:	04913423          	sd	s1,72(sp)
    800012e8:	04a13823          	sd	a0,80(sp)
    800012ec:	04b13c23          	sd	a1,88(sp)
    800012f0:	06c13023          	sd	a2,96(sp)
    800012f4:	06d13423          	sd	a3,104(sp)
    800012f8:	06e13823          	sd	a4,112(sp)
    800012fc:	06f13c23          	sd	a5,120(sp)
    80001300:	09013023          	sd	a6,128(sp)
    80001304:	09113423          	sd	a7,136(sp)
    80001308:	09213823          	sd	s2,144(sp)
    8000130c:	09313c23          	sd	s3,152(sp)
    80001310:	0b413023          	sd	s4,160(sp)
    80001314:	0b513423          	sd	s5,168(sp)
    80001318:	0b613823          	sd	s6,176(sp)
    8000131c:	0b713c23          	sd	s7,184(sp)
    80001320:	0d813023          	sd	s8,192(sp)
    80001324:	0d913423          	sd	s9,200(sp)
    80001328:	0da13823          	sd	s10,208(sp)
    8000132c:	0db13c23          	sd	s11,216(sp)
    80001330:	0fc13023          	sd	t3,224(sp)
    80001334:	0fd13423          	sd	t4,232(sp)
    80001338:	0fe13823          	sd	t5,240(sp)
    8000133c:	0ff13c23          	sd	t6,248(sp)

    call console_handler
    80001340:	594000ef          	jal	ra,800018d4 <console_handler>

    .irp index 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ld x\index, \index * 8(sp)
    .endr
    80001344:	00813083          	ld	ra,8(sp)
    80001348:	01813183          	ld	gp,24(sp)
    8000134c:	02013203          	ld	tp,32(sp)
    80001350:	02813283          	ld	t0,40(sp)
    80001354:	03013303          	ld	t1,48(sp)
    80001358:	03813383          	ld	t2,56(sp)
    8000135c:	04013403          	ld	s0,64(sp)
    80001360:	04813483          	ld	s1,72(sp)
    80001364:	05013503          	ld	a0,80(sp)
    80001368:	05813583          	ld	a1,88(sp)
    8000136c:	06013603          	ld	a2,96(sp)
    80001370:	06813683          	ld	a3,104(sp)
    80001374:	07013703          	ld	a4,112(sp)
    80001378:	07813783          	ld	a5,120(sp)
    8000137c:	08013803          	ld	a6,128(sp)
    80001380:	08813883          	ld	a7,136(sp)
    80001384:	09013903          	ld	s2,144(sp)
    80001388:	09813983          	ld	s3,152(sp)
    8000138c:	0a013a03          	ld	s4,160(sp)
    80001390:	0a813a83          	ld	s5,168(sp)
    80001394:	0b013b03          	ld	s6,176(sp)
    80001398:	0b813b83          	ld	s7,184(sp)
    8000139c:	0c013c03          	ld	s8,192(sp)
    800013a0:	0c813c83          	ld	s9,200(sp)
    800013a4:	0d013d03          	ld	s10,208(sp)
    800013a8:	0d813d83          	ld	s11,216(sp)
    800013ac:	0e013e03          	ld	t3,224(sp)
    800013b0:	0e813e83          	ld	t4,232(sp)
    800013b4:	0f013f03          	ld	t5,240(sp)
    800013b8:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    800013bc:	10010113          	addi	sp,sp,256

    csrw sscratch, s0
    800013c0:	14041073          	csrw	sscratch,s0
    ld s0, _ZN7_thread7runningE
    800013c4:	0000b417          	auipc	s0,0xb
    800013c8:	69c43403          	ld	s0,1692(s0) # 8000ca60 <_ZN7_thread7runningE>
    sd sp, 0(s0)
    800013cc:	00243023          	sd	sp,0(s0)
    ld sp, 16(s0)
    800013d0:	01043103          	ld	sp,16(s0)
    csrr s0, sscratch
    800013d4:	14002473          	csrr	s0,sscratch

    sret
    800013d8:	10200073          	sret

00000000800013dc <other_interrupt>:

.global other_interrupt
.type other_interrupt, @function
other_interrupt:
    800013dc:	10200073          	sret
	...

00000000800013e8 <_ZN7_thread13contextSwitchEPNS_7ContextES1_Pv>:
.global _ZN7_thread13contextSwitchEPNS_7ContextES1_Pv
.type _ZN7_thread13contextSwitchEPNS_7ContextES1_Pv, @function
_ZN7_thread13contextSwitchEPNS_7ContextES1_Pv:
    .irp index 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(a0)
    .endr
    800013e8:	00153423          	sd	ra,8(a0) # 1008 <_entry-0x7fffeff8>
    800013ec:	00353c23          	sd	gp,24(a0)
    800013f0:	02453023          	sd	tp,32(a0)
    800013f4:	02553423          	sd	t0,40(a0)
    800013f8:	02653823          	sd	t1,48(a0)
    800013fc:	02753c23          	sd	t2,56(a0)
    80001400:	04853023          	sd	s0,64(a0)
    80001404:	04953423          	sd	s1,72(a0)
    80001408:	04a53823          	sd	a0,80(a0)
    8000140c:	04b53c23          	sd	a1,88(a0)
    80001410:	06c53023          	sd	a2,96(a0)
    80001414:	06d53423          	sd	a3,104(a0)
    80001418:	06e53823          	sd	a4,112(a0)
    8000141c:	06f53c23          	sd	a5,120(a0)
    80001420:	09053023          	sd	a6,128(a0)
    80001424:	09153423          	sd	a7,136(a0)
    80001428:	09253823          	sd	s2,144(a0)
    8000142c:	09353c23          	sd	s3,152(a0)
    80001430:	0b453023          	sd	s4,160(a0)
    80001434:	0b553423          	sd	s5,168(a0)
    80001438:	0b653823          	sd	s6,176(a0)
    8000143c:	0b753c23          	sd	s7,184(a0)
    80001440:	0d853023          	sd	s8,192(a0)
    80001444:	0d953423          	sd	s9,200(a0)
    80001448:	0da53823          	sd	s10,208(a0)
    8000144c:	0db53c23          	sd	s11,216(a0)
    80001450:	0fc53023          	sd	t3,224(a0)
    80001454:	0fd53423          	sd	t4,232(a0)
    80001458:	0fe53823          	sd	t5,240(a0)
    8000145c:	0ff53c23          	sd	t6,248(a0)
    sd sp, 0 * 8(a0)
    80001460:	00253023          	sd	sp,0(a0)
    csrr a3, sepc
    80001464:	141026f3          	csrr	a3,sepc
    sd a3, 32 * 8(a0)
    80001468:	10d53023          	sd	a3,256(a0)
    csrr a3, sstatus
    8000146c:	100026f3          	csrr	a3,sstatus
    sd a3, 33 * 8(a0)
    80001470:	10d53423          	sd	a3,264(a0)

    .irp index 1, 3, 4, 5, 6, 7, 8, 9, 10, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ld x\index, \index * 8(a1)
    .endr
    80001474:	0085b083          	ld	ra,8(a1)
    80001478:	0185b183          	ld	gp,24(a1)
    8000147c:	0205b203          	ld	tp,32(a1)
    80001480:	0285b283          	ld	t0,40(a1)
    80001484:	0305b303          	ld	t1,48(a1)
    80001488:	0385b383          	ld	t2,56(a1)
    8000148c:	0405b403          	ld	s0,64(a1)
    80001490:	0485b483          	ld	s1,72(a1)
    80001494:	0505b503          	ld	a0,80(a1)
    80001498:	0685b683          	ld	a3,104(a1)
    8000149c:	0705b703          	ld	a4,112(a1)
    800014a0:	0785b783          	ld	a5,120(a1)
    800014a4:	0805b803          	ld	a6,128(a1)
    800014a8:	0885b883          	ld	a7,136(a1)
    800014ac:	0905b903          	ld	s2,144(a1)
    800014b0:	0985b983          	ld	s3,152(a1)
    800014b4:	0a05ba03          	ld	s4,160(a1)
    800014b8:	0a85ba83          	ld	s5,168(a1)
    800014bc:	0b05bb03          	ld	s6,176(a1)
    800014c0:	0b85bb83          	ld	s7,184(a1)
    800014c4:	0c05bc03          	ld	s8,192(a1)
    800014c8:	0c85bc83          	ld	s9,200(a1)
    800014cc:	0d05bd03          	ld	s10,208(a1)
    800014d0:	0d85bd83          	ld	s11,216(a1)
    800014d4:	0e05be03          	ld	t3,224(a1)
    800014d8:	0e85be83          	ld	t4,232(a1)
    800014dc:	0f05bf03          	ld	t5,240(a1)
    800014e0:	0f85bf83          	ld	t6,248(a1)
    ld sp, (a2)
    800014e4:	00063103          	ld	sp,0(a2)
    ld a3, 32 * 8(a1)
    800014e8:	1005b683          	ld	a3,256(a1)
    csrw sepc, a3
    800014ec:	14169073          	csrw	sepc,a3
    ld a3, 33 * 8(a1)
    800014f0:	1085b683          	ld	a3,264(a1)
    csrw sstatus, a3
    800014f4:	10069073          	csrw	sstatus,a3
    ld x12, 12 * 8(a1)
    800014f8:	0605b603          	ld	a2,96(a1)
    ld a1, 11 * 8(a1)
    800014fc:	0585b583          	ld	a1,88(a1)
    ret
    80001500:	00008067          	ret

0000000080001504 <ecall_handler>:

#ifdef __cplusplus
extern "C"
#endif
void ecall_handler()
{
    80001504:	fb010113          	addi	sp,sp,-80
    80001508:	04113423          	sd	ra,72(sp)
    8000150c:	04813023          	sd	s0,64(sp)
    80001510:	02913c23          	sd	s1,56(sp)
    80001514:	05010413          	addi	s0,sp,80
    uint64 volatile a0, a1, a2, a3;
    __asm__ volatile("mv %0, a0" : "=r"(a0));
    80001518:	00050793          	mv	a5,a0
    8000151c:	fcf43c23          	sd	a5,-40(s0)
    __asm__ volatile("mv %0, a1" : "=r"(a1));
    80001520:	00058793          	mv	a5,a1
    80001524:	fcf43823          	sd	a5,-48(s0)
    __asm__ volatile("mv %0, a2" : "=r"(a2));
    80001528:	00060793          	mv	a5,a2
    8000152c:	fcf43423          	sd	a5,-56(s0)
    __asm__ volatile("mv %0, a3" : "=r"(a3));
    80001530:	00068793          	mv	a5,a3
    80001534:	fcf43023          	sd	a5,-64(s0)
    uint64 scause;
    __asm__ volatile("csrr %0, scause": "=r"(scause));
    80001538:	142027f3          	csrr	a5,scause
    if (scause == 0x0000000000000008UL || scause == 0x0000000000000009UL)
    8000153c:	ff878793          	addi	a5,a5,-8
    80001540:	00100713          	li	a4,1
    80001544:	00f77c63          	bgeu	a4,a5,8000155c <ecall_handler+0x58>
            __asm__ volatile("csrr %0, sstatus" : "=r"(sstatus));
            sstatus |= (1ULL << 5);
            __asm__ volatile("csrw sstatus, %0" : : "r"(sstatus));
        }
    }
}
    80001548:	04813083          	ld	ra,72(sp)
    8000154c:	04013403          	ld	s0,64(sp)
    80001550:	03813483          	ld	s1,56(sp)
    80001554:	05010113          	addi	sp,sp,80
    80001558:	00008067          	ret
        __asm__ volatile("mv %0, a0" : "=r"(sys_callID));
    8000155c:	00050793          	mv	a5,a0
        if (sys_callID == MEM_ALLOC)
    80001560:	0ae78063          	beq	a5,a4,80001600 <ecall_handler+0xfc>
        else if (sys_callID == MEM_FREE)
    80001564:	00200713          	li	a4,2
    80001568:	0ce78263          	beq	a5,a4,8000162c <ecall_handler+0x128>
        else if (sys_callID == THREAD_CREATE)
    8000156c:	01100713          	li	a4,17
    80001570:	0ee78463          	beq	a5,a4,80001658 <ecall_handler+0x154>
        else if (sys_callID == THREAD_DISPATCH)
    80001574:	01300713          	li	a4,19
    80001578:	12e78463          	beq	a5,a4,800016a0 <ecall_handler+0x19c>
        else if (sys_callID == THREAD_JOIN)
    8000157c:	01400713          	li	a4,20
    80001580:	12e78c63          	beq	a5,a4,800016b8 <ecall_handler+0x1b4>
        else if (sys_callID == THREAD_EXIT)
    80001584:	01200713          	li	a4,18
    80001588:	14e78663          	beq	a5,a4,800016d4 <ecall_handler+0x1d0>
        else if (sys_callID == SEM_OPEN)
    8000158c:	02100713          	li	a4,33
    80001590:	16e78063          	beq	a5,a4,800016f0 <ecall_handler+0x1ec>
        else if (sys_callID == SEM_CLOSE)
    80001594:	02200713          	li	a4,34
    80001598:	18e78c63          	beq	a5,a4,80001730 <ecall_handler+0x22c>
        else if (sys_callID == SEM_WAIT)
    8000159c:	02300713          	li	a4,35
    800015a0:	1ae78a63          	beq	a5,a4,80001754 <ecall_handler+0x250>
        else if (sys_callID == SEM_SIGNAL)
    800015a4:	02400713          	li	a4,36
    800015a8:	1ce78663          	beq	a5,a4,80001774 <ecall_handler+0x270>
        else if (sys_callID == SLEEP)
    800015ac:	03100713          	li	a4,49
    800015b0:	1ee78263          	beq	a5,a4,80001794 <ecall_handler+0x290>
        else if (sys_callID == GETC)
    800015b4:	04100713          	li	a4,65
    800015b8:	1ee78e63          	beq	a5,a4,800017b4 <ecall_handler+0x2b0>
        else if (sys_callID == PUTC)
    800015bc:	04200713          	li	a4,66
    800015c0:	22e78063          	beq	a5,a4,800017e0 <ecall_handler+0x2dc>
        else if (sys_callID == DISABLE_INTERRUPT)
    800015c4:	06000713          	li	a4,96
    800015c8:	24e78463          	beq	a5,a4,80001810 <ecall_handler+0x30c>
        else if (sys_callID == ENABLE_INTERRUPT)
    800015cc:	06100713          	li	a4,97
    800015d0:	f6e79ce3          	bne	a5,a4,80001548 <ecall_handler+0x44>
    __asm__ volatile("csrr %0, sepc" : "=r"(sepc));
    800015d4:	141027f3          	csrr	a5,sepc
    sepc += 4;
    800015d8:	00478793          	addi	a5,a5,4
    __asm__ volatile("csrw sepc, %0" : : "r"(sepc));
    800015dc:	14179073          	csrw	sepc,a5
            __asm__ volatile("csrr %0, sstatus" : "=r"(sstatus));
    800015e0:	100027f3          	csrr	a5,sstatus
    800015e4:	faf43c23          	sd	a5,-72(s0)
            sstatus |= (1ULL << 5);
    800015e8:	fb843783          	ld	a5,-72(s0)
    800015ec:	0207e793          	ori	a5,a5,32
    800015f0:	faf43c23          	sd	a5,-72(s0)
            __asm__ volatile("csrw sstatus, %0" : : "r"(sstatus));
    800015f4:	fb843783          	ld	a5,-72(s0)
    800015f8:	10079073          	csrw	sstatus,a5
}
    800015fc:	f4dff06f          	j	80001548 <ecall_handler+0x44>
            uint64 size = a1;
    80001600:	fd043483          	ld	s1,-48(s0)
            __asm__ volatile("csrr %0, sepc" : "=r"(sepc));
    80001604:	141027f3          	csrr	a5,sepc
            sepc += 4;
    80001608:	00478793          	addi	a5,a5,4
            __asm__ volatile("csrw sepc, %0" : : "r"(sepc));
    8000160c:	14179073          	csrw	sepc,a5
            void* ptr = MemoryAllocator::__get_instance()->__mem_alloc(size);
    80001610:	00005097          	auipc	ra,0x5
    80001614:	124080e7          	jalr	292(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80001618:	00048593          	mv	a1,s1
    8000161c:	00005097          	auipc	ra,0x5
    80001620:	1bc080e7          	jalr	444(ra) # 800067d8 <_ZN15MemoryAllocator11__mem_allocEm>
            __asm__ volatile("sd a0, 10 * 8(fp)");  // this is good because compiler sets fp to beginning of stack frame
    80001624:	04a43823          	sd	a0,80(s0)
    80001628:	f21ff06f          	j	80001548 <ecall_handler+0x44>
            void* ptr = (void*)a1;
    8000162c:	fd043483          	ld	s1,-48(s0)
    __asm__ volatile("csrr %0, sepc" : "=r"(sepc));
    80001630:	141027f3          	csrr	a5,sepc
    sepc += 4;
    80001634:	00478793          	addi	a5,a5,4
    __asm__ volatile("csrw sepc, %0" : : "r"(sepc));
    80001638:	14179073          	csrw	sepc,a5
            int res = MemoryAllocator::__get_instance()->__mem_free(ptr);
    8000163c:	00005097          	auipc	ra,0x5
    80001640:	0f8080e7          	jalr	248(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80001644:	00048593          	mv	a1,s1
    80001648:	00005097          	auipc	ra,0x5
    8000164c:	2dc080e7          	jalr	732(ra) # 80006924 <_ZN15MemoryAllocator10__mem_freeEPv>
            __asm__ volatile("sd a0, 10 * 8(fp)");
    80001650:	04a43823          	sd	a0,80(s0)
    80001654:	ef5ff06f          	j	80001548 <ecall_handler+0x44>
            thread_t* handle = (thread_t*)a1;
    80001658:	fd043483          	ld	s1,-48(s0)
            _thread::Body routine = (_thread::Body)a2;
    8000165c:	fc843503          	ld	a0,-56(s0)
            void* arg = (void*)a3;
    80001660:	fc043583          	ld	a1,-64(s0)
    __asm__ volatile("csrr %0, sepc" : "=r"(sepc));
    80001664:	141027f3          	csrr	a5,sepc
    sepc += 4;
    80001668:	00478793          	addi	a5,a5,4
    __asm__ volatile("csrw sepc, %0" : : "r"(sepc));
    8000166c:	14179073          	csrw	sepc,a5
            *handle = _thread::thread_create((_thread::Body)routine, arg, true, false);
    80001670:	00000693          	li	a3,0
    80001674:	00100613          	li	a2,1
    80001678:	00001097          	auipc	ra,0x1
    8000167c:	e80080e7          	jalr	-384(ra) # 800024f8 <_ZN7_thread13thread_createEPFvPvES0_bb>
    80001680:	00a4b023          	sd	a0,0(s1)
            if (!(*handle))
    80001684:	00050a63          	beqz	a0,80001698 <ecall_handler+0x194>
            int res = 0;
    80001688:	00000793          	li	a5,0
            __asm__ volatile("mv a0, %0": : "r"(res));
    8000168c:	00078513          	mv	a0,a5
            __asm__ volatile("sd a0, 10 * 8(fp)");
    80001690:	04a43823          	sd	a0,80(s0)
    80001694:	eb5ff06f          	j	80001548 <ecall_handler+0x44>
                res = -1;
    80001698:	fff00793          	li	a5,-1
    8000169c:	ff1ff06f          	j	8000168c <ecall_handler+0x188>
    __asm__ volatile("csrr %0, sepc" : "=r"(sepc));
    800016a0:	141027f3          	csrr	a5,sepc
    sepc += 4;
    800016a4:	00478793          	addi	a5,a5,4
    __asm__ volatile("csrw sepc, %0" : : "r"(sepc));
    800016a8:	14179073          	csrw	sepc,a5
            _thread::dispatch();
    800016ac:	00001097          	auipc	ra,0x1
    800016b0:	ba8080e7          	jalr	-1112(ra) # 80002254 <_ZN7_thread8dispatchEv>
    800016b4:	e95ff06f          	j	80001548 <ecall_handler+0x44>
    __asm__ volatile("csrr %0, sepc" : "=r"(sepc));
    800016b8:	141027f3          	csrr	a5,sepc
    sepc += 4;
    800016bc:	00478793          	addi	a5,a5,4
    __asm__ volatile("csrw sepc, %0" : : "r"(sepc));
    800016c0:	14179073          	csrw	sepc,a5
            thread_t thread = (thread_t)a1;
    800016c4:	fd043503          	ld	a0,-48(s0)
            _thread::thread_join(thread);
    800016c8:	00001097          	auipc	ra,0x1
    800016cc:	dcc080e7          	jalr	-564(ra) # 80002494 <_ZN7_thread11thread_joinEPS_>
    800016d0:	e79ff06f          	j	80001548 <ecall_handler+0x44>
    __asm__ volatile("csrr %0, sepc" : "=r"(sepc));
    800016d4:	141027f3          	csrr	a5,sepc
    sepc += 4;
    800016d8:	00478793          	addi	a5,a5,4
    __asm__ volatile("csrw sepc, %0" : : "r"(sepc));
    800016dc:	14179073          	csrw	sepc,a5
            int res = _thread::thread_exit();
    800016e0:	00001097          	auipc	ra,0x1
    800016e4:	ce4080e7          	jalr	-796(ra) # 800023c4 <_ZN7_thread11thread_exitEv>
            __asm__ volatile("sd a0, 10 * 8(fp)");
    800016e8:	04a43823          	sd	a0,80(s0)
    800016ec:	e5dff06f          	j	80001548 <ecall_handler+0x44>
    __asm__ volatile("csrr %0, sepc" : "=r"(sepc));
    800016f0:	141027f3          	csrr	a5,sepc
    sepc += 4;
    800016f4:	00478793          	addi	a5,a5,4
    __asm__ volatile("csrw sepc, %0" : : "r"(sepc));
    800016f8:	14179073          	csrw	sepc,a5
            sem_t* semaphore = (sem_t*)a1;
    800016fc:	fd043483          	ld	s1,-48(s0)
            uint64 init = a2;
    80001700:	fc843503          	ld	a0,-56(s0)
            *semaphore = _sem::semaphore_create(init);
    80001704:	0005051b          	sext.w	a0,a0
    80001708:	00004097          	auipc	ra,0x4
    8000170c:	62c080e7          	jalr	1580(ra) # 80005d34 <_ZN4_sem16semaphore_createEj>
    80001710:	00a4b023          	sd	a0,0(s1)
            if (!(*semaphore))
    80001714:	00050a63          	beqz	a0,80001728 <ecall_handler+0x224>
            int res = 0;
    80001718:	00000793          	li	a5,0
            __asm__ volatile("mv a0, %0": : "r"(res));
    8000171c:	00078513          	mv	a0,a5
            __asm__ volatile("sd a0, 10 * 8(fp)");
    80001720:	04a43823          	sd	a0,80(s0)
    80001724:	e25ff06f          	j	80001548 <ecall_handler+0x44>
                res = -1;
    80001728:	fff00793          	li	a5,-1
    8000172c:	ff1ff06f          	j	8000171c <ecall_handler+0x218>
    __asm__ volatile("csrr %0, sepc" : "=r"(sepc));
    80001730:	141027f3          	csrr	a5,sepc
    sepc += 4;
    80001734:	00478793          	addi	a5,a5,4
    __asm__ volatile("csrw sepc, %0" : : "r"(sepc));
    80001738:	14179073          	csrw	sepc,a5
            sem_t semaphore = (sem_t)a1;
    8000173c:	fd043503          	ld	a0,-48(s0)
            int res = _sem::close(semaphore, _thread::SEMCLOSED);
    80001740:	00100593          	li	a1,1
    80001744:	00004097          	auipc	ra,0x4
    80001748:	674080e7          	jalr	1652(ra) # 80005db8 <_ZN4_sem5closeEPS_N7_thread14semReturnValueE>
            __asm__ volatile("sd a0, 10 * 8(fp)");
    8000174c:	04a43823          	sd	a0,80(s0)
    80001750:	df9ff06f          	j	80001548 <ecall_handler+0x44>
    __asm__ volatile("csrr %0, sepc" : "=r"(sepc));
    80001754:	141027f3          	csrr	a5,sepc
    sepc += 4;
    80001758:	00478793          	addi	a5,a5,4
    __asm__ volatile("csrw sepc, %0" : : "r"(sepc));
    8000175c:	14179073          	csrw	sepc,a5
            sem_t semaphore = (sem_t)a1;
    80001760:	fd043503          	ld	a0,-48(s0)
            int res = _sem::wait(semaphore);
    80001764:	00004097          	auipc	ra,0x4
    80001768:	790080e7          	jalr	1936(ra) # 80005ef4 <_ZN4_sem4waitEPS_>
            __asm__ volatile("sd a0, 10 * 8(fp)");
    8000176c:	04a43823          	sd	a0,80(s0)
    80001770:	dd9ff06f          	j	80001548 <ecall_handler+0x44>
    __asm__ volatile("csrr %0, sepc" : "=r"(sepc));
    80001774:	141027f3          	csrr	a5,sepc
    sepc += 4;
    80001778:	00478793          	addi	a5,a5,4
    __asm__ volatile("csrw sepc, %0" : : "r"(sepc));
    8000177c:	14179073          	csrw	sepc,a5
            sem_t semaphore = (sem_t)a1;
    80001780:	fd043503          	ld	a0,-48(s0)
            int res = _sem::signal(semaphore);
    80001784:	00004097          	auipc	ra,0x4
    80001788:	6e4080e7          	jalr	1764(ra) # 80005e68 <_ZN4_sem6signalEPS_>
            __asm__ volatile("sd a0, 10 * 8(fp)");
    8000178c:	04a43823          	sd	a0,80(s0)
    80001790:	db9ff06f          	j	80001548 <ecall_handler+0x44>
    __asm__ volatile("csrr %0, sepc" : "=r"(sepc));
    80001794:	141027f3          	csrr	a5,sepc
    sepc += 4;
    80001798:	00478793          	addi	a5,a5,4
    __asm__ volatile("csrw sepc, %0" : : "r"(sepc));
    8000179c:	14179073          	csrw	sepc,a5
            time_t t = (time_t)a1;
    800017a0:	fd043503          	ld	a0,-48(s0)
            int res = _thread::thread_sleep(t);
    800017a4:	00001097          	auipc	ra,0x1
    800017a8:	f30080e7          	jalr	-208(ra) # 800026d4 <_ZN7_thread12thread_sleepEm>
            __asm__ volatile("sd a0, 10 * 8(fp)");
    800017ac:	04a43823          	sd	a0,80(s0)
    800017b0:	d99ff06f          	j	80001548 <ecall_handler+0x44>
    __asm__ volatile("csrr %0, sepc" : "=r"(sepc));
    800017b4:	141027f3          	csrr	a5,sepc
    sepc += 4;
    800017b8:	00478793          	addi	a5,a5,4
    __asm__ volatile("csrw sepc, %0" : : "r"(sepc));
    800017bc:	14179073          	csrw	sepc,a5
            char c = _buffer::consume(_buffer::getcBuffer, true);
    800017c0:	00100593          	li	a1,1
    800017c4:	0000b797          	auipc	a5,0xb
    800017c8:	2047b783          	ld	a5,516(a5) # 8000c9c8 <_GLOBAL_OFFSET_TABLE_+0x30>
    800017cc:	0007b503          	ld	a0,0(a5)
    800017d0:	00005097          	auipc	ra,0x5
    800017d4:	5e8080e7          	jalr	1512(ra) # 80006db8 <_ZN7_buffer7consumeEPS_b>
            __asm__ volatile("sd a0, 10 * 8(fp)");
    800017d8:	04a43823          	sd	a0,80(s0)
    800017dc:	d6dff06f          	j	80001548 <ecall_handler+0x44>
    __asm__ volatile("csrr %0, sepc" : "=r"(sepc));
    800017e0:	141027f3          	csrr	a5,sepc
    sepc += 4;
    800017e4:	00478793          	addi	a5,a5,4
    __asm__ volatile("csrw sepc, %0" : : "r"(sepc));
    800017e8:	14179073          	csrw	sepc,a5
            char c = (char)a1;
    800017ec:	fd043583          	ld	a1,-48(s0)
            _buffer::produce(_buffer::putcBuffer, c, true);
    800017f0:	00100613          	li	a2,1
    800017f4:	0ff5f593          	andi	a1,a1,255
    800017f8:	0000b797          	auipc	a5,0xb
    800017fc:	1f87b783          	ld	a5,504(a5) # 8000c9f0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80001800:	0007b503          	ld	a0,0(a5)
    80001804:	00005097          	auipc	ra,0x5
    80001808:	488080e7          	jalr	1160(ra) # 80006c8c <_ZN7_buffer7produceEPS_cb>
    8000180c:	d3dff06f          	j	80001548 <ecall_handler+0x44>
    __asm__ volatile("csrr %0, sepc" : "=r"(sepc));
    80001810:	141027f3          	csrr	a5,sepc
    sepc += 4;
    80001814:	00478793          	addi	a5,a5,4
    __asm__ volatile("csrw sepc, %0" : : "r"(sepc));
    80001818:	14179073          	csrw	sepc,a5
            __asm__ volatile("csrr %0, sstatus" : "=r"(sstatus));
    8000181c:	100027f3          	csrr	a5,sstatus
    80001820:	faf43823          	sd	a5,-80(s0)
            sstatus &= ~(1ULL << 5);
    80001824:	fb043783          	ld	a5,-80(s0)
    80001828:	fdf7f793          	andi	a5,a5,-33
    8000182c:	faf43823          	sd	a5,-80(s0)
            __asm__ volatile("csrw sstatus, %0" : : "r"(sstatus));
    80001830:	fb043783          	ld	a5,-80(s0)
    80001834:	10079073          	csrw	sstatus,a5
    80001838:	d11ff06f          	j	80001548 <ecall_handler+0x44>

000000008000183c <timer_handler>:
extern "C"
#endif
void timer_handler()
{
    uint64 scause;
    __asm__ volatile("csrr %0, scause": "=r"(scause));
    8000183c:	14202773          	csrr	a4,scause
    if (scause == 0x8000000000000001)
    80001840:	fff00793          	li	a5,-1
    80001844:	03f79793          	slli	a5,a5,0x3f
    80001848:	00178793          	addi	a5,a5,1
    8000184c:	00f70463          	beq	a4,a5,80001854 <timer_handler+0x18>
    80001850:	00008067          	ret
{
    80001854:	fe010113          	addi	sp,sp,-32
    80001858:	00113c23          	sd	ra,24(sp)
    8000185c:	00813823          	sd	s0,16(sp)
    80001860:	00913423          	sd	s1,8(sp)
    80001864:	02010413          	addi	s0,sp,32
    {
        ++_thread::timeCounter;
    80001868:	0000b497          	auipc	s1,0xb
    8000186c:	1704b483          	ld	s1,368(s1) # 8000c9d8 <_GLOBAL_OFFSET_TABLE_+0x40>
    80001870:	0004b783          	ld	a5,0(s1)
    80001874:	00178793          	addi	a5,a5,1
    80001878:	00f4b023          	sd	a5,0(s1)
        ++_thread::relativeSleepTimer;
    8000187c:	0000b717          	auipc	a4,0xb
    80001880:	18473703          	ld	a4,388(a4) # 8000ca00 <_GLOBAL_OFFSET_TABLE_+0x68>
    80001884:	00073783          	ld	a5,0(a4)
    80001888:	00178793          	addi	a5,a5,1
    8000188c:	00f73023          	sd	a5,0(a4)
        _thread::thread_wake();
    80001890:	00001097          	auipc	ra,0x1
    80001894:	f08080e7          	jalr	-248(ra) # 80002798 <_ZN7_thread11thread_wakeEv>
        uint64 sip;
        __asm__ volatile("csrr %0, sip": "=r"(sip));
    80001898:	144027f3          	csrr	a5,sip
        sip &= ~(1ULL << 1);
    8000189c:	ffd7f793          	andi	a5,a5,-3
        __asm__ volatile("csrw sip, %0": : "r"(sip));
    800018a0:	14479073          	csrw	sip,a5
        if (_thread::timeCounter >= DEFAULT_TIME_SLICE)
    800018a4:	0004b703          	ld	a4,0(s1)
    800018a8:	00100793          	li	a5,1
    800018ac:	00e7ec63          	bltu	a5,a4,800018c4 <timer_handler+0x88>
        {
            _thread::timeCounter = 0;
            _thread::dispatch();
        }
    }
}
    800018b0:	01813083          	ld	ra,24(sp)
    800018b4:	01013403          	ld	s0,16(sp)
    800018b8:	00813483          	ld	s1,8(sp)
    800018bc:	02010113          	addi	sp,sp,32
    800018c0:	00008067          	ret
            _thread::timeCounter = 0;
    800018c4:	0004b023          	sd	zero,0(s1)
            _thread::dispatch();
    800018c8:	00001097          	auipc	ra,0x1
    800018cc:	98c080e7          	jalr	-1652(ra) # 80002254 <_ZN7_thread8dispatchEv>
}
    800018d0:	fe1ff06f          	j	800018b0 <timer_handler+0x74>

00000000800018d4 <console_handler>:
extern "C"
#endif
void console_handler()
{
    uint64 sip;
    __asm__ volatile("csrr %0, sip": "=r"(sip));
    800018d4:	144027f3          	csrr	a5,sip
    sip &= ~(1ULL << 9);
    800018d8:	dff7f793          	andi	a5,a5,-513
    __asm__ volatile("csrw sip, %0": : "r"(sip));
    800018dc:	14479073          	csrw	sip,a5
    uint64 scause;
    __asm__ volatile("csrr %0, scause": "=r"(scause));
    800018e0:	14202773          	csrr	a4,scause
    if (scause == 0x8000000000000009)
    800018e4:	fff00793          	li	a5,-1
    800018e8:	03f79793          	slli	a5,a5,0x3f
    800018ec:	00978793          	addi	a5,a5,9
    800018f0:	00f70463          	beq	a4,a5,800018f8 <console_handler+0x24>
    800018f4:	00008067          	ret
{
    800018f8:	ff010113          	addi	sp,sp,-16
    800018fc:	00113423          	sd	ra,8(sp)
    80001900:	00813023          	sd	s0,0(sp)
    80001904:	01010413          	addi	s0,sp,16
    {
        int irq = plic_claim();
    80001908:	00006097          	auipc	ra,0x6
    8000190c:	1dc080e7          	jalr	476(ra) # 80007ae4 <plic_claim>
        if (irq != CONSOLE_IRQ)
    80001910:	00a00793          	li	a5,10
    80001914:	06f51263          	bne	a0,a5,80001978 <console_handler+0xa4>
        {
            plic_complete(irq);
            return;
        }
        while (!_buffer::isFull(_buffer::getcBuffer) && ((*((char*)CONSOLE_STATUS)) & CONSOLE_RX_STATUS_BIT))
    80001918:	0000b797          	auipc	a5,0xb
    8000191c:	0b07b783          	ld	a5,176(a5) # 8000c9c8 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001920:	0007b503          	ld	a0,0(a5)
    80001924:	00005097          	auipc	ra,0x5
    80001928:	46c080e7          	jalr	1132(ra) # 80006d90 <_ZN7_buffer6isFullEPS_>
    8000192c:	04051c63          	bnez	a0,80001984 <console_handler+0xb0>
    80001930:	0000b797          	auipc	a5,0xb
    80001934:	0787b783          	ld	a5,120(a5) # 8000c9a8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001938:	0007b783          	ld	a5,0(a5)
    8000193c:	0007c783          	lbu	a5,0(a5)
    80001940:	0017f793          	andi	a5,a5,1
    80001944:	04078063          	beqz	a5,80001984 <console_handler+0xb0>
        {
            char c = *((char*)CONSOLE_RX_DATA);
    80001948:	0000b797          	auipc	a5,0xb
    8000194c:	0587b783          	ld	a5,88(a5) # 8000c9a0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001950:	0007b783          	ld	a5,0(a5)
    80001954:	0007c583          	lbu	a1,0(a5)
            if(c != 0)
    80001958:	fc0580e3          	beqz	a1,80001918 <console_handler+0x44>
                _buffer::produce(_buffer::getcBuffer, c, true);
    8000195c:	00100613          	li	a2,1
    80001960:	0000b797          	auipc	a5,0xb
    80001964:	0687b783          	ld	a5,104(a5) # 8000c9c8 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001968:	0007b503          	ld	a0,0(a5)
    8000196c:	00005097          	auipc	ra,0x5
    80001970:	320080e7          	jalr	800(ra) # 80006c8c <_ZN7_buffer7produceEPS_cb>
    80001974:	fa5ff06f          	j	80001918 <console_handler+0x44>
            plic_complete(irq);
    80001978:	00006097          	auipc	ra,0x6
    8000197c:	1a4080e7          	jalr	420(ra) # 80007b1c <plic_complete>
            return;
    80001980:	01c0006f          	j	8000199c <console_handler+0xc8>
        }
        if (!_buffer::isFull(_buffer::getcBuffer))
    80001984:	0000b797          	auipc	a5,0xb
    80001988:	0447b783          	ld	a5,68(a5) # 8000c9c8 <_GLOBAL_OFFSET_TABLE_+0x30>
    8000198c:	0007b503          	ld	a0,0(a5)
    80001990:	00005097          	auipc	ra,0x5
    80001994:	400080e7          	jalr	1024(ra) # 80006d90 <_ZN7_buffer6isFullEPS_>
    80001998:	00050a63          	beqz	a0,800019ac <console_handler+0xd8>
            plic_complete(CONSOLE_IRQ);
    }
}
    8000199c:	00813083          	ld	ra,8(sp)
    800019a0:	00013403          	ld	s0,0(sp)
    800019a4:	01010113          	addi	sp,sp,16
    800019a8:	00008067          	ret
            plic_complete(CONSOLE_IRQ);
    800019ac:	00a00513          	li	a0,10
    800019b0:	00006097          	auipc	ra,0x6
    800019b4:	16c080e7          	jalr	364(ra) # 80007b1c <plic_complete>
    800019b8:	fe5ff06f          	j	8000199c <console_handler+0xc8>

00000000800019bc <__ecall_interrupt>:

#ifdef __cplusplus
extern "C"
#endif
void __ecall_interrupt(int sys_call_id, ...)
{
    800019bc:	fb010113          	addi	sp,sp,-80
    800019c0:	00813423          	sd	s0,8(sp)
    800019c4:	01010413          	addi	s0,sp,16
    800019c8:	00b43423          	sd	a1,8(s0)
    800019cc:	00c43823          	sd	a2,16(s0)
    800019d0:	00d43c23          	sd	a3,24(s0)
    800019d4:	02e43023          	sd	a4,32(s0)
    800019d8:	02f43423          	sd	a5,40(s0)
    800019dc:	03043823          	sd	a6,48(s0)
    800019e0:	03143c23          	sd	a7,56(s0)
    __asm__ volatile ("ecall");
    800019e4:	00000073          	ecall
}
    800019e8:	00813403          	ld	s0,8(sp)
    800019ec:	05010113          	addi	sp,sp,80
    800019f0:	00008067          	ret

00000000800019f4 <__mem_alloc>:

#ifdef __cplusplus
extern "C"
#endif
void* __mem_alloc(size_t size)
{
    800019f4:	ff010113          	addi	sp,sp,-16
    800019f8:	00113423          	sd	ra,8(sp)
    800019fc:	00813023          	sd	s0,0(sp)
    80001a00:	01010413          	addi	s0,sp,16
    int numOfBlocks = (size + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE;
    80001a04:	03f50593          	addi	a1,a0,63
    80001a08:	0065d593          	srli	a1,a1,0x6

    void* ptr;
    __ecall_interrupt(MEM_ALLOC, numOfBlocks);
    80001a0c:	0005859b          	sext.w	a1,a1
    80001a10:	00100513          	li	a0,1
    80001a14:	00000097          	auipc	ra,0x0
    80001a18:	fa8080e7          	jalr	-88(ra) # 800019bc <__ecall_interrupt>
    __asm__ volatile("mv %0, a0": "=r"((uint64)ptr));
    80001a1c:	00050513          	mv	a0,a0
    return ptr;
}
    80001a20:	00813083          	ld	ra,8(sp)
    80001a24:	00013403          	ld	s0,0(sp)
    80001a28:	01010113          	addi	sp,sp,16
    80001a2c:	00008067          	ret

0000000080001a30 <__mem_free>:

#ifdef __cplusplus
extern "C"
#endif
int __mem_free(void* ptr)
{
    80001a30:	ff010113          	addi	sp,sp,-16
    80001a34:	00113423          	sd	ra,8(sp)
    80001a38:	00813023          	sd	s0,0(sp)
    80001a3c:	01010413          	addi	s0,sp,16
    80001a40:	00050593          	mv	a1,a0
    __ecall_interrupt(MEM_FREE, ptr);
    80001a44:	00200513          	li	a0,2
    80001a48:	00000097          	auipc	ra,0x0
    80001a4c:	f74080e7          	jalr	-140(ra) # 800019bc <__ecall_interrupt>

    uint64 res;
    __asm__ volatile("mv %0, a0": "=r"(res));
    80001a50:	00050513          	mv	a0,a0
    return res;
}
    80001a54:	0005051b          	sext.w	a0,a0
    80001a58:	00813083          	ld	ra,8(sp)
    80001a5c:	00013403          	ld	s0,0(sp)
    80001a60:	01010113          	addi	sp,sp,16
    80001a64:	00008067          	ret

0000000080001a68 <thread_create>:

#ifdef __cplusplus
extern "C"
#endif
int thread_create(thread_t* handle, _thread::Body routine, void*arg)
{
    80001a68:	ff010113          	addi	sp,sp,-16
    80001a6c:	00113423          	sd	ra,8(sp)
    80001a70:	00813023          	sd	s0,0(sp)
    80001a74:	01010413          	addi	s0,sp,16
    80001a78:	00060693          	mv	a3,a2
    __ecall_interrupt(THREAD_CREATE, handle, routine, arg);
    80001a7c:	00058613          	mv	a2,a1
    80001a80:	00050593          	mv	a1,a0
    80001a84:	01100513          	li	a0,17
    80001a88:	00000097          	auipc	ra,0x0
    80001a8c:	f34080e7          	jalr	-204(ra) # 800019bc <__ecall_interrupt>

    uint64 res;
    __asm__ volatile("mv %0, a0": "=r"(res));
    80001a90:	00050513          	mv	a0,a0
    return (int)res;
}
    80001a94:	0005051b          	sext.w	a0,a0
    80001a98:	00813083          	ld	ra,8(sp)
    80001a9c:	00013403          	ld	s0,0(sp)
    80001aa0:	01010113          	addi	sp,sp,16
    80001aa4:	00008067          	ret

0000000080001aa8 <thread_dispatch>:

#ifdef __cplusplus
extern "C"
#endif
void thread_dispatch()
{
    80001aa8:	ff010113          	addi	sp,sp,-16
    80001aac:	00113423          	sd	ra,8(sp)
    80001ab0:	00813023          	sd	s0,0(sp)
    80001ab4:	01010413          	addi	s0,sp,16
    __ecall_interrupt(THREAD_DISPATCH);
    80001ab8:	01300513          	li	a0,19
    80001abc:	00000097          	auipc	ra,0x0
    80001ac0:	f00080e7          	jalr	-256(ra) # 800019bc <__ecall_interrupt>
}
    80001ac4:	00813083          	ld	ra,8(sp)
    80001ac8:	00013403          	ld	s0,0(sp)
    80001acc:	01010113          	addi	sp,sp,16
    80001ad0:	00008067          	ret

0000000080001ad4 <thread_exit>:

#ifdef __cplusplus
extern "C"
#endif
int thread_exit()
{
    80001ad4:	ff010113          	addi	sp,sp,-16
    80001ad8:	00113423          	sd	ra,8(sp)
    80001adc:	00813023          	sd	s0,0(sp)
    80001ae0:	01010413          	addi	s0,sp,16
    __ecall_interrupt(THREAD_EXIT);
    80001ae4:	01200513          	li	a0,18
    80001ae8:	00000097          	auipc	ra,0x0
    80001aec:	ed4080e7          	jalr	-300(ra) # 800019bc <__ecall_interrupt>

    uint64 res;
    __asm__ volatile("mv %0, a0": "=r"(res));
    80001af0:	00050513          	mv	a0,a0
    return (int)res;
}
    80001af4:	0005051b          	sext.w	a0,a0
    80001af8:	00813083          	ld	ra,8(sp)
    80001afc:	00013403          	ld	s0,0(sp)
    80001b00:	01010113          	addi	sp,sp,16
    80001b04:	00008067          	ret

0000000080001b08 <sem_open>:

#ifdef __cplusplus
extern "C"
#endif
int sem_open(sem_t* handle, unsigned init)
{
    80001b08:	ff010113          	addi	sp,sp,-16
    80001b0c:	00113423          	sd	ra,8(sp)
    80001b10:	00813023          	sd	s0,0(sp)
    80001b14:	01010413          	addi	s0,sp,16
    80001b18:	00058613          	mv	a2,a1
    __ecall_interrupt(SEM_OPEN, handle, init);
    80001b1c:	00050593          	mv	a1,a0
    80001b20:	02100513          	li	a0,33
    80001b24:	00000097          	auipc	ra,0x0
    80001b28:	e98080e7          	jalr	-360(ra) # 800019bc <__ecall_interrupt>
    uint64 res;
    __asm__ volatile("mv %0, a0": "=r"(res));
    80001b2c:	00050513          	mv	a0,a0
    return (int)res;
}
    80001b30:	0005051b          	sext.w	a0,a0
    80001b34:	00813083          	ld	ra,8(sp)
    80001b38:	00013403          	ld	s0,0(sp)
    80001b3c:	01010113          	addi	sp,sp,16
    80001b40:	00008067          	ret

0000000080001b44 <sem_close>:

#ifdef __cplusplus
extern "C"
#endif
int sem_close (sem_t handle)
{
    80001b44:	ff010113          	addi	sp,sp,-16
    80001b48:	00113423          	sd	ra,8(sp)
    80001b4c:	00813023          	sd	s0,0(sp)
    80001b50:	01010413          	addi	s0,sp,16
    80001b54:	00050593          	mv	a1,a0
    __ecall_interrupt(SEM_CLOSE, handle);
    80001b58:	02200513          	li	a0,34
    80001b5c:	00000097          	auipc	ra,0x0
    80001b60:	e60080e7          	jalr	-416(ra) # 800019bc <__ecall_interrupt>
    uint64 res;
    __asm__ volatile("mv %0, a0": "=r"(res));
    80001b64:	00050513          	mv	a0,a0
    return (int)res;
}
    80001b68:	0005051b          	sext.w	a0,a0
    80001b6c:	00813083          	ld	ra,8(sp)
    80001b70:	00013403          	ld	s0,0(sp)
    80001b74:	01010113          	addi	sp,sp,16
    80001b78:	00008067          	ret

0000000080001b7c <sem_wait>:

#ifdef __cplusplus
extern "C"
#endif
int sem_wait (sem_t handle)
{
    80001b7c:	ff010113          	addi	sp,sp,-16
    80001b80:	00113423          	sd	ra,8(sp)
    80001b84:	00813023          	sd	s0,0(sp)
    80001b88:	01010413          	addi	s0,sp,16
    80001b8c:	00050593          	mv	a1,a0
    __ecall_interrupt(SEM_WAIT, handle);
    80001b90:	02300513          	li	a0,35
    80001b94:	00000097          	auipc	ra,0x0
    80001b98:	e28080e7          	jalr	-472(ra) # 800019bc <__ecall_interrupt>

    uint64 res;
    __asm__ volatile("mv %0, a0": "=r"(res));
    80001b9c:	00050513          	mv	a0,a0
    return (int)res;
}
    80001ba0:	0005051b          	sext.w	a0,a0
    80001ba4:	00813083          	ld	ra,8(sp)
    80001ba8:	00013403          	ld	s0,0(sp)
    80001bac:	01010113          	addi	sp,sp,16
    80001bb0:	00008067          	ret

0000000080001bb4 <sem_signal>:

#ifdef __cplusplus
extern "C"
#endif
int sem_signal (sem_t handle)
{
    80001bb4:	ff010113          	addi	sp,sp,-16
    80001bb8:	00113423          	sd	ra,8(sp)
    80001bbc:	00813023          	sd	s0,0(sp)
    80001bc0:	01010413          	addi	s0,sp,16
    80001bc4:	00050593          	mv	a1,a0
    __ecall_interrupt(SEM_SIGNAL, handle);
    80001bc8:	02400513          	li	a0,36
    80001bcc:	00000097          	auipc	ra,0x0
    80001bd0:	df0080e7          	jalr	-528(ra) # 800019bc <__ecall_interrupt>
    uint64 res;
    __asm__ volatile("mv %0, a0": "=r"(res));
    80001bd4:	00050513          	mv	a0,a0
    return (int)res;
}
    80001bd8:	0005051b          	sext.w	a0,a0
    80001bdc:	00813083          	ld	ra,8(sp)
    80001be0:	00013403          	ld	s0,0(sp)
    80001be4:	01010113          	addi	sp,sp,16
    80001be8:	00008067          	ret

0000000080001bec <thread_join>:

#ifdef __cplusplus
extern "C"
#endif
void thread_join(thread_t handle)
{
    80001bec:	ff010113          	addi	sp,sp,-16
    80001bf0:	00113423          	sd	ra,8(sp)
    80001bf4:	00813023          	sd	s0,0(sp)
    80001bf8:	01010413          	addi	s0,sp,16
    80001bfc:	00050593          	mv	a1,a0
    __ecall_interrupt(THREAD_JOIN, handle);
    80001c00:	01400513          	li	a0,20
    80001c04:	00000097          	auipc	ra,0x0
    80001c08:	db8080e7          	jalr	-584(ra) # 800019bc <__ecall_interrupt>
}
    80001c0c:	00813083          	ld	ra,8(sp)
    80001c10:	00013403          	ld	s0,0(sp)
    80001c14:	01010113          	addi	sp,sp,16
    80001c18:	00008067          	ret

0000000080001c1c <putc>:

#ifdef __cplusplus
extern "C"
#endif
void putc(char chr)
{
    80001c1c:	ff010113          	addi	sp,sp,-16
    80001c20:	00113423          	sd	ra,8(sp)
    80001c24:	00813023          	sd	s0,0(sp)
    80001c28:	01010413          	addi	s0,sp,16
    80001c2c:	00050593          	mv	a1,a0
    __ecall_interrupt(PUTC, chr);
    80001c30:	04200513          	li	a0,66
    80001c34:	00000097          	auipc	ra,0x0
    80001c38:	d88080e7          	jalr	-632(ra) # 800019bc <__ecall_interrupt>
}
    80001c3c:	00813083          	ld	ra,8(sp)
    80001c40:	00013403          	ld	s0,0(sp)
    80001c44:	01010113          	addi	sp,sp,16
    80001c48:	00008067          	ret

0000000080001c4c <getc>:

#ifdef __cplusplus
extern "C"
#endif
char getc()
{
    80001c4c:	ff010113          	addi	sp,sp,-16
    80001c50:	00113423          	sd	ra,8(sp)
    80001c54:	00813023          	sd	s0,0(sp)
    80001c58:	01010413          	addi	s0,sp,16
    __ecall_interrupt(GETC);
    80001c5c:	04100513          	li	a0,65
    80001c60:	00000097          	auipc	ra,0x0
    80001c64:	d5c080e7          	jalr	-676(ra) # 800019bc <__ecall_interrupt>

    uint64 res;
    __asm__ volatile("mv %0, a0": "=r"(res));
    80001c68:	00050513          	mv	a0,a0
    return (char)res;
}
    80001c6c:	0ff57513          	andi	a0,a0,255
    80001c70:	00813083          	ld	ra,8(sp)
    80001c74:	00013403          	ld	s0,0(sp)
    80001c78:	01010113          	addi	sp,sp,16
    80001c7c:	00008067          	ret

0000000080001c80 <time_sleep>:
#ifdef __cplusplus
extern "C"
#endif
int time_sleep(time_t t)
{
    if (t == 0)
    80001c80:	00051663          	bnez	a0,80001c8c <time_sleep+0xc>
        return 0;
    80001c84:	00000513          	li	a0,0
    __ecall_interrupt(SLEEP, t);

    uint64 res;
    __asm__ volatile("mv %0, a0": "=r"(res));
    return (int)res;
}
    80001c88:	00008067          	ret
{
    80001c8c:	ff010113          	addi	sp,sp,-16
    80001c90:	00113423          	sd	ra,8(sp)
    80001c94:	00813023          	sd	s0,0(sp)
    80001c98:	01010413          	addi	s0,sp,16
    __ecall_interrupt(SLEEP, t);
    80001c9c:	00050593          	mv	a1,a0
    80001ca0:	03100513          	li	a0,49
    80001ca4:	00000097          	auipc	ra,0x0
    80001ca8:	d18080e7          	jalr	-744(ra) # 800019bc <__ecall_interrupt>
    __asm__ volatile("mv %0, a0": "=r"(res));
    80001cac:	00050513          	mv	a0,a0
    return (int)res;
    80001cb0:	0005051b          	sext.w	a0,a0
}
    80001cb4:	00813083          	ld	ra,8(sp)
    80001cb8:	00013403          	ld	s0,0(sp)
    80001cbc:	01010113          	addi	sp,sp,16
    80001cc0:	00008067          	ret

0000000080001cc4 <disable_interrupt>:

#ifdef __cplusplus
extern "C"
#endif
void disable_interrupt()
{
    80001cc4:	ff010113          	addi	sp,sp,-16
    80001cc8:	00113423          	sd	ra,8(sp)
    80001ccc:	00813023          	sd	s0,0(sp)
    80001cd0:	01010413          	addi	s0,sp,16
    __ecall_interrupt(DISABLE_INTERRUPT);
    80001cd4:	06000513          	li	a0,96
    80001cd8:	00000097          	auipc	ra,0x0
    80001cdc:	ce4080e7          	jalr	-796(ra) # 800019bc <__ecall_interrupt>
}
    80001ce0:	00813083          	ld	ra,8(sp)
    80001ce4:	00013403          	ld	s0,0(sp)
    80001ce8:	01010113          	addi	sp,sp,16
    80001cec:	00008067          	ret

0000000080001cf0 <enable_interrupt>:

#ifdef __cplusplus
extern "C"
#endif
void enable_interrupt()
{
    80001cf0:	ff010113          	addi	sp,sp,-16
    80001cf4:	00113423          	sd	ra,8(sp)
    80001cf8:	00813023          	sd	s0,0(sp)
    80001cfc:	01010413          	addi	s0,sp,16
    __ecall_interrupt(ENABLE_INTERRUPT);
    80001d00:	06100513          	li	a0,97
    80001d04:	00000097          	auipc	ra,0x0
    80001d08:	cb8080e7          	jalr	-840(ra) # 800019bc <__ecall_interrupt>
}
    80001d0c:	00813083          	ld	ra,8(sp)
    80001d10:	00013403          	ld	s0,0(sp)
    80001d14:	01010113          	addi	sp,sp,16
    80001d18:	00008067          	ret

0000000080001d1c <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    80001d1c:	fe010113          	addi	sp,sp,-32
    80001d20:	00113c23          	sd	ra,24(sp)
    80001d24:	00813823          	sd	s0,16(sp)
    80001d28:	00913423          	sd	s1,8(sp)
    80001d2c:	01213023          	sd	s2,0(sp)
    80001d30:	02010413          	addi	s0,sp,32
    80001d34:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80001d38:	00000913          	li	s2,0
    80001d3c:	00c0006f          	j	80001d48 <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80001d40:	00000097          	auipc	ra,0x0
    80001d44:	d68080e7          	jalr	-664(ra) # 80001aa8 <thread_dispatch>
    while ((key = getc()) != 0x1b) {
    80001d48:	00000097          	auipc	ra,0x0
    80001d4c:	f04080e7          	jalr	-252(ra) # 80001c4c <getc>
    80001d50:	0005059b          	sext.w	a1,a0
    80001d54:	01b00793          	li	a5,27
    80001d58:	02f58a63          	beq	a1,a5,80001d8c <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    80001d5c:	0084b503          	ld	a0,8(s1)
    80001d60:	00005097          	auipc	ra,0x5
    80001d64:	2a8080e7          	jalr	680(ra) # 80007008 <_ZN6Buffer3putEi>
        i++;
    80001d68:	0019071b          	addiw	a4,s2,1
    80001d6c:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80001d70:	0004a683          	lw	a3,0(s1)
    80001d74:	0026979b          	slliw	a5,a3,0x2
    80001d78:	00d787bb          	addw	a5,a5,a3
    80001d7c:	0017979b          	slliw	a5,a5,0x1
    80001d80:	02f767bb          	remw	a5,a4,a5
    80001d84:	fc0792e3          	bnez	a5,80001d48 <_ZL16producerKeyboardPv+0x2c>
    80001d88:	fb9ff06f          	j	80001d40 <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    80001d8c:	00100793          	li	a5,1
    80001d90:	0000b717          	auipc	a4,0xb
    80001d94:	ccf72023          	sw	a5,-832(a4) # 8000ca50 <_ZL9threadEnd>
    data->buffer->put('!');
    80001d98:	02100593          	li	a1,33
    80001d9c:	0084b503          	ld	a0,8(s1)
    80001da0:	00005097          	auipc	ra,0x5
    80001da4:	268080e7          	jalr	616(ra) # 80007008 <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    80001da8:	0104b503          	ld	a0,16(s1)
    80001dac:	00000097          	auipc	ra,0x0
    80001db0:	e08080e7          	jalr	-504(ra) # 80001bb4 <sem_signal>
}
    80001db4:	01813083          	ld	ra,24(sp)
    80001db8:	01013403          	ld	s0,16(sp)
    80001dbc:	00813483          	ld	s1,8(sp)
    80001dc0:	00013903          	ld	s2,0(sp)
    80001dc4:	02010113          	addi	sp,sp,32
    80001dc8:	00008067          	ret

0000000080001dcc <_ZL8producerPv>:

static void producer(void *arg) {
    80001dcc:	fe010113          	addi	sp,sp,-32
    80001dd0:	00113c23          	sd	ra,24(sp)
    80001dd4:	00813823          	sd	s0,16(sp)
    80001dd8:	00913423          	sd	s1,8(sp)
    80001ddc:	01213023          	sd	s2,0(sp)
    80001de0:	02010413          	addi	s0,sp,32
    80001de4:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80001de8:	00000913          	li	s2,0
    80001dec:	00c0006f          	j	80001df8 <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80001df0:	00000097          	auipc	ra,0x0
    80001df4:	cb8080e7          	jalr	-840(ra) # 80001aa8 <thread_dispatch>
    while (!threadEnd) {
    80001df8:	0000b797          	auipc	a5,0xb
    80001dfc:	c587a783          	lw	a5,-936(a5) # 8000ca50 <_ZL9threadEnd>
    80001e00:	02079e63          	bnez	a5,80001e3c <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    80001e04:	0004a583          	lw	a1,0(s1)
    80001e08:	0305859b          	addiw	a1,a1,48
    80001e0c:	0084b503          	ld	a0,8(s1)
    80001e10:	00005097          	auipc	ra,0x5
    80001e14:	1f8080e7          	jalr	504(ra) # 80007008 <_ZN6Buffer3putEi>
        i++;
    80001e18:	0019071b          	addiw	a4,s2,1
    80001e1c:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80001e20:	0004a683          	lw	a3,0(s1)
    80001e24:	0026979b          	slliw	a5,a3,0x2
    80001e28:	00d787bb          	addw	a5,a5,a3
    80001e2c:	0017979b          	slliw	a5,a5,0x1
    80001e30:	02f767bb          	remw	a5,a4,a5
    80001e34:	fc0792e3          	bnez	a5,80001df8 <_ZL8producerPv+0x2c>
    80001e38:	fb9ff06f          	j	80001df0 <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    80001e3c:	0104b503          	ld	a0,16(s1)
    80001e40:	00000097          	auipc	ra,0x0
    80001e44:	d74080e7          	jalr	-652(ra) # 80001bb4 <sem_signal>
}
    80001e48:	01813083          	ld	ra,24(sp)
    80001e4c:	01013403          	ld	s0,16(sp)
    80001e50:	00813483          	ld	s1,8(sp)
    80001e54:	00013903          	ld	s2,0(sp)
    80001e58:	02010113          	addi	sp,sp,32
    80001e5c:	00008067          	ret

0000000080001e60 <_ZL8consumerPv>:

static void consumer(void *arg) {
    80001e60:	fd010113          	addi	sp,sp,-48
    80001e64:	02113423          	sd	ra,40(sp)
    80001e68:	02813023          	sd	s0,32(sp)
    80001e6c:	00913c23          	sd	s1,24(sp)
    80001e70:	01213823          	sd	s2,16(sp)
    80001e74:	01313423          	sd	s3,8(sp)
    80001e78:	03010413          	addi	s0,sp,48
    80001e7c:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80001e80:	00000993          	li	s3,0
    80001e84:	01c0006f          	j	80001ea0 <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    80001e88:	00000097          	auipc	ra,0x0
    80001e8c:	c20080e7          	jalr	-992(ra) # 80001aa8 <thread_dispatch>
    80001e90:	0500006f          	j	80001ee0 <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
        putc('\n');
    80001e94:	00a00513          	li	a0,10
    80001e98:	00000097          	auipc	ra,0x0
    80001e9c:	d84080e7          	jalr	-636(ra) # 80001c1c <putc>
    while (!threadEnd) {
    80001ea0:	0000b797          	auipc	a5,0xb
    80001ea4:	bb07a783          	lw	a5,-1104(a5) # 8000ca50 <_ZL9threadEnd>
    80001ea8:	06079063          	bnez	a5,80001f08 <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    80001eac:	00893503          	ld	a0,8(s2)
    80001eb0:	00005097          	auipc	ra,0x5
    80001eb4:	1e8080e7          	jalr	488(ra) # 80007098 <_ZN6Buffer3getEv>
        i++;
    80001eb8:	0019849b          	addiw	s1,s3,1
    80001ebc:	0004899b          	sext.w	s3,s1
        putc(key);
    80001ec0:	0ff57513          	andi	a0,a0,255
    80001ec4:	00000097          	auipc	ra,0x0
    80001ec8:	d58080e7          	jalr	-680(ra) # 80001c1c <putc>
        if (i % (5 * data->id) == 0) {
    80001ecc:	00092703          	lw	a4,0(s2)
    80001ed0:	0027179b          	slliw	a5,a4,0x2
    80001ed4:	00e787bb          	addw	a5,a5,a4
    80001ed8:	02f4e7bb          	remw	a5,s1,a5
    80001edc:	fa0786e3          	beqz	a5,80001e88 <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    80001ee0:	05000793          	li	a5,80
    80001ee4:	02f4e4bb          	remw	s1,s1,a5
    80001ee8:	fa049ce3          	bnez	s1,80001ea0 <_ZL8consumerPv+0x40>
    80001eec:	fa9ff06f          	j	80001e94 <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    80001ef0:	00893503          	ld	a0,8(s2)
    80001ef4:	00005097          	auipc	ra,0x5
    80001ef8:	1a4080e7          	jalr	420(ra) # 80007098 <_ZN6Buffer3getEv>
        putc(key);
    80001efc:	0ff57513          	andi	a0,a0,255
    80001f00:	00000097          	auipc	ra,0x0
    80001f04:	d1c080e7          	jalr	-740(ra) # 80001c1c <putc>
    while (data->buffer->getCnt() > 0) {
    80001f08:	00893503          	ld	a0,8(s2)
    80001f0c:	00005097          	auipc	ra,0x5
    80001f10:	218080e7          	jalr	536(ra) # 80007124 <_ZN6Buffer6getCntEv>
    80001f14:	fca04ee3          	bgtz	a0,80001ef0 <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    80001f18:	01093503          	ld	a0,16(s2)
    80001f1c:	00000097          	auipc	ra,0x0
    80001f20:	c98080e7          	jalr	-872(ra) # 80001bb4 <sem_signal>
}
    80001f24:	02813083          	ld	ra,40(sp)
    80001f28:	02013403          	ld	s0,32(sp)
    80001f2c:	01813483          	ld	s1,24(sp)
    80001f30:	01013903          	ld	s2,16(sp)
    80001f34:	00813983          	ld	s3,8(sp)
    80001f38:	03010113          	addi	sp,sp,48
    80001f3c:	00008067          	ret

0000000080001f40 <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    80001f40:	f9010113          	addi	sp,sp,-112
    80001f44:	06113423          	sd	ra,104(sp)
    80001f48:	06813023          	sd	s0,96(sp)
    80001f4c:	04913c23          	sd	s1,88(sp)
    80001f50:	05213823          	sd	s2,80(sp)
    80001f54:	05313423          	sd	s3,72(sp)
    80001f58:	05413023          	sd	s4,64(sp)
    80001f5c:	03513c23          	sd	s5,56(sp)
    80001f60:	03613823          	sd	s6,48(sp)
    80001f64:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    80001f68:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    80001f6c:	00008517          	auipc	a0,0x8
    80001f70:	0b450513          	addi	a0,a0,180 # 8000a020 <CONSOLE_STATUS+0x10>
    80001f74:	00003097          	auipc	ra,0x3
    80001f78:	b80080e7          	jalr	-1152(ra) # 80004af4 <_Z11printStringPKc>
    getString(input, 30);
    80001f7c:	01e00593          	li	a1,30
    80001f80:	fa040493          	addi	s1,s0,-96
    80001f84:	00048513          	mv	a0,s1
    80001f88:	00003097          	auipc	ra,0x3
    80001f8c:	bf4080e7          	jalr	-1036(ra) # 80004b7c <_Z9getStringPci>
    threadNum = stringToInt(input);
    80001f90:	00048513          	mv	a0,s1
    80001f94:	00003097          	auipc	ra,0x3
    80001f98:	cc0080e7          	jalr	-832(ra) # 80004c54 <_Z11stringToIntPKc>
    80001f9c:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80001fa0:	00008517          	auipc	a0,0x8
    80001fa4:	0a050513          	addi	a0,a0,160 # 8000a040 <CONSOLE_STATUS+0x30>
    80001fa8:	00003097          	auipc	ra,0x3
    80001fac:	b4c080e7          	jalr	-1204(ra) # 80004af4 <_Z11printStringPKc>
    getString(input, 30);
    80001fb0:	01e00593          	li	a1,30
    80001fb4:	00048513          	mv	a0,s1
    80001fb8:	00003097          	auipc	ra,0x3
    80001fbc:	bc4080e7          	jalr	-1084(ra) # 80004b7c <_Z9getStringPci>
    n = stringToInt(input);
    80001fc0:	00048513          	mv	a0,s1
    80001fc4:	00003097          	auipc	ra,0x3
    80001fc8:	c90080e7          	jalr	-880(ra) # 80004c54 <_Z11stringToIntPKc>
    80001fcc:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80001fd0:	00008517          	auipc	a0,0x8
    80001fd4:	09050513          	addi	a0,a0,144 # 8000a060 <CONSOLE_STATUS+0x50>
    80001fd8:	00003097          	auipc	ra,0x3
    80001fdc:	b1c080e7          	jalr	-1252(ra) # 80004af4 <_Z11printStringPKc>
    80001fe0:	00000613          	li	a2,0
    80001fe4:	00a00593          	li	a1,10
    80001fe8:	00090513          	mv	a0,s2
    80001fec:	00003097          	auipc	ra,0x3
    80001ff0:	cb8080e7          	jalr	-840(ra) # 80004ca4 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80001ff4:	00008517          	auipc	a0,0x8
    80001ff8:	08450513          	addi	a0,a0,132 # 8000a078 <CONSOLE_STATUS+0x68>
    80001ffc:	00003097          	auipc	ra,0x3
    80002000:	af8080e7          	jalr	-1288(ra) # 80004af4 <_Z11printStringPKc>
    80002004:	00000613          	li	a2,0
    80002008:	00a00593          	li	a1,10
    8000200c:	00048513          	mv	a0,s1
    80002010:	00003097          	auipc	ra,0x3
    80002014:	c94080e7          	jalr	-876(ra) # 80004ca4 <_Z8printIntiii>
    printString(".\n");
    80002018:	00008517          	auipc	a0,0x8
    8000201c:	07850513          	addi	a0,a0,120 # 8000a090 <CONSOLE_STATUS+0x80>
    80002020:	00003097          	auipc	ra,0x3
    80002024:	ad4080e7          	jalr	-1324(ra) # 80004af4 <_Z11printStringPKc>
    if(threadNum > n) {
    80002028:	0324c463          	blt	s1,s2,80002050 <_Z22producerConsumer_C_APIv+0x110>
    } else if (threadNum < 1) {
    8000202c:	03205c63          	blez	s2,80002064 <_Z22producerConsumer_C_APIv+0x124>
    Buffer *buffer = new Buffer(n);
    80002030:	03800513          	li	a0,56
    80002034:	00004097          	auipc	ra,0x4
    80002038:	804080e7          	jalr	-2044(ra) # 80005838 <_Znwm>
    8000203c:	00050a13          	mv	s4,a0
    80002040:	00048593          	mv	a1,s1
    80002044:	00005097          	auipc	ra,0x5
    80002048:	f28080e7          	jalr	-216(ra) # 80006f6c <_ZN6BufferC1Ei>
    8000204c:	0300006f          	j	8000207c <_Z22producerConsumer_C_APIv+0x13c>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80002050:	00008517          	auipc	a0,0x8
    80002054:	04850513          	addi	a0,a0,72 # 8000a098 <CONSOLE_STATUS+0x88>
    80002058:	00003097          	auipc	ra,0x3
    8000205c:	a9c080e7          	jalr	-1380(ra) # 80004af4 <_Z11printStringPKc>
        return;
    80002060:	0140006f          	j	80002074 <_Z22producerConsumer_C_APIv+0x134>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80002064:	00008517          	auipc	a0,0x8
    80002068:	07450513          	addi	a0,a0,116 # 8000a0d8 <CONSOLE_STATUS+0xc8>
    8000206c:	00003097          	auipc	ra,0x3
    80002070:	a88080e7          	jalr	-1400(ra) # 80004af4 <_Z11printStringPKc>
        return;
    80002074:	000b0113          	mv	sp,s6
    80002078:	1640006f          	j	800021dc <_Z22producerConsumer_C_APIv+0x29c>
    sem_open(&waitForAll, 0);
    8000207c:	00000593          	li	a1,0
    80002080:	0000b517          	auipc	a0,0xb
    80002084:	9d850513          	addi	a0,a0,-1576 # 8000ca58 <_ZL10waitForAll>
    80002088:	00000097          	auipc	ra,0x0
    8000208c:	a80080e7          	jalr	-1408(ra) # 80001b08 <sem_open>
    thread_t threads[threadNum];
    80002090:	00391793          	slli	a5,s2,0x3
    80002094:	00f78793          	addi	a5,a5,15
    80002098:	ff07f793          	andi	a5,a5,-16
    8000209c:	40f10133          	sub	sp,sp,a5
    800020a0:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    800020a4:	0019071b          	addiw	a4,s2,1
    800020a8:	00171793          	slli	a5,a4,0x1
    800020ac:	00e787b3          	add	a5,a5,a4
    800020b0:	00379793          	slli	a5,a5,0x3
    800020b4:	00f78793          	addi	a5,a5,15
    800020b8:	ff07f793          	andi	a5,a5,-16
    800020bc:	40f10133          	sub	sp,sp,a5
    800020c0:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    800020c4:	00191613          	slli	a2,s2,0x1
    800020c8:	012607b3          	add	a5,a2,s2
    800020cc:	00379793          	slli	a5,a5,0x3
    800020d0:	00f987b3          	add	a5,s3,a5
    800020d4:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    800020d8:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    800020dc:	0000b717          	auipc	a4,0xb
    800020e0:	97c73703          	ld	a4,-1668(a4) # 8000ca58 <_ZL10waitForAll>
    800020e4:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    800020e8:	00078613          	mv	a2,a5
    800020ec:	00000597          	auipc	a1,0x0
    800020f0:	d7458593          	addi	a1,a1,-652 # 80001e60 <_ZL8consumerPv>
    800020f4:	f9840513          	addi	a0,s0,-104
    800020f8:	00000097          	auipc	ra,0x0
    800020fc:	970080e7          	jalr	-1680(ra) # 80001a68 <thread_create>
    for (int i = 1; i <= threadNum; i++) {
    80002100:	00100493          	li	s1,1
    80002104:	02c0006f          	j	80002130 <_Z22producerConsumer_C_APIv+0x1f0>
        thread_create(threads + i - 1,
    80002108:	00000597          	auipc	a1,0x0
    8000210c:	c1458593          	addi	a1,a1,-1004 # 80001d1c <_ZL16producerKeyboardPv>
                      data + i - 1);
    80002110:	00179613          	slli	a2,a5,0x1
    80002114:	00f60633          	add	a2,a2,a5
    80002118:	00361613          	slli	a2,a2,0x3
    8000211c:	fe860613          	addi	a2,a2,-24
        thread_create(threads + i - 1,
    80002120:	00c98633          	add	a2,s3,a2
    80002124:	00000097          	auipc	ra,0x0
    80002128:	944080e7          	jalr	-1724(ra) # 80001a68 <thread_create>
    for (int i = 1; i <= threadNum; i++) {
    8000212c:	0014849b          	addiw	s1,s1,1
    80002130:	04994a63          	blt	s2,s1,80002184 <_Z22producerConsumer_C_APIv+0x244>
        data[i-1].id = i;
    80002134:	fff4869b          	addiw	a3,s1,-1
    80002138:	00169793          	slli	a5,a3,0x1
    8000213c:	00d78733          	add	a4,a5,a3
    80002140:	00371713          	slli	a4,a4,0x3
    80002144:	00e98733          	add	a4,s3,a4
    80002148:	00972023          	sw	s1,0(a4)
        data[i-1].buffer = buffer;
    8000214c:	01473423          	sd	s4,8(a4)
        data[i-1].wait = waitForAll;
    80002150:	00070793          	mv	a5,a4
    80002154:	0000b717          	auipc	a4,0xb
    80002158:	90473703          	ld	a4,-1788(a4) # 8000ca58 <_ZL10waitForAll>
    8000215c:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i - 1,
    80002160:	00048793          	mv	a5,s1
    80002164:	00349513          	slli	a0,s1,0x3
    80002168:	ff850513          	addi	a0,a0,-8
    8000216c:	00aa8533          	add	a0,s5,a0
    80002170:	00100713          	li	a4,1
    80002174:	f8975ae3          	bge	a4,s1,80002108 <_Z22producerConsumer_C_APIv+0x1c8>
    80002178:	00000597          	auipc	a1,0x0
    8000217c:	c5458593          	addi	a1,a1,-940 # 80001dcc <_ZL8producerPv>
    80002180:	f91ff06f          	j	80002110 <_Z22producerConsumer_C_APIv+0x1d0>
    thread_dispatch();
    80002184:	00000097          	auipc	ra,0x0
    80002188:	924080e7          	jalr	-1756(ra) # 80001aa8 <thread_dispatch>
    for (int i = 0; i <= threadNum; i++) {
    8000218c:	00000493          	li	s1,0
    80002190:	00994e63          	blt	s2,s1,800021ac <_Z22producerConsumer_C_APIv+0x26c>
        sem_wait(waitForAll);
    80002194:	0000b517          	auipc	a0,0xb
    80002198:	8c453503          	ld	a0,-1852(a0) # 8000ca58 <_ZL10waitForAll>
    8000219c:	00000097          	auipc	ra,0x0
    800021a0:	9e0080e7          	jalr	-1568(ra) # 80001b7c <sem_wait>
    for (int i = 0; i <= threadNum; i++) {
    800021a4:	0014849b          	addiw	s1,s1,1
    800021a8:	fe9ff06f          	j	80002190 <_Z22producerConsumer_C_APIv+0x250>
    sem_close(waitForAll);
    800021ac:	0000b517          	auipc	a0,0xb
    800021b0:	8ac53503          	ld	a0,-1876(a0) # 8000ca58 <_ZL10waitForAll>
    800021b4:	00000097          	auipc	ra,0x0
    800021b8:	990080e7          	jalr	-1648(ra) # 80001b44 <sem_close>
    delete buffer;
    800021bc:	000a0e63          	beqz	s4,800021d8 <_Z22producerConsumer_C_APIv+0x298>
    800021c0:	000a0513          	mv	a0,s4
    800021c4:	00005097          	auipc	ra,0x5
    800021c8:	fe8080e7          	jalr	-24(ra) # 800071ac <_ZN6BufferD1Ev>
    800021cc:	000a0513          	mv	a0,s4
    800021d0:	00003097          	auipc	ra,0x3
    800021d4:	690080e7          	jalr	1680(ra) # 80005860 <_ZdlPv>
    800021d8:	000b0113          	mv	sp,s6

}
    800021dc:	f9040113          	addi	sp,s0,-112
    800021e0:	06813083          	ld	ra,104(sp)
    800021e4:	06013403          	ld	s0,96(sp)
    800021e8:	05813483          	ld	s1,88(sp)
    800021ec:	05013903          	ld	s2,80(sp)
    800021f0:	04813983          	ld	s3,72(sp)
    800021f4:	04013a03          	ld	s4,64(sp)
    800021f8:	03813a83          	ld	s5,56(sp)
    800021fc:	03013b03          	ld	s6,48(sp)
    80002200:	07010113          	addi	sp,sp,112
    80002204:	00008067          	ret
    80002208:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    8000220c:	000a0513          	mv	a0,s4
    80002210:	00003097          	auipc	ra,0x3
    80002214:	650080e7          	jalr	1616(ra) # 80005860 <_ZdlPv>
    80002218:	00048513          	mv	a0,s1
    8000221c:	0000c097          	auipc	ra,0xc
    80002220:	9ac080e7          	jalr	-1620(ra) # 8000dbc8 <_Unwind_Resume>

0000000080002224 <_ZN7_thread18cmpSleepingThreadsEPNS_14SleepingThreadES1_>:
{
    _sem::wait(thread->threadsToActivate);
}

bool _thread::cmpSleepingThreads(_thread::SleepingThread *threadInList, _thread::SleepingThread *threadToAdd)
{
    80002224:	ff010113          	addi	sp,sp,-16
    80002228:	00813423          	sd	s0,8(sp)
    8000222c:	01010413          	addi	s0,sp,16
    if (threadInList->sleepingTime  <= threadToAdd->sleepingTime)
    80002230:	00853703          	ld	a4,8(a0)
    80002234:	0085b783          	ld	a5,8(a1)
    80002238:	00e7fa63          	bgeu	a5,a4,8000224c <_ZN7_thread18cmpSleepingThreadsEPNS_14SleepingThreadES1_+0x28>
        return true;
    return false;
    8000223c:	00000513          	li	a0,0
}
    80002240:	00813403          	ld	s0,8(sp)
    80002244:	01010113          	addi	sp,sp,16
    80002248:	00008067          	ret
        return true;
    8000224c:	00100513          	li	a0,1
    80002250:	ff1ff06f          	j	80002240 <_ZN7_thread18cmpSleepingThreadsEPNS_14SleepingThreadES1_+0x1c>

0000000080002254 <_ZN7_thread8dispatchEv>:
{
    80002254:	fe010113          	addi	sp,sp,-32
    80002258:	00113c23          	sd	ra,24(sp)
    8000225c:	00813823          	sd	s0,16(sp)
    80002260:	00913423          	sd	s1,8(sp)
    80002264:	02010413          	addi	s0,sp,32
    thread_t old = running;
    80002268:	0000a497          	auipc	s1,0xa
    8000226c:	7f84b483          	ld	s1,2040(s1) # 8000ca60 <_ZN7_thread7runningE>
    if (running->currentState == ACTIVE)
    80002270:	13c4a783          	lw	a5,316(s1)
    80002274:	00079663          	bnez	a5,80002280 <_ZN7_thread8dispatchEv+0x2c>
        running->currentState = READY;
    80002278:	00100793          	li	a5,1
    8000227c:	12f4ae23          	sw	a5,316(s1)
    if (running->currentState != BLOCKED && !running->finished)
    80002280:	13c4a703          	lw	a4,316(s1)
    80002284:	00200793          	li	a5,2
    80002288:	00f70663          	beq	a4,a5,80002294 <_ZN7_thread8dispatchEv+0x40>
    8000228c:	1204c783          	lbu	a5,288(s1)
    80002290:	04078a63          	beqz	a5,800022e4 <_ZN7_thread8dispatchEv+0x90>
    running = Scheduler::get();
    80002294:	00003097          	auipc	ra,0x3
    80002298:	11c080e7          	jalr	284(ra) # 800053b0 <_ZN9Scheduler3getEv>
    8000229c:	0000a797          	auipc	a5,0xa
    800022a0:	7ca7b223          	sd	a0,1988(a5) # 8000ca60 <_ZN7_thread7runningE>
    running->currentState = ACTIVE;
    800022a4:	12052e23          	sw	zero,316(a0)
    void* stack = (void*)(&running->context.x[0]);
    800022a8:	00050613          	mv	a2,a0
    if (running->context.x[1] == (uint64)(&threadWrapper) && running->body)
    800022ac:	00853703          	ld	a4,8(a0)
    800022b0:	00000797          	auipc	a5,0x0
    800022b4:	0ac78793          	addi	a5,a5,172 # 8000235c <_ZN7_thread13threadWrapperEv>
    800022b8:	02f70e63          	beq	a4,a5,800022f4 <_ZN7_thread8dispatchEv+0xa0>
    contextSwitch(&old->context, &running->context, stack);
    800022bc:	0000a597          	auipc	a1,0xa
    800022c0:	7a45b583          	ld	a1,1956(a1) # 8000ca60 <_ZN7_thread7runningE>
    800022c4:	00048513          	mv	a0,s1
    800022c8:	fffff097          	auipc	ra,0xfffff
    800022cc:	120080e7          	jalr	288(ra) # 800013e8 <_ZN7_thread13contextSwitchEPNS_7ContextES1_Pv>
}
    800022d0:	01813083          	ld	ra,24(sp)
    800022d4:	01013403          	ld	s0,16(sp)
    800022d8:	00813483          	ld	s1,8(sp)
    800022dc:	02010113          	addi	sp,sp,32
    800022e0:	00008067          	ret
        Scheduler::put(running);
    800022e4:	00048513          	mv	a0,s1
    800022e8:	00003097          	auipc	ra,0x3
    800022ec:	028080e7          	jalr	40(ra) # 80005310 <_ZN9Scheduler3putEP7_thread>
    800022f0:	fa5ff06f          	j	80002294 <_ZN7_thread8dispatchEv+0x40>
    if (running->context.x[1] == (uint64)(&threadWrapper) && running->body)
    800022f4:	12853783          	ld	a5,296(a0)
    800022f8:	fc0782e3          	beqz	a5,800022bc <_ZN7_thread8dispatchEv+0x68>
        __asm__ volatile("csrr %0, sstatus" : "=r"(running->context.x[33]));
    800022fc:	100027f3          	csrr	a5,sstatus
    80002300:	10f53423          	sd	a5,264(a0)
        stack = (void*)(&running->context.x[2]);
    80002304:	01050613          	addi	a2,a0,16
    80002308:	fb5ff06f          	j	800022bc <_ZN7_thread8dispatchEv+0x68>

000000008000230c <_ZN7_thread12setNewThreadEv>:
{
    8000230c:	ff010113          	addi	sp,sp,-16
    80002310:	00813423          	sd	s0,8(sp)
    80002314:	01010413          	addi	s0,sp,16
    if (!running->isKernelThread)
    80002318:	0000a797          	auipc	a5,0xa
    8000231c:	7487b783          	ld	a5,1864(a5) # 8000ca60 <_ZN7_thread7runningE>
    80002320:	1487c783          	lbu	a5,328(a5)
    80002324:	02079463          	bnez	a5,8000234c <_ZN7_thread12setNewThreadEv+0x40>
        __asm__ volatile("csrr %0, sstatus": "=r"(sstatus));
    80002328:	100027f3          	csrr	a5,sstatus
        sstatus &= ~(1ULL << 8);
    8000232c:	eff7f793          	andi	a5,a5,-257
        sstatus |= (1ULL << 5);
    80002330:	0207e793          	ori	a5,a5,32
        __asm__ volatile("csrw sstatus, %0": : "r"(sstatus));
    80002334:	10079073          	csrw	sstatus,a5
    __asm__ volatile("csrw sepc, ra");
    80002338:	14109073          	csrw	sepc,ra
    __asm__ volatile("sret");
    8000233c:	10200073          	sret
}
    80002340:	00813403          	ld	s0,8(sp)
    80002344:	01010113          	addi	sp,sp,16
    80002348:	00008067          	ret
        __asm__ volatile("csrr %0, sstatus": "=r"(sstatus));
    8000234c:	100027f3          	csrr	a5,sstatus
        sstatus |= (1ULL << 8);
    80002350:	1207e793          	ori	a5,a5,288
        __asm__ volatile("csrw sstatus, %0": : "r"(sstatus));
    80002354:	10079073          	csrw	sstatus,a5
    80002358:	fe1ff06f          	j	80002338 <_ZN7_thread12setNewThreadEv+0x2c>

000000008000235c <_ZN7_thread13threadWrapperEv>:
{
    8000235c:	ff010113          	addi	sp,sp,-16
    80002360:	00113423          	sd	ra,8(sp)
    80002364:	00813023          	sd	s0,0(sp)
    80002368:	01010413          	addi	s0,sp,16
    __asm__ volatile("mv ra, x0");
    8000236c:	00000093          	li	ra,0
    setNewThread();
    80002370:	00000097          	auipc	ra,0x0
    80002374:	f9c080e7          	jalr	-100(ra) # 8000230c <_ZN7_thread12setNewThreadEv>
    if (running->body)
    80002378:	0000a717          	auipc	a4,0xa
    8000237c:	6e873703          	ld	a4,1768(a4) # 8000ca60 <_ZN7_thread7runningE>
    80002380:	12873783          	ld	a5,296(a4)
    80002384:	00078663          	beqz	a5,80002390 <_ZN7_thread13threadWrapperEv+0x34>
        running->body(running->arguments);
    80002388:	13073503          	ld	a0,304(a4)
    8000238c:	000780e7          	jalr	a5
    ::thread_exit();
    80002390:	fffff097          	auipc	ra,0xfffff
    80002394:	744080e7          	jalr	1860(ra) # 80001ad4 <thread_exit>
}
    80002398:	00813083          	ld	ra,8(sp)
    8000239c:	00013403          	ld	s0,0(sp)
    800023a0:	01010113          	addi	sp,sp,16
    800023a4:	00008067          	ret

00000000800023a8 <_ZN7_thread10isFinishedEv>:
{
    800023a8:	ff010113          	addi	sp,sp,-16
    800023ac:	00813423          	sd	s0,8(sp)
    800023b0:	01010413          	addi	s0,sp,16
}
    800023b4:	12054503          	lbu	a0,288(a0)
    800023b8:	00813403          	ld	s0,8(sp)
    800023bc:	01010113          	addi	sp,sp,16
    800023c0:	00008067          	ret

00000000800023c4 <_ZN7_thread11thread_exitEv>:
    running->finished = true;
    800023c4:	0000a797          	auipc	a5,0xa
    800023c8:	69c7b783          	ld	a5,1692(a5) # 8000ca60 <_ZN7_thread7runningE>
    800023cc:	00100713          	li	a4,1
    800023d0:	12e78023          	sb	a4,288(a5)
    if (running->body == nullptr)
    800023d4:	1287b783          	ld	a5,296(a5)
    800023d8:	08078e63          	beqz	a5,80002474 <_ZN7_thread11thread_exitEv+0xb0>
{
    800023dc:	ff010113          	addi	sp,sp,-16
    800023e0:	00113423          	sd	ra,8(sp)
    800023e4:	00813023          	sd	s0,0(sp)
    800023e8:	01010413          	addi	s0,sp,16
    res = MemoryAllocator::__get_instance()->__mem_free(running->stack);
    800023ec:	00004097          	auipc	ra,0x4
    800023f0:	348080e7          	jalr	840(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    800023f4:	0000a797          	auipc	a5,0xa
    800023f8:	66c7b783          	ld	a5,1644(a5) # 8000ca60 <_ZN7_thread7runningE>
    800023fc:	1107b583          	ld	a1,272(a5)
    80002400:	00004097          	auipc	ra,0x4
    80002404:	524080e7          	jalr	1316(ra) # 80006924 <_ZN15MemoryAllocator10__mem_freeEPv>
    if (res < 0)
    80002408:	06054a63          	bltz	a0,8000247c <_ZN7_thread11thread_exitEv+0xb8>
    res = MemoryAllocator::__get_instance()->__mem_free(running->kernelStack);
    8000240c:	00004097          	auipc	ra,0x4
    80002410:	328080e7          	jalr	808(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80002414:	0000a797          	auipc	a5,0xa
    80002418:	64c7b783          	ld	a5,1612(a5) # 8000ca60 <_ZN7_thread7runningE>
    8000241c:	1187b583          	ld	a1,280(a5)
    80002420:	00004097          	auipc	ra,0x4
    80002424:	504080e7          	jalr	1284(ra) # 80006924 <_ZN15MemoryAllocator10__mem_freeEPv>
    if (res < 0)
    80002428:	04054e63          	bltz	a0,80002484 <_ZN7_thread11thread_exitEv+0xc0>
    res = _sem::close(running->threadsToActivate, ZERO);
    8000242c:	00000593          	li	a1,0
    80002430:	0000a797          	auipc	a5,0xa
    80002434:	6307b783          	ld	a5,1584(a5) # 8000ca60 <_ZN7_thread7runningE>
    80002438:	1407b503          	ld	a0,320(a5)
    8000243c:	00004097          	auipc	ra,0x4
    80002440:	97c080e7          	jalr	-1668(ra) # 80005db8 <_ZN4_sem5closeEPS_N7_thread14semReturnValueE>
    if (res < 0)
    80002444:	04054463          	bltz	a0,8000248c <_ZN7_thread11thread_exitEv+0xc8>
    running->currentState = BLOCKED;
    80002448:	0000a797          	auipc	a5,0xa
    8000244c:	6187b783          	ld	a5,1560(a5) # 8000ca60 <_ZN7_thread7runningE>
    80002450:	00200713          	li	a4,2
    80002454:	12e7ae23          	sw	a4,316(a5)
    dispatch();
    80002458:	00000097          	auipc	ra,0x0
    8000245c:	dfc080e7          	jalr	-516(ra) # 80002254 <_ZN7_thread8dispatchEv>
    return 0;
    80002460:	00000513          	li	a0,0
}
    80002464:	00813083          	ld	ra,8(sp)
    80002468:	00013403          	ld	s0,0(sp)
    8000246c:	01010113          	addi	sp,sp,16
    80002470:	00008067          	ret
        return -1;
    80002474:	fff00513          	li	a0,-1
}
    80002478:	00008067          	ret
        return -1;
    8000247c:	fff00513          	li	a0,-1
    80002480:	fe5ff06f          	j	80002464 <_ZN7_thread11thread_exitEv+0xa0>
        return -1;
    80002484:	fff00513          	li	a0,-1
    80002488:	fddff06f          	j	80002464 <_ZN7_thread11thread_exitEv+0xa0>
        return -1;
    8000248c:	fff00513          	li	a0,-1
    80002490:	fd5ff06f          	j	80002464 <_ZN7_thread11thread_exitEv+0xa0>

0000000080002494 <_ZN7_thread11thread_joinEPS_>:
{
    80002494:	ff010113          	addi	sp,sp,-16
    80002498:	00113423          	sd	ra,8(sp)
    8000249c:	00813023          	sd	s0,0(sp)
    800024a0:	01010413          	addi	s0,sp,16
    _sem::wait(thread->threadsToActivate);
    800024a4:	14053503          	ld	a0,320(a0)
    800024a8:	00004097          	auipc	ra,0x4
    800024ac:	a4c080e7          	jalr	-1460(ra) # 80005ef4 <_ZN4_sem4waitEPS_>
}
    800024b0:	00813083          	ld	ra,8(sp)
    800024b4:	00013403          	ld	s0,0(sp)
    800024b8:	01010113          	addi	sp,sp,16
    800024bc:	00008067          	ret

00000000800024c0 <_ZN7_thread12thread_blockEv>:
        relativeSleepTimer = 0;
    }
}

void _thread::thread_block()
{
    800024c0:	ff010113          	addi	sp,sp,-16
    800024c4:	00113423          	sd	ra,8(sp)
    800024c8:	00813023          	sd	s0,0(sp)
    800024cc:	01010413          	addi	s0,sp,16
    _thread::running->currentState = BLOCKED;
    800024d0:	0000a797          	auipc	a5,0xa
    800024d4:	5907b783          	ld	a5,1424(a5) # 8000ca60 <_ZN7_thread7runningE>
    800024d8:	00200713          	li	a4,2
    800024dc:	12e7ae23          	sw	a4,316(a5)
    dispatch();
    800024e0:	00000097          	auipc	ra,0x0
    800024e4:	d74080e7          	jalr	-652(ra) # 80002254 <_ZN7_thread8dispatchEv>
}
    800024e8:	00813083          	ld	ra,8(sp)
    800024ec:	00013403          	ld	s0,0(sp)
    800024f0:	01010113          	addi	sp,sp,16
    800024f4:	00008067          	ret

00000000800024f8 <_ZN7_thread13thread_createEPFvPvES0_bb>:
{
    800024f8:	fc010113          	addi	sp,sp,-64
    800024fc:	02113c23          	sd	ra,56(sp)
    80002500:	02813823          	sd	s0,48(sp)
    80002504:	02913423          	sd	s1,40(sp)
    80002508:	03213023          	sd	s2,32(sp)
    8000250c:	01313c23          	sd	s3,24(sp)
    80002510:	01413823          	sd	s4,16(sp)
    80002514:	01513423          	sd	s5,8(sp)
    80002518:	01613023          	sd	s6,0(sp)
    8000251c:	04010413          	addi	s0,sp,64
    80002520:	00050913          	mv	s2,a0
    80002524:	00058a93          	mv	s5,a1
    80002528:	00060993          	mv	s3,a2
    8000252c:	00068a13          	mv	s4,a3
    thread_t thread = (thread_t)MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(sizeof(_thread)));
    80002530:	00004097          	auipc	ra,0x4
    80002534:	204080e7          	jalr	516(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80002538:	00050493          	mv	s1,a0
    8000253c:	15000513          	li	a0,336
    80002540:	00004097          	auipc	ra,0x4
    80002544:	544080e7          	jalr	1348(ra) # 80006a84 <_ZN15MemoryAllocator19__convert_to_blocksEm>
    80002548:	00050593          	mv	a1,a0
    8000254c:	00048513          	mv	a0,s1
    80002550:	00004097          	auipc	ra,0x4
    80002554:	288080e7          	jalr	648(ra) # 800067d8 <_ZN15MemoryAllocator11__mem_allocEm>
    80002558:	00050493          	mv	s1,a0
    if (!thread)
    8000255c:	0e050c63          	beqz	a0,80002654 <_ZN7_thread13thread_createEPFvPvES0_bb+0x15c>
    thread->stack = routine ? (uint64*)MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(DEFAULT_STACK_SIZE)) : 0;  // check if thread is main
    80002560:	08090263          	beqz	s2,800025e4 <_ZN7_thread13thread_createEPFvPvES0_bb+0xec>
    80002564:	00004097          	auipc	ra,0x4
    80002568:	1d0080e7          	jalr	464(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    8000256c:	00050b13          	mv	s6,a0
    80002570:	00001537          	lui	a0,0x1
    80002574:	00004097          	auipc	ra,0x4
    80002578:	510080e7          	jalr	1296(ra) # 80006a84 <_ZN15MemoryAllocator19__convert_to_blocksEm>
    8000257c:	00050593          	mv	a1,a0
    80002580:	000b0513          	mv	a0,s6
    80002584:	00004097          	auipc	ra,0x4
    80002588:	254080e7          	jalr	596(ra) # 800067d8 <_ZN15MemoryAllocator11__mem_allocEm>
    8000258c:	10a4b823          	sd	a0,272(s1)
    thread->kernelStack = (uint64*) MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(DEFAULT_STACK_SIZE));
    80002590:	00004097          	auipc	ra,0x4
    80002594:	1a4080e7          	jalr	420(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80002598:	00050b13          	mv	s6,a0
    8000259c:	00001537          	lui	a0,0x1
    800025a0:	00004097          	auipc	ra,0x4
    800025a4:	4e4080e7          	jalr	1252(ra) # 80006a84 <_ZN15MemoryAllocator19__convert_to_blocksEm>
    800025a8:	00050593          	mv	a1,a0
    800025ac:	000b0513          	mv	a0,s6
    800025b0:	00004097          	auipc	ra,0x4
    800025b4:	228080e7          	jalr	552(ra) # 800067d8 <_ZN15MemoryAllocator11__mem_allocEm>
    800025b8:	10a4bc23          	sd	a0,280(s1)
    thread->finished = false;
    800025bc:	12048023          	sb	zero,288(s1)
    thread->body = routine;
    800025c0:	1324b423          	sd	s2,296(s1)
    for(int i = 0; i < 34; ++i)
    800025c4:	00000793          	li	a5,0
    800025c8:	02100713          	li	a4,33
    800025cc:	02f74063          	blt	a4,a5,800025ec <_ZN7_thread13thread_createEPFvPvES0_bb+0xf4>
        thread->context.x[i] = 0;
    800025d0:	00379713          	slli	a4,a5,0x3
    800025d4:	00e48733          	add	a4,s1,a4
    800025d8:	00073023          	sd	zero,0(a4)
    for(int i = 0; i < 34; ++i)
    800025dc:	0017879b          	addiw	a5,a5,1
    800025e0:	fe9ff06f          	j	800025c8 <_ZN7_thread13thread_createEPFvPvES0_bb+0xd0>
    thread->stack = routine ? (uint64*)MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(DEFAULT_STACK_SIZE)) : 0;  // check if thread is main
    800025e4:	00000513          	li	a0,0
    800025e8:	fa5ff06f          	j	8000258c <_ZN7_thread13thread_createEPFvPvES0_bb+0x94>
    thread->context.x[2] = (uint64)thread->stack + DEFAULT_STACK_SIZE - (((size_t)thread->stack + DEFAULT_STACK_SIZE) % 16);
    800025ec:	1104b703          	ld	a4,272(s1)
    800025f0:	ff077713          	andi	a4,a4,-16
    800025f4:	000017b7          	lui	a5,0x1
    800025f8:	00f70733          	add	a4,a4,a5
    800025fc:	00e4b823          	sd	a4,16(s1)
    thread->context.x[0] = (size_t)thread->kernelStack + DEFAULT_STACK_SIZE - (((size_t)thread->kernelStack + DEFAULT_STACK_SIZE) % 16);
    80002600:	ff057513          	andi	a0,a0,-16
    80002604:	00f507b3          	add	a5,a0,a5
    80002608:	00f4b023          	sd	a5,0(s1)
    thread->context.x[1] = (uint64)(&threadWrapper);
    8000260c:	00000797          	auipc	a5,0x0
    80002610:	d5078793          	addi	a5,a5,-688 # 8000235c <_ZN7_thread13threadWrapperEv>
    80002614:	00f4b423          	sd	a5,8(s1)
    thread->arguments = arg;
    80002618:	1354b823          	sd	s5,304(s1)
    if (routine && start)
    8000261c:	06090263          	beqz	s2,80002680 <_ZN7_thread13thread_createEPFvPvES0_bb+0x188>
    80002620:	06098063          	beqz	s3,80002680 <_ZN7_thread13thread_createEPFvPvES0_bb+0x188>
        thread->currentState = READY;
    80002624:	00100793          	li	a5,1
    80002628:	12f4ae23          	sw	a5,316(s1)
    if (!sleepingThreads)
    8000262c:	0000a797          	auipc	a5,0xa
    80002630:	43c7b783          	ld	a5,1084(a5) # 8000ca68 <_ZN7_thread15sleepingThreadsE>
    80002634:	06078663          	beqz	a5,800026a0 <_ZN7_thread13thread_createEPFvPvES0_bb+0x1a8>
    if (routine)
    80002638:	00090a63          	beqz	s2,8000264c <_ZN7_thread13thread_createEPFvPvES0_bb+0x154>
        thread->threadsToActivate = _sem::semaphore_create(0);
    8000263c:	00000513          	li	a0,0
    80002640:	00003097          	auipc	ra,0x3
    80002644:	6f4080e7          	jalr	1780(ra) # 80005d34 <_ZN4_sem16semaphore_createEj>
    80002648:	14a4b023          	sd	a0,320(s1)
    thread->isKernelThread = isKernelThread;
    8000264c:	15448423          	sb	s4,328(s1)
    if (start)
    80002650:	06099663          	bnez	s3,800026bc <_ZN7_thread13thread_createEPFvPvES0_bb+0x1c4>
}
    80002654:	00048513          	mv	a0,s1
    80002658:	03813083          	ld	ra,56(sp)
    8000265c:	03013403          	ld	s0,48(sp)
    80002660:	02813483          	ld	s1,40(sp)
    80002664:	02013903          	ld	s2,32(sp)
    80002668:	01813983          	ld	s3,24(sp)
    8000266c:	01013a03          	ld	s4,16(sp)
    80002670:	00813a83          	ld	s5,8(sp)
    80002674:	00013b03          	ld	s6,0(sp)
    80002678:	04010113          	addi	sp,sp,64
    8000267c:	00008067          	ret
    else if (routine && !start)
    80002680:	00090a63          	beqz	s2,80002694 <_ZN7_thread13thread_createEPFvPvES0_bb+0x19c>
    80002684:	00099863          	bnez	s3,80002694 <_ZN7_thread13thread_createEPFvPvES0_bb+0x19c>
        thread->currentState = BLOCKED;
    80002688:	00200793          	li	a5,2
    8000268c:	12f4ae23          	sw	a5,316(s1)
    80002690:	f9dff06f          	j	8000262c <_ZN7_thread13thread_createEPFvPvES0_bb+0x134>
    else if (!routine)
    80002694:	f8091ce3          	bnez	s2,8000262c <_ZN7_thread13thread_createEPFvPvES0_bb+0x134>
        thread->currentState = ACTIVE;
    80002698:	1204ae23          	sw	zero,316(s1)
    8000269c:	f91ff06f          	j	8000262c <_ZN7_thread13thread_createEPFvPvES0_bb+0x134>
        sleepingThreads = List<SleepingThread>::list_create();
    800026a0:	00000097          	auipc	ra,0x0
    800026a4:	210080e7          	jalr	528(ra) # 800028b0 <_ZN4ListIN7_thread14SleepingThreadEE11list_createEv>
    800026a8:	0000a797          	auipc	a5,0xa
    800026ac:	3ca7b023          	sd	a0,960(a5) # 8000ca68 <_ZN7_thread15sleepingThreadsE>
        if (!sleepingThreads)
    800026b0:	f80514e3          	bnez	a0,80002638 <_ZN7_thread13thread_createEPFvPvES0_bb+0x140>
            return nullptr;
    800026b4:	00050493          	mv	s1,a0
    800026b8:	f9dff06f          	j	80002654 <_ZN7_thread13thread_createEPFvPvES0_bb+0x15c>
        int res = Scheduler::put(thread);
    800026bc:	00048513          	mv	a0,s1
    800026c0:	00003097          	auipc	ra,0x3
    800026c4:	c50080e7          	jalr	-944(ra) # 80005310 <_ZN9Scheduler3putEP7_thread>
        if (res < 0)
    800026c8:	f80556e3          	bgez	a0,80002654 <_ZN7_thread13thread_createEPFvPvES0_bb+0x15c>
            return nullptr;
    800026cc:	00000493          	li	s1,0
    800026d0:	f85ff06f          	j	80002654 <_ZN7_thread13thread_createEPFvPvES0_bb+0x15c>

00000000800026d4 <_ZN7_thread12thread_sleepEm>:
{
    800026d4:	fe010113          	addi	sp,sp,-32
    800026d8:	00113c23          	sd	ra,24(sp)
    800026dc:	00813823          	sd	s0,16(sp)
    800026e0:	00913423          	sd	s1,8(sp)
    800026e4:	01213023          	sd	s2,0(sp)
    800026e8:	02010413          	addi	s0,sp,32
    800026ec:	00050493          	mv	s1,a0
    SleepingThread* newSleepingThread = (SleepingThread*)MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(sizeof(SleepingThread)));
    800026f0:	00004097          	auipc	ra,0x4
    800026f4:	044080e7          	jalr	68(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    800026f8:	00050913          	mv	s2,a0
    800026fc:	01000513          	li	a0,16
    80002700:	00004097          	auipc	ra,0x4
    80002704:	384080e7          	jalr	900(ra) # 80006a84 <_ZN15MemoryAllocator19__convert_to_blocksEm>
    80002708:	00050593          	mv	a1,a0
    8000270c:	00090513          	mv	a0,s2
    80002710:	00004097          	auipc	ra,0x4
    80002714:	0c8080e7          	jalr	200(ra) # 800067d8 <_ZN15MemoryAllocator11__mem_allocEm>
    if (!newSleepingThread)
    80002718:	06050863          	beqz	a0,80002788 <_ZN7_thread12thread_sleepEm+0xb4>
    8000271c:	00050613          	mv	a2,a0
    newSleepingThread->thread = running;
    80002720:	0000a797          	auipc	a5,0xa
    80002724:	34078793          	addi	a5,a5,832 # 8000ca60 <_ZN7_thread7runningE>
    80002728:	0007b703          	ld	a4,0(a5)
    8000272c:	00e53023          	sd	a4,0(a0) # 1000 <_entry-0x7ffff000>
    newSleepingThread->sleepingTime = t + relativeSleepTimer;
    80002730:	0107b503          	ld	a0,16(a5)
    80002734:	00a48533          	add	a0,s1,a0
    80002738:	00a63423          	sd	a0,8(a2)
    int res = sleepingThreads->putInOrder(&cmpSleepingThreads, newSleepingThread);
    8000273c:	00000597          	auipc	a1,0x0
    80002740:	ae858593          	addi	a1,a1,-1304 # 80002224 <_ZN7_thread18cmpSleepingThreadsEPNS_14SleepingThreadES1_>
    80002744:	0087b503          	ld	a0,8(a5)
    80002748:	00000097          	auipc	ra,0x0
    8000274c:	1c8080e7          	jalr	456(ra) # 80002910 <_ZN4ListIN7_thread14SleepingThreadEE10putInOrderEPFbPS1_S3_ES3_>
    if (res < 0)
    80002750:	04054063          	bltz	a0,80002790 <_ZN7_thread12thread_sleepEm+0xbc>
    running->currentState = BLOCKED;
    80002754:	0000a797          	auipc	a5,0xa
    80002758:	30c7b783          	ld	a5,780(a5) # 8000ca60 <_ZN7_thread7runningE>
    8000275c:	00200713          	li	a4,2
    80002760:	12e7ae23          	sw	a4,316(a5)
    dispatch();
    80002764:	00000097          	auipc	ra,0x0
    80002768:	af0080e7          	jalr	-1296(ra) # 80002254 <_ZN7_thread8dispatchEv>
    return 0;
    8000276c:	00000513          	li	a0,0
}
    80002770:	01813083          	ld	ra,24(sp)
    80002774:	01013403          	ld	s0,16(sp)
    80002778:	00813483          	ld	s1,8(sp)
    8000277c:	00013903          	ld	s2,0(sp)
    80002780:	02010113          	addi	sp,sp,32
    80002784:	00008067          	ret
        return -1;
    80002788:	fff00513          	li	a0,-1
    8000278c:	fe5ff06f          	j	80002770 <_ZN7_thread12thread_sleepEm+0x9c>
        return -2;
    80002790:	ffe00513          	li	a0,-2
    80002794:	fddff06f          	j	80002770 <_ZN7_thread12thread_sleepEm+0x9c>

0000000080002798 <_ZN7_thread11thread_wakeEv>:
{
    80002798:	fe010113          	addi	sp,sp,-32
    8000279c:	00113c23          	sd	ra,24(sp)
    800027a0:	00813823          	sd	s0,16(sp)
    800027a4:	00913423          	sd	s1,8(sp)
    800027a8:	02010413          	addi	s0,sp,32
    if (sleepingThreads->empty())
    800027ac:	0000a497          	auipc	s1,0xa
    800027b0:	2bc4b483          	ld	s1,700(s1) # 8000ca68 <_ZN7_thread15sleepingThreadsE>
    800027b4:	00048513          	mv	a0,s1
    800027b8:	00000097          	auipc	ra,0x0
    800027bc:	260080e7          	jalr	608(ra) # 80002a18 <_ZN4ListIN7_thread14SleepingThreadEE5emptyEv>
    800027c0:	02051063          	bnez	a0,800027e0 <_ZN7_thread11thread_wakeEv+0x48>
    SleepingThread* head = sleepingThreads->peek();
    800027c4:	00048513          	mv	a0,s1
    800027c8:	00000097          	auipc	ra,0x0
    800027cc:	270080e7          	jalr	624(ra) # 80002a38 <_ZN4ListIN7_thread14SleepingThreadEE4peekEv>
    if (head->sleepingTime == relativeSleepTimer)
    800027d0:	00853703          	ld	a4,8(a0)
    800027d4:	0000a797          	auipc	a5,0xa
    800027d8:	29c7b783          	ld	a5,668(a5) # 8000ca70 <_ZN7_thread18relativeSleepTimerE>
    800027dc:	00f70c63          	beq	a4,a5,800027f4 <_ZN7_thread11thread_wakeEv+0x5c>
}
    800027e0:	01813083          	ld	ra,24(sp)
    800027e4:	01013403          	ld	s0,16(sp)
    800027e8:	00813483          	ld	s1,8(sp)
    800027ec:	02010113          	addi	sp,sp,32
    800027f0:	00008067          	ret
        while (!(sleepingThreads->empty()) && sleepingThreads->peek()->sleepingTime == relativeSleepTimer)
    800027f4:	0000a497          	auipc	s1,0xa
    800027f8:	2744b483          	ld	s1,628(s1) # 8000ca68 <_ZN7_thread15sleepingThreadsE>
    800027fc:	00048513          	mv	a0,s1
    80002800:	00000097          	auipc	ra,0x0
    80002804:	218080e7          	jalr	536(ra) # 80002a18 <_ZN4ListIN7_thread14SleepingThreadEE5emptyEv>
    80002808:	04051463          	bnez	a0,80002850 <_ZN7_thread11thread_wakeEv+0xb8>
    8000280c:	00048513          	mv	a0,s1
    80002810:	00000097          	auipc	ra,0x0
    80002814:	228080e7          	jalr	552(ra) # 80002a38 <_ZN4ListIN7_thread14SleepingThreadEE4peekEv>
    80002818:	00853703          	ld	a4,8(a0)
    8000281c:	0000a797          	auipc	a5,0xa
    80002820:	2547b783          	ld	a5,596(a5) # 8000ca70 <_ZN7_thread18relativeSleepTimerE>
    80002824:	02f71663          	bne	a4,a5,80002850 <_ZN7_thread11thread_wakeEv+0xb8>
            SleepingThread* awakeThread = sleepingThreads->get();
    80002828:	00048513          	mv	a0,s1
    8000282c:	00000097          	auipc	ra,0x0
    80002830:	230080e7          	jalr	560(ra) # 80002a5c <_ZN4ListIN7_thread14SleepingThreadEE3getEv>
            awakeThread->thread->currentState = READY;
    80002834:	00053783          	ld	a5,0(a0)
    80002838:	00100713          	li	a4,1
    8000283c:	12e7ae23          	sw	a4,316(a5)
            Scheduler::put(awakeThread->thread);
    80002840:	00053503          	ld	a0,0(a0)
    80002844:	00003097          	auipc	ra,0x3
    80002848:	acc080e7          	jalr	-1332(ra) # 80005310 <_ZN9Scheduler3putEP7_thread>
        while (!(sleepingThreads->empty()) && sleepingThreads->peek()->sleepingTime == relativeSleepTimer)
    8000284c:	fa9ff06f          	j	800027f4 <_ZN7_thread11thread_wakeEv+0x5c>
        for(sleepingThreads->setBegin(); !sleepingThreads->isEnd(); sleepingThreads->nextElem())
    80002850:	00048513          	mv	a0,s1
    80002854:	00000097          	auipc	ra,0x0
    80002858:	284080e7          	jalr	644(ra) # 80002ad8 <_ZN4ListIN7_thread14SleepingThreadEE8setBeginEv>
    8000285c:	0000a497          	auipc	s1,0xa
    80002860:	20c4b483          	ld	s1,524(s1) # 8000ca68 <_ZN7_thread15sleepingThreadsE>
    80002864:	00048513          	mv	a0,s1
    80002868:	00000097          	auipc	ra,0x0
    8000286c:	290080e7          	jalr	656(ra) # 80002af8 <_ZN4ListIN7_thread14SleepingThreadEE5isEndEv>
    80002870:	02051a63          	bnez	a0,800028a4 <_ZN7_thread11thread_wakeEv+0x10c>
            SleepingThread* t = sleepingThreads->getCurrent();
    80002874:	00048513          	mv	a0,s1
    80002878:	00000097          	auipc	ra,0x0
    8000287c:	2d4080e7          	jalr	724(ra) # 80002b4c <_ZN4ListIN7_thread14SleepingThreadEE10getCurrentEv>
            t->sleepingTime -= relativeSleepTimer;
    80002880:	00853783          	ld	a5,8(a0)
    80002884:	0000a717          	auipc	a4,0xa
    80002888:	1ec73703          	ld	a4,492(a4) # 8000ca70 <_ZN7_thread18relativeSleepTimerE>
    8000288c:	40e787b3          	sub	a5,a5,a4
    80002890:	00f53423          	sd	a5,8(a0)
        for(sleepingThreads->setBegin(); !sleepingThreads->isEnd(); sleepingThreads->nextElem())
    80002894:	00048513          	mv	a0,s1
    80002898:	00000097          	auipc	ra,0x0
    8000289c:	28c080e7          	jalr	652(ra) # 80002b24 <_ZN4ListIN7_thread14SleepingThreadEE8nextElemEv>
    800028a0:	fbdff06f          	j	8000285c <_ZN7_thread11thread_wakeEv+0xc4>
        relativeSleepTimer = 0;
    800028a4:	0000a797          	auipc	a5,0xa
    800028a8:	1c07b623          	sd	zero,460(a5) # 8000ca70 <_ZN7_thread18relativeSleepTimerE>
    800028ac:	f35ff06f          	j	800027e0 <_ZN7_thread11thread_wakeEv+0x48>

00000000800028b0 <_ZN4ListIN7_thread14SleepingThreadEE11list_createEv>:
bool List<T>::empty() {
    return head == nullptr;
}

template<typename T>
List<T> *List<T>::list_create() {
    800028b0:	fe010113          	addi	sp,sp,-32
    800028b4:	00113c23          	sd	ra,24(sp)
    800028b8:	00813823          	sd	s0,16(sp)
    800028bc:	00913423          	sd	s1,8(sp)
    800028c0:	02010413          	addi	s0,sp,32
    List<T>* list = (List<T>*)MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(sizeof(List<T>)));
    800028c4:	00004097          	auipc	ra,0x4
    800028c8:	e70080e7          	jalr	-400(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    800028cc:	00050493          	mv	s1,a0
    800028d0:	01800513          	li	a0,24
    800028d4:	00004097          	auipc	ra,0x4
    800028d8:	1b0080e7          	jalr	432(ra) # 80006a84 <_ZN15MemoryAllocator19__convert_to_blocksEm>
    800028dc:	00050593          	mv	a1,a0
    800028e0:	00048513          	mv	a0,s1
    800028e4:	00004097          	auipc	ra,0x4
    800028e8:	ef4080e7          	jalr	-268(ra) # 800067d8 <_ZN15MemoryAllocator11__mem_allocEm>
    if (!list)
    800028ec:	00050863          	beqz	a0,800028fc <_ZN4ListIN7_thread14SleepingThreadEE11list_createEv+0x4c>
        return nullptr;

    list->head = nullptr;
    800028f0:	00053023          	sd	zero,0(a0)
    list->tail = nullptr;
    800028f4:	00053423          	sd	zero,8(a0)
    list->tmp = nullptr;
    800028f8:	00053823          	sd	zero,16(a0)

    return list;
}
    800028fc:	01813083          	ld	ra,24(sp)
    80002900:	01013403          	ld	s0,16(sp)
    80002904:	00813483          	ld	s1,8(sp)
    80002908:	02010113          	addi	sp,sp,32
    8000290c:	00008067          	ret

0000000080002910 <_ZN4ListIN7_thread14SleepingThreadEE10putInOrderEPFbPS1_S3_ES3_>:
int List<T>::putInOrder(bool (*cmp)(T *, T *), T *elem) {
    80002910:	fc010113          	addi	sp,sp,-64
    80002914:	02113c23          	sd	ra,56(sp)
    80002918:	02813823          	sd	s0,48(sp)
    8000291c:	02913423          	sd	s1,40(sp)
    80002920:	03213023          	sd	s2,32(sp)
    80002924:	01313c23          	sd	s3,24(sp)
    80002928:	01413823          	sd	s4,16(sp)
    8000292c:	01513423          	sd	s5,8(sp)
    80002930:	01613023          	sd	s6,0(sp)
    80002934:	04010413          	addi	s0,sp,64
    80002938:	00050b13          	mv	s6,a0
    8000293c:	00058993          	mv	s3,a1
    80002940:	00060913          	mv	s2,a2
    Node* curr = head;
    80002944:	00053483          	ld	s1,0(a0)
    Node* newNode = (Node*)MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(sizeof(Node)));
    80002948:	00004097          	auipc	ra,0x4
    8000294c:	dec080e7          	jalr	-532(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80002950:	00050a13          	mv	s4,a0
    80002954:	01000513          	li	a0,16
    80002958:	00004097          	auipc	ra,0x4
    8000295c:	12c080e7          	jalr	300(ra) # 80006a84 <_ZN15MemoryAllocator19__convert_to_blocksEm>
    80002960:	00050593          	mv	a1,a0
    80002964:	000a0513          	mv	a0,s4
    80002968:	00004097          	auipc	ra,0x4
    8000296c:	e70080e7          	jalr	-400(ra) # 800067d8 <_ZN15MemoryAllocator11__mem_allocEm>
    if (!newNode)
    80002970:	0a050063          	beqz	a0,80002a10 <_ZN4ListIN7_thread14SleepingThreadEE10putInOrderEPFbPS1_S3_ES3_+0x100>
    80002974:	00050a93          	mv	s5,a0
    newNode->elem = elem;
    80002978:	01253023          	sd	s2,0(a0)
    newNode->next = nullptr;
    8000297c:	00053423          	sd	zero,8(a0)
    Node* prev = nullptr;
    80002980:	00000a13          	li	s4,0
    while (curr)
    80002984:	06048063          	beqz	s1,800029e4 <_ZN4ListIN7_thread14SleepingThreadEE10putInOrderEPFbPS1_S3_ES3_+0xd4>
        if (!cmp(curr->elem, elem))
    80002988:	00090593          	mv	a1,s2
    8000298c:	0004b503          	ld	a0,0(s1)
    80002990:	000980e7          	jalr	s3
    80002994:	00050863          	beqz	a0,800029a4 <_ZN4ListIN7_thread14SleepingThreadEE10putInOrderEPFbPS1_S3_ES3_+0x94>
        prev = curr;
    80002998:	00048a13          	mv	s4,s1
        curr = curr->next;
    8000299c:	0084b483          	ld	s1,8(s1)
    while (curr)
    800029a0:	fe5ff06f          	j	80002984 <_ZN4ListIN7_thread14SleepingThreadEE10putInOrderEPFbPS1_S3_ES3_+0x74>
            newNode->next = curr;
    800029a4:	009ab423          	sd	s1,8(s5)
            if (prev)
    800029a8:	020a0a63          	beqz	s4,800029dc <_ZN4ListIN7_thread14SleepingThreadEE10putInOrderEPFbPS1_S3_ES3_+0xcc>
                prev->next = newNode;
    800029ac:	015a3423          	sd	s5,8(s4)
            return 0;
    800029b0:	00000513          	li	a0,0
}
    800029b4:	03813083          	ld	ra,56(sp)
    800029b8:	03013403          	ld	s0,48(sp)
    800029bc:	02813483          	ld	s1,40(sp)
    800029c0:	02013903          	ld	s2,32(sp)
    800029c4:	01813983          	ld	s3,24(sp)
    800029c8:	01013a03          	ld	s4,16(sp)
    800029cc:	00813a83          	ld	s5,8(sp)
    800029d0:	00013b03          	ld	s6,0(sp)
    800029d4:	04010113          	addi	sp,sp,64
    800029d8:	00008067          	ret
                head = newNode;
    800029dc:	015b3023          	sd	s5,0(s6)
    800029e0:	fd1ff06f          	j	800029b0 <_ZN4ListIN7_thread14SleepingThreadEE10putInOrderEPFbPS1_S3_ES3_+0xa0>
    if (tail)
    800029e4:	008b3783          	ld	a5,8(s6)
    800029e8:	00078463          	beqz	a5,800029f0 <_ZN4ListIN7_thread14SleepingThreadEE10putInOrderEPFbPS1_S3_ES3_+0xe0>
        tail->next = newNode;
    800029ec:	0157b423          	sd	s5,8(a5)
    tail = newNode;
    800029f0:	015b3423          	sd	s5,8(s6)
    if (!head)
    800029f4:	000b3783          	ld	a5,0(s6)
    800029f8:	00078663          	beqz	a5,80002a04 <_ZN4ListIN7_thread14SleepingThreadEE10putInOrderEPFbPS1_S3_ES3_+0xf4>
    return 0;
    800029fc:	00000513          	li	a0,0
    80002a00:	fb5ff06f          	j	800029b4 <_ZN4ListIN7_thread14SleepingThreadEE10putInOrderEPFbPS1_S3_ES3_+0xa4>
        head = newNode;
    80002a04:	015b3023          	sd	s5,0(s6)
    return 0;
    80002a08:	00000513          	li	a0,0
    80002a0c:	fa9ff06f          	j	800029b4 <_ZN4ListIN7_thread14SleepingThreadEE10putInOrderEPFbPS1_S3_ES3_+0xa4>
        return -1;
    80002a10:	fff00513          	li	a0,-1
    80002a14:	fa1ff06f          	j	800029b4 <_ZN4ListIN7_thread14SleepingThreadEE10putInOrderEPFbPS1_S3_ES3_+0xa4>

0000000080002a18 <_ZN4ListIN7_thread14SleepingThreadEE5emptyEv>:
bool List<T>::empty() {
    80002a18:	ff010113          	addi	sp,sp,-16
    80002a1c:	00813423          	sd	s0,8(sp)
    80002a20:	01010413          	addi	s0,sp,16
    return head == nullptr;
    80002a24:	00053503          	ld	a0,0(a0)
}
    80002a28:	00153513          	seqz	a0,a0
    80002a2c:	00813403          	ld	s0,8(sp)
    80002a30:	01010113          	addi	sp,sp,16
    80002a34:	00008067          	ret

0000000080002a38 <_ZN4ListIN7_thread14SleepingThreadEE4peekEv>:
T *List<T>::peek() {
    80002a38:	ff010113          	addi	sp,sp,-16
    80002a3c:	00813423          	sd	s0,8(sp)
    80002a40:	01010413          	addi	s0,sp,16
    if (!head)
    80002a44:	00053503          	ld	a0,0(a0)
    80002a48:	00050463          	beqz	a0,80002a50 <_ZN4ListIN7_thread14SleepingThreadEE4peekEv+0x18>
    return head->elem;
    80002a4c:	00053503          	ld	a0,0(a0)
}
    80002a50:	00813403          	ld	s0,8(sp)
    80002a54:	01010113          	addi	sp,sp,16
    80002a58:	00008067          	ret

0000000080002a5c <_ZN4ListIN7_thread14SleepingThreadEE3getEv>:

template<typename T>
T* List<T>::get() {
    80002a5c:	fe010113          	addi	sp,sp,-32
    80002a60:	00113c23          	sd	ra,24(sp)
    80002a64:	00813823          	sd	s0,16(sp)
    80002a68:	00913423          	sd	s1,8(sp)
    80002a6c:	01213023          	sd	s2,0(sp)
    80002a70:	02010413          	addi	s0,sp,32
    if (!head)
    80002a74:	00053483          	ld	s1,0(a0)
    80002a78:	04048863          	beqz	s1,80002ac8 <_ZN4ListIN7_thread14SleepingThreadEE3getEv+0x6c>
        return nullptr;

    T* elem = head->elem;
    80002a7c:	0004b903          	ld	s2,0(s1)

    Node* oldHead = head;
    head = head->next;
    80002a80:	0084b783          	ld	a5,8(s1)
    80002a84:	00f53023          	sd	a5,0(a0)
    if (!head)
    80002a88:	02078c63          	beqz	a5,80002ac0 <_ZN4ListIN7_thread14SleepingThreadEE3getEv+0x64>
        tail = nullptr;

    int res = MemoryAllocator::__get_instance()->__mem_free(oldHead);
    80002a8c:	00004097          	auipc	ra,0x4
    80002a90:	ca8080e7          	jalr	-856(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80002a94:	00048593          	mv	a1,s1
    80002a98:	00004097          	auipc	ra,0x4
    80002a9c:	e8c080e7          	jalr	-372(ra) # 80006924 <_ZN15MemoryAllocator10__mem_freeEPv>
    if (res < 0)
    80002aa0:	02054863          	bltz	a0,80002ad0 <_ZN4ListIN7_thread14SleepingThreadEE3getEv+0x74>
        return nullptr; // ili nesto drugo

    return elem;
}
    80002aa4:	00090513          	mv	a0,s2
    80002aa8:	01813083          	ld	ra,24(sp)
    80002aac:	01013403          	ld	s0,16(sp)
    80002ab0:	00813483          	ld	s1,8(sp)
    80002ab4:	00013903          	ld	s2,0(sp)
    80002ab8:	02010113          	addi	sp,sp,32
    80002abc:	00008067          	ret
        tail = nullptr;
    80002ac0:	00053423          	sd	zero,8(a0)
    80002ac4:	fc9ff06f          	j	80002a8c <_ZN4ListIN7_thread14SleepingThreadEE3getEv+0x30>
        return nullptr;
    80002ac8:	00048913          	mv	s2,s1
    80002acc:	fd9ff06f          	j	80002aa4 <_ZN4ListIN7_thread14SleepingThreadEE3getEv+0x48>
        return nullptr; // ili nesto drugo
    80002ad0:	00000913          	li	s2,0
    80002ad4:	fd1ff06f          	j	80002aa4 <_ZN4ListIN7_thread14SleepingThreadEE3getEv+0x48>

0000000080002ad8 <_ZN4ListIN7_thread14SleepingThreadEE8setBeginEv>:
void List<T>::setBegin() {
    80002ad8:	ff010113          	addi	sp,sp,-16
    80002adc:	00813423          	sd	s0,8(sp)
    80002ae0:	01010413          	addi	s0,sp,16
    tmp = head;
    80002ae4:	00053783          	ld	a5,0(a0)
    80002ae8:	00f53823          	sd	a5,16(a0)
}
    80002aec:	00813403          	ld	s0,8(sp)
    80002af0:	01010113          	addi	sp,sp,16
    80002af4:	00008067          	ret

0000000080002af8 <_ZN4ListIN7_thread14SleepingThreadEE5isEndEv>:
bool List<T>::isEnd() {
    80002af8:	ff010113          	addi	sp,sp,-16
    80002afc:	00813423          	sd	s0,8(sp)
    80002b00:	01010413          	addi	s0,sp,16
    if (tmp)
    80002b04:	01053783          	ld	a5,16(a0)
    80002b08:	00078a63          	beqz	a5,80002b1c <_ZN4ListIN7_thread14SleepingThreadEE5isEndEv+0x24>
        return false;
    80002b0c:	00000513          	li	a0,0
}
    80002b10:	00813403          	ld	s0,8(sp)
    80002b14:	01010113          	addi	sp,sp,16
    80002b18:	00008067          	ret
    return true;
    80002b1c:	00100513          	li	a0,1
    80002b20:	ff1ff06f          	j	80002b10 <_ZN4ListIN7_thread14SleepingThreadEE5isEndEv+0x18>

0000000080002b24 <_ZN4ListIN7_thread14SleepingThreadEE8nextElemEv>:
void List<T>::nextElem() {
    80002b24:	ff010113          	addi	sp,sp,-16
    80002b28:	00813423          	sd	s0,8(sp)
    80002b2c:	01010413          	addi	s0,sp,16
    if (!tmp)
    80002b30:	01053783          	ld	a5,16(a0)
    80002b34:	00078663          	beqz	a5,80002b40 <_ZN4ListIN7_thread14SleepingThreadEE8nextElemEv+0x1c>
    tmp = tmp->next;
    80002b38:	0087b783          	ld	a5,8(a5)
    80002b3c:	00f53823          	sd	a5,16(a0)
}
    80002b40:	00813403          	ld	s0,8(sp)
    80002b44:	01010113          	addi	sp,sp,16
    80002b48:	00008067          	ret

0000000080002b4c <_ZN4ListIN7_thread14SleepingThreadEE10getCurrentEv>:
T *List<T>::getCurrent() {
    80002b4c:	ff010113          	addi	sp,sp,-16
    80002b50:	00813423          	sd	s0,8(sp)
    80002b54:	01010413          	addi	s0,sp,16
    if (!tmp)
    80002b58:	01053503          	ld	a0,16(a0)
    80002b5c:	00050463          	beqz	a0,80002b64 <_ZN4ListIN7_thread14SleepingThreadEE10getCurrentEv+0x18>
    return tmp->elem;
    80002b60:	00053503          	ld	a0,0(a0)
}
    80002b64:	00813403          	ld	s0,8(sp)
    80002b68:	01010113          	addi	sp,sp,16
    80002b6c:	00008067          	ret

0000000080002b70 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80002b70:	fe010113          	addi	sp,sp,-32
    80002b74:	00113c23          	sd	ra,24(sp)
    80002b78:	00813823          	sd	s0,16(sp)
    80002b7c:	00913423          	sd	s1,8(sp)
    80002b80:	01213023          	sd	s2,0(sp)
    80002b84:	02010413          	addi	s0,sp,32
    80002b88:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80002b8c:	00100793          	li	a5,1
    80002b90:	02a7f863          	bgeu	a5,a0,80002bc0 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80002b94:	00a00793          	li	a5,10
    80002b98:	02f577b3          	remu	a5,a0,a5
    80002b9c:	02078e63          	beqz	a5,80002bd8 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80002ba0:	fff48513          	addi	a0,s1,-1
    80002ba4:	00000097          	auipc	ra,0x0
    80002ba8:	fcc080e7          	jalr	-52(ra) # 80002b70 <_ZL9fibonaccim>
    80002bac:	00050913          	mv	s2,a0
    80002bb0:	ffe48513          	addi	a0,s1,-2
    80002bb4:	00000097          	auipc	ra,0x0
    80002bb8:	fbc080e7          	jalr	-68(ra) # 80002b70 <_ZL9fibonaccim>
    80002bbc:	00a90533          	add	a0,s2,a0
}
    80002bc0:	01813083          	ld	ra,24(sp)
    80002bc4:	01013403          	ld	s0,16(sp)
    80002bc8:	00813483          	ld	s1,8(sp)
    80002bcc:	00013903          	ld	s2,0(sp)
    80002bd0:	02010113          	addi	sp,sp,32
    80002bd4:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80002bd8:	fffff097          	auipc	ra,0xfffff
    80002bdc:	ed0080e7          	jalr	-304(ra) # 80001aa8 <thread_dispatch>
    80002be0:	fc1ff06f          	j	80002ba0 <_ZL9fibonaccim+0x30>

0000000080002be4 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80002be4:	fe010113          	addi	sp,sp,-32
    80002be8:	00113c23          	sd	ra,24(sp)
    80002bec:	00813823          	sd	s0,16(sp)
    80002bf0:	00913423          	sd	s1,8(sp)
    80002bf4:	01213023          	sd	s2,0(sp)
    80002bf8:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80002bfc:	00000913          	li	s2,0
    80002c00:	0380006f          	j	80002c38 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80002c04:	fffff097          	auipc	ra,0xfffff
    80002c08:	ea4080e7          	jalr	-348(ra) # 80001aa8 <thread_dispatch>
        for (uint64 j = 0; j < 10000; j++) {
    80002c0c:	00148493          	addi	s1,s1,1
    80002c10:	000027b7          	lui	a5,0x2
    80002c14:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002c18:	0097ee63          	bltu	a5,s1,80002c34 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80002c1c:	00000713          	li	a4,0
    80002c20:	000077b7          	lui	a5,0x7
    80002c24:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80002c28:	fce7eee3          	bltu	a5,a4,80002c04 <_ZN7WorkerA11workerBodyAEPv+0x20>
    80002c2c:	00170713          	addi	a4,a4,1
    80002c30:	ff1ff06f          	j	80002c20 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80002c34:	00190913          	addi	s2,s2,1
    80002c38:	00900793          	li	a5,9
    80002c3c:	0527e063          	bltu	a5,s2,80002c7c <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80002c40:	00007517          	auipc	a0,0x7
    80002c44:	4c850513          	addi	a0,a0,1224 # 8000a108 <CONSOLE_STATUS+0xf8>
    80002c48:	00002097          	auipc	ra,0x2
    80002c4c:	eac080e7          	jalr	-340(ra) # 80004af4 <_Z11printStringPKc>
    80002c50:	00000613          	li	a2,0
    80002c54:	00a00593          	li	a1,10
    80002c58:	0009051b          	sext.w	a0,s2
    80002c5c:	00002097          	auipc	ra,0x2
    80002c60:	048080e7          	jalr	72(ra) # 80004ca4 <_Z8printIntiii>
    80002c64:	00007517          	auipc	a0,0x7
    80002c68:	70450513          	addi	a0,a0,1796 # 8000a368 <CONSOLE_STATUS+0x358>
    80002c6c:	00002097          	auipc	ra,0x2
    80002c70:	e88080e7          	jalr	-376(ra) # 80004af4 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80002c74:	00000493          	li	s1,0
    80002c78:	f99ff06f          	j	80002c10 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    80002c7c:	00007517          	auipc	a0,0x7
    80002c80:	49450513          	addi	a0,a0,1172 # 8000a110 <CONSOLE_STATUS+0x100>
    80002c84:	00002097          	auipc	ra,0x2
    80002c88:	e70080e7          	jalr	-400(ra) # 80004af4 <_Z11printStringPKc>
    finishedA = true;
    80002c8c:	00100793          	li	a5,1
    80002c90:	0000a717          	auipc	a4,0xa
    80002c94:	def70c23          	sb	a5,-520(a4) # 8000ca88 <_ZL9finishedA>
}
    80002c98:	01813083          	ld	ra,24(sp)
    80002c9c:	01013403          	ld	s0,16(sp)
    80002ca0:	00813483          	ld	s1,8(sp)
    80002ca4:	00013903          	ld	s2,0(sp)
    80002ca8:	02010113          	addi	sp,sp,32
    80002cac:	00008067          	ret

0000000080002cb0 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80002cb0:	fe010113          	addi	sp,sp,-32
    80002cb4:	00113c23          	sd	ra,24(sp)
    80002cb8:	00813823          	sd	s0,16(sp)
    80002cbc:	00913423          	sd	s1,8(sp)
    80002cc0:	01213023          	sd	s2,0(sp)
    80002cc4:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80002cc8:	00000913          	li	s2,0
    80002ccc:	0380006f          	j	80002d04 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80002cd0:	fffff097          	auipc	ra,0xfffff
    80002cd4:	dd8080e7          	jalr	-552(ra) # 80001aa8 <thread_dispatch>
        for (uint64 j = 0; j < 10000; j++) {
    80002cd8:	00148493          	addi	s1,s1,1
    80002cdc:	000027b7          	lui	a5,0x2
    80002ce0:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002ce4:	0097ee63          	bltu	a5,s1,80002d00 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80002ce8:	00000713          	li	a4,0
    80002cec:	000077b7          	lui	a5,0x7
    80002cf0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80002cf4:	fce7eee3          	bltu	a5,a4,80002cd0 <_ZN7WorkerB11workerBodyBEPv+0x20>
    80002cf8:	00170713          	addi	a4,a4,1
    80002cfc:	ff1ff06f          	j	80002cec <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80002d00:	00190913          	addi	s2,s2,1
    80002d04:	00f00793          	li	a5,15
    80002d08:	0527e063          	bltu	a5,s2,80002d48 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80002d0c:	00007517          	auipc	a0,0x7
    80002d10:	41450513          	addi	a0,a0,1044 # 8000a120 <CONSOLE_STATUS+0x110>
    80002d14:	00002097          	auipc	ra,0x2
    80002d18:	de0080e7          	jalr	-544(ra) # 80004af4 <_Z11printStringPKc>
    80002d1c:	00000613          	li	a2,0
    80002d20:	00a00593          	li	a1,10
    80002d24:	0009051b          	sext.w	a0,s2
    80002d28:	00002097          	auipc	ra,0x2
    80002d2c:	f7c080e7          	jalr	-132(ra) # 80004ca4 <_Z8printIntiii>
    80002d30:	00007517          	auipc	a0,0x7
    80002d34:	63850513          	addi	a0,a0,1592 # 8000a368 <CONSOLE_STATUS+0x358>
    80002d38:	00002097          	auipc	ra,0x2
    80002d3c:	dbc080e7          	jalr	-580(ra) # 80004af4 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80002d40:	00000493          	li	s1,0
    80002d44:	f99ff06f          	j	80002cdc <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80002d48:	00007517          	auipc	a0,0x7
    80002d4c:	3e050513          	addi	a0,a0,992 # 8000a128 <CONSOLE_STATUS+0x118>
    80002d50:	00002097          	auipc	ra,0x2
    80002d54:	da4080e7          	jalr	-604(ra) # 80004af4 <_Z11printStringPKc>
    finishedB = true;
    80002d58:	00100793          	li	a5,1
    80002d5c:	0000a717          	auipc	a4,0xa
    80002d60:	d2f706a3          	sb	a5,-723(a4) # 8000ca89 <_ZL9finishedB>
    thread_dispatch();
    80002d64:	fffff097          	auipc	ra,0xfffff
    80002d68:	d44080e7          	jalr	-700(ra) # 80001aa8 <thread_dispatch>
}
    80002d6c:	01813083          	ld	ra,24(sp)
    80002d70:	01013403          	ld	s0,16(sp)
    80002d74:	00813483          	ld	s1,8(sp)
    80002d78:	00013903          	ld	s2,0(sp)
    80002d7c:	02010113          	addi	sp,sp,32
    80002d80:	00008067          	ret

0000000080002d84 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80002d84:	fe010113          	addi	sp,sp,-32
    80002d88:	00113c23          	sd	ra,24(sp)
    80002d8c:	00813823          	sd	s0,16(sp)
    80002d90:	00913423          	sd	s1,8(sp)
    80002d94:	01213023          	sd	s2,0(sp)
    80002d98:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80002d9c:	00000493          	li	s1,0
    80002da0:	0400006f          	j	80002de0 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80002da4:	00007517          	auipc	a0,0x7
    80002da8:	39450513          	addi	a0,a0,916 # 8000a138 <CONSOLE_STATUS+0x128>
    80002dac:	00002097          	auipc	ra,0x2
    80002db0:	d48080e7          	jalr	-696(ra) # 80004af4 <_Z11printStringPKc>
    80002db4:	00000613          	li	a2,0
    80002db8:	00a00593          	li	a1,10
    80002dbc:	00048513          	mv	a0,s1
    80002dc0:	00002097          	auipc	ra,0x2
    80002dc4:	ee4080e7          	jalr	-284(ra) # 80004ca4 <_Z8printIntiii>
    80002dc8:	00007517          	auipc	a0,0x7
    80002dcc:	5a050513          	addi	a0,a0,1440 # 8000a368 <CONSOLE_STATUS+0x358>
    80002dd0:	00002097          	auipc	ra,0x2
    80002dd4:	d24080e7          	jalr	-732(ra) # 80004af4 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80002dd8:	0014849b          	addiw	s1,s1,1
    80002ddc:	0ff4f493          	andi	s1,s1,255
    80002de0:	00200793          	li	a5,2
    80002de4:	fc97f0e3          	bgeu	a5,s1,80002da4 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80002de8:	00007517          	auipc	a0,0x7
    80002dec:	35850513          	addi	a0,a0,856 # 8000a140 <CONSOLE_STATUS+0x130>
    80002df0:	00002097          	auipc	ra,0x2
    80002df4:	d04080e7          	jalr	-764(ra) # 80004af4 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80002df8:	00700313          	li	t1,7
    thread_dispatch();
    80002dfc:	fffff097          	auipc	ra,0xfffff
    80002e00:	cac080e7          	jalr	-852(ra) # 80001aa8 <thread_dispatch>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80002e04:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80002e08:	00007517          	auipc	a0,0x7
    80002e0c:	34850513          	addi	a0,a0,840 # 8000a150 <CONSOLE_STATUS+0x140>
    80002e10:	00002097          	auipc	ra,0x2
    80002e14:	ce4080e7          	jalr	-796(ra) # 80004af4 <_Z11printStringPKc>
    80002e18:	00000613          	li	a2,0
    80002e1c:	00a00593          	li	a1,10
    80002e20:	0009051b          	sext.w	a0,s2
    80002e24:	00002097          	auipc	ra,0x2
    80002e28:	e80080e7          	jalr	-384(ra) # 80004ca4 <_Z8printIntiii>
    80002e2c:	00007517          	auipc	a0,0x7
    80002e30:	53c50513          	addi	a0,a0,1340 # 8000a368 <CONSOLE_STATUS+0x358>
    80002e34:	00002097          	auipc	ra,0x2
    80002e38:	cc0080e7          	jalr	-832(ra) # 80004af4 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80002e3c:	00c00513          	li	a0,12
    80002e40:	00000097          	auipc	ra,0x0
    80002e44:	d30080e7          	jalr	-720(ra) # 80002b70 <_ZL9fibonaccim>
    80002e48:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80002e4c:	00007517          	auipc	a0,0x7
    80002e50:	30c50513          	addi	a0,a0,780 # 8000a158 <CONSOLE_STATUS+0x148>
    80002e54:	00002097          	auipc	ra,0x2
    80002e58:	ca0080e7          	jalr	-864(ra) # 80004af4 <_Z11printStringPKc>
    80002e5c:	00000613          	li	a2,0
    80002e60:	00a00593          	li	a1,10
    80002e64:	0009051b          	sext.w	a0,s2
    80002e68:	00002097          	auipc	ra,0x2
    80002e6c:	e3c080e7          	jalr	-452(ra) # 80004ca4 <_Z8printIntiii>
    80002e70:	00007517          	auipc	a0,0x7
    80002e74:	4f850513          	addi	a0,a0,1272 # 8000a368 <CONSOLE_STATUS+0x358>
    80002e78:	00002097          	auipc	ra,0x2
    80002e7c:	c7c080e7          	jalr	-900(ra) # 80004af4 <_Z11printStringPKc>
    80002e80:	0400006f          	j	80002ec0 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80002e84:	00007517          	auipc	a0,0x7
    80002e88:	2b450513          	addi	a0,a0,692 # 8000a138 <CONSOLE_STATUS+0x128>
    80002e8c:	00002097          	auipc	ra,0x2
    80002e90:	c68080e7          	jalr	-920(ra) # 80004af4 <_Z11printStringPKc>
    80002e94:	00000613          	li	a2,0
    80002e98:	00a00593          	li	a1,10
    80002e9c:	00048513          	mv	a0,s1
    80002ea0:	00002097          	auipc	ra,0x2
    80002ea4:	e04080e7          	jalr	-508(ra) # 80004ca4 <_Z8printIntiii>
    80002ea8:	00007517          	auipc	a0,0x7
    80002eac:	4c050513          	addi	a0,a0,1216 # 8000a368 <CONSOLE_STATUS+0x358>
    80002eb0:	00002097          	auipc	ra,0x2
    80002eb4:	c44080e7          	jalr	-956(ra) # 80004af4 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80002eb8:	0014849b          	addiw	s1,s1,1
    80002ebc:	0ff4f493          	andi	s1,s1,255
    80002ec0:	00500793          	li	a5,5
    80002ec4:	fc97f0e3          	bgeu	a5,s1,80002e84 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("C finished!\n");
    80002ec8:	00007517          	auipc	a0,0x7
    80002ecc:	2a050513          	addi	a0,a0,672 # 8000a168 <CONSOLE_STATUS+0x158>
    80002ed0:	00002097          	auipc	ra,0x2
    80002ed4:	c24080e7          	jalr	-988(ra) # 80004af4 <_Z11printStringPKc>
    finishedC = true;
    80002ed8:	00100793          	li	a5,1
    80002edc:	0000a717          	auipc	a4,0xa
    80002ee0:	baf70723          	sb	a5,-1106(a4) # 8000ca8a <_ZL9finishedC>
    thread_dispatch();
    80002ee4:	fffff097          	auipc	ra,0xfffff
    80002ee8:	bc4080e7          	jalr	-1084(ra) # 80001aa8 <thread_dispatch>
}
    80002eec:	01813083          	ld	ra,24(sp)
    80002ef0:	01013403          	ld	s0,16(sp)
    80002ef4:	00813483          	ld	s1,8(sp)
    80002ef8:	00013903          	ld	s2,0(sp)
    80002efc:	02010113          	addi	sp,sp,32
    80002f00:	00008067          	ret

0000000080002f04 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80002f04:	fe010113          	addi	sp,sp,-32
    80002f08:	00113c23          	sd	ra,24(sp)
    80002f0c:	00813823          	sd	s0,16(sp)
    80002f10:	00913423          	sd	s1,8(sp)
    80002f14:	01213023          	sd	s2,0(sp)
    80002f18:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80002f1c:	00a00493          	li	s1,10
    80002f20:	0400006f          	j	80002f60 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002f24:	00007517          	auipc	a0,0x7
    80002f28:	25450513          	addi	a0,a0,596 # 8000a178 <CONSOLE_STATUS+0x168>
    80002f2c:	00002097          	auipc	ra,0x2
    80002f30:	bc8080e7          	jalr	-1080(ra) # 80004af4 <_Z11printStringPKc>
    80002f34:	00000613          	li	a2,0
    80002f38:	00a00593          	li	a1,10
    80002f3c:	00048513          	mv	a0,s1
    80002f40:	00002097          	auipc	ra,0x2
    80002f44:	d64080e7          	jalr	-668(ra) # 80004ca4 <_Z8printIntiii>
    80002f48:	00007517          	auipc	a0,0x7
    80002f4c:	42050513          	addi	a0,a0,1056 # 8000a368 <CONSOLE_STATUS+0x358>
    80002f50:	00002097          	auipc	ra,0x2
    80002f54:	ba4080e7          	jalr	-1116(ra) # 80004af4 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80002f58:	0014849b          	addiw	s1,s1,1
    80002f5c:	0ff4f493          	andi	s1,s1,255
    80002f60:	00c00793          	li	a5,12
    80002f64:	fc97f0e3          	bgeu	a5,s1,80002f24 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    80002f68:	00007517          	auipc	a0,0x7
    80002f6c:	21850513          	addi	a0,a0,536 # 8000a180 <CONSOLE_STATUS+0x170>
    80002f70:	00002097          	auipc	ra,0x2
    80002f74:	b84080e7          	jalr	-1148(ra) # 80004af4 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80002f78:	00500313          	li	t1,5
    thread_dispatch();
    80002f7c:	fffff097          	auipc	ra,0xfffff
    80002f80:	b2c080e7          	jalr	-1236(ra) # 80001aa8 <thread_dispatch>

    uint64 result = fibonacci(16);
    80002f84:	01000513          	li	a0,16
    80002f88:	00000097          	auipc	ra,0x0
    80002f8c:	be8080e7          	jalr	-1048(ra) # 80002b70 <_ZL9fibonaccim>
    80002f90:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80002f94:	00007517          	auipc	a0,0x7
    80002f98:	1fc50513          	addi	a0,a0,508 # 8000a190 <CONSOLE_STATUS+0x180>
    80002f9c:	00002097          	auipc	ra,0x2
    80002fa0:	b58080e7          	jalr	-1192(ra) # 80004af4 <_Z11printStringPKc>
    80002fa4:	00000613          	li	a2,0
    80002fa8:	00a00593          	li	a1,10
    80002fac:	0009051b          	sext.w	a0,s2
    80002fb0:	00002097          	auipc	ra,0x2
    80002fb4:	cf4080e7          	jalr	-780(ra) # 80004ca4 <_Z8printIntiii>
    80002fb8:	00007517          	auipc	a0,0x7
    80002fbc:	3b050513          	addi	a0,a0,944 # 8000a368 <CONSOLE_STATUS+0x358>
    80002fc0:	00002097          	auipc	ra,0x2
    80002fc4:	b34080e7          	jalr	-1228(ra) # 80004af4 <_Z11printStringPKc>
    80002fc8:	0400006f          	j	80003008 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002fcc:	00007517          	auipc	a0,0x7
    80002fd0:	1ac50513          	addi	a0,a0,428 # 8000a178 <CONSOLE_STATUS+0x168>
    80002fd4:	00002097          	auipc	ra,0x2
    80002fd8:	b20080e7          	jalr	-1248(ra) # 80004af4 <_Z11printStringPKc>
    80002fdc:	00000613          	li	a2,0
    80002fe0:	00a00593          	li	a1,10
    80002fe4:	00048513          	mv	a0,s1
    80002fe8:	00002097          	auipc	ra,0x2
    80002fec:	cbc080e7          	jalr	-836(ra) # 80004ca4 <_Z8printIntiii>
    80002ff0:	00007517          	auipc	a0,0x7
    80002ff4:	37850513          	addi	a0,a0,888 # 8000a368 <CONSOLE_STATUS+0x358>
    80002ff8:	00002097          	auipc	ra,0x2
    80002ffc:	afc080e7          	jalr	-1284(ra) # 80004af4 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80003000:	0014849b          	addiw	s1,s1,1
    80003004:	0ff4f493          	andi	s1,s1,255
    80003008:	00f00793          	li	a5,15
    8000300c:	fc97f0e3          	bgeu	a5,s1,80002fcc <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    80003010:	00007517          	auipc	a0,0x7
    80003014:	19050513          	addi	a0,a0,400 # 8000a1a0 <CONSOLE_STATUS+0x190>
    80003018:	00002097          	auipc	ra,0x2
    8000301c:	adc080e7          	jalr	-1316(ra) # 80004af4 <_Z11printStringPKc>
    finishedD = true;
    80003020:	00100793          	li	a5,1
    80003024:	0000a717          	auipc	a4,0xa
    80003028:	a6f703a3          	sb	a5,-1433(a4) # 8000ca8b <_ZL9finishedD>
    thread_dispatch();
    8000302c:	fffff097          	auipc	ra,0xfffff
    80003030:	a7c080e7          	jalr	-1412(ra) # 80001aa8 <thread_dispatch>
}
    80003034:	01813083          	ld	ra,24(sp)
    80003038:	01013403          	ld	s0,16(sp)
    8000303c:	00813483          	ld	s1,8(sp)
    80003040:	00013903          	ld	s2,0(sp)
    80003044:	02010113          	addi	sp,sp,32
    80003048:	00008067          	ret

000000008000304c <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    8000304c:	fc010113          	addi	sp,sp,-64
    80003050:	02113c23          	sd	ra,56(sp)
    80003054:	02813823          	sd	s0,48(sp)
    80003058:	02913423          	sd	s1,40(sp)
    8000305c:	03213023          	sd	s2,32(sp)
    80003060:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    80003064:	02000513          	li	a0,32
    80003068:	00002097          	auipc	ra,0x2
    8000306c:	7d0080e7          	jalr	2000(ra) # 80005838 <_Znwm>
    80003070:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    80003074:	00003097          	auipc	ra,0x3
    80003078:	94c080e7          	jalr	-1716(ra) # 800059c0 <_ZN6ThreadC1Ev>
    8000307c:	00009797          	auipc	a5,0x9
    80003080:	70c78793          	addi	a5,a5,1804 # 8000c788 <_ZTV7WorkerA+0x10>
    80003084:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    80003088:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    8000308c:	00007517          	auipc	a0,0x7
    80003090:	12450513          	addi	a0,a0,292 # 8000a1b0 <CONSOLE_STATUS+0x1a0>
    80003094:	00002097          	auipc	ra,0x2
    80003098:	a60080e7          	jalr	-1440(ra) # 80004af4 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    8000309c:	02000513          	li	a0,32
    800030a0:	00002097          	auipc	ra,0x2
    800030a4:	798080e7          	jalr	1944(ra) # 80005838 <_Znwm>
    800030a8:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    800030ac:	00003097          	auipc	ra,0x3
    800030b0:	914080e7          	jalr	-1772(ra) # 800059c0 <_ZN6ThreadC1Ev>
    800030b4:	00009797          	auipc	a5,0x9
    800030b8:	6fc78793          	addi	a5,a5,1788 # 8000c7b0 <_ZTV7WorkerB+0x10>
    800030bc:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    800030c0:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    800030c4:	00007517          	auipc	a0,0x7
    800030c8:	10450513          	addi	a0,a0,260 # 8000a1c8 <CONSOLE_STATUS+0x1b8>
    800030cc:	00002097          	auipc	ra,0x2
    800030d0:	a28080e7          	jalr	-1496(ra) # 80004af4 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    800030d4:	02000513          	li	a0,32
    800030d8:	00002097          	auipc	ra,0x2
    800030dc:	760080e7          	jalr	1888(ra) # 80005838 <_Znwm>
    800030e0:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    800030e4:	00003097          	auipc	ra,0x3
    800030e8:	8dc080e7          	jalr	-1828(ra) # 800059c0 <_ZN6ThreadC1Ev>
    800030ec:	00009797          	auipc	a5,0x9
    800030f0:	6ec78793          	addi	a5,a5,1772 # 8000c7d8 <_ZTV7WorkerC+0x10>
    800030f4:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    800030f8:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    800030fc:	00007517          	auipc	a0,0x7
    80003100:	0e450513          	addi	a0,a0,228 # 8000a1e0 <CONSOLE_STATUS+0x1d0>
    80003104:	00002097          	auipc	ra,0x2
    80003108:	9f0080e7          	jalr	-1552(ra) # 80004af4 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    8000310c:	02000513          	li	a0,32
    80003110:	00002097          	auipc	ra,0x2
    80003114:	728080e7          	jalr	1832(ra) # 80005838 <_Znwm>
    80003118:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    8000311c:	00003097          	auipc	ra,0x3
    80003120:	8a4080e7          	jalr	-1884(ra) # 800059c0 <_ZN6ThreadC1Ev>
    80003124:	00009797          	auipc	a5,0x9
    80003128:	6dc78793          	addi	a5,a5,1756 # 8000c800 <_ZTV7WorkerD+0x10>
    8000312c:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    80003130:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    80003134:	00007517          	auipc	a0,0x7
    80003138:	0c450513          	addi	a0,a0,196 # 8000a1f8 <CONSOLE_STATUS+0x1e8>
    8000313c:	00002097          	auipc	ra,0x2
    80003140:	9b8080e7          	jalr	-1608(ra) # 80004af4 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80003144:	00000493          	li	s1,0
    80003148:	00300793          	li	a5,3
    8000314c:	0297c663          	blt	a5,s1,80003178 <_Z20Threads_CPP_API_testv+0x12c>
        threads[i]->start();
    80003150:	00349793          	slli	a5,s1,0x3
    80003154:	fe040713          	addi	a4,s0,-32
    80003158:	00f707b3          	add	a5,a4,a5
    8000315c:	fe07b503          	ld	a0,-32(a5)
    80003160:	00002097          	auipc	ra,0x2
    80003164:	7d4080e7          	jalr	2004(ra) # 80005934 <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    80003168:	0014849b          	addiw	s1,s1,1
    8000316c:	fddff06f          	j	80003148 <_Z20Threads_CPP_API_testv+0xfc>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    80003170:	00003097          	auipc	ra,0x3
    80003174:	828080e7          	jalr	-2008(ra) # 80005998 <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80003178:	0000a797          	auipc	a5,0xa
    8000317c:	9107c783          	lbu	a5,-1776(a5) # 8000ca88 <_ZL9finishedA>
    80003180:	fe0788e3          	beqz	a5,80003170 <_Z20Threads_CPP_API_testv+0x124>
    80003184:	0000a797          	auipc	a5,0xa
    80003188:	9057c783          	lbu	a5,-1787(a5) # 8000ca89 <_ZL9finishedB>
    8000318c:	fe0782e3          	beqz	a5,80003170 <_Z20Threads_CPP_API_testv+0x124>
    80003190:	0000a797          	auipc	a5,0xa
    80003194:	8fa7c783          	lbu	a5,-1798(a5) # 8000ca8a <_ZL9finishedC>
    80003198:	fc078ce3          	beqz	a5,80003170 <_Z20Threads_CPP_API_testv+0x124>
    8000319c:	0000a797          	auipc	a5,0xa
    800031a0:	8ef7c783          	lbu	a5,-1809(a5) # 8000ca8b <_ZL9finishedD>
    800031a4:	fc0786e3          	beqz	a5,80003170 <_Z20Threads_CPP_API_testv+0x124>
    800031a8:	fc040493          	addi	s1,s0,-64
    800031ac:	0080006f          	j	800031b4 <_Z20Threads_CPP_API_testv+0x168>
    }

    for (auto thread: threads) { delete thread; }
    800031b0:	00848493          	addi	s1,s1,8
    800031b4:	fe040793          	addi	a5,s0,-32
    800031b8:	08f48663          	beq	s1,a5,80003244 <_Z20Threads_CPP_API_testv+0x1f8>
    800031bc:	0004b503          	ld	a0,0(s1)
    800031c0:	fe0508e3          	beqz	a0,800031b0 <_Z20Threads_CPP_API_testv+0x164>
    800031c4:	00053783          	ld	a5,0(a0)
    800031c8:	0087b783          	ld	a5,8(a5)
    800031cc:	000780e7          	jalr	a5
    800031d0:	fe1ff06f          	j	800031b0 <_Z20Threads_CPP_API_testv+0x164>
    800031d4:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    800031d8:	00048513          	mv	a0,s1
    800031dc:	00002097          	auipc	ra,0x2
    800031e0:	684080e7          	jalr	1668(ra) # 80005860 <_ZdlPv>
    800031e4:	00090513          	mv	a0,s2
    800031e8:	0000b097          	auipc	ra,0xb
    800031ec:	9e0080e7          	jalr	-1568(ra) # 8000dbc8 <_Unwind_Resume>
    800031f0:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    800031f4:	00048513          	mv	a0,s1
    800031f8:	00002097          	auipc	ra,0x2
    800031fc:	668080e7          	jalr	1640(ra) # 80005860 <_ZdlPv>
    80003200:	00090513          	mv	a0,s2
    80003204:	0000b097          	auipc	ra,0xb
    80003208:	9c4080e7          	jalr	-1596(ra) # 8000dbc8 <_Unwind_Resume>
    8000320c:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    80003210:	00048513          	mv	a0,s1
    80003214:	00002097          	auipc	ra,0x2
    80003218:	64c080e7          	jalr	1612(ra) # 80005860 <_ZdlPv>
    8000321c:	00090513          	mv	a0,s2
    80003220:	0000b097          	auipc	ra,0xb
    80003224:	9a8080e7          	jalr	-1624(ra) # 8000dbc8 <_Unwind_Resume>
    80003228:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    8000322c:	00048513          	mv	a0,s1
    80003230:	00002097          	auipc	ra,0x2
    80003234:	630080e7          	jalr	1584(ra) # 80005860 <_ZdlPv>
    80003238:	00090513          	mv	a0,s2
    8000323c:	0000b097          	auipc	ra,0xb
    80003240:	98c080e7          	jalr	-1652(ra) # 8000dbc8 <_Unwind_Resume>
}
    80003244:	03813083          	ld	ra,56(sp)
    80003248:	03013403          	ld	s0,48(sp)
    8000324c:	02813483          	ld	s1,40(sp)
    80003250:	02013903          	ld	s2,32(sp)
    80003254:	04010113          	addi	sp,sp,64
    80003258:	00008067          	ret

000000008000325c <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    8000325c:	ff010113          	addi	sp,sp,-16
    80003260:	00113423          	sd	ra,8(sp)
    80003264:	00813023          	sd	s0,0(sp)
    80003268:	01010413          	addi	s0,sp,16
    8000326c:	00009797          	auipc	a5,0x9
    80003270:	51c78793          	addi	a5,a5,1308 # 8000c788 <_ZTV7WorkerA+0x10>
    80003274:	00f53023          	sd	a5,0(a0)
    80003278:	00002097          	auipc	ra,0x2
    8000327c:	4ac080e7          	jalr	1196(ra) # 80005724 <_ZN6ThreadD1Ev>
    80003280:	00813083          	ld	ra,8(sp)
    80003284:	00013403          	ld	s0,0(sp)
    80003288:	01010113          	addi	sp,sp,16
    8000328c:	00008067          	ret

0000000080003290 <_ZN7WorkerAD0Ev>:
    80003290:	fe010113          	addi	sp,sp,-32
    80003294:	00113c23          	sd	ra,24(sp)
    80003298:	00813823          	sd	s0,16(sp)
    8000329c:	00913423          	sd	s1,8(sp)
    800032a0:	02010413          	addi	s0,sp,32
    800032a4:	00050493          	mv	s1,a0
    800032a8:	00009797          	auipc	a5,0x9
    800032ac:	4e078793          	addi	a5,a5,1248 # 8000c788 <_ZTV7WorkerA+0x10>
    800032b0:	00f53023          	sd	a5,0(a0)
    800032b4:	00002097          	auipc	ra,0x2
    800032b8:	470080e7          	jalr	1136(ra) # 80005724 <_ZN6ThreadD1Ev>
    800032bc:	00048513          	mv	a0,s1
    800032c0:	00002097          	auipc	ra,0x2
    800032c4:	5a0080e7          	jalr	1440(ra) # 80005860 <_ZdlPv>
    800032c8:	01813083          	ld	ra,24(sp)
    800032cc:	01013403          	ld	s0,16(sp)
    800032d0:	00813483          	ld	s1,8(sp)
    800032d4:	02010113          	addi	sp,sp,32
    800032d8:	00008067          	ret

00000000800032dc <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    800032dc:	ff010113          	addi	sp,sp,-16
    800032e0:	00113423          	sd	ra,8(sp)
    800032e4:	00813023          	sd	s0,0(sp)
    800032e8:	01010413          	addi	s0,sp,16
    800032ec:	00009797          	auipc	a5,0x9
    800032f0:	4c478793          	addi	a5,a5,1220 # 8000c7b0 <_ZTV7WorkerB+0x10>
    800032f4:	00f53023          	sd	a5,0(a0)
    800032f8:	00002097          	auipc	ra,0x2
    800032fc:	42c080e7          	jalr	1068(ra) # 80005724 <_ZN6ThreadD1Ev>
    80003300:	00813083          	ld	ra,8(sp)
    80003304:	00013403          	ld	s0,0(sp)
    80003308:	01010113          	addi	sp,sp,16
    8000330c:	00008067          	ret

0000000080003310 <_ZN7WorkerBD0Ev>:
    80003310:	fe010113          	addi	sp,sp,-32
    80003314:	00113c23          	sd	ra,24(sp)
    80003318:	00813823          	sd	s0,16(sp)
    8000331c:	00913423          	sd	s1,8(sp)
    80003320:	02010413          	addi	s0,sp,32
    80003324:	00050493          	mv	s1,a0
    80003328:	00009797          	auipc	a5,0x9
    8000332c:	48878793          	addi	a5,a5,1160 # 8000c7b0 <_ZTV7WorkerB+0x10>
    80003330:	00f53023          	sd	a5,0(a0)
    80003334:	00002097          	auipc	ra,0x2
    80003338:	3f0080e7          	jalr	1008(ra) # 80005724 <_ZN6ThreadD1Ev>
    8000333c:	00048513          	mv	a0,s1
    80003340:	00002097          	auipc	ra,0x2
    80003344:	520080e7          	jalr	1312(ra) # 80005860 <_ZdlPv>
    80003348:	01813083          	ld	ra,24(sp)
    8000334c:	01013403          	ld	s0,16(sp)
    80003350:	00813483          	ld	s1,8(sp)
    80003354:	02010113          	addi	sp,sp,32
    80003358:	00008067          	ret

000000008000335c <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    8000335c:	ff010113          	addi	sp,sp,-16
    80003360:	00113423          	sd	ra,8(sp)
    80003364:	00813023          	sd	s0,0(sp)
    80003368:	01010413          	addi	s0,sp,16
    8000336c:	00009797          	auipc	a5,0x9
    80003370:	46c78793          	addi	a5,a5,1132 # 8000c7d8 <_ZTV7WorkerC+0x10>
    80003374:	00f53023          	sd	a5,0(a0)
    80003378:	00002097          	auipc	ra,0x2
    8000337c:	3ac080e7          	jalr	940(ra) # 80005724 <_ZN6ThreadD1Ev>
    80003380:	00813083          	ld	ra,8(sp)
    80003384:	00013403          	ld	s0,0(sp)
    80003388:	01010113          	addi	sp,sp,16
    8000338c:	00008067          	ret

0000000080003390 <_ZN7WorkerCD0Ev>:
    80003390:	fe010113          	addi	sp,sp,-32
    80003394:	00113c23          	sd	ra,24(sp)
    80003398:	00813823          	sd	s0,16(sp)
    8000339c:	00913423          	sd	s1,8(sp)
    800033a0:	02010413          	addi	s0,sp,32
    800033a4:	00050493          	mv	s1,a0
    800033a8:	00009797          	auipc	a5,0x9
    800033ac:	43078793          	addi	a5,a5,1072 # 8000c7d8 <_ZTV7WorkerC+0x10>
    800033b0:	00f53023          	sd	a5,0(a0)
    800033b4:	00002097          	auipc	ra,0x2
    800033b8:	370080e7          	jalr	880(ra) # 80005724 <_ZN6ThreadD1Ev>
    800033bc:	00048513          	mv	a0,s1
    800033c0:	00002097          	auipc	ra,0x2
    800033c4:	4a0080e7          	jalr	1184(ra) # 80005860 <_ZdlPv>
    800033c8:	01813083          	ld	ra,24(sp)
    800033cc:	01013403          	ld	s0,16(sp)
    800033d0:	00813483          	ld	s1,8(sp)
    800033d4:	02010113          	addi	sp,sp,32
    800033d8:	00008067          	ret

00000000800033dc <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    800033dc:	ff010113          	addi	sp,sp,-16
    800033e0:	00113423          	sd	ra,8(sp)
    800033e4:	00813023          	sd	s0,0(sp)
    800033e8:	01010413          	addi	s0,sp,16
    800033ec:	00009797          	auipc	a5,0x9
    800033f0:	41478793          	addi	a5,a5,1044 # 8000c800 <_ZTV7WorkerD+0x10>
    800033f4:	00f53023          	sd	a5,0(a0)
    800033f8:	00002097          	auipc	ra,0x2
    800033fc:	32c080e7          	jalr	812(ra) # 80005724 <_ZN6ThreadD1Ev>
    80003400:	00813083          	ld	ra,8(sp)
    80003404:	00013403          	ld	s0,0(sp)
    80003408:	01010113          	addi	sp,sp,16
    8000340c:	00008067          	ret

0000000080003410 <_ZN7WorkerDD0Ev>:
    80003410:	fe010113          	addi	sp,sp,-32
    80003414:	00113c23          	sd	ra,24(sp)
    80003418:	00813823          	sd	s0,16(sp)
    8000341c:	00913423          	sd	s1,8(sp)
    80003420:	02010413          	addi	s0,sp,32
    80003424:	00050493          	mv	s1,a0
    80003428:	00009797          	auipc	a5,0x9
    8000342c:	3d878793          	addi	a5,a5,984 # 8000c800 <_ZTV7WorkerD+0x10>
    80003430:	00f53023          	sd	a5,0(a0)
    80003434:	00002097          	auipc	ra,0x2
    80003438:	2f0080e7          	jalr	752(ra) # 80005724 <_ZN6ThreadD1Ev>
    8000343c:	00048513          	mv	a0,s1
    80003440:	00002097          	auipc	ra,0x2
    80003444:	420080e7          	jalr	1056(ra) # 80005860 <_ZdlPv>
    80003448:	01813083          	ld	ra,24(sp)
    8000344c:	01013403          	ld	s0,16(sp)
    80003450:	00813483          	ld	s1,8(sp)
    80003454:	02010113          	addi	sp,sp,32
    80003458:	00008067          	ret

000000008000345c <_ZN7WorkerA3runEv>:
    void run() override {
    8000345c:	ff010113          	addi	sp,sp,-16
    80003460:	00113423          	sd	ra,8(sp)
    80003464:	00813023          	sd	s0,0(sp)
    80003468:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    8000346c:	00000593          	li	a1,0
    80003470:	fffff097          	auipc	ra,0xfffff
    80003474:	774080e7          	jalr	1908(ra) # 80002be4 <_ZN7WorkerA11workerBodyAEPv>
    }
    80003478:	00813083          	ld	ra,8(sp)
    8000347c:	00013403          	ld	s0,0(sp)
    80003480:	01010113          	addi	sp,sp,16
    80003484:	00008067          	ret

0000000080003488 <_ZN7WorkerB3runEv>:
    void run() override {
    80003488:	ff010113          	addi	sp,sp,-16
    8000348c:	00113423          	sd	ra,8(sp)
    80003490:	00813023          	sd	s0,0(sp)
    80003494:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80003498:	00000593          	li	a1,0
    8000349c:	00000097          	auipc	ra,0x0
    800034a0:	814080e7          	jalr	-2028(ra) # 80002cb0 <_ZN7WorkerB11workerBodyBEPv>
    }
    800034a4:	00813083          	ld	ra,8(sp)
    800034a8:	00013403          	ld	s0,0(sp)
    800034ac:	01010113          	addi	sp,sp,16
    800034b0:	00008067          	ret

00000000800034b4 <_ZN7WorkerC3runEv>:
    void run() override {
    800034b4:	ff010113          	addi	sp,sp,-16
    800034b8:	00113423          	sd	ra,8(sp)
    800034bc:	00813023          	sd	s0,0(sp)
    800034c0:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    800034c4:	00000593          	li	a1,0
    800034c8:	00000097          	auipc	ra,0x0
    800034cc:	8bc080e7          	jalr	-1860(ra) # 80002d84 <_ZN7WorkerC11workerBodyCEPv>
    }
    800034d0:	00813083          	ld	ra,8(sp)
    800034d4:	00013403          	ld	s0,0(sp)
    800034d8:	01010113          	addi	sp,sp,16
    800034dc:	00008067          	ret

00000000800034e0 <_ZN7WorkerD3runEv>:
    void run() override {
    800034e0:	ff010113          	addi	sp,sp,-16
    800034e4:	00113423          	sd	ra,8(sp)
    800034e8:	00813023          	sd	s0,0(sp)
    800034ec:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    800034f0:	00000593          	li	a1,0
    800034f4:	00000097          	auipc	ra,0x0
    800034f8:	a10080e7          	jalr	-1520(ra) # 80002f04 <_ZN7WorkerD11workerBodyDEPv>
    }
    800034fc:	00813083          	ld	ra,8(sp)
    80003500:	00013403          	ld	s0,0(sp)
    80003504:	01010113          	addi	sp,sp,16
    80003508:	00008067          	ret

000000008000350c <_Z20testConsumerProducerv>:

        td->sem->signal();
    }
};

void testConsumerProducer() {
    8000350c:	f8010113          	addi	sp,sp,-128
    80003510:	06113c23          	sd	ra,120(sp)
    80003514:	06813823          	sd	s0,112(sp)
    80003518:	06913423          	sd	s1,104(sp)
    8000351c:	07213023          	sd	s2,96(sp)
    80003520:	05313c23          	sd	s3,88(sp)
    80003524:	05413823          	sd	s4,80(sp)
    80003528:	05513423          	sd	s5,72(sp)
    8000352c:	05613023          	sd	s6,64(sp)
    80003530:	03713c23          	sd	s7,56(sp)
    80003534:	03813823          	sd	s8,48(sp)
    80003538:	03913423          	sd	s9,40(sp)
    8000353c:	08010413          	addi	s0,sp,128
    delete waitForAll;
    for (int i = 0; i < threadNum; i++) {
        delete producers[i];
    }
    delete consumer;
    delete buffer;
    80003540:	00010c13          	mv	s8,sp
    printString("Unesite broj proizvodjaca?\n");
    80003544:	00007517          	auipc	a0,0x7
    80003548:	adc50513          	addi	a0,a0,-1316 # 8000a020 <CONSOLE_STATUS+0x10>
    8000354c:	00001097          	auipc	ra,0x1
    80003550:	5a8080e7          	jalr	1448(ra) # 80004af4 <_Z11printStringPKc>
    getString(input, 30);
    80003554:	01e00593          	li	a1,30
    80003558:	f8040493          	addi	s1,s0,-128
    8000355c:	00048513          	mv	a0,s1
    80003560:	00001097          	auipc	ra,0x1
    80003564:	61c080e7          	jalr	1564(ra) # 80004b7c <_Z9getStringPci>
    threadNum = stringToInt(input);
    80003568:	00048513          	mv	a0,s1
    8000356c:	00001097          	auipc	ra,0x1
    80003570:	6e8080e7          	jalr	1768(ra) # 80004c54 <_Z11stringToIntPKc>
    80003574:	00050993          	mv	s3,a0
    printString("Unesite velicinu bafera?\n");
    80003578:	00007517          	auipc	a0,0x7
    8000357c:	ac850513          	addi	a0,a0,-1336 # 8000a040 <CONSOLE_STATUS+0x30>
    80003580:	00001097          	auipc	ra,0x1
    80003584:	574080e7          	jalr	1396(ra) # 80004af4 <_Z11printStringPKc>
    getString(input, 30);
    80003588:	01e00593          	li	a1,30
    8000358c:	00048513          	mv	a0,s1
    80003590:	00001097          	auipc	ra,0x1
    80003594:	5ec080e7          	jalr	1516(ra) # 80004b7c <_Z9getStringPci>
    n = stringToInt(input);
    80003598:	00048513          	mv	a0,s1
    8000359c:	00001097          	auipc	ra,0x1
    800035a0:	6b8080e7          	jalr	1720(ra) # 80004c54 <_Z11stringToIntPKc>
    800035a4:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca ");
    800035a8:	00007517          	auipc	a0,0x7
    800035ac:	ab850513          	addi	a0,a0,-1352 # 8000a060 <CONSOLE_STATUS+0x50>
    800035b0:	00001097          	auipc	ra,0x1
    800035b4:	544080e7          	jalr	1348(ra) # 80004af4 <_Z11printStringPKc>
    printInt(threadNum);
    800035b8:	00000613          	li	a2,0
    800035bc:	00a00593          	li	a1,10
    800035c0:	00098513          	mv	a0,s3
    800035c4:	00001097          	auipc	ra,0x1
    800035c8:	6e0080e7          	jalr	1760(ra) # 80004ca4 <_Z8printIntiii>
    printString(" i velicina bafera ");
    800035cc:	00007517          	auipc	a0,0x7
    800035d0:	aac50513          	addi	a0,a0,-1364 # 8000a078 <CONSOLE_STATUS+0x68>
    800035d4:	00001097          	auipc	ra,0x1
    800035d8:	520080e7          	jalr	1312(ra) # 80004af4 <_Z11printStringPKc>
    printInt(n);
    800035dc:	00000613          	li	a2,0
    800035e0:	00a00593          	li	a1,10
    800035e4:	00048513          	mv	a0,s1
    800035e8:	00001097          	auipc	ra,0x1
    800035ec:	6bc080e7          	jalr	1724(ra) # 80004ca4 <_Z8printIntiii>
    printString(".\n");
    800035f0:	00007517          	auipc	a0,0x7
    800035f4:	aa050513          	addi	a0,a0,-1376 # 8000a090 <CONSOLE_STATUS+0x80>
    800035f8:	00001097          	auipc	ra,0x1
    800035fc:	4fc080e7          	jalr	1276(ra) # 80004af4 <_Z11printStringPKc>
    if (threadNum > n) {
    80003600:	0334c463          	blt	s1,s3,80003628 <_Z20testConsumerProducerv+0x11c>
    } else if (threadNum < 1) {
    80003604:	03305c63          	blez	s3,8000363c <_Z20testConsumerProducerv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    80003608:	03800513          	li	a0,56
    8000360c:	00002097          	auipc	ra,0x2
    80003610:	22c080e7          	jalr	556(ra) # 80005838 <_Znwm>
    80003614:	00050a93          	mv	s5,a0
    80003618:	00048593          	mv	a1,s1
    8000361c:	00001097          	auipc	ra,0x1
    80003620:	7a8080e7          	jalr	1960(ra) # 80004dc4 <_ZN9BufferCPPC1Ei>
    80003624:	0300006f          	j	80003654 <_Z20testConsumerProducerv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80003628:	00007517          	auipc	a0,0x7
    8000362c:	a7050513          	addi	a0,a0,-1424 # 8000a098 <CONSOLE_STATUS+0x88>
    80003630:	00001097          	auipc	ra,0x1
    80003634:	4c4080e7          	jalr	1220(ra) # 80004af4 <_Z11printStringPKc>
        return;
    80003638:	0140006f          	j	8000364c <_Z20testConsumerProducerv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    8000363c:	00007517          	auipc	a0,0x7
    80003640:	a9c50513          	addi	a0,a0,-1380 # 8000a0d8 <CONSOLE_STATUS+0xc8>
    80003644:	00001097          	auipc	ra,0x1
    80003648:	4b0080e7          	jalr	1200(ra) # 80004af4 <_Z11printStringPKc>
        return;
    8000364c:	000c0113          	mv	sp,s8
    80003650:	2140006f          	j	80003864 <_Z20testConsumerProducerv+0x358>
    waitForAll = new Semaphore(0);
    80003654:	01000513          	li	a0,16
    80003658:	00002097          	auipc	ra,0x2
    8000365c:	1e0080e7          	jalr	480(ra) # 80005838 <_Znwm>
    80003660:	00050913          	mv	s2,a0
    80003664:	00000593          	li	a1,0
    80003668:	00002097          	auipc	ra,0x2
    8000366c:	3ac080e7          	jalr	940(ra) # 80005a14 <_ZN9SemaphoreC1Ej>
    80003670:	00009797          	auipc	a5,0x9
    80003674:	4327b423          	sd	s2,1064(a5) # 8000ca98 <_ZL10waitForAll>
    Thread *producers[threadNum];
    80003678:	00399793          	slli	a5,s3,0x3
    8000367c:	00f78793          	addi	a5,a5,15
    80003680:	ff07f793          	andi	a5,a5,-16
    80003684:	40f10133          	sub	sp,sp,a5
    80003688:	00010a13          	mv	s4,sp
    thread_data threadData[threadNum + 1];
    8000368c:	0019871b          	addiw	a4,s3,1
    80003690:	00171793          	slli	a5,a4,0x1
    80003694:	00e787b3          	add	a5,a5,a4
    80003698:	00379793          	slli	a5,a5,0x3
    8000369c:	00f78793          	addi	a5,a5,15
    800036a0:	ff07f793          	andi	a5,a5,-16
    800036a4:	40f10133          	sub	sp,sp,a5
    800036a8:	00010b13          	mv	s6,sp
    threadData[threadNum].id = threadNum;
    800036ac:	00199493          	slli	s1,s3,0x1
    800036b0:	013484b3          	add	s1,s1,s3
    800036b4:	00349493          	slli	s1,s1,0x3
    800036b8:	009b04b3          	add	s1,s6,s1
    800036bc:	0134a023          	sw	s3,0(s1)
    threadData[threadNum].buffer = buffer;
    800036c0:	0154b423          	sd	s5,8(s1)
    threadData[threadNum].sem = waitForAll;
    800036c4:	0124b823          	sd	s2,16(s1)
    Thread *consumer = new Consumer(&threadData[threadNum]);
    800036c8:	02800513          	li	a0,40
    800036cc:	00002097          	auipc	ra,0x2
    800036d0:	16c080e7          	jalr	364(ra) # 80005838 <_Znwm>
    800036d4:	00050b93          	mv	s7,a0
    Consumer(thread_data *_td) : Thread(), td(_td) {}
    800036d8:	00002097          	auipc	ra,0x2
    800036dc:	2e8080e7          	jalr	744(ra) # 800059c0 <_ZN6ThreadC1Ev>
    800036e0:	00009797          	auipc	a5,0x9
    800036e4:	19878793          	addi	a5,a5,408 # 8000c878 <_ZTV8Consumer+0x10>
    800036e8:	00fbb023          	sd	a5,0(s7)
    800036ec:	029bb023          	sd	s1,32(s7)
    consumer->start();
    800036f0:	000b8513          	mv	a0,s7
    800036f4:	00002097          	auipc	ra,0x2
    800036f8:	240080e7          	jalr	576(ra) # 80005934 <_ZN6Thread5startEv>
    threadData[0].id = 0;
    800036fc:	000b2023          	sw	zero,0(s6)
    threadData[0].buffer = buffer;
    80003700:	015b3423          	sd	s5,8(s6)
    threadData[0].sem = waitForAll;
    80003704:	00009797          	auipc	a5,0x9
    80003708:	3947b783          	ld	a5,916(a5) # 8000ca98 <_ZL10waitForAll>
    8000370c:	00fb3823          	sd	a5,16(s6)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80003710:	02800513          	li	a0,40
    80003714:	00002097          	auipc	ra,0x2
    80003718:	124080e7          	jalr	292(ra) # 80005838 <_Znwm>
    8000371c:	00050493          	mv	s1,a0
    ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80003720:	00002097          	auipc	ra,0x2
    80003724:	2a0080e7          	jalr	672(ra) # 800059c0 <_ZN6ThreadC1Ev>
    80003728:	00009797          	auipc	a5,0x9
    8000372c:	10078793          	addi	a5,a5,256 # 8000c828 <_ZTV16ProducerKeyborad+0x10>
    80003730:	00f4b023          	sd	a5,0(s1)
    80003734:	0364b023          	sd	s6,32(s1)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80003738:	009a3023          	sd	s1,0(s4)
    producers[0]->start();
    8000373c:	00048513          	mv	a0,s1
    80003740:	00002097          	auipc	ra,0x2
    80003744:	1f4080e7          	jalr	500(ra) # 80005934 <_ZN6Thread5startEv>
    for (int i = 1; i < threadNum; i++) {
    80003748:	00100913          	li	s2,1
    8000374c:	0300006f          	j	8000377c <_Z20testConsumerProducerv+0x270>
    Producer(thread_data *_td) : Thread(), td(_td) {}
    80003750:	00009797          	auipc	a5,0x9
    80003754:	10078793          	addi	a5,a5,256 # 8000c850 <_ZTV8Producer+0x10>
    80003758:	00fcb023          	sd	a5,0(s9)
    8000375c:	029cb023          	sd	s1,32(s9)
        producers[i] = new Producer(&threadData[i]);
    80003760:	00391793          	slli	a5,s2,0x3
    80003764:	00fa07b3          	add	a5,s4,a5
    80003768:	0197b023          	sd	s9,0(a5)
        producers[i]->start();
    8000376c:	000c8513          	mv	a0,s9
    80003770:	00002097          	auipc	ra,0x2
    80003774:	1c4080e7          	jalr	452(ra) # 80005934 <_ZN6Thread5startEv>
    for (int i = 1; i < threadNum; i++) {
    80003778:	0019091b          	addiw	s2,s2,1
    8000377c:	05395263          	bge	s2,s3,800037c0 <_Z20testConsumerProducerv+0x2b4>
        threadData[i].id = i;
    80003780:	00191493          	slli	s1,s2,0x1
    80003784:	012484b3          	add	s1,s1,s2
    80003788:	00349493          	slli	s1,s1,0x3
    8000378c:	009b04b3          	add	s1,s6,s1
    80003790:	0124a023          	sw	s2,0(s1)
        threadData[i].buffer = buffer;
    80003794:	0154b423          	sd	s5,8(s1)
        threadData[i].sem = waitForAll;
    80003798:	00009797          	auipc	a5,0x9
    8000379c:	3007b783          	ld	a5,768(a5) # 8000ca98 <_ZL10waitForAll>
    800037a0:	00f4b823          	sd	a5,16(s1)
        producers[i] = new Producer(&threadData[i]);
    800037a4:	02800513          	li	a0,40
    800037a8:	00002097          	auipc	ra,0x2
    800037ac:	090080e7          	jalr	144(ra) # 80005838 <_Znwm>
    800037b0:	00050c93          	mv	s9,a0
    Producer(thread_data *_td) : Thread(), td(_td) {}
    800037b4:	00002097          	auipc	ra,0x2
    800037b8:	20c080e7          	jalr	524(ra) # 800059c0 <_ZN6ThreadC1Ev>
    800037bc:	f95ff06f          	j	80003750 <_Z20testConsumerProducerv+0x244>
    Thread::dispatch();
    800037c0:	00002097          	auipc	ra,0x2
    800037c4:	1d8080e7          	jalr	472(ra) # 80005998 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    800037c8:	00000493          	li	s1,0
    800037cc:	0099ce63          	blt	s3,s1,800037e8 <_Z20testConsumerProducerv+0x2dc>
        waitForAll->wait();
    800037d0:	00009517          	auipc	a0,0x9
    800037d4:	2c853503          	ld	a0,712(a0) # 8000ca98 <_ZL10waitForAll>
    800037d8:	00002097          	auipc	ra,0x2
    800037dc:	274080e7          	jalr	628(ra) # 80005a4c <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    800037e0:	0014849b          	addiw	s1,s1,1
    800037e4:	fe9ff06f          	j	800037cc <_Z20testConsumerProducerv+0x2c0>
    delete waitForAll;
    800037e8:	00009517          	auipc	a0,0x9
    800037ec:	2b053503          	ld	a0,688(a0) # 8000ca98 <_ZL10waitForAll>
    800037f0:	00050863          	beqz	a0,80003800 <_Z20testConsumerProducerv+0x2f4>
    800037f4:	00053783          	ld	a5,0(a0)
    800037f8:	0087b783          	ld	a5,8(a5)
    800037fc:	000780e7          	jalr	a5
    for (int i = 0; i <= threadNum; i++) {
    80003800:	00000493          	li	s1,0
    80003804:	0080006f          	j	8000380c <_Z20testConsumerProducerv+0x300>
    for (int i = 0; i < threadNum; i++) {
    80003808:	0014849b          	addiw	s1,s1,1
    8000380c:	0334d263          	bge	s1,s3,80003830 <_Z20testConsumerProducerv+0x324>
        delete producers[i];
    80003810:	00349793          	slli	a5,s1,0x3
    80003814:	00fa07b3          	add	a5,s4,a5
    80003818:	0007b503          	ld	a0,0(a5)
    8000381c:	fe0506e3          	beqz	a0,80003808 <_Z20testConsumerProducerv+0x2fc>
    80003820:	00053783          	ld	a5,0(a0)
    80003824:	0087b783          	ld	a5,8(a5)
    80003828:	000780e7          	jalr	a5
    8000382c:	fddff06f          	j	80003808 <_Z20testConsumerProducerv+0x2fc>
    delete consumer;
    80003830:	000b8a63          	beqz	s7,80003844 <_Z20testConsumerProducerv+0x338>
    80003834:	000bb783          	ld	a5,0(s7)
    80003838:	0087b783          	ld	a5,8(a5)
    8000383c:	000b8513          	mv	a0,s7
    80003840:	000780e7          	jalr	a5
    delete buffer;
    80003844:	000a8e63          	beqz	s5,80003860 <_Z20testConsumerProducerv+0x354>
    80003848:	000a8513          	mv	a0,s5
    8000384c:	00002097          	auipc	ra,0x2
    80003850:	870080e7          	jalr	-1936(ra) # 800050bc <_ZN9BufferCPPD1Ev>
    80003854:	000a8513          	mv	a0,s5
    80003858:	00002097          	auipc	ra,0x2
    8000385c:	008080e7          	jalr	8(ra) # 80005860 <_ZdlPv>
    80003860:	000c0113          	mv	sp,s8
}
    80003864:	f8040113          	addi	sp,s0,-128
    80003868:	07813083          	ld	ra,120(sp)
    8000386c:	07013403          	ld	s0,112(sp)
    80003870:	06813483          	ld	s1,104(sp)
    80003874:	06013903          	ld	s2,96(sp)
    80003878:	05813983          	ld	s3,88(sp)
    8000387c:	05013a03          	ld	s4,80(sp)
    80003880:	04813a83          	ld	s5,72(sp)
    80003884:	04013b03          	ld	s6,64(sp)
    80003888:	03813b83          	ld	s7,56(sp)
    8000388c:	03013c03          	ld	s8,48(sp)
    80003890:	02813c83          	ld	s9,40(sp)
    80003894:	08010113          	addi	sp,sp,128
    80003898:	00008067          	ret
    8000389c:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    800038a0:	000a8513          	mv	a0,s5
    800038a4:	00002097          	auipc	ra,0x2
    800038a8:	fbc080e7          	jalr	-68(ra) # 80005860 <_ZdlPv>
    800038ac:	00048513          	mv	a0,s1
    800038b0:	0000a097          	auipc	ra,0xa
    800038b4:	318080e7          	jalr	792(ra) # 8000dbc8 <_Unwind_Resume>
    800038b8:	00050493          	mv	s1,a0
    waitForAll = new Semaphore(0);
    800038bc:	00090513          	mv	a0,s2
    800038c0:	00002097          	auipc	ra,0x2
    800038c4:	fa0080e7          	jalr	-96(ra) # 80005860 <_ZdlPv>
    800038c8:	00048513          	mv	a0,s1
    800038cc:	0000a097          	auipc	ra,0xa
    800038d0:	2fc080e7          	jalr	764(ra) # 8000dbc8 <_Unwind_Resume>
    800038d4:	00050493          	mv	s1,a0
    Thread *consumer = new Consumer(&threadData[threadNum]);
    800038d8:	000b8513          	mv	a0,s7
    800038dc:	00002097          	auipc	ra,0x2
    800038e0:	f84080e7          	jalr	-124(ra) # 80005860 <_ZdlPv>
    800038e4:	00048513          	mv	a0,s1
    800038e8:	0000a097          	auipc	ra,0xa
    800038ec:	2e0080e7          	jalr	736(ra) # 8000dbc8 <_Unwind_Resume>
    800038f0:	00050913          	mv	s2,a0
    producers[0] = new ProducerKeyborad(&threadData[0]);
    800038f4:	00048513          	mv	a0,s1
    800038f8:	00002097          	auipc	ra,0x2
    800038fc:	f68080e7          	jalr	-152(ra) # 80005860 <_ZdlPv>
    80003900:	00090513          	mv	a0,s2
    80003904:	0000a097          	auipc	ra,0xa
    80003908:	2c4080e7          	jalr	708(ra) # 8000dbc8 <_Unwind_Resume>
    8000390c:	00050493          	mv	s1,a0
        producers[i] = new Producer(&threadData[i]);
    80003910:	000c8513          	mv	a0,s9
    80003914:	00002097          	auipc	ra,0x2
    80003918:	f4c080e7          	jalr	-180(ra) # 80005860 <_ZdlPv>
    8000391c:	00048513          	mv	a0,s1
    80003920:	0000a097          	auipc	ra,0xa
    80003924:	2a8080e7          	jalr	680(ra) # 8000dbc8 <_Unwind_Resume>

0000000080003928 <_ZN8Consumer3runEv>:
    void run() override {
    80003928:	fd010113          	addi	sp,sp,-48
    8000392c:	02113423          	sd	ra,40(sp)
    80003930:	02813023          	sd	s0,32(sp)
    80003934:	00913c23          	sd	s1,24(sp)
    80003938:	01213823          	sd	s2,16(sp)
    8000393c:	01313423          	sd	s3,8(sp)
    80003940:	03010413          	addi	s0,sp,48
    80003944:	00050913          	mv	s2,a0
        int i = 0;
    80003948:	00000993          	li	s3,0
    8000394c:	0100006f          	j	8000395c <_ZN8Consumer3runEv+0x34>
                Console::putc('\n');
    80003950:	00a00513          	li	a0,10
    80003954:	00002097          	auipc	ra,0x2
    80003958:	178080e7          	jalr	376(ra) # 80005acc <_ZN7Console4putcEc>
        while (!threadEnd) {
    8000395c:	00009797          	auipc	a5,0x9
    80003960:	1347a783          	lw	a5,308(a5) # 8000ca90 <_ZL9threadEnd>
    80003964:	04079a63          	bnez	a5,800039b8 <_ZN8Consumer3runEv+0x90>
            int key = td->buffer->get();
    80003968:	02093783          	ld	a5,32(s2)
    8000396c:	0087b503          	ld	a0,8(a5)
    80003970:	00001097          	auipc	ra,0x1
    80003974:	638080e7          	jalr	1592(ra) # 80004fa8 <_ZN9BufferCPP3getEv>
            i++;
    80003978:	0019849b          	addiw	s1,s3,1
    8000397c:	0004899b          	sext.w	s3,s1
            Console::putc(key);
    80003980:	0ff57513          	andi	a0,a0,255
    80003984:	00002097          	auipc	ra,0x2
    80003988:	148080e7          	jalr	328(ra) # 80005acc <_ZN7Console4putcEc>
            if (i % 80 == 0) {
    8000398c:	05000793          	li	a5,80
    80003990:	02f4e4bb          	remw	s1,s1,a5
    80003994:	fc0494e3          	bnez	s1,8000395c <_ZN8Consumer3runEv+0x34>
    80003998:	fb9ff06f          	j	80003950 <_ZN8Consumer3runEv+0x28>
            int key = td->buffer->get();
    8000399c:	02093783          	ld	a5,32(s2)
    800039a0:	0087b503          	ld	a0,8(a5)
    800039a4:	00001097          	auipc	ra,0x1
    800039a8:	604080e7          	jalr	1540(ra) # 80004fa8 <_ZN9BufferCPP3getEv>
            Console::putc(key);
    800039ac:	0ff57513          	andi	a0,a0,255
    800039b0:	00002097          	auipc	ra,0x2
    800039b4:	11c080e7          	jalr	284(ra) # 80005acc <_ZN7Console4putcEc>
        while (td->buffer->getCnt() > 0) {
    800039b8:	02093783          	ld	a5,32(s2)
    800039bc:	0087b503          	ld	a0,8(a5)
    800039c0:	00001097          	auipc	ra,0x1
    800039c4:	674080e7          	jalr	1652(ra) # 80005034 <_ZN9BufferCPP6getCntEv>
    800039c8:	fca04ae3          	bgtz	a0,8000399c <_ZN8Consumer3runEv+0x74>
        td->sem->signal();
    800039cc:	02093783          	ld	a5,32(s2)
    800039d0:	0107b503          	ld	a0,16(a5)
    800039d4:	00002097          	auipc	ra,0x2
    800039d8:	0a4080e7          	jalr	164(ra) # 80005a78 <_ZN9Semaphore6signalEv>
    }
    800039dc:	02813083          	ld	ra,40(sp)
    800039e0:	02013403          	ld	s0,32(sp)
    800039e4:	01813483          	ld	s1,24(sp)
    800039e8:	01013903          	ld	s2,16(sp)
    800039ec:	00813983          	ld	s3,8(sp)
    800039f0:	03010113          	addi	sp,sp,48
    800039f4:	00008067          	ret

00000000800039f8 <_ZN8ConsumerD1Ev>:
class Consumer : public Thread {
    800039f8:	ff010113          	addi	sp,sp,-16
    800039fc:	00113423          	sd	ra,8(sp)
    80003a00:	00813023          	sd	s0,0(sp)
    80003a04:	01010413          	addi	s0,sp,16
    80003a08:	00009797          	auipc	a5,0x9
    80003a0c:	e7078793          	addi	a5,a5,-400 # 8000c878 <_ZTV8Consumer+0x10>
    80003a10:	00f53023          	sd	a5,0(a0)
    80003a14:	00002097          	auipc	ra,0x2
    80003a18:	d10080e7          	jalr	-752(ra) # 80005724 <_ZN6ThreadD1Ev>
    80003a1c:	00813083          	ld	ra,8(sp)
    80003a20:	00013403          	ld	s0,0(sp)
    80003a24:	01010113          	addi	sp,sp,16
    80003a28:	00008067          	ret

0000000080003a2c <_ZN8ConsumerD0Ev>:
    80003a2c:	fe010113          	addi	sp,sp,-32
    80003a30:	00113c23          	sd	ra,24(sp)
    80003a34:	00813823          	sd	s0,16(sp)
    80003a38:	00913423          	sd	s1,8(sp)
    80003a3c:	02010413          	addi	s0,sp,32
    80003a40:	00050493          	mv	s1,a0
    80003a44:	00009797          	auipc	a5,0x9
    80003a48:	e3478793          	addi	a5,a5,-460 # 8000c878 <_ZTV8Consumer+0x10>
    80003a4c:	00f53023          	sd	a5,0(a0)
    80003a50:	00002097          	auipc	ra,0x2
    80003a54:	cd4080e7          	jalr	-812(ra) # 80005724 <_ZN6ThreadD1Ev>
    80003a58:	00048513          	mv	a0,s1
    80003a5c:	00002097          	auipc	ra,0x2
    80003a60:	e04080e7          	jalr	-508(ra) # 80005860 <_ZdlPv>
    80003a64:	01813083          	ld	ra,24(sp)
    80003a68:	01013403          	ld	s0,16(sp)
    80003a6c:	00813483          	ld	s1,8(sp)
    80003a70:	02010113          	addi	sp,sp,32
    80003a74:	00008067          	ret

0000000080003a78 <_ZN16ProducerKeyboradD1Ev>:
class ProducerKeyborad : public Thread {
    80003a78:	ff010113          	addi	sp,sp,-16
    80003a7c:	00113423          	sd	ra,8(sp)
    80003a80:	00813023          	sd	s0,0(sp)
    80003a84:	01010413          	addi	s0,sp,16
    80003a88:	00009797          	auipc	a5,0x9
    80003a8c:	da078793          	addi	a5,a5,-608 # 8000c828 <_ZTV16ProducerKeyborad+0x10>
    80003a90:	00f53023          	sd	a5,0(a0)
    80003a94:	00002097          	auipc	ra,0x2
    80003a98:	c90080e7          	jalr	-880(ra) # 80005724 <_ZN6ThreadD1Ev>
    80003a9c:	00813083          	ld	ra,8(sp)
    80003aa0:	00013403          	ld	s0,0(sp)
    80003aa4:	01010113          	addi	sp,sp,16
    80003aa8:	00008067          	ret

0000000080003aac <_ZN16ProducerKeyboradD0Ev>:
    80003aac:	fe010113          	addi	sp,sp,-32
    80003ab0:	00113c23          	sd	ra,24(sp)
    80003ab4:	00813823          	sd	s0,16(sp)
    80003ab8:	00913423          	sd	s1,8(sp)
    80003abc:	02010413          	addi	s0,sp,32
    80003ac0:	00050493          	mv	s1,a0
    80003ac4:	00009797          	auipc	a5,0x9
    80003ac8:	d6478793          	addi	a5,a5,-668 # 8000c828 <_ZTV16ProducerKeyborad+0x10>
    80003acc:	00f53023          	sd	a5,0(a0)
    80003ad0:	00002097          	auipc	ra,0x2
    80003ad4:	c54080e7          	jalr	-940(ra) # 80005724 <_ZN6ThreadD1Ev>
    80003ad8:	00048513          	mv	a0,s1
    80003adc:	00002097          	auipc	ra,0x2
    80003ae0:	d84080e7          	jalr	-636(ra) # 80005860 <_ZdlPv>
    80003ae4:	01813083          	ld	ra,24(sp)
    80003ae8:	01013403          	ld	s0,16(sp)
    80003aec:	00813483          	ld	s1,8(sp)
    80003af0:	02010113          	addi	sp,sp,32
    80003af4:	00008067          	ret

0000000080003af8 <_ZN8ProducerD1Ev>:
class Producer : public Thread {
    80003af8:	ff010113          	addi	sp,sp,-16
    80003afc:	00113423          	sd	ra,8(sp)
    80003b00:	00813023          	sd	s0,0(sp)
    80003b04:	01010413          	addi	s0,sp,16
    80003b08:	00009797          	auipc	a5,0x9
    80003b0c:	d4878793          	addi	a5,a5,-696 # 8000c850 <_ZTV8Producer+0x10>
    80003b10:	00f53023          	sd	a5,0(a0)
    80003b14:	00002097          	auipc	ra,0x2
    80003b18:	c10080e7          	jalr	-1008(ra) # 80005724 <_ZN6ThreadD1Ev>
    80003b1c:	00813083          	ld	ra,8(sp)
    80003b20:	00013403          	ld	s0,0(sp)
    80003b24:	01010113          	addi	sp,sp,16
    80003b28:	00008067          	ret

0000000080003b2c <_ZN8ProducerD0Ev>:
    80003b2c:	fe010113          	addi	sp,sp,-32
    80003b30:	00113c23          	sd	ra,24(sp)
    80003b34:	00813823          	sd	s0,16(sp)
    80003b38:	00913423          	sd	s1,8(sp)
    80003b3c:	02010413          	addi	s0,sp,32
    80003b40:	00050493          	mv	s1,a0
    80003b44:	00009797          	auipc	a5,0x9
    80003b48:	d0c78793          	addi	a5,a5,-756 # 8000c850 <_ZTV8Producer+0x10>
    80003b4c:	00f53023          	sd	a5,0(a0)
    80003b50:	00002097          	auipc	ra,0x2
    80003b54:	bd4080e7          	jalr	-1068(ra) # 80005724 <_ZN6ThreadD1Ev>
    80003b58:	00048513          	mv	a0,s1
    80003b5c:	00002097          	auipc	ra,0x2
    80003b60:	d04080e7          	jalr	-764(ra) # 80005860 <_ZdlPv>
    80003b64:	01813083          	ld	ra,24(sp)
    80003b68:	01013403          	ld	s0,16(sp)
    80003b6c:	00813483          	ld	s1,8(sp)
    80003b70:	02010113          	addi	sp,sp,32
    80003b74:	00008067          	ret

0000000080003b78 <_ZN16ProducerKeyborad3runEv>:
    void run() override {
    80003b78:	fe010113          	addi	sp,sp,-32
    80003b7c:	00113c23          	sd	ra,24(sp)
    80003b80:	00813823          	sd	s0,16(sp)
    80003b84:	00913423          	sd	s1,8(sp)
    80003b88:	02010413          	addi	s0,sp,32
    80003b8c:	00050493          	mv	s1,a0
        while ((key = Console::getc()) != 0x1b) {
    80003b90:	00002097          	auipc	ra,0x2
    80003b94:	f14080e7          	jalr	-236(ra) # 80005aa4 <_ZN7Console4getcEv>
    80003b98:	0005059b          	sext.w	a1,a0
    80003b9c:	01b00793          	li	a5,27
    80003ba0:	00f58c63          	beq	a1,a5,80003bb8 <_ZN16ProducerKeyborad3runEv+0x40>
            td->buffer->put(key);
    80003ba4:	0204b783          	ld	a5,32(s1)
    80003ba8:	0087b503          	ld	a0,8(a5)
    80003bac:	00001097          	auipc	ra,0x1
    80003bb0:	36c080e7          	jalr	876(ra) # 80004f18 <_ZN9BufferCPP3putEi>
        while ((key = Console::getc()) != 0x1b) {
    80003bb4:	fddff06f          	j	80003b90 <_ZN16ProducerKeyborad3runEv+0x18>
        threadEnd = 1;
    80003bb8:	00100793          	li	a5,1
    80003bbc:	00009717          	auipc	a4,0x9
    80003bc0:	ecf72a23          	sw	a5,-300(a4) # 8000ca90 <_ZL9threadEnd>
        td->buffer->put('!');
    80003bc4:	0204b783          	ld	a5,32(s1)
    80003bc8:	02100593          	li	a1,33
    80003bcc:	0087b503          	ld	a0,8(a5)
    80003bd0:	00001097          	auipc	ra,0x1
    80003bd4:	348080e7          	jalr	840(ra) # 80004f18 <_ZN9BufferCPP3putEi>
        td->sem->signal();
    80003bd8:	0204b783          	ld	a5,32(s1)
    80003bdc:	0107b503          	ld	a0,16(a5)
    80003be0:	00002097          	auipc	ra,0x2
    80003be4:	e98080e7          	jalr	-360(ra) # 80005a78 <_ZN9Semaphore6signalEv>
    }
    80003be8:	01813083          	ld	ra,24(sp)
    80003bec:	01013403          	ld	s0,16(sp)
    80003bf0:	00813483          	ld	s1,8(sp)
    80003bf4:	02010113          	addi	sp,sp,32
    80003bf8:	00008067          	ret

0000000080003bfc <_ZN8Producer3runEv>:
    void run() override {
    80003bfc:	fe010113          	addi	sp,sp,-32
    80003c00:	00113c23          	sd	ra,24(sp)
    80003c04:	00813823          	sd	s0,16(sp)
    80003c08:	00913423          	sd	s1,8(sp)
    80003c0c:	01213023          	sd	s2,0(sp)
    80003c10:	02010413          	addi	s0,sp,32
    80003c14:	00050493          	mv	s1,a0
        int i = 0;
    80003c18:	00000913          	li	s2,0
        while (!threadEnd) {
    80003c1c:	00009797          	auipc	a5,0x9
    80003c20:	e747a783          	lw	a5,-396(a5) # 8000ca90 <_ZL9threadEnd>
    80003c24:	04079263          	bnez	a5,80003c68 <_ZN8Producer3runEv+0x6c>
            td->buffer->put(td->id + '0');
    80003c28:	0204b783          	ld	a5,32(s1)
    80003c2c:	0007a583          	lw	a1,0(a5)
    80003c30:	0305859b          	addiw	a1,a1,48
    80003c34:	0087b503          	ld	a0,8(a5)
    80003c38:	00001097          	auipc	ra,0x1
    80003c3c:	2e0080e7          	jalr	736(ra) # 80004f18 <_ZN9BufferCPP3putEi>
            i++;
    80003c40:	0019071b          	addiw	a4,s2,1
    80003c44:	0007091b          	sext.w	s2,a4
            Thread::sleep((i + td->id) % 5);
    80003c48:	0204b783          	ld	a5,32(s1)
    80003c4c:	0007a783          	lw	a5,0(a5)
    80003c50:	00e787bb          	addw	a5,a5,a4
    80003c54:	00500513          	li	a0,5
    80003c58:	02a7e53b          	remw	a0,a5,a0
    80003c5c:	00002097          	auipc	ra,0x2
    80003c60:	d90080e7          	jalr	-624(ra) # 800059ec <_ZN6Thread5sleepEm>
        while (!threadEnd) {
    80003c64:	fb9ff06f          	j	80003c1c <_ZN8Producer3runEv+0x20>
        td->sem->signal();
    80003c68:	0204b783          	ld	a5,32(s1)
    80003c6c:	0107b503          	ld	a0,16(a5)
    80003c70:	00002097          	auipc	ra,0x2
    80003c74:	e08080e7          	jalr	-504(ra) # 80005a78 <_ZN9Semaphore6signalEv>
    }
    80003c78:	01813083          	ld	ra,24(sp)
    80003c7c:	01013403          	ld	s0,16(sp)
    80003c80:	00813483          	ld	s1,8(sp)
    80003c84:	00013903          	ld	s2,0(sp)
    80003c88:	02010113          	addi	sp,sp,32
    80003c8c:	00008067          	ret

0000000080003c90 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80003c90:	fe010113          	addi	sp,sp,-32
    80003c94:	00113c23          	sd	ra,24(sp)
    80003c98:	00813823          	sd	s0,16(sp)
    80003c9c:	00913423          	sd	s1,8(sp)
    80003ca0:	01213023          	sd	s2,0(sp)
    80003ca4:	02010413          	addi	s0,sp,32
    80003ca8:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80003cac:	00100793          	li	a5,1
    80003cb0:	02a7f863          	bgeu	a5,a0,80003ce0 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80003cb4:	00a00793          	li	a5,10
    80003cb8:	02f577b3          	remu	a5,a0,a5
    80003cbc:	02078e63          	beqz	a5,80003cf8 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80003cc0:	fff48513          	addi	a0,s1,-1
    80003cc4:	00000097          	auipc	ra,0x0
    80003cc8:	fcc080e7          	jalr	-52(ra) # 80003c90 <_ZL9fibonaccim>
    80003ccc:	00050913          	mv	s2,a0
    80003cd0:	ffe48513          	addi	a0,s1,-2
    80003cd4:	00000097          	auipc	ra,0x0
    80003cd8:	fbc080e7          	jalr	-68(ra) # 80003c90 <_ZL9fibonaccim>
    80003cdc:	00a90533          	add	a0,s2,a0
}
    80003ce0:	01813083          	ld	ra,24(sp)
    80003ce4:	01013403          	ld	s0,16(sp)
    80003ce8:	00813483          	ld	s1,8(sp)
    80003cec:	00013903          	ld	s2,0(sp)
    80003cf0:	02010113          	addi	sp,sp,32
    80003cf4:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80003cf8:	ffffe097          	auipc	ra,0xffffe
    80003cfc:	db0080e7          	jalr	-592(ra) # 80001aa8 <thread_dispatch>
    80003d00:	fc1ff06f          	j	80003cc0 <_ZL9fibonaccim+0x30>

0000000080003d04 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80003d04:	fe010113          	addi	sp,sp,-32
    80003d08:	00113c23          	sd	ra,24(sp)
    80003d0c:	00813823          	sd	s0,16(sp)
    80003d10:	00913423          	sd	s1,8(sp)
    80003d14:	01213023          	sd	s2,0(sp)
    80003d18:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80003d1c:	00a00493          	li	s1,10
    80003d20:	0400006f          	j	80003d60 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80003d24:	00006517          	auipc	a0,0x6
    80003d28:	45450513          	addi	a0,a0,1108 # 8000a178 <CONSOLE_STATUS+0x168>
    80003d2c:	00001097          	auipc	ra,0x1
    80003d30:	dc8080e7          	jalr	-568(ra) # 80004af4 <_Z11printStringPKc>
    80003d34:	00000613          	li	a2,0
    80003d38:	00a00593          	li	a1,10
    80003d3c:	00048513          	mv	a0,s1
    80003d40:	00001097          	auipc	ra,0x1
    80003d44:	f64080e7          	jalr	-156(ra) # 80004ca4 <_Z8printIntiii>
    80003d48:	00006517          	auipc	a0,0x6
    80003d4c:	62050513          	addi	a0,a0,1568 # 8000a368 <CONSOLE_STATUS+0x358>
    80003d50:	00001097          	auipc	ra,0x1
    80003d54:	da4080e7          	jalr	-604(ra) # 80004af4 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80003d58:	0014849b          	addiw	s1,s1,1
    80003d5c:	0ff4f493          	andi	s1,s1,255
    80003d60:	00c00793          	li	a5,12
    80003d64:	fc97f0e3          	bgeu	a5,s1,80003d24 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80003d68:	00006517          	auipc	a0,0x6
    80003d6c:	41850513          	addi	a0,a0,1048 # 8000a180 <CONSOLE_STATUS+0x170>
    80003d70:	00001097          	auipc	ra,0x1
    80003d74:	d84080e7          	jalr	-636(ra) # 80004af4 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80003d78:	00500313          	li	t1,5
    thread_dispatch();
    80003d7c:	ffffe097          	auipc	ra,0xffffe
    80003d80:	d2c080e7          	jalr	-724(ra) # 80001aa8 <thread_dispatch>

    uint64 result = fibonacci(16);
    80003d84:	01000513          	li	a0,16
    80003d88:	00000097          	auipc	ra,0x0
    80003d8c:	f08080e7          	jalr	-248(ra) # 80003c90 <_ZL9fibonaccim>
    80003d90:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80003d94:	00006517          	auipc	a0,0x6
    80003d98:	3fc50513          	addi	a0,a0,1020 # 8000a190 <CONSOLE_STATUS+0x180>
    80003d9c:	00001097          	auipc	ra,0x1
    80003da0:	d58080e7          	jalr	-680(ra) # 80004af4 <_Z11printStringPKc>
    80003da4:	00000613          	li	a2,0
    80003da8:	00a00593          	li	a1,10
    80003dac:	0009051b          	sext.w	a0,s2
    80003db0:	00001097          	auipc	ra,0x1
    80003db4:	ef4080e7          	jalr	-268(ra) # 80004ca4 <_Z8printIntiii>
    80003db8:	00006517          	auipc	a0,0x6
    80003dbc:	5b050513          	addi	a0,a0,1456 # 8000a368 <CONSOLE_STATUS+0x358>
    80003dc0:	00001097          	auipc	ra,0x1
    80003dc4:	d34080e7          	jalr	-716(ra) # 80004af4 <_Z11printStringPKc>
    80003dc8:	0400006f          	j	80003e08 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80003dcc:	00006517          	auipc	a0,0x6
    80003dd0:	3ac50513          	addi	a0,a0,940 # 8000a178 <CONSOLE_STATUS+0x168>
    80003dd4:	00001097          	auipc	ra,0x1
    80003dd8:	d20080e7          	jalr	-736(ra) # 80004af4 <_Z11printStringPKc>
    80003ddc:	00000613          	li	a2,0
    80003de0:	00a00593          	li	a1,10
    80003de4:	00048513          	mv	a0,s1
    80003de8:	00001097          	auipc	ra,0x1
    80003dec:	ebc080e7          	jalr	-324(ra) # 80004ca4 <_Z8printIntiii>
    80003df0:	00006517          	auipc	a0,0x6
    80003df4:	57850513          	addi	a0,a0,1400 # 8000a368 <CONSOLE_STATUS+0x358>
    80003df8:	00001097          	auipc	ra,0x1
    80003dfc:	cfc080e7          	jalr	-772(ra) # 80004af4 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80003e00:	0014849b          	addiw	s1,s1,1
    80003e04:	0ff4f493          	andi	s1,s1,255
    80003e08:	00f00793          	li	a5,15
    80003e0c:	fc97f0e3          	bgeu	a5,s1,80003dcc <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80003e10:	00006517          	auipc	a0,0x6
    80003e14:	39050513          	addi	a0,a0,912 # 8000a1a0 <CONSOLE_STATUS+0x190>
    80003e18:	00001097          	auipc	ra,0x1
    80003e1c:	cdc080e7          	jalr	-804(ra) # 80004af4 <_Z11printStringPKc>
    finishedD = true;
    80003e20:	00100793          	li	a5,1
    80003e24:	00009717          	auipc	a4,0x9
    80003e28:	c6f70e23          	sb	a5,-900(a4) # 8000caa0 <_ZL9finishedD>
    thread_dispatch();
    80003e2c:	ffffe097          	auipc	ra,0xffffe
    80003e30:	c7c080e7          	jalr	-900(ra) # 80001aa8 <thread_dispatch>
}
    80003e34:	01813083          	ld	ra,24(sp)
    80003e38:	01013403          	ld	s0,16(sp)
    80003e3c:	00813483          	ld	s1,8(sp)
    80003e40:	00013903          	ld	s2,0(sp)
    80003e44:	02010113          	addi	sp,sp,32
    80003e48:	00008067          	ret

0000000080003e4c <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80003e4c:	fe010113          	addi	sp,sp,-32
    80003e50:	00113c23          	sd	ra,24(sp)
    80003e54:	00813823          	sd	s0,16(sp)
    80003e58:	00913423          	sd	s1,8(sp)
    80003e5c:	01213023          	sd	s2,0(sp)
    80003e60:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80003e64:	00000493          	li	s1,0
    80003e68:	0400006f          	j	80003ea8 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80003e6c:	00006517          	auipc	a0,0x6
    80003e70:	2cc50513          	addi	a0,a0,716 # 8000a138 <CONSOLE_STATUS+0x128>
    80003e74:	00001097          	auipc	ra,0x1
    80003e78:	c80080e7          	jalr	-896(ra) # 80004af4 <_Z11printStringPKc>
    80003e7c:	00000613          	li	a2,0
    80003e80:	00a00593          	li	a1,10
    80003e84:	00048513          	mv	a0,s1
    80003e88:	00001097          	auipc	ra,0x1
    80003e8c:	e1c080e7          	jalr	-484(ra) # 80004ca4 <_Z8printIntiii>
    80003e90:	00006517          	auipc	a0,0x6
    80003e94:	4d850513          	addi	a0,a0,1240 # 8000a368 <CONSOLE_STATUS+0x358>
    80003e98:	00001097          	auipc	ra,0x1
    80003e9c:	c5c080e7          	jalr	-932(ra) # 80004af4 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80003ea0:	0014849b          	addiw	s1,s1,1
    80003ea4:	0ff4f493          	andi	s1,s1,255
    80003ea8:	00200793          	li	a5,2
    80003eac:	fc97f0e3          	bgeu	a5,s1,80003e6c <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80003eb0:	00006517          	auipc	a0,0x6
    80003eb4:	29050513          	addi	a0,a0,656 # 8000a140 <CONSOLE_STATUS+0x130>
    80003eb8:	00001097          	auipc	ra,0x1
    80003ebc:	c3c080e7          	jalr	-964(ra) # 80004af4 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80003ec0:	00700313          	li	t1,7
    thread_dispatch();
    80003ec4:	ffffe097          	auipc	ra,0xffffe
    80003ec8:	be4080e7          	jalr	-1052(ra) # 80001aa8 <thread_dispatch>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80003ecc:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80003ed0:	00006517          	auipc	a0,0x6
    80003ed4:	28050513          	addi	a0,a0,640 # 8000a150 <CONSOLE_STATUS+0x140>
    80003ed8:	00001097          	auipc	ra,0x1
    80003edc:	c1c080e7          	jalr	-996(ra) # 80004af4 <_Z11printStringPKc>
    80003ee0:	00000613          	li	a2,0
    80003ee4:	00a00593          	li	a1,10
    80003ee8:	0009051b          	sext.w	a0,s2
    80003eec:	00001097          	auipc	ra,0x1
    80003ef0:	db8080e7          	jalr	-584(ra) # 80004ca4 <_Z8printIntiii>
    80003ef4:	00006517          	auipc	a0,0x6
    80003ef8:	47450513          	addi	a0,a0,1140 # 8000a368 <CONSOLE_STATUS+0x358>
    80003efc:	00001097          	auipc	ra,0x1
    80003f00:	bf8080e7          	jalr	-1032(ra) # 80004af4 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80003f04:	00c00513          	li	a0,12
    80003f08:	00000097          	auipc	ra,0x0
    80003f0c:	d88080e7          	jalr	-632(ra) # 80003c90 <_ZL9fibonaccim>
    80003f10:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80003f14:	00006517          	auipc	a0,0x6
    80003f18:	24450513          	addi	a0,a0,580 # 8000a158 <CONSOLE_STATUS+0x148>
    80003f1c:	00001097          	auipc	ra,0x1
    80003f20:	bd8080e7          	jalr	-1064(ra) # 80004af4 <_Z11printStringPKc>
    80003f24:	00000613          	li	a2,0
    80003f28:	00a00593          	li	a1,10
    80003f2c:	0009051b          	sext.w	a0,s2
    80003f30:	00001097          	auipc	ra,0x1
    80003f34:	d74080e7          	jalr	-652(ra) # 80004ca4 <_Z8printIntiii>
    80003f38:	00006517          	auipc	a0,0x6
    80003f3c:	43050513          	addi	a0,a0,1072 # 8000a368 <CONSOLE_STATUS+0x358>
    80003f40:	00001097          	auipc	ra,0x1
    80003f44:	bb4080e7          	jalr	-1100(ra) # 80004af4 <_Z11printStringPKc>
    80003f48:	0400006f          	j	80003f88 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80003f4c:	00006517          	auipc	a0,0x6
    80003f50:	1ec50513          	addi	a0,a0,492 # 8000a138 <CONSOLE_STATUS+0x128>
    80003f54:	00001097          	auipc	ra,0x1
    80003f58:	ba0080e7          	jalr	-1120(ra) # 80004af4 <_Z11printStringPKc>
    80003f5c:	00000613          	li	a2,0
    80003f60:	00a00593          	li	a1,10
    80003f64:	00048513          	mv	a0,s1
    80003f68:	00001097          	auipc	ra,0x1
    80003f6c:	d3c080e7          	jalr	-708(ra) # 80004ca4 <_Z8printIntiii>
    80003f70:	00006517          	auipc	a0,0x6
    80003f74:	3f850513          	addi	a0,a0,1016 # 8000a368 <CONSOLE_STATUS+0x358>
    80003f78:	00001097          	auipc	ra,0x1
    80003f7c:	b7c080e7          	jalr	-1156(ra) # 80004af4 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80003f80:	0014849b          	addiw	s1,s1,1
    80003f84:	0ff4f493          	andi	s1,s1,255
    80003f88:	00500793          	li	a5,5
    80003f8c:	fc97f0e3          	bgeu	a5,s1,80003f4c <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80003f90:	00006517          	auipc	a0,0x6
    80003f94:	18050513          	addi	a0,a0,384 # 8000a110 <CONSOLE_STATUS+0x100>
    80003f98:	00001097          	auipc	ra,0x1
    80003f9c:	b5c080e7          	jalr	-1188(ra) # 80004af4 <_Z11printStringPKc>
    finishedC = true;
    80003fa0:	00100793          	li	a5,1
    80003fa4:	00009717          	auipc	a4,0x9
    80003fa8:	aef70ea3          	sb	a5,-1283(a4) # 8000caa1 <_ZL9finishedC>
    thread_dispatch();
    80003fac:	ffffe097          	auipc	ra,0xffffe
    80003fb0:	afc080e7          	jalr	-1284(ra) # 80001aa8 <thread_dispatch>
}
    80003fb4:	01813083          	ld	ra,24(sp)
    80003fb8:	01013403          	ld	s0,16(sp)
    80003fbc:	00813483          	ld	s1,8(sp)
    80003fc0:	00013903          	ld	s2,0(sp)
    80003fc4:	02010113          	addi	sp,sp,32
    80003fc8:	00008067          	ret

0000000080003fcc <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80003fcc:	fe010113          	addi	sp,sp,-32
    80003fd0:	00113c23          	sd	ra,24(sp)
    80003fd4:	00813823          	sd	s0,16(sp)
    80003fd8:	00913423          	sd	s1,8(sp)
    80003fdc:	01213023          	sd	s2,0(sp)
    80003fe0:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80003fe4:	00000913          	li	s2,0
    80003fe8:	0380006f          	j	80004020 <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80003fec:	ffffe097          	auipc	ra,0xffffe
    80003ff0:	abc080e7          	jalr	-1348(ra) # 80001aa8 <thread_dispatch>
        for (uint64 j = 0; j < 10000; j++) {
    80003ff4:	00148493          	addi	s1,s1,1
    80003ff8:	000027b7          	lui	a5,0x2
    80003ffc:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004000:	0097ee63          	bltu	a5,s1,8000401c <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004004:	00000713          	li	a4,0
    80004008:	000077b7          	lui	a5,0x7
    8000400c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004010:	fce7eee3          	bltu	a5,a4,80003fec <_ZL11workerBodyBPv+0x20>
    80004014:	00170713          	addi	a4,a4,1
    80004018:	ff1ff06f          	j	80004008 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    8000401c:	00190913          	addi	s2,s2,1
    80004020:	00f00793          	li	a5,15
    80004024:	0527e063          	bltu	a5,s2,80004064 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80004028:	00006517          	auipc	a0,0x6
    8000402c:	0f850513          	addi	a0,a0,248 # 8000a120 <CONSOLE_STATUS+0x110>
    80004030:	00001097          	auipc	ra,0x1
    80004034:	ac4080e7          	jalr	-1340(ra) # 80004af4 <_Z11printStringPKc>
    80004038:	00000613          	li	a2,0
    8000403c:	00a00593          	li	a1,10
    80004040:	0009051b          	sext.w	a0,s2
    80004044:	00001097          	auipc	ra,0x1
    80004048:	c60080e7          	jalr	-928(ra) # 80004ca4 <_Z8printIntiii>
    8000404c:	00006517          	auipc	a0,0x6
    80004050:	31c50513          	addi	a0,a0,796 # 8000a368 <CONSOLE_STATUS+0x358>
    80004054:	00001097          	auipc	ra,0x1
    80004058:	aa0080e7          	jalr	-1376(ra) # 80004af4 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000405c:	00000493          	li	s1,0
    80004060:	f99ff06f          	j	80003ff8 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    80004064:	00006517          	auipc	a0,0x6
    80004068:	0c450513          	addi	a0,a0,196 # 8000a128 <CONSOLE_STATUS+0x118>
    8000406c:	00001097          	auipc	ra,0x1
    80004070:	a88080e7          	jalr	-1400(ra) # 80004af4 <_Z11printStringPKc>
    finishedB = true;
    80004074:	00100793          	li	a5,1
    80004078:	00009717          	auipc	a4,0x9
    8000407c:	a2f70523          	sb	a5,-1494(a4) # 8000caa2 <_ZL9finishedB>
    thread_dispatch();
    80004080:	ffffe097          	auipc	ra,0xffffe
    80004084:	a28080e7          	jalr	-1496(ra) # 80001aa8 <thread_dispatch>
}
    80004088:	01813083          	ld	ra,24(sp)
    8000408c:	01013403          	ld	s0,16(sp)
    80004090:	00813483          	ld	s1,8(sp)
    80004094:	00013903          	ld	s2,0(sp)
    80004098:	02010113          	addi	sp,sp,32
    8000409c:	00008067          	ret

00000000800040a0 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    800040a0:	fe010113          	addi	sp,sp,-32
    800040a4:	00113c23          	sd	ra,24(sp)
    800040a8:	00813823          	sd	s0,16(sp)
    800040ac:	00913423          	sd	s1,8(sp)
    800040b0:	01213023          	sd	s2,0(sp)
    800040b4:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800040b8:	00000913          	li	s2,0
    800040bc:	0380006f          	j	800040f4 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    800040c0:	ffffe097          	auipc	ra,0xffffe
    800040c4:	9e8080e7          	jalr	-1560(ra) # 80001aa8 <thread_dispatch>
        for (uint64 j = 0; j < 10000; j++) {
    800040c8:	00148493          	addi	s1,s1,1
    800040cc:	000027b7          	lui	a5,0x2
    800040d0:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800040d4:	0097ee63          	bltu	a5,s1,800040f0 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800040d8:	00000713          	li	a4,0
    800040dc:	000077b7          	lui	a5,0x7
    800040e0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800040e4:	fce7eee3          	bltu	a5,a4,800040c0 <_ZL11workerBodyAPv+0x20>
    800040e8:	00170713          	addi	a4,a4,1
    800040ec:	ff1ff06f          	j	800040dc <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800040f0:	00190913          	addi	s2,s2,1
    800040f4:	00900793          	li	a5,9
    800040f8:	0527e063          	bltu	a5,s2,80004138 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    800040fc:	00006517          	auipc	a0,0x6
    80004100:	00c50513          	addi	a0,a0,12 # 8000a108 <CONSOLE_STATUS+0xf8>
    80004104:	00001097          	auipc	ra,0x1
    80004108:	9f0080e7          	jalr	-1552(ra) # 80004af4 <_Z11printStringPKc>
    8000410c:	00000613          	li	a2,0
    80004110:	00a00593          	li	a1,10
    80004114:	0009051b          	sext.w	a0,s2
    80004118:	00001097          	auipc	ra,0x1
    8000411c:	b8c080e7          	jalr	-1140(ra) # 80004ca4 <_Z8printIntiii>
    80004120:	00006517          	auipc	a0,0x6
    80004124:	24850513          	addi	a0,a0,584 # 8000a368 <CONSOLE_STATUS+0x358>
    80004128:	00001097          	auipc	ra,0x1
    8000412c:	9cc080e7          	jalr	-1588(ra) # 80004af4 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004130:	00000493          	li	s1,0
    80004134:	f99ff06f          	j	800040cc <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80004138:	00006517          	auipc	a0,0x6
    8000413c:	fd850513          	addi	a0,a0,-40 # 8000a110 <CONSOLE_STATUS+0x100>
    80004140:	00001097          	auipc	ra,0x1
    80004144:	9b4080e7          	jalr	-1612(ra) # 80004af4 <_Z11printStringPKc>
    finishedA = true;
    80004148:	00100793          	li	a5,1
    8000414c:	00009717          	auipc	a4,0x9
    80004150:	94f70ba3          	sb	a5,-1705(a4) # 8000caa3 <_ZL9finishedA>
}
    80004154:	01813083          	ld	ra,24(sp)
    80004158:	01013403          	ld	s0,16(sp)
    8000415c:	00813483          	ld	s1,8(sp)
    80004160:	00013903          	ld	s2,0(sp)
    80004164:	02010113          	addi	sp,sp,32
    80004168:	00008067          	ret

000000008000416c <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    8000416c:	fd010113          	addi	sp,sp,-48
    80004170:	02113423          	sd	ra,40(sp)
    80004174:	02813023          	sd	s0,32(sp)
    80004178:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    8000417c:	00000613          	li	a2,0
    80004180:	00000597          	auipc	a1,0x0
    80004184:	f2058593          	addi	a1,a1,-224 # 800040a0 <_ZL11workerBodyAPv>
    80004188:	fd040513          	addi	a0,s0,-48
    8000418c:	ffffe097          	auipc	ra,0xffffe
    80004190:	8dc080e7          	jalr	-1828(ra) # 80001a68 <thread_create>
    printString("ThreadA created\n");
    80004194:	00006517          	auipc	a0,0x6
    80004198:	01c50513          	addi	a0,a0,28 # 8000a1b0 <CONSOLE_STATUS+0x1a0>
    8000419c:	00001097          	auipc	ra,0x1
    800041a0:	958080e7          	jalr	-1704(ra) # 80004af4 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    800041a4:	00000613          	li	a2,0
    800041a8:	00000597          	auipc	a1,0x0
    800041ac:	e2458593          	addi	a1,a1,-476 # 80003fcc <_ZL11workerBodyBPv>
    800041b0:	fd840513          	addi	a0,s0,-40
    800041b4:	ffffe097          	auipc	ra,0xffffe
    800041b8:	8b4080e7          	jalr	-1868(ra) # 80001a68 <thread_create>
    printString("ThreadB created\n");
    800041bc:	00006517          	auipc	a0,0x6
    800041c0:	00c50513          	addi	a0,a0,12 # 8000a1c8 <CONSOLE_STATUS+0x1b8>
    800041c4:	00001097          	auipc	ra,0x1
    800041c8:	930080e7          	jalr	-1744(ra) # 80004af4 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    800041cc:	00000613          	li	a2,0
    800041d0:	00000597          	auipc	a1,0x0
    800041d4:	c7c58593          	addi	a1,a1,-900 # 80003e4c <_ZL11workerBodyCPv>
    800041d8:	fe040513          	addi	a0,s0,-32
    800041dc:	ffffe097          	auipc	ra,0xffffe
    800041e0:	88c080e7          	jalr	-1908(ra) # 80001a68 <thread_create>
    printString("ThreadC created\n");
    800041e4:	00006517          	auipc	a0,0x6
    800041e8:	ffc50513          	addi	a0,a0,-4 # 8000a1e0 <CONSOLE_STATUS+0x1d0>
    800041ec:	00001097          	auipc	ra,0x1
    800041f0:	908080e7          	jalr	-1784(ra) # 80004af4 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    800041f4:	00000613          	li	a2,0
    800041f8:	00000597          	auipc	a1,0x0
    800041fc:	b0c58593          	addi	a1,a1,-1268 # 80003d04 <_ZL11workerBodyDPv>
    80004200:	fe840513          	addi	a0,s0,-24
    80004204:	ffffe097          	auipc	ra,0xffffe
    80004208:	864080e7          	jalr	-1948(ra) # 80001a68 <thread_create>
    printString("ThreadD created\n");
    8000420c:	00006517          	auipc	a0,0x6
    80004210:	fec50513          	addi	a0,a0,-20 # 8000a1f8 <CONSOLE_STATUS+0x1e8>
    80004214:	00001097          	auipc	ra,0x1
    80004218:	8e0080e7          	jalr	-1824(ra) # 80004af4 <_Z11printStringPKc>
    8000421c:	00c0006f          	j	80004228 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80004220:	ffffe097          	auipc	ra,0xffffe
    80004224:	888080e7          	jalr	-1912(ra) # 80001aa8 <thread_dispatch>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80004228:	00009797          	auipc	a5,0x9
    8000422c:	87b7c783          	lbu	a5,-1925(a5) # 8000caa3 <_ZL9finishedA>
    80004230:	fe0788e3          	beqz	a5,80004220 <_Z18Threads_C_API_testv+0xb4>
    80004234:	00009797          	auipc	a5,0x9
    80004238:	86e7c783          	lbu	a5,-1938(a5) # 8000caa2 <_ZL9finishedB>
    8000423c:	fe0782e3          	beqz	a5,80004220 <_Z18Threads_C_API_testv+0xb4>
    80004240:	00009797          	auipc	a5,0x9
    80004244:	8617c783          	lbu	a5,-1951(a5) # 8000caa1 <_ZL9finishedC>
    80004248:	fc078ce3          	beqz	a5,80004220 <_Z18Threads_C_API_testv+0xb4>
    8000424c:	00009797          	auipc	a5,0x9
    80004250:	8547c783          	lbu	a5,-1964(a5) # 8000caa0 <_ZL9finishedD>
    80004254:	fc0786e3          	beqz	a5,80004220 <_Z18Threads_C_API_testv+0xb4>
    }

}
    80004258:	02813083          	ld	ra,40(sp)
    8000425c:	02013403          	ld	s0,32(sp)
    80004260:	03010113          	addi	sp,sp,48
    80004264:	00008067          	ret

0000000080004268 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80004268:	fd010113          	addi	sp,sp,-48
    8000426c:	02113423          	sd	ra,40(sp)
    80004270:	02813023          	sd	s0,32(sp)
    80004274:	00913c23          	sd	s1,24(sp)
    80004278:	01213823          	sd	s2,16(sp)
    8000427c:	01313423          	sd	s3,8(sp)
    80004280:	03010413          	addi	s0,sp,48
    80004284:	00050993          	mv	s3,a0
    80004288:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    8000428c:	00000913          	li	s2,0
    80004290:	00c0006f          	j	8000429c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80004294:	00001097          	auipc	ra,0x1
    80004298:	704080e7          	jalr	1796(ra) # 80005998 <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 0x1b) {
    8000429c:	ffffe097          	auipc	ra,0xffffe
    800042a0:	9b0080e7          	jalr	-1616(ra) # 80001c4c <getc>
    800042a4:	0005059b          	sext.w	a1,a0
    800042a8:	01b00793          	li	a5,27
    800042ac:	02f58a63          	beq	a1,a5,800042e0 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    800042b0:	0084b503          	ld	a0,8(s1)
    800042b4:	00001097          	auipc	ra,0x1
    800042b8:	c64080e7          	jalr	-924(ra) # 80004f18 <_ZN9BufferCPP3putEi>
        i++;
    800042bc:	0019071b          	addiw	a4,s2,1
    800042c0:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800042c4:	0004a683          	lw	a3,0(s1)
    800042c8:	0026979b          	slliw	a5,a3,0x2
    800042cc:	00d787bb          	addw	a5,a5,a3
    800042d0:	0017979b          	slliw	a5,a5,0x1
    800042d4:	02f767bb          	remw	a5,a4,a5
    800042d8:	fc0792e3          	bnez	a5,8000429c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    800042dc:	fb9ff06f          	j	80004294 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    800042e0:	00100793          	li	a5,1
    800042e4:	00008717          	auipc	a4,0x8
    800042e8:	7cf72223          	sw	a5,1988(a4) # 8000caa8 <_ZL9threadEnd>
    td->buffer->put('!');
    800042ec:	0209b783          	ld	a5,32(s3)
    800042f0:	02100593          	li	a1,33
    800042f4:	0087b503          	ld	a0,8(a5)
    800042f8:	00001097          	auipc	ra,0x1
    800042fc:	c20080e7          	jalr	-992(ra) # 80004f18 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    80004300:	0104b503          	ld	a0,16(s1)
    80004304:	00001097          	auipc	ra,0x1
    80004308:	774080e7          	jalr	1908(ra) # 80005a78 <_ZN9Semaphore6signalEv>
}
    8000430c:	02813083          	ld	ra,40(sp)
    80004310:	02013403          	ld	s0,32(sp)
    80004314:	01813483          	ld	s1,24(sp)
    80004318:	01013903          	ld	s2,16(sp)
    8000431c:	00813983          	ld	s3,8(sp)
    80004320:	03010113          	addi	sp,sp,48
    80004324:	00008067          	ret

0000000080004328 <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    80004328:	fe010113          	addi	sp,sp,-32
    8000432c:	00113c23          	sd	ra,24(sp)
    80004330:	00813823          	sd	s0,16(sp)
    80004334:	00913423          	sd	s1,8(sp)
    80004338:	01213023          	sd	s2,0(sp)
    8000433c:	02010413          	addi	s0,sp,32
    80004340:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80004344:	00000913          	li	s2,0
    80004348:	00c0006f          	j	80004354 <_ZN12ProducerSync8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    8000434c:	00001097          	auipc	ra,0x1
    80004350:	64c080e7          	jalr	1612(ra) # 80005998 <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    80004354:	00008797          	auipc	a5,0x8
    80004358:	7547a783          	lw	a5,1876(a5) # 8000caa8 <_ZL9threadEnd>
    8000435c:	02079e63          	bnez	a5,80004398 <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    80004360:	0004a583          	lw	a1,0(s1)
    80004364:	0305859b          	addiw	a1,a1,48
    80004368:	0084b503          	ld	a0,8(s1)
    8000436c:	00001097          	auipc	ra,0x1
    80004370:	bac080e7          	jalr	-1108(ra) # 80004f18 <_ZN9BufferCPP3putEi>
        i++;
    80004374:	0019071b          	addiw	a4,s2,1
    80004378:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    8000437c:	0004a683          	lw	a3,0(s1)
    80004380:	0026979b          	slliw	a5,a3,0x2
    80004384:	00d787bb          	addw	a5,a5,a3
    80004388:	0017979b          	slliw	a5,a5,0x1
    8000438c:	02f767bb          	remw	a5,a4,a5
    80004390:	fc0792e3          	bnez	a5,80004354 <_ZN12ProducerSync8producerEPv+0x2c>
    80004394:	fb9ff06f          	j	8000434c <_ZN12ProducerSync8producerEPv+0x24>
        }
    }

    data->wait->signal();
    80004398:	0104b503          	ld	a0,16(s1)
    8000439c:	00001097          	auipc	ra,0x1
    800043a0:	6dc080e7          	jalr	1756(ra) # 80005a78 <_ZN9Semaphore6signalEv>
}
    800043a4:	01813083          	ld	ra,24(sp)
    800043a8:	01013403          	ld	s0,16(sp)
    800043ac:	00813483          	ld	s1,8(sp)
    800043b0:	00013903          	ld	s2,0(sp)
    800043b4:	02010113          	addi	sp,sp,32
    800043b8:	00008067          	ret

00000000800043bc <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    800043bc:	fd010113          	addi	sp,sp,-48
    800043c0:	02113423          	sd	ra,40(sp)
    800043c4:	02813023          	sd	s0,32(sp)
    800043c8:	00913c23          	sd	s1,24(sp)
    800043cc:	01213823          	sd	s2,16(sp)
    800043d0:	01313423          	sd	s3,8(sp)
    800043d4:	01413023          	sd	s4,0(sp)
    800043d8:	03010413          	addi	s0,sp,48
    800043dc:	00050993          	mv	s3,a0
    800043e0:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800043e4:	00000a13          	li	s4,0
    800043e8:	01c0006f          	j	80004404 <_ZN12ConsumerSync8consumerEPv+0x48>
        i++;

        Console::putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    800043ec:	00001097          	auipc	ra,0x1
    800043f0:	5ac080e7          	jalr	1452(ra) # 80005998 <_ZN6Thread8dispatchEv>
    800043f4:	0500006f          	j	80004444 <_ZN12ConsumerSync8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    800043f8:	00a00513          	li	a0,10
    800043fc:	ffffe097          	auipc	ra,0xffffe
    80004400:	820080e7          	jalr	-2016(ra) # 80001c1c <putc>
    while (!threadEnd) {
    80004404:	00008797          	auipc	a5,0x8
    80004408:	6a47a783          	lw	a5,1700(a5) # 8000caa8 <_ZL9threadEnd>
    8000440c:	06079263          	bnez	a5,80004470 <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    80004410:	00893503          	ld	a0,8(s2)
    80004414:	00001097          	auipc	ra,0x1
    80004418:	b94080e7          	jalr	-1132(ra) # 80004fa8 <_ZN9BufferCPP3getEv>
        i++;
    8000441c:	001a049b          	addiw	s1,s4,1
    80004420:	00048a1b          	sext.w	s4,s1
        Console::putc(key);
    80004424:	0ff57513          	andi	a0,a0,255
    80004428:	00001097          	auipc	ra,0x1
    8000442c:	6a4080e7          	jalr	1700(ra) # 80005acc <_ZN7Console4putcEc>
        if (i % (5 * data->id) == 0) {
    80004430:	00092703          	lw	a4,0(s2)
    80004434:	0027179b          	slliw	a5,a4,0x2
    80004438:	00e787bb          	addw	a5,a5,a4
    8000443c:	02f4e7bb          	remw	a5,s1,a5
    80004440:	fa0786e3          	beqz	a5,800043ec <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    80004444:	05000793          	li	a5,80
    80004448:	02f4e4bb          	remw	s1,s1,a5
    8000444c:	fa049ce3          	bnez	s1,80004404 <_ZN12ConsumerSync8consumerEPv+0x48>
    80004450:	fa9ff06f          	j	800043f8 <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    80004454:	0209b783          	ld	a5,32(s3)
    80004458:	0087b503          	ld	a0,8(a5)
    8000445c:	00001097          	auipc	ra,0x1
    80004460:	b4c080e7          	jalr	-1204(ra) # 80004fa8 <_ZN9BufferCPP3getEv>
        Console::putc(key);
    80004464:	0ff57513          	andi	a0,a0,255
    80004468:	00001097          	auipc	ra,0x1
    8000446c:	664080e7          	jalr	1636(ra) # 80005acc <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    80004470:	0209b783          	ld	a5,32(s3)
    80004474:	0087b503          	ld	a0,8(a5)
    80004478:	00001097          	auipc	ra,0x1
    8000447c:	bbc080e7          	jalr	-1092(ra) # 80005034 <_ZN9BufferCPP6getCntEv>
    80004480:	fca04ae3          	bgtz	a0,80004454 <_ZN12ConsumerSync8consumerEPv+0x98>
    }

    data->wait->signal();
    80004484:	01093503          	ld	a0,16(s2)
    80004488:	00001097          	auipc	ra,0x1
    8000448c:	5f0080e7          	jalr	1520(ra) # 80005a78 <_ZN9Semaphore6signalEv>
}
    80004490:	02813083          	ld	ra,40(sp)
    80004494:	02013403          	ld	s0,32(sp)
    80004498:	01813483          	ld	s1,24(sp)
    8000449c:	01013903          	ld	s2,16(sp)
    800044a0:	00813983          	ld	s3,8(sp)
    800044a4:	00013a03          	ld	s4,0(sp)
    800044a8:	03010113          	addi	sp,sp,48
    800044ac:	00008067          	ret

00000000800044b0 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    800044b0:	f8010113          	addi	sp,sp,-128
    800044b4:	06113c23          	sd	ra,120(sp)
    800044b8:	06813823          	sd	s0,112(sp)
    800044bc:	06913423          	sd	s1,104(sp)
    800044c0:	07213023          	sd	s2,96(sp)
    800044c4:	05313c23          	sd	s3,88(sp)
    800044c8:	05413823          	sd	s4,80(sp)
    800044cc:	05513423          	sd	s5,72(sp)
    800044d0:	05613023          	sd	s6,64(sp)
    800044d4:	03713c23          	sd	s7,56(sp)
    800044d8:	03813823          	sd	s8,48(sp)
    800044dc:	03913423          	sd	s9,40(sp)
    800044e0:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    800044e4:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    800044e8:	00006517          	auipc	a0,0x6
    800044ec:	b3850513          	addi	a0,a0,-1224 # 8000a020 <CONSOLE_STATUS+0x10>
    800044f0:	00000097          	auipc	ra,0x0
    800044f4:	604080e7          	jalr	1540(ra) # 80004af4 <_Z11printStringPKc>
    getString(input, 30);
    800044f8:	01e00593          	li	a1,30
    800044fc:	f8040493          	addi	s1,s0,-128
    80004500:	00048513          	mv	a0,s1
    80004504:	00000097          	auipc	ra,0x0
    80004508:	678080e7          	jalr	1656(ra) # 80004b7c <_Z9getStringPci>
    threadNum = stringToInt(input);
    8000450c:	00048513          	mv	a0,s1
    80004510:	00000097          	auipc	ra,0x0
    80004514:	744080e7          	jalr	1860(ra) # 80004c54 <_Z11stringToIntPKc>
    80004518:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    8000451c:	00006517          	auipc	a0,0x6
    80004520:	b2450513          	addi	a0,a0,-1244 # 8000a040 <CONSOLE_STATUS+0x30>
    80004524:	00000097          	auipc	ra,0x0
    80004528:	5d0080e7          	jalr	1488(ra) # 80004af4 <_Z11printStringPKc>
    getString(input, 30);
    8000452c:	01e00593          	li	a1,30
    80004530:	00048513          	mv	a0,s1
    80004534:	00000097          	auipc	ra,0x0
    80004538:	648080e7          	jalr	1608(ra) # 80004b7c <_Z9getStringPci>
    n = stringToInt(input);
    8000453c:	00048513          	mv	a0,s1
    80004540:	00000097          	auipc	ra,0x0
    80004544:	714080e7          	jalr	1812(ra) # 80004c54 <_Z11stringToIntPKc>
    80004548:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    8000454c:	00006517          	auipc	a0,0x6
    80004550:	b1450513          	addi	a0,a0,-1260 # 8000a060 <CONSOLE_STATUS+0x50>
    80004554:	00000097          	auipc	ra,0x0
    80004558:	5a0080e7          	jalr	1440(ra) # 80004af4 <_Z11printStringPKc>
    8000455c:	00000613          	li	a2,0
    80004560:	00a00593          	li	a1,10
    80004564:	00090513          	mv	a0,s2
    80004568:	00000097          	auipc	ra,0x0
    8000456c:	73c080e7          	jalr	1852(ra) # 80004ca4 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80004570:	00006517          	auipc	a0,0x6
    80004574:	b0850513          	addi	a0,a0,-1272 # 8000a078 <CONSOLE_STATUS+0x68>
    80004578:	00000097          	auipc	ra,0x0
    8000457c:	57c080e7          	jalr	1404(ra) # 80004af4 <_Z11printStringPKc>
    80004580:	00000613          	li	a2,0
    80004584:	00a00593          	li	a1,10
    80004588:	00048513          	mv	a0,s1
    8000458c:	00000097          	auipc	ra,0x0
    80004590:	718080e7          	jalr	1816(ra) # 80004ca4 <_Z8printIntiii>
    printString(".\n");
    80004594:	00006517          	auipc	a0,0x6
    80004598:	afc50513          	addi	a0,a0,-1284 # 8000a090 <CONSOLE_STATUS+0x80>
    8000459c:	00000097          	auipc	ra,0x0
    800045a0:	558080e7          	jalr	1368(ra) # 80004af4 <_Z11printStringPKc>
    if(threadNum > n) {
    800045a4:	0324c463          	blt	s1,s2,800045cc <_Z29producerConsumer_CPP_Sync_APIv+0x11c>
    } else if (threadNum < 1) {
    800045a8:	03205c63          	blez	s2,800045e0 <_Z29producerConsumer_CPP_Sync_APIv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    800045ac:	03800513          	li	a0,56
    800045b0:	00001097          	auipc	ra,0x1
    800045b4:	288080e7          	jalr	648(ra) # 80005838 <_Znwm>
    800045b8:	00050a93          	mv	s5,a0
    800045bc:	00048593          	mv	a1,s1
    800045c0:	00001097          	auipc	ra,0x1
    800045c4:	804080e7          	jalr	-2044(ra) # 80004dc4 <_ZN9BufferCPPC1Ei>
    800045c8:	0300006f          	j	800045f8 <_Z29producerConsumer_CPP_Sync_APIv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800045cc:	00006517          	auipc	a0,0x6
    800045d0:	acc50513          	addi	a0,a0,-1332 # 8000a098 <CONSOLE_STATUS+0x88>
    800045d4:	00000097          	auipc	ra,0x0
    800045d8:	520080e7          	jalr	1312(ra) # 80004af4 <_Z11printStringPKc>
        return;
    800045dc:	0140006f          	j	800045f0 <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    800045e0:	00006517          	auipc	a0,0x6
    800045e4:	af850513          	addi	a0,a0,-1288 # 8000a0d8 <CONSOLE_STATUS+0xc8>
    800045e8:	00000097          	auipc	ra,0x0
    800045ec:	50c080e7          	jalr	1292(ra) # 80004af4 <_Z11printStringPKc>
        return;
    800045f0:	000b8113          	mv	sp,s7
    800045f4:	2380006f          	j	8000482c <_Z29producerConsumer_CPP_Sync_APIv+0x37c>
    waitForAll = new Semaphore(0);
    800045f8:	01000513          	li	a0,16
    800045fc:	00001097          	auipc	ra,0x1
    80004600:	23c080e7          	jalr	572(ra) # 80005838 <_Znwm>
    80004604:	00050493          	mv	s1,a0
    80004608:	00000593          	li	a1,0
    8000460c:	00001097          	auipc	ra,0x1
    80004610:	408080e7          	jalr	1032(ra) # 80005a14 <_ZN9SemaphoreC1Ej>
    80004614:	00008797          	auipc	a5,0x8
    80004618:	4897be23          	sd	s1,1180(a5) # 8000cab0 <_ZL10waitForAll>
    Thread* threads[threadNum];
    8000461c:	00391793          	slli	a5,s2,0x3
    80004620:	00f78793          	addi	a5,a5,15
    80004624:	ff07f793          	andi	a5,a5,-16
    80004628:	40f10133          	sub	sp,sp,a5
    8000462c:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    80004630:	0019071b          	addiw	a4,s2,1
    80004634:	00171793          	slli	a5,a4,0x1
    80004638:	00e787b3          	add	a5,a5,a4
    8000463c:	00379793          	slli	a5,a5,0x3
    80004640:	00f78793          	addi	a5,a5,15
    80004644:	ff07f793          	andi	a5,a5,-16
    80004648:	40f10133          	sub	sp,sp,a5
    8000464c:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    80004650:	00191c13          	slli	s8,s2,0x1
    80004654:	012c07b3          	add	a5,s8,s2
    80004658:	00379793          	slli	a5,a5,0x3
    8000465c:	00fa07b3          	add	a5,s4,a5
    80004660:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80004664:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80004668:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    8000466c:	02800513          	li	a0,40
    80004670:	00001097          	auipc	ra,0x1
    80004674:	1c8080e7          	jalr	456(ra) # 80005838 <_Znwm>
    80004678:	00050b13          	mv	s6,a0
    8000467c:	012c0c33          	add	s8,s8,s2
    80004680:	003c1c13          	slli	s8,s8,0x3
    80004684:	018a0c33          	add	s8,s4,s8
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    80004688:	00001097          	auipc	ra,0x1
    8000468c:	338080e7          	jalr	824(ra) # 800059c0 <_ZN6ThreadC1Ev>
    80004690:	00008797          	auipc	a5,0x8
    80004694:	26078793          	addi	a5,a5,608 # 8000c8f0 <_ZTV12ConsumerSync+0x10>
    80004698:	00fb3023          	sd	a5,0(s6)
    8000469c:	038b3023          	sd	s8,32(s6)
    consumerThread->start();
    800046a0:	000b0513          	mv	a0,s6
    800046a4:	00001097          	auipc	ra,0x1
    800046a8:	290080e7          	jalr	656(ra) # 80005934 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    800046ac:	00000493          	li	s1,0
    800046b0:	0380006f          	j	800046e8 <_Z29producerConsumer_CPP_Sync_APIv+0x238>
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    800046b4:	00008797          	auipc	a5,0x8
    800046b8:	21478793          	addi	a5,a5,532 # 8000c8c8 <_ZTV12ProducerSync+0x10>
    800046bc:	00fcb023          	sd	a5,0(s9)
    800046c0:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerSync(data+i);
    800046c4:	00349793          	slli	a5,s1,0x3
    800046c8:	00f987b3          	add	a5,s3,a5
    800046cc:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    800046d0:	00349793          	slli	a5,s1,0x3
    800046d4:	00f987b3          	add	a5,s3,a5
    800046d8:	0007b503          	ld	a0,0(a5)
    800046dc:	00001097          	auipc	ra,0x1
    800046e0:	258080e7          	jalr	600(ra) # 80005934 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    800046e4:	0014849b          	addiw	s1,s1,1
    800046e8:	0b24d063          	bge	s1,s2,80004788 <_Z29producerConsumer_CPP_Sync_APIv+0x2d8>
        data[i].id = i;
    800046ec:	00149793          	slli	a5,s1,0x1
    800046f0:	009787b3          	add	a5,a5,s1
    800046f4:	00379793          	slli	a5,a5,0x3
    800046f8:	00fa07b3          	add	a5,s4,a5
    800046fc:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80004700:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    80004704:	00008717          	auipc	a4,0x8
    80004708:	3ac73703          	ld	a4,940(a4) # 8000cab0 <_ZL10waitForAll>
    8000470c:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    80004710:	02905863          	blez	s1,80004740 <_Z29producerConsumer_CPP_Sync_APIv+0x290>
            threads[i] = new ProducerSync(data+i);
    80004714:	02800513          	li	a0,40
    80004718:	00001097          	auipc	ra,0x1
    8000471c:	120080e7          	jalr	288(ra) # 80005838 <_Znwm>
    80004720:	00050c93          	mv	s9,a0
    80004724:	00149c13          	slli	s8,s1,0x1
    80004728:	009c0c33          	add	s8,s8,s1
    8000472c:	003c1c13          	slli	s8,s8,0x3
    80004730:	018a0c33          	add	s8,s4,s8
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80004734:	00001097          	auipc	ra,0x1
    80004738:	28c080e7          	jalr	652(ra) # 800059c0 <_ZN6ThreadC1Ev>
    8000473c:	f79ff06f          	j	800046b4 <_Z29producerConsumer_CPP_Sync_APIv+0x204>
            threads[i] = new ProducerKeyboard(data+i);
    80004740:	02800513          	li	a0,40
    80004744:	00001097          	auipc	ra,0x1
    80004748:	0f4080e7          	jalr	244(ra) # 80005838 <_Znwm>
    8000474c:	00050c93          	mv	s9,a0
    80004750:	00149c13          	slli	s8,s1,0x1
    80004754:	009c0c33          	add	s8,s8,s1
    80004758:	003c1c13          	slli	s8,s8,0x3
    8000475c:	018a0c33          	add	s8,s4,s8
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    80004760:	00001097          	auipc	ra,0x1
    80004764:	260080e7          	jalr	608(ra) # 800059c0 <_ZN6ThreadC1Ev>
    80004768:	00008797          	auipc	a5,0x8
    8000476c:	13878793          	addi	a5,a5,312 # 8000c8a0 <_ZTV16ProducerKeyboard+0x10>
    80004770:	00fcb023          	sd	a5,0(s9)
    80004774:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerKeyboard(data+i);
    80004778:	00349793          	slli	a5,s1,0x3
    8000477c:	00f987b3          	add	a5,s3,a5
    80004780:	0197b023          	sd	s9,0(a5)
    80004784:	f4dff06f          	j	800046d0 <_Z29producerConsumer_CPP_Sync_APIv+0x220>
    Thread::dispatch();
    80004788:	00001097          	auipc	ra,0x1
    8000478c:	210080e7          	jalr	528(ra) # 80005998 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80004790:	00000493          	li	s1,0
    80004794:	00994e63          	blt	s2,s1,800047b0 <_Z29producerConsumer_CPP_Sync_APIv+0x300>
        waitForAll->wait();
    80004798:	00008517          	auipc	a0,0x8
    8000479c:	31853503          	ld	a0,792(a0) # 8000cab0 <_ZL10waitForAll>
    800047a0:	00001097          	auipc	ra,0x1
    800047a4:	2ac080e7          	jalr	684(ra) # 80005a4c <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    800047a8:	0014849b          	addiw	s1,s1,1
    800047ac:	fe9ff06f          	j	80004794 <_Z29producerConsumer_CPP_Sync_APIv+0x2e4>
    for (int i = 0; i < threadNum; i++) {
    800047b0:	00000493          	li	s1,0
    800047b4:	0080006f          	j	800047bc <_Z29producerConsumer_CPP_Sync_APIv+0x30c>
    800047b8:	0014849b          	addiw	s1,s1,1
    800047bc:	0324d263          	bge	s1,s2,800047e0 <_Z29producerConsumer_CPP_Sync_APIv+0x330>
        delete threads[i];
    800047c0:	00349793          	slli	a5,s1,0x3
    800047c4:	00f987b3          	add	a5,s3,a5
    800047c8:	0007b503          	ld	a0,0(a5)
    800047cc:	fe0506e3          	beqz	a0,800047b8 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    800047d0:	00053783          	ld	a5,0(a0)
    800047d4:	0087b783          	ld	a5,8(a5)
    800047d8:	000780e7          	jalr	a5
    800047dc:	fddff06f          	j	800047b8 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    delete consumerThread;
    800047e0:	000b0a63          	beqz	s6,800047f4 <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    800047e4:	000b3783          	ld	a5,0(s6)
    800047e8:	0087b783          	ld	a5,8(a5)
    800047ec:	000b0513          	mv	a0,s6
    800047f0:	000780e7          	jalr	a5
    delete waitForAll;
    800047f4:	00008517          	auipc	a0,0x8
    800047f8:	2bc53503          	ld	a0,700(a0) # 8000cab0 <_ZL10waitForAll>
    800047fc:	00050863          	beqz	a0,8000480c <_Z29producerConsumer_CPP_Sync_APIv+0x35c>
    80004800:	00053783          	ld	a5,0(a0)
    80004804:	0087b783          	ld	a5,8(a5)
    80004808:	000780e7          	jalr	a5
    delete buffer;
    8000480c:	000a8e63          	beqz	s5,80004828 <_Z29producerConsumer_CPP_Sync_APIv+0x378>
    80004810:	000a8513          	mv	a0,s5
    80004814:	00001097          	auipc	ra,0x1
    80004818:	8a8080e7          	jalr	-1880(ra) # 800050bc <_ZN9BufferCPPD1Ev>
    8000481c:	000a8513          	mv	a0,s5
    80004820:	00001097          	auipc	ra,0x1
    80004824:	040080e7          	jalr	64(ra) # 80005860 <_ZdlPv>
    80004828:	000b8113          	mv	sp,s7

}
    8000482c:	f8040113          	addi	sp,s0,-128
    80004830:	07813083          	ld	ra,120(sp)
    80004834:	07013403          	ld	s0,112(sp)
    80004838:	06813483          	ld	s1,104(sp)
    8000483c:	06013903          	ld	s2,96(sp)
    80004840:	05813983          	ld	s3,88(sp)
    80004844:	05013a03          	ld	s4,80(sp)
    80004848:	04813a83          	ld	s5,72(sp)
    8000484c:	04013b03          	ld	s6,64(sp)
    80004850:	03813b83          	ld	s7,56(sp)
    80004854:	03013c03          	ld	s8,48(sp)
    80004858:	02813c83          	ld	s9,40(sp)
    8000485c:	08010113          	addi	sp,sp,128
    80004860:	00008067          	ret
    80004864:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80004868:	000a8513          	mv	a0,s5
    8000486c:	00001097          	auipc	ra,0x1
    80004870:	ff4080e7          	jalr	-12(ra) # 80005860 <_ZdlPv>
    80004874:	00048513          	mv	a0,s1
    80004878:	00009097          	auipc	ra,0x9
    8000487c:	350080e7          	jalr	848(ra) # 8000dbc8 <_Unwind_Resume>
    80004880:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80004884:	00048513          	mv	a0,s1
    80004888:	00001097          	auipc	ra,0x1
    8000488c:	fd8080e7          	jalr	-40(ra) # 80005860 <_ZdlPv>
    80004890:	00090513          	mv	a0,s2
    80004894:	00009097          	auipc	ra,0x9
    80004898:	334080e7          	jalr	820(ra) # 8000dbc8 <_Unwind_Resume>
    8000489c:	00050493          	mv	s1,a0
    consumerThread = new ConsumerSync(data+threadNum);
    800048a0:	000b0513          	mv	a0,s6
    800048a4:	00001097          	auipc	ra,0x1
    800048a8:	fbc080e7          	jalr	-68(ra) # 80005860 <_ZdlPv>
    800048ac:	00048513          	mv	a0,s1
    800048b0:	00009097          	auipc	ra,0x9
    800048b4:	318080e7          	jalr	792(ra) # 8000dbc8 <_Unwind_Resume>
    800048b8:	00050493          	mv	s1,a0
            threads[i] = new ProducerSync(data+i);
    800048bc:	000c8513          	mv	a0,s9
    800048c0:	00001097          	auipc	ra,0x1
    800048c4:	fa0080e7          	jalr	-96(ra) # 80005860 <_ZdlPv>
    800048c8:	00048513          	mv	a0,s1
    800048cc:	00009097          	auipc	ra,0x9
    800048d0:	2fc080e7          	jalr	764(ra) # 8000dbc8 <_Unwind_Resume>
    800048d4:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    800048d8:	000c8513          	mv	a0,s9
    800048dc:	00001097          	auipc	ra,0x1
    800048e0:	f84080e7          	jalr	-124(ra) # 80005860 <_ZdlPv>
    800048e4:	00048513          	mv	a0,s1
    800048e8:	00009097          	auipc	ra,0x9
    800048ec:	2e0080e7          	jalr	736(ra) # 8000dbc8 <_Unwind_Resume>

00000000800048f0 <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    800048f0:	ff010113          	addi	sp,sp,-16
    800048f4:	00113423          	sd	ra,8(sp)
    800048f8:	00813023          	sd	s0,0(sp)
    800048fc:	01010413          	addi	s0,sp,16
    80004900:	00008797          	auipc	a5,0x8
    80004904:	ff078793          	addi	a5,a5,-16 # 8000c8f0 <_ZTV12ConsumerSync+0x10>
    80004908:	00f53023          	sd	a5,0(a0)
    8000490c:	00001097          	auipc	ra,0x1
    80004910:	e18080e7          	jalr	-488(ra) # 80005724 <_ZN6ThreadD1Ev>
    80004914:	00813083          	ld	ra,8(sp)
    80004918:	00013403          	ld	s0,0(sp)
    8000491c:	01010113          	addi	sp,sp,16
    80004920:	00008067          	ret

0000000080004924 <_ZN12ConsumerSyncD0Ev>:
    80004924:	fe010113          	addi	sp,sp,-32
    80004928:	00113c23          	sd	ra,24(sp)
    8000492c:	00813823          	sd	s0,16(sp)
    80004930:	00913423          	sd	s1,8(sp)
    80004934:	02010413          	addi	s0,sp,32
    80004938:	00050493          	mv	s1,a0
    8000493c:	00008797          	auipc	a5,0x8
    80004940:	fb478793          	addi	a5,a5,-76 # 8000c8f0 <_ZTV12ConsumerSync+0x10>
    80004944:	00f53023          	sd	a5,0(a0)
    80004948:	00001097          	auipc	ra,0x1
    8000494c:	ddc080e7          	jalr	-548(ra) # 80005724 <_ZN6ThreadD1Ev>
    80004950:	00048513          	mv	a0,s1
    80004954:	00001097          	auipc	ra,0x1
    80004958:	f0c080e7          	jalr	-244(ra) # 80005860 <_ZdlPv>
    8000495c:	01813083          	ld	ra,24(sp)
    80004960:	01013403          	ld	s0,16(sp)
    80004964:	00813483          	ld	s1,8(sp)
    80004968:	02010113          	addi	sp,sp,32
    8000496c:	00008067          	ret

0000000080004970 <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    80004970:	ff010113          	addi	sp,sp,-16
    80004974:	00113423          	sd	ra,8(sp)
    80004978:	00813023          	sd	s0,0(sp)
    8000497c:	01010413          	addi	s0,sp,16
    80004980:	00008797          	auipc	a5,0x8
    80004984:	f4878793          	addi	a5,a5,-184 # 8000c8c8 <_ZTV12ProducerSync+0x10>
    80004988:	00f53023          	sd	a5,0(a0)
    8000498c:	00001097          	auipc	ra,0x1
    80004990:	d98080e7          	jalr	-616(ra) # 80005724 <_ZN6ThreadD1Ev>
    80004994:	00813083          	ld	ra,8(sp)
    80004998:	00013403          	ld	s0,0(sp)
    8000499c:	01010113          	addi	sp,sp,16
    800049a0:	00008067          	ret

00000000800049a4 <_ZN12ProducerSyncD0Ev>:
    800049a4:	fe010113          	addi	sp,sp,-32
    800049a8:	00113c23          	sd	ra,24(sp)
    800049ac:	00813823          	sd	s0,16(sp)
    800049b0:	00913423          	sd	s1,8(sp)
    800049b4:	02010413          	addi	s0,sp,32
    800049b8:	00050493          	mv	s1,a0
    800049bc:	00008797          	auipc	a5,0x8
    800049c0:	f0c78793          	addi	a5,a5,-244 # 8000c8c8 <_ZTV12ProducerSync+0x10>
    800049c4:	00f53023          	sd	a5,0(a0)
    800049c8:	00001097          	auipc	ra,0x1
    800049cc:	d5c080e7          	jalr	-676(ra) # 80005724 <_ZN6ThreadD1Ev>
    800049d0:	00048513          	mv	a0,s1
    800049d4:	00001097          	auipc	ra,0x1
    800049d8:	e8c080e7          	jalr	-372(ra) # 80005860 <_ZdlPv>
    800049dc:	01813083          	ld	ra,24(sp)
    800049e0:	01013403          	ld	s0,16(sp)
    800049e4:	00813483          	ld	s1,8(sp)
    800049e8:	02010113          	addi	sp,sp,32
    800049ec:	00008067          	ret

00000000800049f0 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    800049f0:	ff010113          	addi	sp,sp,-16
    800049f4:	00113423          	sd	ra,8(sp)
    800049f8:	00813023          	sd	s0,0(sp)
    800049fc:	01010413          	addi	s0,sp,16
    80004a00:	00008797          	auipc	a5,0x8
    80004a04:	ea078793          	addi	a5,a5,-352 # 8000c8a0 <_ZTV16ProducerKeyboard+0x10>
    80004a08:	00f53023          	sd	a5,0(a0)
    80004a0c:	00001097          	auipc	ra,0x1
    80004a10:	d18080e7          	jalr	-744(ra) # 80005724 <_ZN6ThreadD1Ev>
    80004a14:	00813083          	ld	ra,8(sp)
    80004a18:	00013403          	ld	s0,0(sp)
    80004a1c:	01010113          	addi	sp,sp,16
    80004a20:	00008067          	ret

0000000080004a24 <_ZN16ProducerKeyboardD0Ev>:
    80004a24:	fe010113          	addi	sp,sp,-32
    80004a28:	00113c23          	sd	ra,24(sp)
    80004a2c:	00813823          	sd	s0,16(sp)
    80004a30:	00913423          	sd	s1,8(sp)
    80004a34:	02010413          	addi	s0,sp,32
    80004a38:	00050493          	mv	s1,a0
    80004a3c:	00008797          	auipc	a5,0x8
    80004a40:	e6478793          	addi	a5,a5,-412 # 8000c8a0 <_ZTV16ProducerKeyboard+0x10>
    80004a44:	00f53023          	sd	a5,0(a0)
    80004a48:	00001097          	auipc	ra,0x1
    80004a4c:	cdc080e7          	jalr	-804(ra) # 80005724 <_ZN6ThreadD1Ev>
    80004a50:	00048513          	mv	a0,s1
    80004a54:	00001097          	auipc	ra,0x1
    80004a58:	e0c080e7          	jalr	-500(ra) # 80005860 <_ZdlPv>
    80004a5c:	01813083          	ld	ra,24(sp)
    80004a60:	01013403          	ld	s0,16(sp)
    80004a64:	00813483          	ld	s1,8(sp)
    80004a68:	02010113          	addi	sp,sp,32
    80004a6c:	00008067          	ret

0000000080004a70 <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80004a70:	ff010113          	addi	sp,sp,-16
    80004a74:	00113423          	sd	ra,8(sp)
    80004a78:	00813023          	sd	s0,0(sp)
    80004a7c:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80004a80:	02053583          	ld	a1,32(a0)
    80004a84:	fffff097          	auipc	ra,0xfffff
    80004a88:	7e4080e7          	jalr	2020(ra) # 80004268 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80004a8c:	00813083          	ld	ra,8(sp)
    80004a90:	00013403          	ld	s0,0(sp)
    80004a94:	01010113          	addi	sp,sp,16
    80004a98:	00008067          	ret

0000000080004a9c <_ZN12ProducerSync3runEv>:
    void run() override {
    80004a9c:	ff010113          	addi	sp,sp,-16
    80004aa0:	00113423          	sd	ra,8(sp)
    80004aa4:	00813023          	sd	s0,0(sp)
    80004aa8:	01010413          	addi	s0,sp,16
        producer(td);
    80004aac:	02053583          	ld	a1,32(a0)
    80004ab0:	00000097          	auipc	ra,0x0
    80004ab4:	878080e7          	jalr	-1928(ra) # 80004328 <_ZN12ProducerSync8producerEPv>
    }
    80004ab8:	00813083          	ld	ra,8(sp)
    80004abc:	00013403          	ld	s0,0(sp)
    80004ac0:	01010113          	addi	sp,sp,16
    80004ac4:	00008067          	ret

0000000080004ac8 <_ZN12ConsumerSync3runEv>:
    void run() override {
    80004ac8:	ff010113          	addi	sp,sp,-16
    80004acc:	00113423          	sd	ra,8(sp)
    80004ad0:	00813023          	sd	s0,0(sp)
    80004ad4:	01010413          	addi	s0,sp,16
        consumer(td);
    80004ad8:	02053583          	ld	a1,32(a0)
    80004adc:	00000097          	auipc	ra,0x0
    80004ae0:	8e0080e7          	jalr	-1824(ra) # 800043bc <_ZN12ConsumerSync8consumerEPv>
    }
    80004ae4:	00813083          	ld	ra,8(sp)
    80004ae8:	00013403          	ld	s0,0(sp)
    80004aec:	01010113          	addi	sp,sp,16
    80004af0:	00008067          	ret

0000000080004af4 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80004af4:	fe010113          	addi	sp,sp,-32
    80004af8:	00113c23          	sd	ra,24(sp)
    80004afc:	00813823          	sd	s0,16(sp)
    80004b00:	00913423          	sd	s1,8(sp)
    80004b04:	02010413          	addi	s0,sp,32
    80004b08:	00050493          	mv	s1,a0
    LOCK();
    80004b0c:	00100613          	li	a2,1
    80004b10:	00000593          	li	a1,0
    80004b14:	00008517          	auipc	a0,0x8
    80004b18:	fa450513          	addi	a0,a0,-92 # 8000cab8 <lockPrint>
    80004b1c:	ffffc097          	auipc	ra,0xffffc
    80004b20:	4e4080e7          	jalr	1252(ra) # 80001000 <copy_and_swap>
    80004b24:	00050863          	beqz	a0,80004b34 <_Z11printStringPKc+0x40>
    80004b28:	ffffd097          	auipc	ra,0xffffd
    80004b2c:	f80080e7          	jalr	-128(ra) # 80001aa8 <thread_dispatch>
    80004b30:	fddff06f          	j	80004b0c <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80004b34:	0004c503          	lbu	a0,0(s1)
    80004b38:	00050a63          	beqz	a0,80004b4c <_Z11printStringPKc+0x58>
    {
        putc(*string);
    80004b3c:	ffffd097          	auipc	ra,0xffffd
    80004b40:	0e0080e7          	jalr	224(ra) # 80001c1c <putc>
        string++;
    80004b44:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80004b48:	fedff06f          	j	80004b34 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    80004b4c:	00000613          	li	a2,0
    80004b50:	00100593          	li	a1,1
    80004b54:	00008517          	auipc	a0,0x8
    80004b58:	f6450513          	addi	a0,a0,-156 # 8000cab8 <lockPrint>
    80004b5c:	ffffc097          	auipc	ra,0xffffc
    80004b60:	4a4080e7          	jalr	1188(ra) # 80001000 <copy_and_swap>
    80004b64:	fe0514e3          	bnez	a0,80004b4c <_Z11printStringPKc+0x58>
}
    80004b68:	01813083          	ld	ra,24(sp)
    80004b6c:	01013403          	ld	s0,16(sp)
    80004b70:	00813483          	ld	s1,8(sp)
    80004b74:	02010113          	addi	sp,sp,32
    80004b78:	00008067          	ret

0000000080004b7c <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80004b7c:	fd010113          	addi	sp,sp,-48
    80004b80:	02113423          	sd	ra,40(sp)
    80004b84:	02813023          	sd	s0,32(sp)
    80004b88:	00913c23          	sd	s1,24(sp)
    80004b8c:	01213823          	sd	s2,16(sp)
    80004b90:	01313423          	sd	s3,8(sp)
    80004b94:	01413023          	sd	s4,0(sp)
    80004b98:	03010413          	addi	s0,sp,48
    80004b9c:	00050993          	mv	s3,a0
    80004ba0:	00058a13          	mv	s4,a1
    LOCK();
    80004ba4:	00100613          	li	a2,1
    80004ba8:	00000593          	li	a1,0
    80004bac:	00008517          	auipc	a0,0x8
    80004bb0:	f0c50513          	addi	a0,a0,-244 # 8000cab8 <lockPrint>
    80004bb4:	ffffc097          	auipc	ra,0xffffc
    80004bb8:	44c080e7          	jalr	1100(ra) # 80001000 <copy_and_swap>
    80004bbc:	00050863          	beqz	a0,80004bcc <_Z9getStringPci+0x50>
    80004bc0:	ffffd097          	auipc	ra,0xffffd
    80004bc4:	ee8080e7          	jalr	-280(ra) # 80001aa8 <thread_dispatch>
    80004bc8:	fddff06f          	j	80004ba4 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80004bcc:	00000913          	li	s2,0
    80004bd0:	00090493          	mv	s1,s2
    80004bd4:	0019091b          	addiw	s2,s2,1
    80004bd8:	03495a63          	bge	s2,s4,80004c0c <_Z9getStringPci+0x90>
        cc = getc();
    80004bdc:	ffffd097          	auipc	ra,0xffffd
    80004be0:	070080e7          	jalr	112(ra) # 80001c4c <getc>
        if(cc < 1)
    80004be4:	02050463          	beqz	a0,80004c0c <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    80004be8:	009984b3          	add	s1,s3,s1
    80004bec:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80004bf0:	00a00793          	li	a5,10
    80004bf4:	00f50a63          	beq	a0,a5,80004c08 <_Z9getStringPci+0x8c>
    80004bf8:	00d00793          	li	a5,13
    80004bfc:	fcf51ae3          	bne	a0,a5,80004bd0 <_Z9getStringPci+0x54>
        buf[i++] = c;
    80004c00:	00090493          	mv	s1,s2
    80004c04:	0080006f          	j	80004c0c <_Z9getStringPci+0x90>
    80004c08:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80004c0c:	009984b3          	add	s1,s3,s1
    80004c10:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80004c14:	00000613          	li	a2,0
    80004c18:	00100593          	li	a1,1
    80004c1c:	00008517          	auipc	a0,0x8
    80004c20:	e9c50513          	addi	a0,a0,-356 # 8000cab8 <lockPrint>
    80004c24:	ffffc097          	auipc	ra,0xffffc
    80004c28:	3dc080e7          	jalr	988(ra) # 80001000 <copy_and_swap>
    80004c2c:	fe0514e3          	bnez	a0,80004c14 <_Z9getStringPci+0x98>
    return buf;
}
    80004c30:	00098513          	mv	a0,s3
    80004c34:	02813083          	ld	ra,40(sp)
    80004c38:	02013403          	ld	s0,32(sp)
    80004c3c:	01813483          	ld	s1,24(sp)
    80004c40:	01013903          	ld	s2,16(sp)
    80004c44:	00813983          	ld	s3,8(sp)
    80004c48:	00013a03          	ld	s4,0(sp)
    80004c4c:	03010113          	addi	sp,sp,48
    80004c50:	00008067          	ret

0000000080004c54 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80004c54:	ff010113          	addi	sp,sp,-16
    80004c58:	00813423          	sd	s0,8(sp)
    80004c5c:	01010413          	addi	s0,sp,16
    80004c60:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80004c64:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80004c68:	0006c603          	lbu	a2,0(a3)
    80004c6c:	fd06071b          	addiw	a4,a2,-48
    80004c70:	0ff77713          	andi	a4,a4,255
    80004c74:	00900793          	li	a5,9
    80004c78:	02e7e063          	bltu	a5,a4,80004c98 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80004c7c:	0025179b          	slliw	a5,a0,0x2
    80004c80:	00a787bb          	addw	a5,a5,a0
    80004c84:	0017979b          	slliw	a5,a5,0x1
    80004c88:	00168693          	addi	a3,a3,1
    80004c8c:	00c787bb          	addw	a5,a5,a2
    80004c90:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80004c94:	fd5ff06f          	j	80004c68 <_Z11stringToIntPKc+0x14>
    return n;
}
    80004c98:	00813403          	ld	s0,8(sp)
    80004c9c:	01010113          	addi	sp,sp,16
    80004ca0:	00008067          	ret

0000000080004ca4 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80004ca4:	fc010113          	addi	sp,sp,-64
    80004ca8:	02113c23          	sd	ra,56(sp)
    80004cac:	02813823          	sd	s0,48(sp)
    80004cb0:	02913423          	sd	s1,40(sp)
    80004cb4:	03213023          	sd	s2,32(sp)
    80004cb8:	01313c23          	sd	s3,24(sp)
    80004cbc:	04010413          	addi	s0,sp,64
    80004cc0:	00050493          	mv	s1,a0
    80004cc4:	00058913          	mv	s2,a1
    80004cc8:	00060993          	mv	s3,a2
    LOCK();
    80004ccc:	00100613          	li	a2,1
    80004cd0:	00000593          	li	a1,0
    80004cd4:	00008517          	auipc	a0,0x8
    80004cd8:	de450513          	addi	a0,a0,-540 # 8000cab8 <lockPrint>
    80004cdc:	ffffc097          	auipc	ra,0xffffc
    80004ce0:	324080e7          	jalr	804(ra) # 80001000 <copy_and_swap>
    80004ce4:	00050863          	beqz	a0,80004cf4 <_Z8printIntiii+0x50>
    80004ce8:	ffffd097          	auipc	ra,0xffffd
    80004cec:	dc0080e7          	jalr	-576(ra) # 80001aa8 <thread_dispatch>
    80004cf0:	fddff06f          	j	80004ccc <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80004cf4:	00098463          	beqz	s3,80004cfc <_Z8printIntiii+0x58>
    80004cf8:	0804c463          	bltz	s1,80004d80 <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80004cfc:	0004851b          	sext.w	a0,s1
    neg = 0;
    80004d00:	00000593          	li	a1,0
    }

    i = 0;
    80004d04:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80004d08:	0009079b          	sext.w	a5,s2
    80004d0c:	0325773b          	remuw	a4,a0,s2
    80004d10:	00048613          	mv	a2,s1
    80004d14:	0014849b          	addiw	s1,s1,1
    80004d18:	02071693          	slli	a3,a4,0x20
    80004d1c:	0206d693          	srli	a3,a3,0x20
    80004d20:	00008717          	auipc	a4,0x8
    80004d24:	be870713          	addi	a4,a4,-1048 # 8000c908 <digits>
    80004d28:	00d70733          	add	a4,a4,a3
    80004d2c:	00074683          	lbu	a3,0(a4)
    80004d30:	fd040713          	addi	a4,s0,-48
    80004d34:	00c70733          	add	a4,a4,a2
    80004d38:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80004d3c:	0005071b          	sext.w	a4,a0
    80004d40:	0325553b          	divuw	a0,a0,s2
    80004d44:	fcf772e3          	bgeu	a4,a5,80004d08 <_Z8printIntiii+0x64>
    if(neg)
    80004d48:	00058c63          	beqz	a1,80004d60 <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80004d4c:	fd040793          	addi	a5,s0,-48
    80004d50:	009784b3          	add	s1,a5,s1
    80004d54:	02d00793          	li	a5,45
    80004d58:	fef48823          	sb	a5,-16(s1)
    80004d5c:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80004d60:	fff4849b          	addiw	s1,s1,-1
    80004d64:	0204c463          	bltz	s1,80004d8c <_Z8printIntiii+0xe8>
        putc(buf[i]);
    80004d68:	fd040793          	addi	a5,s0,-48
    80004d6c:	009787b3          	add	a5,a5,s1
    80004d70:	ff07c503          	lbu	a0,-16(a5)
    80004d74:	ffffd097          	auipc	ra,0xffffd
    80004d78:	ea8080e7          	jalr	-344(ra) # 80001c1c <putc>
    80004d7c:	fe5ff06f          	j	80004d60 <_Z8printIntiii+0xbc>
        x = -xx;
    80004d80:	4090053b          	negw	a0,s1
        neg = 1;
    80004d84:	00100593          	li	a1,1
        x = -xx;
    80004d88:	f7dff06f          	j	80004d04 <_Z8printIntiii+0x60>

    UNLOCK();
    80004d8c:	00000613          	li	a2,0
    80004d90:	00100593          	li	a1,1
    80004d94:	00008517          	auipc	a0,0x8
    80004d98:	d2450513          	addi	a0,a0,-732 # 8000cab8 <lockPrint>
    80004d9c:	ffffc097          	auipc	ra,0xffffc
    80004da0:	264080e7          	jalr	612(ra) # 80001000 <copy_and_swap>
    80004da4:	fe0514e3          	bnez	a0,80004d8c <_Z8printIntiii+0xe8>
    80004da8:	03813083          	ld	ra,56(sp)
    80004dac:	03013403          	ld	s0,48(sp)
    80004db0:	02813483          	ld	s1,40(sp)
    80004db4:	02013903          	ld	s2,32(sp)
    80004db8:	01813983          	ld	s3,24(sp)
    80004dbc:	04010113          	addi	sp,sp,64
    80004dc0:	00008067          	ret

0000000080004dc4 <_ZN9BufferCPPC1Ei>:
#include "../test/buffer_CPP_API.hpp"
#include "../h/syscall_c.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80004dc4:	fd010113          	addi	sp,sp,-48
    80004dc8:	02113423          	sd	ra,40(sp)
    80004dcc:	02813023          	sd	s0,32(sp)
    80004dd0:	00913c23          	sd	s1,24(sp)
    80004dd4:	01213823          	sd	s2,16(sp)
    80004dd8:	01313423          	sd	s3,8(sp)
    80004ddc:	03010413          	addi	s0,sp,48
    80004de0:	00050493          	mv	s1,a0
    80004de4:	00058913          	mv	s2,a1
    80004de8:	0015879b          	addiw	a5,a1,1
    80004dec:	0007851b          	sext.w	a0,a5
    80004df0:	00f4a023          	sw	a5,0(s1)
    80004df4:	0004a823          	sw	zero,16(s1)
    80004df8:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)__mem_alloc(sizeof(int) * cap);
    80004dfc:	00251513          	slli	a0,a0,0x2
    80004e00:	ffffd097          	auipc	ra,0xffffd
    80004e04:	bf4080e7          	jalr	-1036(ra) # 800019f4 <__mem_alloc>
    80004e08:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80004e0c:	01000513          	li	a0,16
    80004e10:	00001097          	auipc	ra,0x1
    80004e14:	a28080e7          	jalr	-1496(ra) # 80005838 <_Znwm>
    80004e18:	00050993          	mv	s3,a0
    80004e1c:	00000593          	li	a1,0
    80004e20:	00001097          	auipc	ra,0x1
    80004e24:	bf4080e7          	jalr	-1036(ra) # 80005a14 <_ZN9SemaphoreC1Ej>
    80004e28:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80004e2c:	01000513          	li	a0,16
    80004e30:	00001097          	auipc	ra,0x1
    80004e34:	a08080e7          	jalr	-1528(ra) # 80005838 <_Znwm>
    80004e38:	00050993          	mv	s3,a0
    80004e3c:	00090593          	mv	a1,s2
    80004e40:	00001097          	auipc	ra,0x1
    80004e44:	bd4080e7          	jalr	-1068(ra) # 80005a14 <_ZN9SemaphoreC1Ej>
    80004e48:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    80004e4c:	01000513          	li	a0,16
    80004e50:	00001097          	auipc	ra,0x1
    80004e54:	9e8080e7          	jalr	-1560(ra) # 80005838 <_Znwm>
    80004e58:	00050913          	mv	s2,a0
    80004e5c:	00100593          	li	a1,1
    80004e60:	00001097          	auipc	ra,0x1
    80004e64:	bb4080e7          	jalr	-1100(ra) # 80005a14 <_ZN9SemaphoreC1Ej>
    80004e68:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80004e6c:	01000513          	li	a0,16
    80004e70:	00001097          	auipc	ra,0x1
    80004e74:	9c8080e7          	jalr	-1592(ra) # 80005838 <_Znwm>
    80004e78:	00050913          	mv	s2,a0
    80004e7c:	00100593          	li	a1,1
    80004e80:	00001097          	auipc	ra,0x1
    80004e84:	b94080e7          	jalr	-1132(ra) # 80005a14 <_ZN9SemaphoreC1Ej>
    80004e88:	0324b823          	sd	s2,48(s1)
}
    80004e8c:	02813083          	ld	ra,40(sp)
    80004e90:	02013403          	ld	s0,32(sp)
    80004e94:	01813483          	ld	s1,24(sp)
    80004e98:	01013903          	ld	s2,16(sp)
    80004e9c:	00813983          	ld	s3,8(sp)
    80004ea0:	03010113          	addi	sp,sp,48
    80004ea4:	00008067          	ret
    80004ea8:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80004eac:	00098513          	mv	a0,s3
    80004eb0:	00001097          	auipc	ra,0x1
    80004eb4:	9b0080e7          	jalr	-1616(ra) # 80005860 <_ZdlPv>
    80004eb8:	00048513          	mv	a0,s1
    80004ebc:	00009097          	auipc	ra,0x9
    80004ec0:	d0c080e7          	jalr	-756(ra) # 8000dbc8 <_Unwind_Resume>
    80004ec4:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80004ec8:	00098513          	mv	a0,s3
    80004ecc:	00001097          	auipc	ra,0x1
    80004ed0:	994080e7          	jalr	-1644(ra) # 80005860 <_ZdlPv>
    80004ed4:	00048513          	mv	a0,s1
    80004ed8:	00009097          	auipc	ra,0x9
    80004edc:	cf0080e7          	jalr	-784(ra) # 8000dbc8 <_Unwind_Resume>
    80004ee0:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80004ee4:	00090513          	mv	a0,s2
    80004ee8:	00001097          	auipc	ra,0x1
    80004eec:	978080e7          	jalr	-1672(ra) # 80005860 <_ZdlPv>
    80004ef0:	00048513          	mv	a0,s1
    80004ef4:	00009097          	auipc	ra,0x9
    80004ef8:	cd4080e7          	jalr	-812(ra) # 8000dbc8 <_Unwind_Resume>
    80004efc:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80004f00:	00090513          	mv	a0,s2
    80004f04:	00001097          	auipc	ra,0x1
    80004f08:	95c080e7          	jalr	-1700(ra) # 80005860 <_ZdlPv>
    80004f0c:	00048513          	mv	a0,s1
    80004f10:	00009097          	auipc	ra,0x9
    80004f14:	cb8080e7          	jalr	-840(ra) # 8000dbc8 <_Unwind_Resume>

0000000080004f18 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80004f18:	fe010113          	addi	sp,sp,-32
    80004f1c:	00113c23          	sd	ra,24(sp)
    80004f20:	00813823          	sd	s0,16(sp)
    80004f24:	00913423          	sd	s1,8(sp)
    80004f28:	01213023          	sd	s2,0(sp)
    80004f2c:	02010413          	addi	s0,sp,32
    80004f30:	00050493          	mv	s1,a0
    80004f34:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80004f38:	01853503          	ld	a0,24(a0)
    80004f3c:	00001097          	auipc	ra,0x1
    80004f40:	b10080e7          	jalr	-1264(ra) # 80005a4c <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80004f44:	0304b503          	ld	a0,48(s1)
    80004f48:	00001097          	auipc	ra,0x1
    80004f4c:	b04080e7          	jalr	-1276(ra) # 80005a4c <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80004f50:	0084b783          	ld	a5,8(s1)
    80004f54:	0144a703          	lw	a4,20(s1)
    80004f58:	00271713          	slli	a4,a4,0x2
    80004f5c:	00e787b3          	add	a5,a5,a4
    80004f60:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004f64:	0144a783          	lw	a5,20(s1)
    80004f68:	0017879b          	addiw	a5,a5,1
    80004f6c:	0004a703          	lw	a4,0(s1)
    80004f70:	02e7e7bb          	remw	a5,a5,a4
    80004f74:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80004f78:	0304b503          	ld	a0,48(s1)
    80004f7c:	00001097          	auipc	ra,0x1
    80004f80:	afc080e7          	jalr	-1284(ra) # 80005a78 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80004f84:	0204b503          	ld	a0,32(s1)
    80004f88:	00001097          	auipc	ra,0x1
    80004f8c:	af0080e7          	jalr	-1296(ra) # 80005a78 <_ZN9Semaphore6signalEv>

}
    80004f90:	01813083          	ld	ra,24(sp)
    80004f94:	01013403          	ld	s0,16(sp)
    80004f98:	00813483          	ld	s1,8(sp)
    80004f9c:	00013903          	ld	s2,0(sp)
    80004fa0:	02010113          	addi	sp,sp,32
    80004fa4:	00008067          	ret

0000000080004fa8 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80004fa8:	fe010113          	addi	sp,sp,-32
    80004fac:	00113c23          	sd	ra,24(sp)
    80004fb0:	00813823          	sd	s0,16(sp)
    80004fb4:	00913423          	sd	s1,8(sp)
    80004fb8:	01213023          	sd	s2,0(sp)
    80004fbc:	02010413          	addi	s0,sp,32
    80004fc0:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80004fc4:	02053503          	ld	a0,32(a0)
    80004fc8:	00001097          	auipc	ra,0x1
    80004fcc:	a84080e7          	jalr	-1404(ra) # 80005a4c <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80004fd0:	0284b503          	ld	a0,40(s1)
    80004fd4:	00001097          	auipc	ra,0x1
    80004fd8:	a78080e7          	jalr	-1416(ra) # 80005a4c <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80004fdc:	0084b703          	ld	a4,8(s1)
    80004fe0:	0104a783          	lw	a5,16(s1)
    80004fe4:	00279693          	slli	a3,a5,0x2
    80004fe8:	00d70733          	add	a4,a4,a3
    80004fec:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80004ff0:	0017879b          	addiw	a5,a5,1
    80004ff4:	0004a703          	lw	a4,0(s1)
    80004ff8:	02e7e7bb          	remw	a5,a5,a4
    80004ffc:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80005000:	0284b503          	ld	a0,40(s1)
    80005004:	00001097          	auipc	ra,0x1
    80005008:	a74080e7          	jalr	-1420(ra) # 80005a78 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    8000500c:	0184b503          	ld	a0,24(s1)
    80005010:	00001097          	auipc	ra,0x1
    80005014:	a68080e7          	jalr	-1432(ra) # 80005a78 <_ZN9Semaphore6signalEv>

    return ret;
}
    80005018:	00090513          	mv	a0,s2
    8000501c:	01813083          	ld	ra,24(sp)
    80005020:	01013403          	ld	s0,16(sp)
    80005024:	00813483          	ld	s1,8(sp)
    80005028:	00013903          	ld	s2,0(sp)
    8000502c:	02010113          	addi	sp,sp,32
    80005030:	00008067          	ret

0000000080005034 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80005034:	fe010113          	addi	sp,sp,-32
    80005038:	00113c23          	sd	ra,24(sp)
    8000503c:	00813823          	sd	s0,16(sp)
    80005040:	00913423          	sd	s1,8(sp)
    80005044:	01213023          	sd	s2,0(sp)
    80005048:	02010413          	addi	s0,sp,32
    8000504c:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80005050:	02853503          	ld	a0,40(a0)
    80005054:	00001097          	auipc	ra,0x1
    80005058:	9f8080e7          	jalr	-1544(ra) # 80005a4c <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    8000505c:	0304b503          	ld	a0,48(s1)
    80005060:	00001097          	auipc	ra,0x1
    80005064:	9ec080e7          	jalr	-1556(ra) # 80005a4c <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80005068:	0144a783          	lw	a5,20(s1)
    8000506c:	0104a903          	lw	s2,16(s1)
    80005070:	0327ce63          	blt	a5,s2,800050ac <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    80005074:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80005078:	0304b503          	ld	a0,48(s1)
    8000507c:	00001097          	auipc	ra,0x1
    80005080:	9fc080e7          	jalr	-1540(ra) # 80005a78 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80005084:	0284b503          	ld	a0,40(s1)
    80005088:	00001097          	auipc	ra,0x1
    8000508c:	9f0080e7          	jalr	-1552(ra) # 80005a78 <_ZN9Semaphore6signalEv>

    return ret;
}
    80005090:	00090513          	mv	a0,s2
    80005094:	01813083          	ld	ra,24(sp)
    80005098:	01013403          	ld	s0,16(sp)
    8000509c:	00813483          	ld	s1,8(sp)
    800050a0:	00013903          	ld	s2,0(sp)
    800050a4:	02010113          	addi	sp,sp,32
    800050a8:	00008067          	ret
        ret = cap - head + tail;
    800050ac:	0004a703          	lw	a4,0(s1)
    800050b0:	4127093b          	subw	s2,a4,s2
    800050b4:	00f9093b          	addw	s2,s2,a5
    800050b8:	fc1ff06f          	j	80005078 <_ZN9BufferCPP6getCntEv+0x44>

00000000800050bc <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    800050bc:	fe010113          	addi	sp,sp,-32
    800050c0:	00113c23          	sd	ra,24(sp)
    800050c4:	00813823          	sd	s0,16(sp)
    800050c8:	00913423          	sd	s1,8(sp)
    800050cc:	02010413          	addi	s0,sp,32
    800050d0:	00050493          	mv	s1,a0
    Console::putc('\n');
    800050d4:	00a00513          	li	a0,10
    800050d8:	00001097          	auipc	ra,0x1
    800050dc:	9f4080e7          	jalr	-1548(ra) # 80005acc <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    800050e0:	00005517          	auipc	a0,0x5
    800050e4:	13050513          	addi	a0,a0,304 # 8000a210 <CONSOLE_STATUS+0x200>
    800050e8:	00000097          	auipc	ra,0x0
    800050ec:	a0c080e7          	jalr	-1524(ra) # 80004af4 <_Z11printStringPKc>
    while (getCnt()) {
    800050f0:	00048513          	mv	a0,s1
    800050f4:	00000097          	auipc	ra,0x0
    800050f8:	f40080e7          	jalr	-192(ra) # 80005034 <_ZN9BufferCPP6getCntEv>
    800050fc:	02050c63          	beqz	a0,80005134 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80005100:	0084b783          	ld	a5,8(s1)
    80005104:	0104a703          	lw	a4,16(s1)
    80005108:	00271713          	slli	a4,a4,0x2
    8000510c:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80005110:	0007c503          	lbu	a0,0(a5)
    80005114:	00001097          	auipc	ra,0x1
    80005118:	9b8080e7          	jalr	-1608(ra) # 80005acc <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    8000511c:	0104a783          	lw	a5,16(s1)
    80005120:	0017879b          	addiw	a5,a5,1
    80005124:	0004a703          	lw	a4,0(s1)
    80005128:	02e7e7bb          	remw	a5,a5,a4
    8000512c:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80005130:	fc1ff06f          	j	800050f0 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80005134:	02100513          	li	a0,33
    80005138:	00001097          	auipc	ra,0x1
    8000513c:	994080e7          	jalr	-1644(ra) # 80005acc <_ZN7Console4putcEc>
    Console::putc('\n');
    80005140:	00a00513          	li	a0,10
    80005144:	00001097          	auipc	ra,0x1
    80005148:	988080e7          	jalr	-1656(ra) # 80005acc <_ZN7Console4putcEc>
    __mem_free(buffer);
    8000514c:	0084b503          	ld	a0,8(s1)
    80005150:	ffffd097          	auipc	ra,0xffffd
    80005154:	8e0080e7          	jalr	-1824(ra) # 80001a30 <__mem_free>
    delete itemAvailable;
    80005158:	0204b503          	ld	a0,32(s1)
    8000515c:	00050863          	beqz	a0,8000516c <_ZN9BufferCPPD1Ev+0xb0>
    80005160:	00053783          	ld	a5,0(a0)
    80005164:	0087b783          	ld	a5,8(a5)
    80005168:	000780e7          	jalr	a5
    delete spaceAvailable;
    8000516c:	0184b503          	ld	a0,24(s1)
    80005170:	00050863          	beqz	a0,80005180 <_ZN9BufferCPPD1Ev+0xc4>
    80005174:	00053783          	ld	a5,0(a0)
    80005178:	0087b783          	ld	a5,8(a5)
    8000517c:	000780e7          	jalr	a5
    delete mutexTail;
    80005180:	0304b503          	ld	a0,48(s1)
    80005184:	00050863          	beqz	a0,80005194 <_ZN9BufferCPPD1Ev+0xd8>
    80005188:	00053783          	ld	a5,0(a0)
    8000518c:	0087b783          	ld	a5,8(a5)
    80005190:	000780e7          	jalr	a5
    delete mutexHead;
    80005194:	0284b503          	ld	a0,40(s1)
    80005198:	00050863          	beqz	a0,800051a8 <_ZN9BufferCPPD1Ev+0xec>
    8000519c:	00053783          	ld	a5,0(a0)
    800051a0:	0087b783          	ld	a5,8(a5)
    800051a4:	000780e7          	jalr	a5
}
    800051a8:	01813083          	ld	ra,24(sp)
    800051ac:	01013403          	ld	s0,16(sp)
    800051b0:	00813483          	ld	s1,8(sp)
    800051b4:	02010113          	addi	sp,sp,32
    800051b8:	00008067          	ret

00000000800051bc <_Z8userMainv>:
#include "../test/System_Mode_test.hpp"
#include "../h/syscall_cpp.hpp"

#endif

void userMain() {
    800051bc:	fe010113          	addi	sp,sp,-32
    800051c0:	00113c23          	sd	ra,24(sp)
    800051c4:	00813823          	sd	s0,16(sp)
    800051c8:	00913423          	sd	s1,8(sp)
    800051cc:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    800051d0:	00005517          	auipc	a0,0x5
    800051d4:	05850513          	addi	a0,a0,88 # 8000a228 <CONSOLE_STATUS+0x218>
    800051d8:	00000097          	auipc	ra,0x0
    800051dc:	91c080e7          	jalr	-1764(ra) # 80004af4 <_Z11printStringPKc>
    int test = Console::getc() - '0';
    800051e0:	00001097          	auipc	ra,0x1
    800051e4:	8c4080e7          	jalr	-1852(ra) # 80005aa4 <_ZN7Console4getcEv>
    800051e8:	fd05049b          	addiw	s1,a0,-48
    Console::getc(); // Enter posle broja
    800051ec:	00001097          	auipc	ra,0x1
    800051f0:	8b8080e7          	jalr	-1864(ra) # 80005aa4 <_ZN7Console4getcEv>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    800051f4:	00700793          	li	a5,7
    800051f8:	1097e263          	bltu	a5,s1,800052fc <_Z8userMainv+0x140>
    800051fc:	00249493          	slli	s1,s1,0x2
    80005200:	00005717          	auipc	a4,0x5
    80005204:	28070713          	addi	a4,a4,640 # 8000a480 <CONSOLE_STATUS+0x470>
    80005208:	00e484b3          	add	s1,s1,a4
    8000520c:	0004a783          	lw	a5,0(s1)
    80005210:	00e787b3          	add	a5,a5,a4
    80005214:	00078067          	jr	a5
        case 1:
#if LEVEL_2_IMPLEMENTED == 1
            Threads_C_API_test();
    80005218:	fffff097          	auipc	ra,0xfffff
    8000521c:	f54080e7          	jalr	-172(ra) # 8000416c <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    80005220:	00005517          	auipc	a0,0x5
    80005224:	02850513          	addi	a0,a0,40 # 8000a248 <CONSOLE_STATUS+0x238>
    80005228:	00000097          	auipc	ra,0x0
    8000522c:	8cc080e7          	jalr	-1844(ra) # 80004af4 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    80005230:	01813083          	ld	ra,24(sp)
    80005234:	01013403          	ld	s0,16(sp)
    80005238:	00813483          	ld	s1,8(sp)
    8000523c:	02010113          	addi	sp,sp,32
    80005240:	00008067          	ret
            Threads_CPP_API_test();
    80005244:	ffffe097          	auipc	ra,0xffffe
    80005248:	e08080e7          	jalr	-504(ra) # 8000304c <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    8000524c:	00005517          	auipc	a0,0x5
    80005250:	03c50513          	addi	a0,a0,60 # 8000a288 <CONSOLE_STATUS+0x278>
    80005254:	00000097          	auipc	ra,0x0
    80005258:	8a0080e7          	jalr	-1888(ra) # 80004af4 <_Z11printStringPKc>
            break;
    8000525c:	fd5ff06f          	j	80005230 <_Z8userMainv+0x74>
            producerConsumer_C_API();
    80005260:	ffffd097          	auipc	ra,0xffffd
    80005264:	ce0080e7          	jalr	-800(ra) # 80001f40 <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    80005268:	00005517          	auipc	a0,0x5
    8000526c:	06050513          	addi	a0,a0,96 # 8000a2c8 <CONSOLE_STATUS+0x2b8>
    80005270:	00000097          	auipc	ra,0x0
    80005274:	884080e7          	jalr	-1916(ra) # 80004af4 <_Z11printStringPKc>
            break;
    80005278:	fb9ff06f          	j	80005230 <_Z8userMainv+0x74>
            producerConsumer_CPP_Sync_API();
    8000527c:	fffff097          	auipc	ra,0xfffff
    80005280:	234080e7          	jalr	564(ra) # 800044b0 <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    80005284:	00005517          	auipc	a0,0x5
    80005288:	09450513          	addi	a0,a0,148 # 8000a318 <CONSOLE_STATUS+0x308>
    8000528c:	00000097          	auipc	ra,0x0
    80005290:	868080e7          	jalr	-1944(ra) # 80004af4 <_Z11printStringPKc>
            break;
    80005294:	f9dff06f          	j	80005230 <_Z8userMainv+0x74>
            testSleeping();
    80005298:	00001097          	auipc	ra,0x1
    8000529c:	a14080e7          	jalr	-1516(ra) # 80005cac <_Z12testSleepingv>
            printString("TEST 5 (zadatak 4., thread_sleep test C API)\n");
    800052a0:	00005517          	auipc	a0,0x5
    800052a4:	0d050513          	addi	a0,a0,208 # 8000a370 <CONSOLE_STATUS+0x360>
    800052a8:	00000097          	auipc	ra,0x0
    800052ac:	84c080e7          	jalr	-1972(ra) # 80004af4 <_Z11printStringPKc>
            break;
    800052b0:	f81ff06f          	j	80005230 <_Z8userMainv+0x74>
            testConsumerProducer();
    800052b4:	ffffe097          	auipc	ra,0xffffe
    800052b8:	258080e7          	jalr	600(ra) # 8000350c <_Z20testConsumerProducerv>
            printString("TEST 6 (zadatak 4. CPP API i asinhrona promena konteksta)\n");
    800052bc:	00005517          	auipc	a0,0x5
    800052c0:	0e450513          	addi	a0,a0,228 # 8000a3a0 <CONSOLE_STATUS+0x390>
    800052c4:	00000097          	auipc	ra,0x0
    800052c8:	830080e7          	jalr	-2000(ra) # 80004af4 <_Z11printStringPKc>
            break;
    800052cc:	f65ff06f          	j	80005230 <_Z8userMainv+0x74>
            System_Mode_test();
    800052d0:	00001097          	auipc	ra,0x1
    800052d4:	368080e7          	jalr	872(ra) # 80006638 <_Z16System_Mode_testv>
            printString("Test se nije uspesno zavrsio\n");
    800052d8:	00005517          	auipc	a0,0x5
    800052dc:	10850513          	addi	a0,a0,264 # 8000a3e0 <CONSOLE_STATUS+0x3d0>
    800052e0:	00000097          	auipc	ra,0x0
    800052e4:	814080e7          	jalr	-2028(ra) # 80004af4 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    800052e8:	00005517          	auipc	a0,0x5
    800052ec:	11850513          	addi	a0,a0,280 # 8000a400 <CONSOLE_STATUS+0x3f0>
    800052f0:	00000097          	auipc	ra,0x0
    800052f4:	804080e7          	jalr	-2044(ra) # 80004af4 <_Z11printStringPKc>
            break;
    800052f8:	f39ff06f          	j	80005230 <_Z8userMainv+0x74>
            printString("Niste uneli odgovarajuci broj za test\n");
    800052fc:	00005517          	auipc	a0,0x5
    80005300:	15c50513          	addi	a0,a0,348 # 8000a458 <CONSOLE_STATUS+0x448>
    80005304:	fffff097          	auipc	ra,0xfffff
    80005308:	7f0080e7          	jalr	2032(ra) # 80004af4 <_Z11printStringPKc>
    8000530c:	f25ff06f          	j	80005230 <_Z8userMainv+0x74>

0000000080005310 <_ZN9Scheduler3putEP7_thread>:

Scheduler::Node* Scheduler::head = nullptr;
Scheduler::Node* Scheduler::tail = nullptr;

int Scheduler::put(thread_t thread)
{
    80005310:	fe010113          	addi	sp,sp,-32
    80005314:	00113c23          	sd	ra,24(sp)
    80005318:	00813823          	sd	s0,16(sp)
    8000531c:	00913423          	sd	s1,8(sp)
    80005320:	01213023          	sd	s2,0(sp)
    80005324:	02010413          	addi	s0,sp,32
    80005328:	00050493          	mv	s1,a0
    Node* newThread = (Node*)MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(sizeof(Node)));
    8000532c:	00001097          	auipc	ra,0x1
    80005330:	408080e7          	jalr	1032(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80005334:	00050913          	mv	s2,a0
    80005338:	01000513          	li	a0,16
    8000533c:	00001097          	auipc	ra,0x1
    80005340:	748080e7          	jalr	1864(ra) # 80006a84 <_ZN15MemoryAllocator19__convert_to_blocksEm>
    80005344:	00050593          	mv	a1,a0
    80005348:	00090513          	mv	a0,s2
    8000534c:	00001097          	auipc	ra,0x1
    80005350:	48c080e7          	jalr	1164(ra) # 800067d8 <_ZN15MemoryAllocator11__mem_allocEm>

    if (!newThread)
    80005354:	04050a63          	beqz	a0,800053a8 <_ZN9Scheduler3putEP7_thread+0x98>
        return -1;

    newThread->thread = thread;
    80005358:	00953023          	sd	s1,0(a0)
    newThread->next = nullptr;
    8000535c:	00053423          	sd	zero,8(a0)

    thread->currentState = _thread::READY;
    80005360:	00100793          	li	a5,1
    80005364:	12f4ae23          	sw	a5,316(s1)

    if (tail)
    80005368:	00007797          	auipc	a5,0x7
    8000536c:	7587b783          	ld	a5,1880(a5) # 8000cac0 <_ZN9Scheduler4tailE>
    80005370:	02078663          	beqz	a5,8000539c <_ZN9Scheduler3putEP7_thread+0x8c>
        tail->next = newThread;
    80005374:	00a7b423          	sd	a0,8(a5)
    else
        head = newThread;
    tail = newThread;
    80005378:	00007797          	auipc	a5,0x7
    8000537c:	74a7b423          	sd	a0,1864(a5) # 8000cac0 <_ZN9Scheduler4tailE>

    return 0;
    80005380:	00000513          	li	a0,0
}
    80005384:	01813083          	ld	ra,24(sp)
    80005388:	01013403          	ld	s0,16(sp)
    8000538c:	00813483          	ld	s1,8(sp)
    80005390:	00013903          	ld	s2,0(sp)
    80005394:	02010113          	addi	sp,sp,32
    80005398:	00008067          	ret
        head = newThread;
    8000539c:	00007797          	auipc	a5,0x7
    800053a0:	72a7b623          	sd	a0,1836(a5) # 8000cac8 <_ZN9Scheduler4headE>
    800053a4:	fd5ff06f          	j	80005378 <_ZN9Scheduler3putEP7_thread+0x68>
        return -1;
    800053a8:	fff00513          	li	a0,-1
    800053ac:	fd9ff06f          	j	80005384 <_ZN9Scheduler3putEP7_thread+0x74>

00000000800053b0 <_ZN9Scheduler3getEv>:

thread_t Scheduler::get()
{
    800053b0:	fe010113          	addi	sp,sp,-32
    800053b4:	00113c23          	sd	ra,24(sp)
    800053b8:	00813823          	sd	s0,16(sp)
    800053bc:	00913423          	sd	s1,8(sp)
    800053c0:	01213023          	sd	s2,0(sp)
    800053c4:	02010413          	addi	s0,sp,32
    if (!head)
    800053c8:	00007497          	auipc	s1,0x7
    800053cc:	7004b483          	ld	s1,1792(s1) # 8000cac8 <_ZN9Scheduler4headE>
    800053d0:	04048e63          	beqz	s1,8000542c <_ZN9Scheduler3getEv+0x7c>
        return nullptr;

    Node* node = head;
    thread_t thread = head->thread;
    800053d4:	0004b903          	ld	s2,0(s1)

    head = head->next;
    800053d8:	0084b703          	ld	a4,8(s1)
    800053dc:	00007797          	auipc	a5,0x7
    800053e0:	6e478793          	addi	a5,a5,1764 # 8000cac0 <_ZN9Scheduler4tailE>
    800053e4:	00e7b423          	sd	a4,8(a5)
    if (tail == node)
    800053e8:	0007b783          	ld	a5,0(a5)
    800053ec:	02f48a63          	beq	s1,a5,80005420 <_ZN9Scheduler3getEv+0x70>
        tail = nullptr;

    MemoryAllocator::__get_instance()->__mem_free(node);
    800053f0:	00001097          	auipc	ra,0x1
    800053f4:	344080e7          	jalr	836(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    800053f8:	00048593          	mv	a1,s1
    800053fc:	00001097          	auipc	ra,0x1
    80005400:	528080e7          	jalr	1320(ra) # 80006924 <_ZN15MemoryAllocator10__mem_freeEPv>

    return thread;
    80005404:	00090513          	mv	a0,s2
    80005408:	01813083          	ld	ra,24(sp)
    8000540c:	01013403          	ld	s0,16(sp)
    80005410:	00813483          	ld	s1,8(sp)
    80005414:	00013903          	ld	s2,0(sp)
    80005418:	02010113          	addi	sp,sp,32
    8000541c:	00008067          	ret
        tail = nullptr;
    80005420:	00007797          	auipc	a5,0x7
    80005424:	6a07b023          	sd	zero,1696(a5) # 8000cac0 <_ZN9Scheduler4tailE>
    80005428:	fc9ff06f          	j	800053f0 <_ZN9Scheduler3getEv+0x40>
        return nullptr;
    8000542c:	00048913          	mv	s2,s1
    80005430:	fd5ff06f          	j	80005404 <_ZN9Scheduler3getEv+0x54>

0000000080005434 <_Z9doNothingPv>:
        putc('c');
    }
}

void doNothing(void*)
{
    80005434:	ff010113          	addi	sp,sp,-16
    80005438:	00113423          	sd	ra,8(sp)
    8000543c:	00813023          	sd	s0,0(sp)
    80005440:	01010413          	addi	s0,sp,16
    while(1)
    {
        thread_dispatch();
    80005444:	ffffc097          	auipc	ra,0xffffc
    80005448:	664080e7          	jalr	1636(ra) # 80001aa8 <thread_dispatch>
    while(1)
    8000544c:	ff9ff06f          	j	80005444 <_Z9doNothingPv+0x10>

0000000080005450 <_Z14userMainThreadPv>:
    }
}

void userMainThread(void*)
{
    80005450:	ff010113          	addi	sp,sp,-16
    80005454:	00113423          	sd	ra,8(sp)
    80005458:	00813023          	sd	s0,0(sp)
    8000545c:	01010413          	addi	s0,sp,16
    userMain();
    80005460:	00000097          	auipc	ra,0x0
    80005464:	d5c080e7          	jalr	-676(ra) # 800051bc <_Z8userMainv>
}
    80005468:	00813083          	ld	ra,8(sp)
    8000546c:	00013403          	ld	s0,0(sp)
    80005470:	01010113          	addi	sp,sp,16
    80005474:	00008067          	ret

0000000080005478 <_Z3funPv>:
{
    80005478:	ff010113          	addi	sp,sp,-16
    8000547c:	00113423          	sd	ra,8(sp)
    80005480:	00813023          	sd	s0,0(sp)
    80005484:	01010413          	addi	s0,sp,16
        putc('c');
    80005488:	06300513          	li	a0,99
    8000548c:	ffffc097          	auipc	ra,0xffffc
    80005490:	790080e7          	jalr	1936(ra) # 80001c1c <putc>
    while(1)
    80005494:	ff5ff06f          	j	80005488 <_Z3funPv+0x10>

0000000080005498 <main>:

int main()
{
    80005498:	fe010113          	addi	sp,sp,-32
    8000549c:	00113c23          	sd	ra,24(sp)
    800054a0:	00813823          	sd	s0,16(sp)
    800054a4:	00913423          	sd	s1,8(sp)
    800054a8:	02010413          	addi	s0,sp,32

    __asm__ volatile("csrw stvec, %0" : : "r"(&interruptHandler));
    __asm__ volatile("csrs sstatus, %0" : : "r"(1 << 1));  // interrupt enable
    */

    thread_t thread = _thread::thread_create(nullptr, nullptr, false, true);
    800054ac:	00100693          	li	a3,1
    800054b0:	00000613          	li	a2,0
    800054b4:	00000593          	li	a1,0
    800054b8:	00000513          	li	a0,0
    800054bc:	ffffd097          	auipc	ra,0xffffd
    800054c0:	03c080e7          	jalr	60(ra) # 800024f8 <_ZN7_thread13thread_createEPFvPvES0_bb>
    _thread::running = thread;
    800054c4:	00007797          	auipc	a5,0x7
    800054c8:	4f47b783          	ld	a5,1268(a5) # 8000c9b8 <_GLOBAL_OFFSET_TABLE_+0x20>
    800054cc:	00a7b023          	sd	a0,0(a5)
    _thread::running->context.x[1] = 0;
    800054d0:	00053423          	sd	zero,8(a0)
    thread_t thread1 = _thread::thread_create(&userMainThread, nullptr, true, false);
    800054d4:	00000693          	li	a3,0
    800054d8:	00100613          	li	a2,1
    800054dc:	00000593          	li	a1,0
    800054e0:	00000517          	auipc	a0,0x0
    800054e4:	f7050513          	addi	a0,a0,-144 # 80005450 <_Z14userMainThreadPv>
    800054e8:	ffffd097          	auipc	ra,0xffffd
    800054ec:	010080e7          	jalr	16(ra) # 800024f8 <_ZN7_thread13thread_createEPFvPvES0_bb>
    800054f0:	00050493          	mv	s1,a0
    thread_t thread2 = _thread::thread_create(&doNothing, nullptr, true, false);
    800054f4:	00000693          	li	a3,0
    800054f8:	00100613          	li	a2,1
    800054fc:	00000593          	li	a1,0
    80005500:	00000517          	auipc	a0,0x0
    80005504:	f3450513          	addi	a0,a0,-204 # 80005434 <_Z9doNothingPv>
    80005508:	ffffd097          	auipc	ra,0xffffd
    8000550c:	ff0080e7          	jalr	-16(ra) # 800024f8 <_ZN7_thread13thread_createEPFvPvES0_bb>
    (void)thread2;

    /*thread_t thread1 = _thread::thread_create(&fun, nullptr, true, false);
    (void)thread1;*/

    _buffer::putcBuffer = _buffer::buffer_create(1000);
    80005510:	3e800513          	li	a0,1000
    80005514:	00001097          	auipc	ra,0x1
    80005518:	590080e7          	jalr	1424(ra) # 80006aa4 <_ZN7_buffer13buffer_createEj>
    8000551c:	00007797          	auipc	a5,0x7
    80005520:	4d47b783          	ld	a5,1236(a5) # 8000c9f0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80005524:	00a7b023          	sd	a0,0(a5)
    _buffer::getcBuffer = _buffer::buffer_create(1000);
    80005528:	3e800513          	li	a0,1000
    8000552c:	00001097          	auipc	ra,0x1
    80005530:	578080e7          	jalr	1400(ra) # 80006aa4 <_ZN7_buffer13buffer_createEj>
    80005534:	00007797          	auipc	a5,0x7
    80005538:	4947b783          	ld	a5,1172(a5) # 8000c9c8 <_GLOBAL_OFFSET_TABLE_+0x30>
    8000553c:	00a7b023          	sd	a0,0(a5)
    _thread::putcThread = _thread::thread_create(&__putcWrapper, nullptr, true, true);
    80005540:	00100693          	li	a3,1
    80005544:	00100613          	li	a2,1
    80005548:	00000593          	li	a1,0
    8000554c:	00007517          	auipc	a0,0x7
    80005550:	4ac53503          	ld	a0,1196(a0) # 8000c9f8 <_GLOBAL_OFFSET_TABLE_+0x60>
    80005554:	ffffd097          	auipc	ra,0xffffd
    80005558:	fa4080e7          	jalr	-92(ra) # 800024f8 <_ZN7_thread13thread_createEPFvPvES0_bb>
    8000555c:	00007797          	auipc	a5,0x7
    80005560:	4ac7b783          	ld	a5,1196(a5) # 8000ca08 <_GLOBAL_OFFSET_TABLE_+0x70>
    80005564:	00a7b023          	sd	a0,0(a5)


    __asm__ volatile("csrw stvec, %0" : : "r"((size_t)(&interruptHandler) + 1)); // interrupt vector table
    80005568:	00007797          	auipc	a5,0x7
    8000556c:	4807b783          	ld	a5,1152(a5) # 8000c9e8 <_GLOBAL_OFFSET_TABLE_+0x50>
    80005570:	00178793          	addi	a5,a5,1
    80005574:	10579073          	csrw	stvec,a5
    __asm__ volatile("csrs sstatus, %0" : : "r"(1 << 1));  // interrupt enable
    80005578:	00200793          	li	a5,2
    8000557c:	1007a073          	csrs	sstatus,a5


    thread_join(thread1);
    80005580:	00048513          	mv	a0,s1
    80005584:	ffffc097          	auipc	ra,0xffffc
    80005588:	668080e7          	jalr	1640(ra) # 80001bec <thread_join>

    disable_interrupt();
    8000558c:	ffffc097          	auipc	ra,0xffffc
    80005590:	738080e7          	jalr	1848(ra) # 80001cc4 <disable_interrupt>

    while (!_buffer::isEmpty(_buffer::putcBuffer) && _thread::putcThread->currentState == _thread::BLOCKED)
    80005594:	00007797          	auipc	a5,0x7
    80005598:	45c7b783          	ld	a5,1116(a5) # 8000c9f0 <_GLOBAL_OFFSET_TABLE_+0x58>
    8000559c:	0007b503          	ld	a0,0(a5)
    800055a0:	00002097          	auipc	ra,0x2
    800055a4:	938080e7          	jalr	-1736(ra) # 80006ed8 <_ZN7_buffer7isEmptyEPS_>
    800055a8:	02051463          	bnez	a0,800055d0 <main+0x138>
    800055ac:	00007797          	auipc	a5,0x7
    800055b0:	45c7b783          	ld	a5,1116(a5) # 8000ca08 <_GLOBAL_OFFSET_TABLE_+0x70>
    800055b4:	0007b783          	ld	a5,0(a5)
    800055b8:	13c7a703          	lw	a4,316(a5)
    800055bc:	00200793          	li	a5,2
    800055c0:	00f71863          	bne	a4,a5,800055d0 <main+0x138>
    {
        thread_dispatch();
    800055c4:	ffffc097          	auipc	ra,0xffffc
    800055c8:	4e4080e7          	jalr	1252(ra) # 80001aa8 <thread_dispatch>
    while (!_buffer::isEmpty(_buffer::putcBuffer) && _thread::putcThread->currentState == _thread::BLOCKED)
    800055cc:	fc9ff06f          	j	80005594 <main+0xfc>
    }


    return 0;
    800055d0:	00000513          	li	a0,0
    800055d4:	01813083          	ld	ra,24(sp)
    800055d8:	01013403          	ld	s0,16(sp)
    800055dc:	00813483          	ld	s1,8(sp)
    800055e0:	02010113          	addi	sp,sp,32
    800055e4:	00008067          	ret

00000000800055e8 <__putc>:

#ifdef __cplusplus
extern "C"
#endif
void __putc(char chr)
{
    800055e8:	fe010113          	addi	sp,sp,-32
    800055ec:	00113c23          	sd	ra,24(sp)
    800055f0:	00813823          	sd	s0,16(sp)
    800055f4:	02010413          	addi	s0,sp,32
    800055f8:	0200006f          	j	80005618 <__putc+0x30>
            char volatile c = _buffer::consume(_buffer::putcBuffer, false);
            __asm__ volatile("li a0, 2");
            __asm__ volatile ("csrc sstatus, a0");
            if (c == '\r')
                c = '\n';
            *((char*)CONSOLE_TX_DATA) = c;
    800055fc:	00007797          	auipc	a5,0x7
    80005600:	3c47b783          	ld	a5,964(a5) # 8000c9c0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80005604:	0007b783          	ld	a5,0(a5)
    80005608:	fe744703          	lbu	a4,-25(s0)
    8000560c:	00e78023          	sb	a4,0(a5)
            __asm__ volatile("li a0, 2");
    80005610:	00200513          	li	a0,2
            __asm__ volatile ("csrs sstatus, a0");
    80005614:	10052073          	csrs	sstatus,a0
        __asm__ volatile("li a0, 2");
    80005618:	00200513          	li	a0,2
        __asm__ volatile ("csrc sstatus, a0");
    8000561c:	10053073          	csrc	sstatus,a0
        uint64 volatile statusReg = (uint64)(*((char*)CONSOLE_STATUS));
    80005620:	00007797          	auipc	a5,0x7
    80005624:	3887b783          	ld	a5,904(a5) # 8000c9a8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80005628:	0007b783          	ld	a5,0(a5)
    8000562c:	0007c783          	lbu	a5,0(a5)
    80005630:	fef43423          	sd	a5,-24(s0)
        __asm__ volatile("li a0, 2");
    80005634:	00200513          	li	a0,2
        __asm__ volatile ("csrs sstatus, a0");
    80005638:	10052073          	csrs	sstatus,a0
        if (statusReg & CONSOLE_TX_STATUS_BIT)
    8000563c:	fe843783          	ld	a5,-24(s0)
    80005640:	0207f793          	andi	a5,a5,32
    80005644:	fc078ae3          	beqz	a5,80005618 <__putc+0x30>
            char volatile c = _buffer::consume(_buffer::putcBuffer, false);
    80005648:	00000593          	li	a1,0
    8000564c:	00007797          	auipc	a5,0x7
    80005650:	3a47b783          	ld	a5,932(a5) # 8000c9f0 <_GLOBAL_OFFSET_TABLE_+0x58>
    80005654:	0007b503          	ld	a0,0(a5)
    80005658:	00001097          	auipc	ra,0x1
    8000565c:	760080e7          	jalr	1888(ra) # 80006db8 <_ZN7_buffer7consumeEPS_b>
    80005660:	fea403a3          	sb	a0,-25(s0)
            __asm__ volatile("li a0, 2");
    80005664:	00200513          	li	a0,2
            __asm__ volatile ("csrc sstatus, a0");
    80005668:	10053073          	csrc	sstatus,a0
            if (c == '\r')
    8000566c:	fe744783          	lbu	a5,-25(s0)
    80005670:	0ff7f793          	andi	a5,a5,255
    80005674:	00d00713          	li	a4,13
    80005678:	f8e792e3          	bne	a5,a4,800055fc <__putc+0x14>
                c = '\n';
    8000567c:	00a00793          	li	a5,10
    80005680:	fef403a3          	sb	a5,-25(s0)
    80005684:	f79ff06f          	j	800055fc <__putc+0x14>

0000000080005688 <__putcWrapper>:

#ifdef __cplusplus
extern "C"
#endif
void __putcWrapper(void*)
{
    80005688:	ff010113          	addi	sp,sp,-16
    8000568c:	00113423          	sd	ra,8(sp)
    80005690:	00813023          	sd	s0,0(sp)
    80005694:	01010413          	addi	s0,sp,16
    __putc(0);
    80005698:	00000513          	li	a0,0
    8000569c:	00000097          	auipc	ra,0x0
    800056a0:	f4c080e7          	jalr	-180(ra) # 800055e8 <__putc>

00000000800056a4 <_ZN6Thread3runEv>:
    thread_dispatch();
}

void Thread::run()
{
    if (body)
    800056a4:	01053783          	ld	a5,16(a0)
    800056a8:	02078663          	beqz	a5,800056d4 <_ZN6Thread3runEv+0x30>
{
    800056ac:	ff010113          	addi	sp,sp,-16
    800056b0:	00113423          	sd	ra,8(sp)
    800056b4:	00813023          	sd	s0,0(sp)
    800056b8:	01010413          	addi	s0,sp,16
        body(arg);
    800056bc:	01853503          	ld	a0,24(a0)
    800056c0:	000780e7          	jalr	a5
}
    800056c4:	00813083          	ld	ra,8(sp)
    800056c8:	00013403          	ld	s0,0(sp)
    800056cc:	01010113          	addi	sp,sp,16
    800056d0:	00008067          	ret
    800056d4:	00008067          	ret

00000000800056d8 <_ZN6Thread10runWrapperEPv>:
}

void Thread::runWrapper(void *arg)
{
    Thread* thread = (Thread*)arg;
    if (!thread)
    800056d8:	02050863          	beqz	a0,80005708 <_ZN6Thread10runWrapperEPv+0x30>
{
    800056dc:	ff010113          	addi	sp,sp,-16
    800056e0:	00113423          	sd	ra,8(sp)
    800056e4:	00813023          	sd	s0,0(sp)
    800056e8:	01010413          	addi	s0,sp,16
        return;
    thread->run();
    800056ec:	00053783          	ld	a5,0(a0)
    800056f0:	0107b783          	ld	a5,16(a5)
    800056f4:	000780e7          	jalr	a5
}
    800056f8:	00813083          	ld	ra,8(sp)
    800056fc:	00013403          	ld	s0,0(sp)
    80005700:	01010113          	addi	sp,sp,16
    80005704:	00008067          	ret
    80005708:	00008067          	ret

000000008000570c <_ZN14PeriodicThread18periodicActivationEv>:
    flag = false;
    this->period = period;
}

void PeriodicThread::periodicActivation()
{
    8000570c:	ff010113          	addi	sp,sp,-16
    80005710:	00813423          	sd	s0,8(sp)
    80005714:	01010413          	addi	s0,sp,16

}
    80005718:	00813403          	ld	s0,8(sp)
    8000571c:	01010113          	addi	sp,sp,16
    80005720:	00008067          	ret

0000000080005724 <_ZN6ThreadD1Ev>:
Thread::~Thread()
    80005724:	fe010113          	addi	sp,sp,-32
    80005728:	00113c23          	sd	ra,24(sp)
    8000572c:	00813823          	sd	s0,16(sp)
    80005730:	00913423          	sd	s1,8(sp)
    80005734:	02010413          	addi	s0,sp,32
    80005738:	00050493          	mv	s1,a0
    8000573c:	00007797          	auipc	a5,0x7
    80005740:	1f478793          	addi	a5,a5,500 # 8000c930 <_ZTV6Thread+0x10>
    80005744:	00f53023          	sd	a5,0(a0)
    if (!myHandle->isFinished())
    80005748:	00853503          	ld	a0,8(a0)
    8000574c:	ffffd097          	auipc	ra,0xffffd
    80005750:	c5c080e7          	jalr	-932(ra) # 800023a8 <_ZN7_thread10isFinishedEv>
    80005754:	00050c63          	beqz	a0,8000576c <_ZN6ThreadD1Ev+0x48>
}
    80005758:	01813083          	ld	ra,24(sp)
    8000575c:	01013403          	ld	s0,16(sp)
    80005760:	00813483          	ld	s1,8(sp)
    80005764:	02010113          	addi	sp,sp,32
    80005768:	00008067          	ret
        thread_join(myHandle);
    8000576c:	0084b503          	ld	a0,8(s1)
    80005770:	ffffc097          	auipc	ra,0xffffc
    80005774:	47c080e7          	jalr	1148(ra) # 80001bec <thread_join>
}
    80005778:	fe1ff06f          	j	80005758 <_ZN6ThreadD1Ev+0x34>

000000008000577c <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore()
    8000577c:	ff010113          	addi	sp,sp,-16
    80005780:	00113423          	sd	ra,8(sp)
    80005784:	00813023          	sd	s0,0(sp)
    80005788:	01010413          	addi	s0,sp,16
    8000578c:	00007797          	auipc	a5,0x7
    80005790:	1cc78793          	addi	a5,a5,460 # 8000c958 <_ZTV9Semaphore+0x10>
    80005794:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80005798:	00853503          	ld	a0,8(a0)
    8000579c:	ffffc097          	auipc	ra,0xffffc
    800057a0:	3a8080e7          	jalr	936(ra) # 80001b44 <sem_close>
}
    800057a4:	00813083          	ld	ra,8(sp)
    800057a8:	00013403          	ld	s0,0(sp)
    800057ac:	01010113          	addi	sp,sp,16
    800057b0:	00008067          	ret

00000000800057b4 <_ZN14PeriodicThread3runEv>:

void PeriodicThread::run()
{
    800057b4:	fe010113          	addi	sp,sp,-32
    800057b8:	00113c23          	sd	ra,24(sp)
    800057bc:	00813823          	sd	s0,16(sp)
    800057c0:	00913423          	sd	s1,8(sp)
    800057c4:	02010413          	addi	s0,sp,32
    800057c8:	00050493          	mv	s1,a0
    disable_interrupt();
    800057cc:	ffffc097          	auipc	ra,0xffffc
    800057d0:	4f8080e7          	jalr	1272(ra) # 80001cc4 <disable_interrupt>
    flag = true;
    800057d4:	00100793          	li	a5,1
    800057d8:	02f48423          	sb	a5,40(s1)
    enable_interrupt();
    800057dc:	ffffc097          	auipc	ra,0xffffc
    800057e0:	514080e7          	jalr	1300(ra) # 80001cf0 <enable_interrupt>
    while (1)
    {
        disable_interrupt();
    800057e4:	ffffc097          	auipc	ra,0xffffc
    800057e8:	4e0080e7          	jalr	1248(ra) # 80001cc4 <disable_interrupt>
        if (!flag)
    800057ec:	0284c783          	lbu	a5,40(s1)
    800057f0:	02078663          	beqz	a5,8000581c <_ZN14PeriodicThread3runEv+0x68>
        {
            enable_interrupt();
            return;
        }
        enable_interrupt();
    800057f4:	ffffc097          	auipc	ra,0xffffc
    800057f8:	4fc080e7          	jalr	1276(ra) # 80001cf0 <enable_interrupt>
        periodicActivation();
    800057fc:	0004b783          	ld	a5,0(s1)
    80005800:	0187b783          	ld	a5,24(a5)
    80005804:	00048513          	mv	a0,s1
    80005808:	000780e7          	jalr	a5
        time_sleep(period);
    8000580c:	0204b503          	ld	a0,32(s1)
    80005810:	ffffc097          	auipc	ra,0xffffc
    80005814:	470080e7          	jalr	1136(ra) # 80001c80 <time_sleep>
        disable_interrupt();
    80005818:	fcdff06f          	j	800057e4 <_ZN14PeriodicThread3runEv+0x30>
            enable_interrupt();
    8000581c:	ffffc097          	auipc	ra,0xffffc
    80005820:	4d4080e7          	jalr	1236(ra) # 80001cf0 <enable_interrupt>
    }
}
    80005824:	01813083          	ld	ra,24(sp)
    80005828:	01013403          	ld	s0,16(sp)
    8000582c:	00813483          	ld	s1,8(sp)
    80005830:	02010113          	addi	sp,sp,32
    80005834:	00008067          	ret

0000000080005838 <_Znwm>:
{
    80005838:	ff010113          	addi	sp,sp,-16
    8000583c:	00113423          	sd	ra,8(sp)
    80005840:	00813023          	sd	s0,0(sp)
    80005844:	01010413          	addi	s0,sp,16
    return __mem_alloc(size);
    80005848:	ffffc097          	auipc	ra,0xffffc
    8000584c:	1ac080e7          	jalr	428(ra) # 800019f4 <__mem_alloc>
}
    80005850:	00813083          	ld	ra,8(sp)
    80005854:	00013403          	ld	s0,0(sp)
    80005858:	01010113          	addi	sp,sp,16
    8000585c:	00008067          	ret

0000000080005860 <_ZdlPv>:
{
    80005860:	ff010113          	addi	sp,sp,-16
    80005864:	00113423          	sd	ra,8(sp)
    80005868:	00813023          	sd	s0,0(sp)
    8000586c:	01010413          	addi	s0,sp,16
    __mem_free(ptr);
    80005870:	ffffc097          	auipc	ra,0xffffc
    80005874:	1c0080e7          	jalr	448(ra) # 80001a30 <__mem_free>
}
    80005878:	00813083          	ld	ra,8(sp)
    8000587c:	00013403          	ld	s0,0(sp)
    80005880:	01010113          	addi	sp,sp,16
    80005884:	00008067          	ret

0000000080005888 <_ZN6ThreadD0Ev>:
Thread::~Thread()
    80005888:	fe010113          	addi	sp,sp,-32
    8000588c:	00113c23          	sd	ra,24(sp)
    80005890:	00813823          	sd	s0,16(sp)
    80005894:	00913423          	sd	s1,8(sp)
    80005898:	02010413          	addi	s0,sp,32
    8000589c:	00050493          	mv	s1,a0
}
    800058a0:	00000097          	auipc	ra,0x0
    800058a4:	e84080e7          	jalr	-380(ra) # 80005724 <_ZN6ThreadD1Ev>
    800058a8:	00048513          	mv	a0,s1
    800058ac:	00000097          	auipc	ra,0x0
    800058b0:	fb4080e7          	jalr	-76(ra) # 80005860 <_ZdlPv>
    800058b4:	01813083          	ld	ra,24(sp)
    800058b8:	01013403          	ld	s0,16(sp)
    800058bc:	00813483          	ld	s1,8(sp)
    800058c0:	02010113          	addi	sp,sp,32
    800058c4:	00008067          	ret

00000000800058c8 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore()
    800058c8:	fe010113          	addi	sp,sp,-32
    800058cc:	00113c23          	sd	ra,24(sp)
    800058d0:	00813823          	sd	s0,16(sp)
    800058d4:	00913423          	sd	s1,8(sp)
    800058d8:	02010413          	addi	s0,sp,32
    800058dc:	00050493          	mv	s1,a0
}
    800058e0:	00000097          	auipc	ra,0x0
    800058e4:	e9c080e7          	jalr	-356(ra) # 8000577c <_ZN9SemaphoreD1Ev>
    800058e8:	00048513          	mv	a0,s1
    800058ec:	00000097          	auipc	ra,0x0
    800058f0:	f74080e7          	jalr	-140(ra) # 80005860 <_ZdlPv>
    800058f4:	01813083          	ld	ra,24(sp)
    800058f8:	01013403          	ld	s0,16(sp)
    800058fc:	00813483          	ld	s1,8(sp)
    80005900:	02010113          	addi	sp,sp,32
    80005904:	00008067          	ret

0000000080005908 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg)
    80005908:	ff010113          	addi	sp,sp,-16
    8000590c:	00813423          	sd	s0,8(sp)
    80005910:	01010413          	addi	s0,sp,16
    80005914:	00007797          	auipc	a5,0x7
    80005918:	01c78793          	addi	a5,a5,28 # 8000c930 <_ZTV6Thread+0x10>
    8000591c:	00f53023          	sd	a5,0(a0)
    this->body = body;
    80005920:	00b53823          	sd	a1,16(a0)
    this->arg = arg;
    80005924:	00c53c23          	sd	a2,24(a0)
}
    80005928:	00813403          	ld	s0,8(sp)
    8000592c:	01010113          	addi	sp,sp,16
    80005930:	00008067          	ret

0000000080005934 <_ZN6Thread5startEv>:
int Thread::start() {
    80005934:	ff010113          	addi	sp,sp,-16
    80005938:	00113423          	sd	ra,8(sp)
    8000593c:	00813023          	sd	s0,0(sp)
    80005940:	01010413          	addi	s0,sp,16
    int res = thread_create(&myHandle, &runWrapper, this);
    80005944:	00050613          	mv	a2,a0
    80005948:	00000597          	auipc	a1,0x0
    8000594c:	d9058593          	addi	a1,a1,-624 # 800056d8 <_ZN6Thread10runWrapperEPv>
    80005950:	00850513          	addi	a0,a0,8
    80005954:	ffffc097          	auipc	ra,0xffffc
    80005958:	114080e7          	jalr	276(ra) # 80001a68 <thread_create>
}
    8000595c:	00813083          	ld	ra,8(sp)
    80005960:	00013403          	ld	s0,0(sp)
    80005964:	01010113          	addi	sp,sp,16
    80005968:	00008067          	ret

000000008000596c <_ZN6Thread4joinEv>:
{
    8000596c:	ff010113          	addi	sp,sp,-16
    80005970:	00113423          	sd	ra,8(sp)
    80005974:	00813023          	sd	s0,0(sp)
    80005978:	01010413          	addi	s0,sp,16
    thread_join(myHandle);
    8000597c:	00853503          	ld	a0,8(a0)
    80005980:	ffffc097          	auipc	ra,0xffffc
    80005984:	26c080e7          	jalr	620(ra) # 80001bec <thread_join>
}
    80005988:	00813083          	ld	ra,8(sp)
    8000598c:	00013403          	ld	s0,0(sp)
    80005990:	01010113          	addi	sp,sp,16
    80005994:	00008067          	ret

0000000080005998 <_ZN6Thread8dispatchEv>:
{
    80005998:	ff010113          	addi	sp,sp,-16
    8000599c:	00113423          	sd	ra,8(sp)
    800059a0:	00813023          	sd	s0,0(sp)
    800059a4:	01010413          	addi	s0,sp,16
    thread_dispatch();
    800059a8:	ffffc097          	auipc	ra,0xffffc
    800059ac:	100080e7          	jalr	256(ra) # 80001aa8 <thread_dispatch>
}
    800059b0:	00813083          	ld	ra,8(sp)
    800059b4:	00013403          	ld	s0,0(sp)
    800059b8:	01010113          	addi	sp,sp,16
    800059bc:	00008067          	ret

00000000800059c0 <_ZN6ThreadC1Ev>:
Thread::Thread()
    800059c0:	ff010113          	addi	sp,sp,-16
    800059c4:	00813423          	sd	s0,8(sp)
    800059c8:	01010413          	addi	s0,sp,16
    800059cc:	00007797          	auipc	a5,0x7
    800059d0:	f6478793          	addi	a5,a5,-156 # 8000c930 <_ZTV6Thread+0x10>
    800059d4:	00f53023          	sd	a5,0(a0)
    body = nullptr;
    800059d8:	00053823          	sd	zero,16(a0)
    arg = nullptr;
    800059dc:	00053c23          	sd	zero,24(a0)
}
    800059e0:	00813403          	ld	s0,8(sp)
    800059e4:	01010113          	addi	sp,sp,16
    800059e8:	00008067          	ret

00000000800059ec <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t t) {
    800059ec:	ff010113          	addi	sp,sp,-16
    800059f0:	00113423          	sd	ra,8(sp)
    800059f4:	00813023          	sd	s0,0(sp)
    800059f8:	01010413          	addi	s0,sp,16
    int res = time_sleep(t);
    800059fc:	ffffc097          	auipc	ra,0xffffc
    80005a00:	284080e7          	jalr	644(ra) # 80001c80 <time_sleep>
}
    80005a04:	00813083          	ld	ra,8(sp)
    80005a08:	00013403          	ld	s0,0(sp)
    80005a0c:	01010113          	addi	sp,sp,16
    80005a10:	00008067          	ret

0000000080005a14 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init)
    80005a14:	ff010113          	addi	sp,sp,-16
    80005a18:	00113423          	sd	ra,8(sp)
    80005a1c:	00813023          	sd	s0,0(sp)
    80005a20:	01010413          	addi	s0,sp,16
    80005a24:	00007797          	auipc	a5,0x7
    80005a28:	f3478793          	addi	a5,a5,-204 # 8000c958 <_ZTV9Semaphore+0x10>
    80005a2c:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80005a30:	00850513          	addi	a0,a0,8
    80005a34:	ffffc097          	auipc	ra,0xffffc
    80005a38:	0d4080e7          	jalr	212(ra) # 80001b08 <sem_open>
}
    80005a3c:	00813083          	ld	ra,8(sp)
    80005a40:	00013403          	ld	s0,0(sp)
    80005a44:	01010113          	addi	sp,sp,16
    80005a48:	00008067          	ret

0000000080005a4c <_ZN9Semaphore4waitEv>:
{
    80005a4c:	ff010113          	addi	sp,sp,-16
    80005a50:	00113423          	sd	ra,8(sp)
    80005a54:	00813023          	sd	s0,0(sp)
    80005a58:	01010413          	addi	s0,sp,16
    int res = sem_wait(myHandle);
    80005a5c:	00853503          	ld	a0,8(a0)
    80005a60:	ffffc097          	auipc	ra,0xffffc
    80005a64:	11c080e7          	jalr	284(ra) # 80001b7c <sem_wait>
}
    80005a68:	00813083          	ld	ra,8(sp)
    80005a6c:	00013403          	ld	s0,0(sp)
    80005a70:	01010113          	addi	sp,sp,16
    80005a74:	00008067          	ret

0000000080005a78 <_ZN9Semaphore6signalEv>:
{
    80005a78:	ff010113          	addi	sp,sp,-16
    80005a7c:	00113423          	sd	ra,8(sp)
    80005a80:	00813023          	sd	s0,0(sp)
    80005a84:	01010413          	addi	s0,sp,16
    int res = sem_signal(myHandle);
    80005a88:	00853503          	ld	a0,8(a0)
    80005a8c:	ffffc097          	auipc	ra,0xffffc
    80005a90:	128080e7          	jalr	296(ra) # 80001bb4 <sem_signal>
}
    80005a94:	00813083          	ld	ra,8(sp)
    80005a98:	00013403          	ld	s0,0(sp)
    80005a9c:	01010113          	addi	sp,sp,16
    80005aa0:	00008067          	ret

0000000080005aa4 <_ZN7Console4getcEv>:
char Console::getc() {
    80005aa4:	ff010113          	addi	sp,sp,-16
    80005aa8:	00113423          	sd	ra,8(sp)
    80005aac:	00813023          	sd	s0,0(sp)
    80005ab0:	01010413          	addi	s0,sp,16
    return ::getc();
    80005ab4:	ffffc097          	auipc	ra,0xffffc
    80005ab8:	198080e7          	jalr	408(ra) # 80001c4c <getc>
}
    80005abc:	00813083          	ld	ra,8(sp)
    80005ac0:	00013403          	ld	s0,0(sp)
    80005ac4:	01010113          	addi	sp,sp,16
    80005ac8:	00008067          	ret

0000000080005acc <_ZN7Console4putcEc>:
void Console::putc(char c) {
    80005acc:	ff010113          	addi	sp,sp,-16
    80005ad0:	00113423          	sd	ra,8(sp)
    80005ad4:	00813023          	sd	s0,0(sp)
    80005ad8:	01010413          	addi	s0,sp,16
    ::putc(c);
    80005adc:	ffffc097          	auipc	ra,0xffffc
    80005ae0:	140080e7          	jalr	320(ra) # 80001c1c <putc>
}
    80005ae4:	00813083          	ld	ra,8(sp)
    80005ae8:	00013403          	ld	s0,0(sp)
    80005aec:	01010113          	addi	sp,sp,16
    80005af0:	00008067          	ret

0000000080005af4 <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period)
    80005af4:	fe010113          	addi	sp,sp,-32
    80005af8:	00113c23          	sd	ra,24(sp)
    80005afc:	00813823          	sd	s0,16(sp)
    80005b00:	00913423          	sd	s1,8(sp)
    80005b04:	01213023          	sd	s2,0(sp)
    80005b08:	02010413          	addi	s0,sp,32
    80005b0c:	00050493          	mv	s1,a0
    80005b10:	00058913          	mv	s2,a1
    80005b14:	00000097          	auipc	ra,0x0
    80005b18:	eac080e7          	jalr	-340(ra) # 800059c0 <_ZN6ThreadC1Ev>
    80005b1c:	00007797          	auipc	a5,0x7
    80005b20:	e5c78793          	addi	a5,a5,-420 # 8000c978 <_ZTV14PeriodicThread+0x10>
    80005b24:	00f4b023          	sd	a5,0(s1)
    flag = false;
    80005b28:	02048423          	sb	zero,40(s1)
    this->period = period;
    80005b2c:	0324b023          	sd	s2,32(s1)
}
    80005b30:	01813083          	ld	ra,24(sp)
    80005b34:	01013403          	ld	s0,16(sp)
    80005b38:	00813483          	ld	s1,8(sp)
    80005b3c:	00013903          	ld	s2,0(sp)
    80005b40:	02010113          	addi	sp,sp,32
    80005b44:	00008067          	ret

0000000080005b48 <_ZN14PeriodicThread9terminateEv>:

void PeriodicThread::terminate()
{
    80005b48:	fe010113          	addi	sp,sp,-32
    80005b4c:	00113c23          	sd	ra,24(sp)
    80005b50:	00813823          	sd	s0,16(sp)
    80005b54:	00913423          	sd	s1,8(sp)
    80005b58:	02010413          	addi	s0,sp,32
    80005b5c:	00050493          	mv	s1,a0
    disable_interrupt();
    80005b60:	ffffc097          	auipc	ra,0xffffc
    80005b64:	164080e7          	jalr	356(ra) # 80001cc4 <disable_interrupt>
    flag = false;
    80005b68:	02048423          	sb	zero,40(s1)
    enable_interrupt();
    80005b6c:	ffffc097          	auipc	ra,0xffffc
    80005b70:	184080e7          	jalr	388(ra) # 80001cf0 <enable_interrupt>
}
    80005b74:	01813083          	ld	ra,24(sp)
    80005b78:	01013403          	ld	s0,16(sp)
    80005b7c:	00813483          	ld	s1,8(sp)
    80005b80:	02010113          	addi	sp,sp,32
    80005b84:	00008067          	ret

0000000080005b88 <_ZN14PeriodicThreadD1Ev>:
    int signal ();
private:
    sem_t myHandle;
};

class PeriodicThread : public Thread {
    80005b88:	ff010113          	addi	sp,sp,-16
    80005b8c:	00113423          	sd	ra,8(sp)
    80005b90:	00813023          	sd	s0,0(sp)
    80005b94:	01010413          	addi	s0,sp,16
    80005b98:	00007797          	auipc	a5,0x7
    80005b9c:	de078793          	addi	a5,a5,-544 # 8000c978 <_ZTV14PeriodicThread+0x10>
    80005ba0:	00f53023          	sd	a5,0(a0)
    80005ba4:	00000097          	auipc	ra,0x0
    80005ba8:	b80080e7          	jalr	-1152(ra) # 80005724 <_ZN6ThreadD1Ev>
    80005bac:	00813083          	ld	ra,8(sp)
    80005bb0:	00013403          	ld	s0,0(sp)
    80005bb4:	01010113          	addi	sp,sp,16
    80005bb8:	00008067          	ret

0000000080005bbc <_ZN14PeriodicThreadD0Ev>:
    80005bbc:	fe010113          	addi	sp,sp,-32
    80005bc0:	00113c23          	sd	ra,24(sp)
    80005bc4:	00813823          	sd	s0,16(sp)
    80005bc8:	00913423          	sd	s1,8(sp)
    80005bcc:	02010413          	addi	s0,sp,32
    80005bd0:	00050493          	mv	s1,a0
    80005bd4:	00007797          	auipc	a5,0x7
    80005bd8:	da478793          	addi	a5,a5,-604 # 8000c978 <_ZTV14PeriodicThread+0x10>
    80005bdc:	00f53023          	sd	a5,0(a0)
    80005be0:	00000097          	auipc	ra,0x0
    80005be4:	b44080e7          	jalr	-1212(ra) # 80005724 <_ZN6ThreadD1Ev>
    80005be8:	00048513          	mv	a0,s1
    80005bec:	00000097          	auipc	ra,0x0
    80005bf0:	c74080e7          	jalr	-908(ra) # 80005860 <_ZdlPv>
    80005bf4:	01813083          	ld	ra,24(sp)
    80005bf8:	01013403          	ld	s0,16(sp)
    80005bfc:	00813483          	ld	s1,8(sp)
    80005c00:	02010113          	addi	sp,sp,32
    80005c04:	00008067          	ret

0000000080005c08 <_ZL9sleepyRunPv>:
#include "../test/printing.hpp"
#include "../h/syscall_c.hpp"

static volatile bool finished[2];

static void sleepyRun(void *arg) {
    80005c08:	fe010113          	addi	sp,sp,-32
    80005c0c:	00113c23          	sd	ra,24(sp)
    80005c10:	00813823          	sd	s0,16(sp)
    80005c14:	00913423          	sd	s1,8(sp)
    80005c18:	01213023          	sd	s2,0(sp)
    80005c1c:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    80005c20:	00053903          	ld	s2,0(a0)
    int i = 6;
    80005c24:	00600493          	li	s1,6
    while (--i > 0) {
    80005c28:	fff4849b          	addiw	s1,s1,-1
    80005c2c:	04905463          	blez	s1,80005c74 <_ZL9sleepyRunPv+0x6c>

        printString("Hello ");
    80005c30:	00005517          	auipc	a0,0x5
    80005c34:	87050513          	addi	a0,a0,-1936 # 8000a4a0 <CONSOLE_STATUS+0x490>
    80005c38:	fffff097          	auipc	ra,0xfffff
    80005c3c:	ebc080e7          	jalr	-324(ra) # 80004af4 <_Z11printStringPKc>
        printInt(sleep_time);
    80005c40:	00000613          	li	a2,0
    80005c44:	00a00593          	li	a1,10
    80005c48:	0009051b          	sext.w	a0,s2
    80005c4c:	fffff097          	auipc	ra,0xfffff
    80005c50:	058080e7          	jalr	88(ra) # 80004ca4 <_Z8printIntiii>
        printString(" !\n");
    80005c54:	00005517          	auipc	a0,0x5
    80005c58:	85450513          	addi	a0,a0,-1964 # 8000a4a8 <CONSOLE_STATUS+0x498>
    80005c5c:	fffff097          	auipc	ra,0xfffff
    80005c60:	e98080e7          	jalr	-360(ra) # 80004af4 <_Z11printStringPKc>
        time_sleep(sleep_time);
    80005c64:	00090513          	mv	a0,s2
    80005c68:	ffffc097          	auipc	ra,0xffffc
    80005c6c:	018080e7          	jalr	24(ra) # 80001c80 <time_sleep>
    while (--i > 0) {
    80005c70:	fb9ff06f          	j	80005c28 <_ZL9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    80005c74:	00a00793          	li	a5,10
    80005c78:	02f95933          	divu	s2,s2,a5
    80005c7c:	fff90913          	addi	s2,s2,-1
    80005c80:	00007797          	auipc	a5,0x7
    80005c84:	e5078793          	addi	a5,a5,-432 # 8000cad0 <_ZL8finished>
    80005c88:	01278933          	add	s2,a5,s2
    80005c8c:	00100793          	li	a5,1
    80005c90:	00f90023          	sb	a5,0(s2)
}
    80005c94:	01813083          	ld	ra,24(sp)
    80005c98:	01013403          	ld	s0,16(sp)
    80005c9c:	00813483          	ld	s1,8(sp)
    80005ca0:	00013903          	ld	s2,0(sp)
    80005ca4:	02010113          	addi	sp,sp,32
    80005ca8:	00008067          	ret

0000000080005cac <_Z12testSleepingv>:

void testSleeping() {
    80005cac:	fc010113          	addi	sp,sp,-64
    80005cb0:	02113c23          	sd	ra,56(sp)
    80005cb4:	02813823          	sd	s0,48(sp)
    80005cb8:	02913423          	sd	s1,40(sp)
    80005cbc:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    80005cc0:	00a00793          	li	a5,10
    80005cc4:	fcf43823          	sd	a5,-48(s0)
    80005cc8:	01400793          	li	a5,20
    80005ccc:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    80005cd0:	00000493          	li	s1,0
    80005cd4:	02c0006f          	j	80005d00 <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    80005cd8:	00349793          	slli	a5,s1,0x3
    80005cdc:	fd040613          	addi	a2,s0,-48
    80005ce0:	00f60633          	add	a2,a2,a5
    80005ce4:	00000597          	auipc	a1,0x0
    80005ce8:	f2458593          	addi	a1,a1,-220 # 80005c08 <_ZL9sleepyRunPv>
    80005cec:	fc040513          	addi	a0,s0,-64
    80005cf0:	00f50533          	add	a0,a0,a5
    80005cf4:	ffffc097          	auipc	ra,0xffffc
    80005cf8:	d74080e7          	jalr	-652(ra) # 80001a68 <thread_create>
    for (int i = 0; i < sleepy_thread_count; i++) {
    80005cfc:	0014849b          	addiw	s1,s1,1
    80005d00:	00100793          	li	a5,1
    80005d04:	fc97dae3          	bge	a5,s1,80005cd8 <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    80005d08:	00007797          	auipc	a5,0x7
    80005d0c:	dc87c783          	lbu	a5,-568(a5) # 8000cad0 <_ZL8finished>
    80005d10:	fe078ce3          	beqz	a5,80005d08 <_Z12testSleepingv+0x5c>
    80005d14:	00007797          	auipc	a5,0x7
    80005d18:	dbd7c783          	lbu	a5,-579(a5) # 8000cad1 <_ZL8finished+0x1>
    80005d1c:	fe0786e3          	beqz	a5,80005d08 <_Z12testSleepingv+0x5c>
}
    80005d20:	03813083          	ld	ra,56(sp)
    80005d24:	03013403          	ld	s0,48(sp)
    80005d28:	02813483          	ld	s1,40(sp)
    80005d2c:	04010113          	addi	sp,sp,64
    80005d30:	00008067          	ret

0000000080005d34 <_ZN4_sem16semaphore_createEj>:
#include "../h/_sem.hpp"
#include "../h/Scheduler.hpp"
#include "../h/_thread.hpp"

sem_t _sem::semaphore_create(unsigned init) {
    80005d34:	fe010113          	addi	sp,sp,-32
    80005d38:	00113c23          	sd	ra,24(sp)
    80005d3c:	00813823          	sd	s0,16(sp)
    80005d40:	00913423          	sd	s1,8(sp)
    80005d44:	01213023          	sd	s2,0(sp)
    80005d48:	02010413          	addi	s0,sp,32
    80005d4c:	00050913          	mv	s2,a0
    sem_t semaphore = (sem_t)MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(sizeof(_sem)));
    80005d50:	00001097          	auipc	ra,0x1
    80005d54:	9e4080e7          	jalr	-1564(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80005d58:	00050493          	mv	s1,a0
    80005d5c:	01000513          	li	a0,16
    80005d60:	00001097          	auipc	ra,0x1
    80005d64:	d24080e7          	jalr	-732(ra) # 80006a84 <_ZN15MemoryAllocator19__convert_to_blocksEm>
    80005d68:	00050593          	mv	a1,a0
    80005d6c:	00048513          	mv	a0,s1
    80005d70:	00001097          	auipc	ra,0x1
    80005d74:	a68080e7          	jalr	-1432(ra) # 800067d8 <_ZN15MemoryAllocator11__mem_allocEm>
    80005d78:	00050493          	mv	s1,a0
    if (!semaphore)
    80005d7c:	00050c63          	beqz	a0,80005d94 <_ZN4_sem16semaphore_createEj+0x60>
        return nullptr;

    semaphore->value = (int)init;
    80005d80:	01252023          	sw	s2,0(a0)
    semaphore->blocked = List<_thread>::list_create();
    80005d84:	00000097          	auipc	ra,0x0
    80005d88:	234080e7          	jalr	564(ra) # 80005fb8 <_ZN4ListI7_threadE11list_createEv>
    80005d8c:	00a4b423          	sd	a0,8(s1)
    if (!semaphore->blocked)
    80005d90:	02050063          	beqz	a0,80005db0 <_ZN4_sem16semaphore_createEj+0x7c>
        return nullptr;

    return semaphore;
}
    80005d94:	00048513          	mv	a0,s1
    80005d98:	01813083          	ld	ra,24(sp)
    80005d9c:	01013403          	ld	s0,16(sp)
    80005da0:	00813483          	ld	s1,8(sp)
    80005da4:	00013903          	ld	s2,0(sp)
    80005da8:	02010113          	addi	sp,sp,32
    80005dac:	00008067          	ret
        return nullptr;
    80005db0:	00050493          	mv	s1,a0
    80005db4:	fe1ff06f          	j	80005d94 <_ZN4_sem16semaphore_createEj+0x60>

0000000080005db8 <_ZN4_sem5closeEPS_N7_thread14semReturnValueE>:

int _sem::close(sem_t semaphore, _thread::semReturnValue returnValue) {
    80005db8:	fd010113          	addi	sp,sp,-48
    80005dbc:	02113423          	sd	ra,40(sp)
    80005dc0:	02813023          	sd	s0,32(sp)
    80005dc4:	00913c23          	sd	s1,24(sp)
    80005dc8:	01213823          	sd	s2,16(sp)
    80005dcc:	01313423          	sd	s3,8(sp)
    80005dd0:	03010413          	addi	s0,sp,48
    80005dd4:	00050913          	mv	s2,a0
    80005dd8:	00058993          	mv	s3,a1
    while (!semaphore->blocked->empty())
    80005ddc:	00893483          	ld	s1,8(s2)
    80005de0:	00048513          	mv	a0,s1
    80005de4:	00000097          	auipc	ra,0x0
    80005de8:	234080e7          	jalr	564(ra) # 80006018 <_ZN4ListI7_threadE5emptyEv>
    80005dec:	02051a63          	bnez	a0,80005e20 <_ZN4_sem5closeEPS_N7_thread14semReturnValueE+0x68>
    {
        thread_t thread = semaphore->blocked->get();
    80005df0:	00048513          	mv	a0,s1
    80005df4:	00000097          	auipc	ra,0x0
    80005df8:	244080e7          	jalr	580(ra) # 80006038 <_ZN4ListI7_threadE3getEv>
        if (!thread)
    80005dfc:	04050e63          	beqz	a0,80005e58 <_ZN4_sem5closeEPS_N7_thread14semReturnValueE+0xa0>
            return -1;
        thread->currentState = _thread::READY;
    80005e00:	00100793          	li	a5,1
    80005e04:	12f52e23          	sw	a5,316(a0)
        thread->state = returnValue;
    80005e08:	13352c23          	sw	s3,312(a0)
        int res = Scheduler::put(thread);
    80005e0c:	fffff097          	auipc	ra,0xfffff
    80005e10:	504080e7          	jalr	1284(ra) # 80005310 <_ZN9Scheduler3putEP7_thread>
        if (res < 0)
    80005e14:	fc0554e3          	bgez	a0,80005ddc <_ZN4_sem5closeEPS_N7_thread14semReturnValueE+0x24>
            return -2;
    80005e18:	ffe00513          	li	a0,-2
    80005e1c:	0200006f          	j	80005e3c <_ZN4_sem5closeEPS_N7_thread14semReturnValueE+0x84>
    }
    int res = MemoryAllocator::__get_instance()->__mem_free(semaphore);
    80005e20:	00001097          	auipc	ra,0x1
    80005e24:	914080e7          	jalr	-1772(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80005e28:	00090593          	mv	a1,s2
    80005e2c:	00001097          	auipc	ra,0x1
    80005e30:	af8080e7          	jalr	-1288(ra) # 80006924 <_ZN15MemoryAllocator10__mem_freeEPv>
    if (res < 0)
    80005e34:	02054663          	bltz	a0,80005e60 <_ZN4_sem5closeEPS_N7_thread14semReturnValueE+0xa8>
        return -3;

    return 0;
    80005e38:	00000513          	li	a0,0
}
    80005e3c:	02813083          	ld	ra,40(sp)
    80005e40:	02013403          	ld	s0,32(sp)
    80005e44:	01813483          	ld	s1,24(sp)
    80005e48:	01013903          	ld	s2,16(sp)
    80005e4c:	00813983          	ld	s3,8(sp)
    80005e50:	03010113          	addi	sp,sp,48
    80005e54:	00008067          	ret
            return -1;
    80005e58:	fff00513          	li	a0,-1
    80005e5c:	fe1ff06f          	j	80005e3c <_ZN4_sem5closeEPS_N7_thread14semReturnValueE+0x84>
        return -3;
    80005e60:	ffd00513          	li	a0,-3
    80005e64:	fd9ff06f          	j	80005e3c <_ZN4_sem5closeEPS_N7_thread14semReturnValueE+0x84>

0000000080005e68 <_ZN4_sem6signalEPS_>:

    return 0;
}

int _sem::signal(sem_t semaphore) {
    ++semaphore->value;
    80005e68:	00052783          	lw	a5,0(a0)
    80005e6c:	0017879b          	addiw	a5,a5,1
    80005e70:	0007871b          	sext.w	a4,a5
    80005e74:	00f52023          	sw	a5,0(a0)
    if (semaphore->value <= 0 && !semaphore->blocked->empty()) {
    80005e78:	00e05663          	blez	a4,80005e84 <_ZN4_sem6signalEPS_+0x1c>
        int res = Scheduler::put(thread);
        if (res < 0)
            return -1;
    }

    return 0;
    80005e7c:	00000513          	li	a0,0
}
    80005e80:	00008067          	ret
int _sem::signal(sem_t semaphore) {
    80005e84:	fe010113          	addi	sp,sp,-32
    80005e88:	00113c23          	sd	ra,24(sp)
    80005e8c:	00813823          	sd	s0,16(sp)
    80005e90:	00913423          	sd	s1,8(sp)
    80005e94:	02010413          	addi	s0,sp,32
    if (semaphore->value <= 0 && !semaphore->blocked->empty()) {
    80005e98:	00853483          	ld	s1,8(a0)
    80005e9c:	00048513          	mv	a0,s1
    80005ea0:	00000097          	auipc	ra,0x0
    80005ea4:	178080e7          	jalr	376(ra) # 80006018 <_ZN4ListI7_threadE5emptyEv>
    80005ea8:	00050e63          	beqz	a0,80005ec4 <_ZN4_sem6signalEPS_+0x5c>
    return 0;
    80005eac:	00000513          	li	a0,0
}
    80005eb0:	01813083          	ld	ra,24(sp)
    80005eb4:	01013403          	ld	s0,16(sp)
    80005eb8:	00813483          	ld	s1,8(sp)
    80005ebc:	02010113          	addi	sp,sp,32
    80005ec0:	00008067          	ret
        thread_t thread = semaphore->blocked->get();
    80005ec4:	00048513          	mv	a0,s1
    80005ec8:	00000097          	auipc	ra,0x0
    80005ecc:	170080e7          	jalr	368(ra) # 80006038 <_ZN4ListI7_threadE3getEv>
        thread->currentState = _thread::READY;
    80005ed0:	00100793          	li	a5,1
    80005ed4:	12f52e23          	sw	a5,316(a0)
        int res = Scheduler::put(thread);
    80005ed8:	fffff097          	auipc	ra,0xfffff
    80005edc:	438080e7          	jalr	1080(ra) # 80005310 <_ZN9Scheduler3putEP7_thread>
        if (res < 0)
    80005ee0:	00054663          	bltz	a0,80005eec <_ZN4_sem6signalEPS_+0x84>
    return 0;
    80005ee4:	00000513          	li	a0,0
    80005ee8:	fc9ff06f          	j	80005eb0 <_ZN4_sem6signalEPS_+0x48>
            return -1;
    80005eec:	fff00513          	li	a0,-1
    80005ef0:	fc1ff06f          	j	80005eb0 <_ZN4_sem6signalEPS_+0x48>

0000000080005ef4 <_ZN4_sem4waitEPS_>:
    _thread::running->state = _thread::ZERO;
    80005ef4:	00007797          	auipc	a5,0x7
    80005ef8:	ac47b783          	ld	a5,-1340(a5) # 8000c9b8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80005efc:	0007b783          	ld	a5,0(a5)
    80005f00:	1207ac23          	sw	zero,312(a5)
    --semaphore->value;
    80005f04:	00052783          	lw	a5,0(a0)
    80005f08:	fff7879b          	addiw	a5,a5,-1
    80005f0c:	00f52023          	sw	a5,0(a0)
    if (semaphore->value < 0)
    80005f10:	02079713          	slli	a4,a5,0x20
    80005f14:	02074263          	bltz	a4,80005f38 <_ZN4_sem4waitEPS_+0x44>
    if (_thread::running->state == _thread::SEMCLOSED)
    80005f18:	00007797          	auipc	a5,0x7
    80005f1c:	aa07b783          	ld	a5,-1376(a5) # 8000c9b8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80005f20:	0007b783          	ld	a5,0(a5)
    80005f24:	1387a703          	lw	a4,312(a5)
    80005f28:	00100793          	li	a5,1
    80005f2c:	08f70263          	beq	a4,a5,80005fb0 <_ZN4_sem4waitEPS_+0xbc>
    return 0;
    80005f30:	00000513          	li	a0,0
    80005f34:	00008067          	ret
int _sem::wait(sem_t semaphore) {
    80005f38:	ff010113          	addi	sp,sp,-16
    80005f3c:	00113423          	sd	ra,8(sp)
    80005f40:	00813023          	sd	s0,0(sp)
    80005f44:	01010413          	addi	s0,sp,16
        _thread::running->currentState = _thread::BLOCKED;
    80005f48:	00007797          	auipc	a5,0x7
    80005f4c:	a707b783          	ld	a5,-1424(a5) # 8000c9b8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80005f50:	0007b583          	ld	a1,0(a5)
    80005f54:	00200793          	li	a5,2
    80005f58:	12f5ae23          	sw	a5,316(a1)
        int res = semaphore->blocked->put(_thread::running);
    80005f5c:	00853503          	ld	a0,8(a0)
    80005f60:	00000097          	auipc	ra,0x0
    80005f64:	154080e7          	jalr	340(ra) # 800060b4 <_ZN4ListI7_threadE3putEPS0_>
        if (res < 0)
    80005f68:	02054c63          	bltz	a0,80005fa0 <_ZN4_sem4waitEPS_+0xac>
        _thread::dispatch();
    80005f6c:	ffffc097          	auipc	ra,0xffffc
    80005f70:	2e8080e7          	jalr	744(ra) # 80002254 <_ZN7_thread8dispatchEv>
    if (_thread::running->state == _thread::SEMCLOSED)
    80005f74:	00007797          	auipc	a5,0x7
    80005f78:	a447b783          	ld	a5,-1468(a5) # 8000c9b8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80005f7c:	0007b783          	ld	a5,0(a5)
    80005f80:	1387a703          	lw	a4,312(a5)
    80005f84:	00100793          	li	a5,1
    80005f88:	02f70063          	beq	a4,a5,80005fa8 <_ZN4_sem4waitEPS_+0xb4>
    return 0;
    80005f8c:	00000513          	li	a0,0
}
    80005f90:	00813083          	ld	ra,8(sp)
    80005f94:	00013403          	ld	s0,0(sp)
    80005f98:	01010113          	addi	sp,sp,16
    80005f9c:	00008067          	ret
            return -1;
    80005fa0:	fff00513          	li	a0,-1
    80005fa4:	fedff06f          	j	80005f90 <_ZN4_sem4waitEPS_+0x9c>
        return -2;
    80005fa8:	ffe00513          	li	a0,-2
    80005fac:	fe5ff06f          	j	80005f90 <_ZN4_sem4waitEPS_+0x9c>
    80005fb0:	ffe00513          	li	a0,-2
}
    80005fb4:	00008067          	ret

0000000080005fb8 <_ZN4ListI7_threadE11list_createEv>:
List<T> *List<T>::list_create() {
    80005fb8:	fe010113          	addi	sp,sp,-32
    80005fbc:	00113c23          	sd	ra,24(sp)
    80005fc0:	00813823          	sd	s0,16(sp)
    80005fc4:	00913423          	sd	s1,8(sp)
    80005fc8:	02010413          	addi	s0,sp,32
    List<T>* list = (List<T>*)MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(sizeof(List<T>)));
    80005fcc:	00000097          	auipc	ra,0x0
    80005fd0:	768080e7          	jalr	1896(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80005fd4:	00050493          	mv	s1,a0
    80005fd8:	01800513          	li	a0,24
    80005fdc:	00001097          	auipc	ra,0x1
    80005fe0:	aa8080e7          	jalr	-1368(ra) # 80006a84 <_ZN15MemoryAllocator19__convert_to_blocksEm>
    80005fe4:	00050593          	mv	a1,a0
    80005fe8:	00048513          	mv	a0,s1
    80005fec:	00000097          	auipc	ra,0x0
    80005ff0:	7ec080e7          	jalr	2028(ra) # 800067d8 <_ZN15MemoryAllocator11__mem_allocEm>
    if (!list)
    80005ff4:	00050863          	beqz	a0,80006004 <_ZN4ListI7_threadE11list_createEv+0x4c>
    list->head = nullptr;
    80005ff8:	00053023          	sd	zero,0(a0)
    list->tail = nullptr;
    80005ffc:	00053423          	sd	zero,8(a0)
    list->tmp = nullptr;
    80006000:	00053823          	sd	zero,16(a0)
}
    80006004:	01813083          	ld	ra,24(sp)
    80006008:	01013403          	ld	s0,16(sp)
    8000600c:	00813483          	ld	s1,8(sp)
    80006010:	02010113          	addi	sp,sp,32
    80006014:	00008067          	ret

0000000080006018 <_ZN4ListI7_threadE5emptyEv>:
bool List<T>::empty() {
    80006018:	ff010113          	addi	sp,sp,-16
    8000601c:	00813423          	sd	s0,8(sp)
    80006020:	01010413          	addi	s0,sp,16
    return head == nullptr;
    80006024:	00053503          	ld	a0,0(a0)
}
    80006028:	00153513          	seqz	a0,a0
    8000602c:	00813403          	ld	s0,8(sp)
    80006030:	01010113          	addi	sp,sp,16
    80006034:	00008067          	ret

0000000080006038 <_ZN4ListI7_threadE3getEv>:
T* List<T>::get() {
    80006038:	fe010113          	addi	sp,sp,-32
    8000603c:	00113c23          	sd	ra,24(sp)
    80006040:	00813823          	sd	s0,16(sp)
    80006044:	00913423          	sd	s1,8(sp)
    80006048:	01213023          	sd	s2,0(sp)
    8000604c:	02010413          	addi	s0,sp,32
    if (!head)
    80006050:	00053483          	ld	s1,0(a0)
    80006054:	04048863          	beqz	s1,800060a4 <_ZN4ListI7_threadE3getEv+0x6c>
    T* elem = head->elem;
    80006058:	0004b903          	ld	s2,0(s1)
    head = head->next;
    8000605c:	0084b783          	ld	a5,8(s1)
    80006060:	00f53023          	sd	a5,0(a0)
    if (!head)
    80006064:	02078c63          	beqz	a5,8000609c <_ZN4ListI7_threadE3getEv+0x64>
    int res = MemoryAllocator::__get_instance()->__mem_free(oldHead);
    80006068:	00000097          	auipc	ra,0x0
    8000606c:	6cc080e7          	jalr	1740(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80006070:	00048593          	mv	a1,s1
    80006074:	00001097          	auipc	ra,0x1
    80006078:	8b0080e7          	jalr	-1872(ra) # 80006924 <_ZN15MemoryAllocator10__mem_freeEPv>
    if (res < 0)
    8000607c:	02054863          	bltz	a0,800060ac <_ZN4ListI7_threadE3getEv+0x74>
}
    80006080:	00090513          	mv	a0,s2
    80006084:	01813083          	ld	ra,24(sp)
    80006088:	01013403          	ld	s0,16(sp)
    8000608c:	00813483          	ld	s1,8(sp)
    80006090:	00013903          	ld	s2,0(sp)
    80006094:	02010113          	addi	sp,sp,32
    80006098:	00008067          	ret
        tail = nullptr;
    8000609c:	00053423          	sd	zero,8(a0)
    800060a0:	fc9ff06f          	j	80006068 <_ZN4ListI7_threadE3getEv+0x30>
        return nullptr;
    800060a4:	00048913          	mv	s2,s1
    800060a8:	fd9ff06f          	j	80006080 <_ZN4ListI7_threadE3getEv+0x48>
        return nullptr; // ili nesto drugo
    800060ac:	00000913          	li	s2,0
    800060b0:	fd1ff06f          	j	80006080 <_ZN4ListI7_threadE3getEv+0x48>

00000000800060b4 <_ZN4ListI7_threadE3putEPS0_>:

template<typename T>
int List<T>::put(T* elem) {
    800060b4:	fd010113          	addi	sp,sp,-48
    800060b8:	02113423          	sd	ra,40(sp)
    800060bc:	02813023          	sd	s0,32(sp)
    800060c0:	00913c23          	sd	s1,24(sp)
    800060c4:	01213823          	sd	s2,16(sp)
    800060c8:	01313423          	sd	s3,8(sp)
    800060cc:	03010413          	addi	s0,sp,48
    800060d0:	00050493          	mv	s1,a0
    800060d4:	00058993          	mv	s3,a1
    Node* newNode = (Node*)(MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(sizeof(Node))));
    800060d8:	00000097          	auipc	ra,0x0
    800060dc:	65c080e7          	jalr	1628(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    800060e0:	00050913          	mv	s2,a0
    800060e4:	01000513          	li	a0,16
    800060e8:	00001097          	auipc	ra,0x1
    800060ec:	99c080e7          	jalr	-1636(ra) # 80006a84 <_ZN15MemoryAllocator19__convert_to_blocksEm>
    800060f0:	00050593          	mv	a1,a0
    800060f4:	00090513          	mv	a0,s2
    800060f8:	00000097          	auipc	ra,0x0
    800060fc:	6e0080e7          	jalr	1760(ra) # 800067d8 <_ZN15MemoryAllocator11__mem_allocEm>
    if (!newNode)
    80006100:	04050263          	beqz	a0,80006144 <_ZN4ListI7_threadE3putEPS0_+0x90>
        return -1;

    newNode->elem = elem;
    80006104:	01353023          	sd	s3,0(a0)
    newNode->next = nullptr;
    80006108:	00053423          	sd	zero,8(a0)

    if (tail)
    8000610c:	0084b783          	ld	a5,8(s1)
    80006110:	02078663          	beqz	a5,8000613c <_ZN4ListI7_threadE3putEPS0_+0x88>
        tail->next = newNode;
    80006114:	00a7b423          	sd	a0,8(a5)
    else
        head = newNode;
    tail = newNode;
    80006118:	00a4b423          	sd	a0,8(s1)

    return 0;
    8000611c:	00000513          	li	a0,0
}
    80006120:	02813083          	ld	ra,40(sp)
    80006124:	02013403          	ld	s0,32(sp)
    80006128:	01813483          	ld	s1,24(sp)
    8000612c:	01013903          	ld	s2,16(sp)
    80006130:	00813983          	ld	s3,8(sp)
    80006134:	03010113          	addi	sp,sp,48
    80006138:	00008067          	ret
        head = newNode;
    8000613c:	00a4b023          	sd	a0,0(s1)
    80006140:	fd9ff06f          	j	80006118 <_ZN4ListI7_threadE3putEPS0_+0x64>
        return -1;
    80006144:	fff00513          	li	a0,-1
    80006148:	fd9ff06f          	j	80006120 <_ZN4ListI7_threadE3putEPS0_+0x6c>

000000008000614c <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    8000614c:	fe010113          	addi	sp,sp,-32
    80006150:	00113c23          	sd	ra,24(sp)
    80006154:	00813823          	sd	s0,16(sp)
    80006158:	00913423          	sd	s1,8(sp)
    8000615c:	01213023          	sd	s2,0(sp)
    80006160:	02010413          	addi	s0,sp,32
    80006164:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80006168:	00100793          	li	a5,1
    8000616c:	02a7f863          	bgeu	a5,a0,8000619c <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80006170:	00a00793          	li	a5,10
    80006174:	02f577b3          	remu	a5,a0,a5
    80006178:	02078e63          	beqz	a5,800061b4 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    8000617c:	fff48513          	addi	a0,s1,-1
    80006180:	00000097          	auipc	ra,0x0
    80006184:	fcc080e7          	jalr	-52(ra) # 8000614c <_ZL9fibonaccim>
    80006188:	00050913          	mv	s2,a0
    8000618c:	ffe48513          	addi	a0,s1,-2
    80006190:	00000097          	auipc	ra,0x0
    80006194:	fbc080e7          	jalr	-68(ra) # 8000614c <_ZL9fibonaccim>
    80006198:	00a90533          	add	a0,s2,a0
}
    8000619c:	01813083          	ld	ra,24(sp)
    800061a0:	01013403          	ld	s0,16(sp)
    800061a4:	00813483          	ld	s1,8(sp)
    800061a8:	00013903          	ld	s2,0(sp)
    800061ac:	02010113          	addi	sp,sp,32
    800061b0:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    800061b4:	ffffc097          	auipc	ra,0xffffc
    800061b8:	8f4080e7          	jalr	-1804(ra) # 80001aa8 <thread_dispatch>
    800061bc:	fc1ff06f          	j	8000617c <_ZL9fibonaccim+0x30>

00000000800061c0 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    800061c0:	fe010113          	addi	sp,sp,-32
    800061c4:	00113c23          	sd	ra,24(sp)
    800061c8:	00813823          	sd	s0,16(sp)
    800061cc:	00913423          	sd	s1,8(sp)
    800061d0:	01213023          	sd	s2,0(sp)
    800061d4:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800061d8:	00a00493          	li	s1,10
    800061dc:	0400006f          	j	8000621c <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800061e0:	00004517          	auipc	a0,0x4
    800061e4:	f9850513          	addi	a0,a0,-104 # 8000a178 <CONSOLE_STATUS+0x168>
    800061e8:	fffff097          	auipc	ra,0xfffff
    800061ec:	90c080e7          	jalr	-1780(ra) # 80004af4 <_Z11printStringPKc>
    800061f0:	00000613          	li	a2,0
    800061f4:	00a00593          	li	a1,10
    800061f8:	00048513          	mv	a0,s1
    800061fc:	fffff097          	auipc	ra,0xfffff
    80006200:	aa8080e7          	jalr	-1368(ra) # 80004ca4 <_Z8printIntiii>
    80006204:	00004517          	auipc	a0,0x4
    80006208:	16450513          	addi	a0,a0,356 # 8000a368 <CONSOLE_STATUS+0x358>
    8000620c:	fffff097          	auipc	ra,0xfffff
    80006210:	8e8080e7          	jalr	-1816(ra) # 80004af4 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80006214:	0014849b          	addiw	s1,s1,1
    80006218:	0ff4f493          	andi	s1,s1,255
    8000621c:	00c00793          	li	a5,12
    80006220:	fc97f0e3          	bgeu	a5,s1,800061e0 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80006224:	00004517          	auipc	a0,0x4
    80006228:	f5c50513          	addi	a0,a0,-164 # 8000a180 <CONSOLE_STATUS+0x170>
    8000622c:	fffff097          	auipc	ra,0xfffff
    80006230:	8c8080e7          	jalr	-1848(ra) # 80004af4 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80006234:	00500313          	li	t1,5
    thread_dispatch();
    80006238:	ffffc097          	auipc	ra,0xffffc
    8000623c:	870080e7          	jalr	-1936(ra) # 80001aa8 <thread_dispatch>

    uint64 result = fibonacci(16);
    80006240:	01000513          	li	a0,16
    80006244:	00000097          	auipc	ra,0x0
    80006248:	f08080e7          	jalr	-248(ra) # 8000614c <_ZL9fibonaccim>
    8000624c:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80006250:	00004517          	auipc	a0,0x4
    80006254:	f4050513          	addi	a0,a0,-192 # 8000a190 <CONSOLE_STATUS+0x180>
    80006258:	fffff097          	auipc	ra,0xfffff
    8000625c:	89c080e7          	jalr	-1892(ra) # 80004af4 <_Z11printStringPKc>
    80006260:	00000613          	li	a2,0
    80006264:	00a00593          	li	a1,10
    80006268:	0009051b          	sext.w	a0,s2
    8000626c:	fffff097          	auipc	ra,0xfffff
    80006270:	a38080e7          	jalr	-1480(ra) # 80004ca4 <_Z8printIntiii>
    80006274:	00004517          	auipc	a0,0x4
    80006278:	0f450513          	addi	a0,a0,244 # 8000a368 <CONSOLE_STATUS+0x358>
    8000627c:	fffff097          	auipc	ra,0xfffff
    80006280:	878080e7          	jalr	-1928(ra) # 80004af4 <_Z11printStringPKc>
    80006284:	0400006f          	j	800062c4 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80006288:	00004517          	auipc	a0,0x4
    8000628c:	ef050513          	addi	a0,a0,-272 # 8000a178 <CONSOLE_STATUS+0x168>
    80006290:	fffff097          	auipc	ra,0xfffff
    80006294:	864080e7          	jalr	-1948(ra) # 80004af4 <_Z11printStringPKc>
    80006298:	00000613          	li	a2,0
    8000629c:	00a00593          	li	a1,10
    800062a0:	00048513          	mv	a0,s1
    800062a4:	fffff097          	auipc	ra,0xfffff
    800062a8:	a00080e7          	jalr	-1536(ra) # 80004ca4 <_Z8printIntiii>
    800062ac:	00004517          	auipc	a0,0x4
    800062b0:	0bc50513          	addi	a0,a0,188 # 8000a368 <CONSOLE_STATUS+0x358>
    800062b4:	fffff097          	auipc	ra,0xfffff
    800062b8:	840080e7          	jalr	-1984(ra) # 80004af4 <_Z11printStringPKc>
    for (; i < 16; i++) {
    800062bc:	0014849b          	addiw	s1,s1,1
    800062c0:	0ff4f493          	andi	s1,s1,255
    800062c4:	00f00793          	li	a5,15
    800062c8:	fc97f0e3          	bgeu	a5,s1,80006288 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    800062cc:	00004517          	auipc	a0,0x4
    800062d0:	ed450513          	addi	a0,a0,-300 # 8000a1a0 <CONSOLE_STATUS+0x190>
    800062d4:	fffff097          	auipc	ra,0xfffff
    800062d8:	820080e7          	jalr	-2016(ra) # 80004af4 <_Z11printStringPKc>
    finishedD = true;
    800062dc:	00100793          	li	a5,1
    800062e0:	00006717          	auipc	a4,0x6
    800062e4:	7ef70923          	sb	a5,2034(a4) # 8000cad2 <_ZL9finishedD>
    thread_dispatch();
    800062e8:	ffffb097          	auipc	ra,0xffffb
    800062ec:	7c0080e7          	jalr	1984(ra) # 80001aa8 <thread_dispatch>
}
    800062f0:	01813083          	ld	ra,24(sp)
    800062f4:	01013403          	ld	s0,16(sp)
    800062f8:	00813483          	ld	s1,8(sp)
    800062fc:	00013903          	ld	s2,0(sp)
    80006300:	02010113          	addi	sp,sp,32
    80006304:	00008067          	ret

0000000080006308 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80006308:	fe010113          	addi	sp,sp,-32
    8000630c:	00113c23          	sd	ra,24(sp)
    80006310:	00813823          	sd	s0,16(sp)
    80006314:	00913423          	sd	s1,8(sp)
    80006318:	01213023          	sd	s2,0(sp)
    8000631c:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80006320:	00000493          	li	s1,0
    80006324:	0400006f          	j	80006364 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80006328:	00004517          	auipc	a0,0x4
    8000632c:	e1050513          	addi	a0,a0,-496 # 8000a138 <CONSOLE_STATUS+0x128>
    80006330:	ffffe097          	auipc	ra,0xffffe
    80006334:	7c4080e7          	jalr	1988(ra) # 80004af4 <_Z11printStringPKc>
    80006338:	00000613          	li	a2,0
    8000633c:	00a00593          	li	a1,10
    80006340:	00048513          	mv	a0,s1
    80006344:	fffff097          	auipc	ra,0xfffff
    80006348:	960080e7          	jalr	-1696(ra) # 80004ca4 <_Z8printIntiii>
    8000634c:	00004517          	auipc	a0,0x4
    80006350:	01c50513          	addi	a0,a0,28 # 8000a368 <CONSOLE_STATUS+0x358>
    80006354:	ffffe097          	auipc	ra,0xffffe
    80006358:	7a0080e7          	jalr	1952(ra) # 80004af4 <_Z11printStringPKc>
    for (; i < 3; i++) {
    8000635c:	0014849b          	addiw	s1,s1,1
    80006360:	0ff4f493          	andi	s1,s1,255
    80006364:	00200793          	li	a5,2
    80006368:	fc97f0e3          	bgeu	a5,s1,80006328 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    8000636c:	00004517          	auipc	a0,0x4
    80006370:	dd450513          	addi	a0,a0,-556 # 8000a140 <CONSOLE_STATUS+0x130>
    80006374:	ffffe097          	auipc	ra,0xffffe
    80006378:	780080e7          	jalr	1920(ra) # 80004af4 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    8000637c:	00700313          	li	t1,7
    thread_dispatch();
    80006380:	ffffb097          	auipc	ra,0xffffb
    80006384:	728080e7          	jalr	1832(ra) # 80001aa8 <thread_dispatch>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80006388:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    8000638c:	00004517          	auipc	a0,0x4
    80006390:	dc450513          	addi	a0,a0,-572 # 8000a150 <CONSOLE_STATUS+0x140>
    80006394:	ffffe097          	auipc	ra,0xffffe
    80006398:	760080e7          	jalr	1888(ra) # 80004af4 <_Z11printStringPKc>
    8000639c:	00000613          	li	a2,0
    800063a0:	00a00593          	li	a1,10
    800063a4:	0009051b          	sext.w	a0,s2
    800063a8:	fffff097          	auipc	ra,0xfffff
    800063ac:	8fc080e7          	jalr	-1796(ra) # 80004ca4 <_Z8printIntiii>
    800063b0:	00004517          	auipc	a0,0x4
    800063b4:	fb850513          	addi	a0,a0,-72 # 8000a368 <CONSOLE_STATUS+0x358>
    800063b8:	ffffe097          	auipc	ra,0xffffe
    800063bc:	73c080e7          	jalr	1852(ra) # 80004af4 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    800063c0:	00c00513          	li	a0,12
    800063c4:	00000097          	auipc	ra,0x0
    800063c8:	d88080e7          	jalr	-632(ra) # 8000614c <_ZL9fibonaccim>
    800063cc:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800063d0:	00004517          	auipc	a0,0x4
    800063d4:	d8850513          	addi	a0,a0,-632 # 8000a158 <CONSOLE_STATUS+0x148>
    800063d8:	ffffe097          	auipc	ra,0xffffe
    800063dc:	71c080e7          	jalr	1820(ra) # 80004af4 <_Z11printStringPKc>
    800063e0:	00000613          	li	a2,0
    800063e4:	00a00593          	li	a1,10
    800063e8:	0009051b          	sext.w	a0,s2
    800063ec:	fffff097          	auipc	ra,0xfffff
    800063f0:	8b8080e7          	jalr	-1864(ra) # 80004ca4 <_Z8printIntiii>
    800063f4:	00004517          	auipc	a0,0x4
    800063f8:	f7450513          	addi	a0,a0,-140 # 8000a368 <CONSOLE_STATUS+0x358>
    800063fc:	ffffe097          	auipc	ra,0xffffe
    80006400:	6f8080e7          	jalr	1784(ra) # 80004af4 <_Z11printStringPKc>
    80006404:	0400006f          	j	80006444 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80006408:	00004517          	auipc	a0,0x4
    8000640c:	d3050513          	addi	a0,a0,-720 # 8000a138 <CONSOLE_STATUS+0x128>
    80006410:	ffffe097          	auipc	ra,0xffffe
    80006414:	6e4080e7          	jalr	1764(ra) # 80004af4 <_Z11printStringPKc>
    80006418:	00000613          	li	a2,0
    8000641c:	00a00593          	li	a1,10
    80006420:	00048513          	mv	a0,s1
    80006424:	fffff097          	auipc	ra,0xfffff
    80006428:	880080e7          	jalr	-1920(ra) # 80004ca4 <_Z8printIntiii>
    8000642c:	00004517          	auipc	a0,0x4
    80006430:	f3c50513          	addi	a0,a0,-196 # 8000a368 <CONSOLE_STATUS+0x358>
    80006434:	ffffe097          	auipc	ra,0xffffe
    80006438:	6c0080e7          	jalr	1728(ra) # 80004af4 <_Z11printStringPKc>
    for (; i < 6; i++) {
    8000643c:	0014849b          	addiw	s1,s1,1
    80006440:	0ff4f493          	andi	s1,s1,255
    80006444:	00500793          	li	a5,5
    80006448:	fc97f0e3          	bgeu	a5,s1,80006408 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    8000644c:	00004517          	auipc	a0,0x4
    80006450:	cc450513          	addi	a0,a0,-828 # 8000a110 <CONSOLE_STATUS+0x100>
    80006454:	ffffe097          	auipc	ra,0xffffe
    80006458:	6a0080e7          	jalr	1696(ra) # 80004af4 <_Z11printStringPKc>
    finishedC = true;
    8000645c:	00100793          	li	a5,1
    80006460:	00006717          	auipc	a4,0x6
    80006464:	66f709a3          	sb	a5,1651(a4) # 8000cad3 <_ZL9finishedC>
    thread_dispatch();
    80006468:	ffffb097          	auipc	ra,0xffffb
    8000646c:	640080e7          	jalr	1600(ra) # 80001aa8 <thread_dispatch>
}
    80006470:	01813083          	ld	ra,24(sp)
    80006474:	01013403          	ld	s0,16(sp)
    80006478:	00813483          	ld	s1,8(sp)
    8000647c:	00013903          	ld	s2,0(sp)
    80006480:	02010113          	addi	sp,sp,32
    80006484:	00008067          	ret

0000000080006488 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80006488:	fe010113          	addi	sp,sp,-32
    8000648c:	00113c23          	sd	ra,24(sp)
    80006490:	00813823          	sd	s0,16(sp)
    80006494:	00913423          	sd	s1,8(sp)
    80006498:	01213023          	sd	s2,0(sp)
    8000649c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    800064a0:	00000913          	li	s2,0
    800064a4:	0400006f          	j	800064e4 <_ZL11workerBodyBPv+0x5c>
            thread_dispatch();
    800064a8:	ffffb097          	auipc	ra,0xffffb
    800064ac:	600080e7          	jalr	1536(ra) # 80001aa8 <thread_dispatch>
        for (uint64 j = 0; j < 10000; j++) {
    800064b0:	00148493          	addi	s1,s1,1
    800064b4:	000027b7          	lui	a5,0x2
    800064b8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800064bc:	0097ee63          	bltu	a5,s1,800064d8 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800064c0:	00000713          	li	a4,0
    800064c4:	000077b7          	lui	a5,0x7
    800064c8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800064cc:	fce7eee3          	bltu	a5,a4,800064a8 <_ZL11workerBodyBPv+0x20>
    800064d0:	00170713          	addi	a4,a4,1
    800064d4:	ff1ff06f          	j	800064c4 <_ZL11workerBodyBPv+0x3c>
        if (i == 10) {
    800064d8:	00a00793          	li	a5,10
    800064dc:	04f90663          	beq	s2,a5,80006528 <_ZL11workerBodyBPv+0xa0>
    for (uint64 i = 0; i < 16; i++) {
    800064e0:	00190913          	addi	s2,s2,1
    800064e4:	00f00793          	li	a5,15
    800064e8:	0527e463          	bltu	a5,s2,80006530 <_ZL11workerBodyBPv+0xa8>
        printString("B: i="); printInt(i); printString("\n");
    800064ec:	00004517          	auipc	a0,0x4
    800064f0:	c3450513          	addi	a0,a0,-972 # 8000a120 <CONSOLE_STATUS+0x110>
    800064f4:	ffffe097          	auipc	ra,0xffffe
    800064f8:	600080e7          	jalr	1536(ra) # 80004af4 <_Z11printStringPKc>
    800064fc:	00000613          	li	a2,0
    80006500:	00a00593          	li	a1,10
    80006504:	0009051b          	sext.w	a0,s2
    80006508:	ffffe097          	auipc	ra,0xffffe
    8000650c:	79c080e7          	jalr	1948(ra) # 80004ca4 <_Z8printIntiii>
    80006510:	00004517          	auipc	a0,0x4
    80006514:	e5850513          	addi	a0,a0,-424 # 8000a368 <CONSOLE_STATUS+0x358>
    80006518:	ffffe097          	auipc	ra,0xffffe
    8000651c:	5dc080e7          	jalr	1500(ra) # 80004af4 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80006520:	00000493          	li	s1,0
    80006524:	f91ff06f          	j	800064b4 <_ZL11workerBodyBPv+0x2c>
            asm volatile("csrr t6, sepc");
    80006528:	14102ff3          	csrr	t6,sepc
    8000652c:	fb5ff06f          	j	800064e0 <_ZL11workerBodyBPv+0x58>
    printString("B finished!\n");
    80006530:	00004517          	auipc	a0,0x4
    80006534:	bf850513          	addi	a0,a0,-1032 # 8000a128 <CONSOLE_STATUS+0x118>
    80006538:	ffffe097          	auipc	ra,0xffffe
    8000653c:	5bc080e7          	jalr	1468(ra) # 80004af4 <_Z11printStringPKc>
    finishedB = true;
    80006540:	00100793          	li	a5,1
    80006544:	00006717          	auipc	a4,0x6
    80006548:	58f70823          	sb	a5,1424(a4) # 8000cad4 <_ZL9finishedB>
    thread_dispatch();
    8000654c:	ffffb097          	auipc	ra,0xffffb
    80006550:	55c080e7          	jalr	1372(ra) # 80001aa8 <thread_dispatch>
}
    80006554:	01813083          	ld	ra,24(sp)
    80006558:	01013403          	ld	s0,16(sp)
    8000655c:	00813483          	ld	s1,8(sp)
    80006560:	00013903          	ld	s2,0(sp)
    80006564:	02010113          	addi	sp,sp,32
    80006568:	00008067          	ret

000000008000656c <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    8000656c:	fe010113          	addi	sp,sp,-32
    80006570:	00113c23          	sd	ra,24(sp)
    80006574:	00813823          	sd	s0,16(sp)
    80006578:	00913423          	sd	s1,8(sp)
    8000657c:	01213023          	sd	s2,0(sp)
    80006580:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80006584:	00000913          	li	s2,0
    80006588:	0380006f          	j	800065c0 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    8000658c:	ffffb097          	auipc	ra,0xffffb
    80006590:	51c080e7          	jalr	1308(ra) # 80001aa8 <thread_dispatch>
        for (uint64 j = 0; j < 10000; j++) {
    80006594:	00148493          	addi	s1,s1,1
    80006598:	000027b7          	lui	a5,0x2
    8000659c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800065a0:	0097ee63          	bltu	a5,s1,800065bc <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800065a4:	00000713          	li	a4,0
    800065a8:	000077b7          	lui	a5,0x7
    800065ac:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800065b0:	fce7eee3          	bltu	a5,a4,8000658c <_ZL11workerBodyAPv+0x20>
    800065b4:	00170713          	addi	a4,a4,1
    800065b8:	ff1ff06f          	j	800065a8 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800065bc:	00190913          	addi	s2,s2,1
    800065c0:	00900793          	li	a5,9
    800065c4:	0527e063          	bltu	a5,s2,80006604 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    800065c8:	00004517          	auipc	a0,0x4
    800065cc:	b4050513          	addi	a0,a0,-1216 # 8000a108 <CONSOLE_STATUS+0xf8>
    800065d0:	ffffe097          	auipc	ra,0xffffe
    800065d4:	524080e7          	jalr	1316(ra) # 80004af4 <_Z11printStringPKc>
    800065d8:	00000613          	li	a2,0
    800065dc:	00a00593          	li	a1,10
    800065e0:	0009051b          	sext.w	a0,s2
    800065e4:	ffffe097          	auipc	ra,0xffffe
    800065e8:	6c0080e7          	jalr	1728(ra) # 80004ca4 <_Z8printIntiii>
    800065ec:	00004517          	auipc	a0,0x4
    800065f0:	d7c50513          	addi	a0,a0,-644 # 8000a368 <CONSOLE_STATUS+0x358>
    800065f4:	ffffe097          	auipc	ra,0xffffe
    800065f8:	500080e7          	jalr	1280(ra) # 80004af4 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800065fc:	00000493          	li	s1,0
    80006600:	f99ff06f          	j	80006598 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80006604:	00004517          	auipc	a0,0x4
    80006608:	b0c50513          	addi	a0,a0,-1268 # 8000a110 <CONSOLE_STATUS+0x100>
    8000660c:	ffffe097          	auipc	ra,0xffffe
    80006610:	4e8080e7          	jalr	1256(ra) # 80004af4 <_Z11printStringPKc>
    finishedA = true;
    80006614:	00100793          	li	a5,1
    80006618:	00006717          	auipc	a4,0x6
    8000661c:	4af70ea3          	sb	a5,1213(a4) # 8000cad5 <_ZL9finishedA>
}
    80006620:	01813083          	ld	ra,24(sp)
    80006624:	01013403          	ld	s0,16(sp)
    80006628:	00813483          	ld	s1,8(sp)
    8000662c:	00013903          	ld	s2,0(sp)
    80006630:	02010113          	addi	sp,sp,32
    80006634:	00008067          	ret

0000000080006638 <_Z16System_Mode_testv>:


void System_Mode_test() {
    80006638:	fd010113          	addi	sp,sp,-48
    8000663c:	02113423          	sd	ra,40(sp)
    80006640:	02813023          	sd	s0,32(sp)
    80006644:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80006648:	00000613          	li	a2,0
    8000664c:	00000597          	auipc	a1,0x0
    80006650:	f2058593          	addi	a1,a1,-224 # 8000656c <_ZL11workerBodyAPv>
    80006654:	fd040513          	addi	a0,s0,-48
    80006658:	ffffb097          	auipc	ra,0xffffb
    8000665c:	410080e7          	jalr	1040(ra) # 80001a68 <thread_create>
    printString("ThreadA created\n");
    80006660:	00004517          	auipc	a0,0x4
    80006664:	b5050513          	addi	a0,a0,-1200 # 8000a1b0 <CONSOLE_STATUS+0x1a0>
    80006668:	ffffe097          	auipc	ra,0xffffe
    8000666c:	48c080e7          	jalr	1164(ra) # 80004af4 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80006670:	00000613          	li	a2,0
    80006674:	00000597          	auipc	a1,0x0
    80006678:	e1458593          	addi	a1,a1,-492 # 80006488 <_ZL11workerBodyBPv>
    8000667c:	fd840513          	addi	a0,s0,-40
    80006680:	ffffb097          	auipc	ra,0xffffb
    80006684:	3e8080e7          	jalr	1000(ra) # 80001a68 <thread_create>
    printString("ThreadB created\n");
    80006688:	00004517          	auipc	a0,0x4
    8000668c:	b4050513          	addi	a0,a0,-1216 # 8000a1c8 <CONSOLE_STATUS+0x1b8>
    80006690:	ffffe097          	auipc	ra,0xffffe
    80006694:	464080e7          	jalr	1124(ra) # 80004af4 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80006698:	00000613          	li	a2,0
    8000669c:	00000597          	auipc	a1,0x0
    800066a0:	c6c58593          	addi	a1,a1,-916 # 80006308 <_ZL11workerBodyCPv>
    800066a4:	fe040513          	addi	a0,s0,-32
    800066a8:	ffffb097          	auipc	ra,0xffffb
    800066ac:	3c0080e7          	jalr	960(ra) # 80001a68 <thread_create>
    printString("ThreadC created\n");
    800066b0:	00004517          	auipc	a0,0x4
    800066b4:	b3050513          	addi	a0,a0,-1232 # 8000a1e0 <CONSOLE_STATUS+0x1d0>
    800066b8:	ffffe097          	auipc	ra,0xffffe
    800066bc:	43c080e7          	jalr	1084(ra) # 80004af4 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    800066c0:	00000613          	li	a2,0
    800066c4:	00000597          	auipc	a1,0x0
    800066c8:	afc58593          	addi	a1,a1,-1284 # 800061c0 <_ZL11workerBodyDPv>
    800066cc:	fe840513          	addi	a0,s0,-24
    800066d0:	ffffb097          	auipc	ra,0xffffb
    800066d4:	398080e7          	jalr	920(ra) # 80001a68 <thread_create>
    printString("ThreadD created\n");
    800066d8:	00004517          	auipc	a0,0x4
    800066dc:	b2050513          	addi	a0,a0,-1248 # 8000a1f8 <CONSOLE_STATUS+0x1e8>
    800066e0:	ffffe097          	auipc	ra,0xffffe
    800066e4:	414080e7          	jalr	1044(ra) # 80004af4 <_Z11printStringPKc>
    800066e8:	00c0006f          	j	800066f4 <_Z16System_Mode_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800066ec:	ffffb097          	auipc	ra,0xffffb
    800066f0:	3bc080e7          	jalr	956(ra) # 80001aa8 <thread_dispatch>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800066f4:	00006797          	auipc	a5,0x6
    800066f8:	3e17c783          	lbu	a5,993(a5) # 8000cad5 <_ZL9finishedA>
    800066fc:	fe0788e3          	beqz	a5,800066ec <_Z16System_Mode_testv+0xb4>
    80006700:	00006797          	auipc	a5,0x6
    80006704:	3d47c783          	lbu	a5,980(a5) # 8000cad4 <_ZL9finishedB>
    80006708:	fe0782e3          	beqz	a5,800066ec <_Z16System_Mode_testv+0xb4>
    8000670c:	00006797          	auipc	a5,0x6
    80006710:	3c77c783          	lbu	a5,967(a5) # 8000cad3 <_ZL9finishedC>
    80006714:	fc078ce3          	beqz	a5,800066ec <_Z16System_Mode_testv+0xb4>
    80006718:	00006797          	auipc	a5,0x6
    8000671c:	3ba7c783          	lbu	a5,954(a5) # 8000cad2 <_ZL9finishedD>
    80006720:	fc0786e3          	beqz	a5,800066ec <_Z16System_Mode_testv+0xb4>
    }

}
    80006724:	02813083          	ld	ra,40(sp)
    80006728:	02013403          	ld	s0,32(sp)
    8000672c:	03010113          	addi	sp,sp,48
    80006730:	00008067          	ret

0000000080006734 <_ZN15MemoryAllocator14__get_instanceEv>:

MemoryAllocator* MemoryAllocator::allocator = nullptr;
MemoryAllocator::Header* MemoryAllocator::free = nullptr;
MemoryAllocator::Header* MemoryAllocator::occ = nullptr;

MemoryAllocator* MemoryAllocator::__get_instance() {
    80006734:	ff010113          	addi	sp,sp,-16
    80006738:	00813423          	sd	s0,8(sp)
    8000673c:	01010413          	addi	s0,sp,16
    if (!allocator)                                                                                             // check if allocator is set
    80006740:	00006797          	auipc	a5,0x6
    80006744:	3987b783          	ld	a5,920(a5) # 8000cad8 <_ZN15MemoryAllocator9allocatorE>
    80006748:	00078c63          	beqz	a5,80006760 <_ZN15MemoryAllocator14__get_instanceEv+0x2c>
        occ = nullptr;
        allocator = (MemoryAllocator*)HEAP_START_ADDR;
    }

    return allocator;
}
    8000674c:	00006517          	auipc	a0,0x6
    80006750:	38c53503          	ld	a0,908(a0) # 8000cad8 <_ZN15MemoryAllocator9allocatorE>
    80006754:	00813403          	ld	s0,8(sp)
    80006758:	01010113          	addi	sp,sp,16
    8000675c:	00008067          	ret
        free = (Header*)((size_t)HEAP_START_ADDR + sizeof(MemoryAllocator));
    80006760:	00006617          	auipc	a2,0x6
    80006764:	25063603          	ld	a2,592(a2) # 8000c9b0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80006768:	00063683          	ld	a3,0(a2)
    8000676c:	00168793          	addi	a5,a3,1
    80006770:	00006717          	auipc	a4,0x6
    80006774:	36870713          	addi	a4,a4,872 # 8000cad8 <_ZN15MemoryAllocator9allocatorE>
    80006778:	00f73423          	sd	a5,8(a4)
        free->size = (size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR - sizeof(Header) - sizeof(MemoryAllocator);
    8000677c:	00006797          	auipc	a5,0x6
    80006780:	2647b783          	ld	a5,612(a5) # 8000c9e0 <_GLOBAL_OFFSET_TABLE_+0x48>
    80006784:	0007b783          	ld	a5,0(a5)
    80006788:	40d787b3          	sub	a5,a5,a3
    8000678c:	fef78793          	addi	a5,a5,-17
    80006790:	00f6b0a3          	sd	a5,1(a3)
        free->next = nullptr;
    80006794:	00873783          	ld	a5,8(a4)
    80006798:	0007b423          	sd	zero,8(a5)
        occ = nullptr;
    8000679c:	00073823          	sd	zero,16(a4)
        allocator = (MemoryAllocator*)HEAP_START_ADDR;
    800067a0:	00063783          	ld	a5,0(a2)
    800067a4:	00f73023          	sd	a5,0(a4)
    800067a8:	fa5ff06f          	j	8000674c <_ZN15MemoryAllocator14__get_instanceEv+0x18>

00000000800067ac <_ZN15MemoryAllocator14__add_occupiedEPNS_6HeaderE>:
    }
    free = nullptr;
    return nullptr;
}

void MemoryAllocator::__add_occupied(Header* ptr) {
    800067ac:	ff010113          	addi	sp,sp,-16
    800067b0:	00813423          	sd	s0,8(sp)
    800067b4:	01010413          	addi	s0,sp,16
    ptr->next = occ;
    800067b8:	00006797          	auipc	a5,0x6
    800067bc:	32078793          	addi	a5,a5,800 # 8000cad8 <_ZN15MemoryAllocator9allocatorE>
    800067c0:	0107b703          	ld	a4,16(a5)
    800067c4:	00e53423          	sd	a4,8(a0)
    occ = ptr;
    800067c8:	00a7b823          	sd	a0,16(a5)
}
    800067cc:	00813403          	ld	s0,8(sp)
    800067d0:	01010113          	addi	sp,sp,16
    800067d4:	00008067          	ret

00000000800067d8 <_ZN15MemoryAllocator11__mem_allocEm>:
void* MemoryAllocator::__mem_alloc(size_t size) {
    800067d8:	fe010113          	addi	sp,sp,-32
    800067dc:	00113c23          	sd	ra,24(sp)
    800067e0:	00813823          	sd	s0,16(sp)
    800067e4:	00913423          	sd	s1,8(sp)
    800067e8:	02010413          	addi	s0,sp,32
    if (size == 0)
    800067ec:	0c058263          	beqz	a1,800068b0 <_ZN15MemoryAllocator11__mem_allocEm+0xd8>
    size = size * MEM_BLOCK_SIZE;                      // real number of bytes to allocate
    800067f0:	00659593          	slli	a1,a1,0x6
    Header* curr = free;
    800067f4:	00006497          	auipc	s1,0x6
    800067f8:	2ec4b483          	ld	s1,748(s1) # 8000cae0 <_ZN15MemoryAllocator4freeE>
    Header* prev = nullptr;
    800067fc:	00000713          	li	a4,0
    while (curr)
    80006800:	08048863          	beqz	s1,80006890 <_ZN15MemoryAllocator11__mem_allocEm+0xb8>
        if (curr->size >= size)                                         // check if current block has enough memory
    80006804:	0004b783          	ld	a5,0(s1)
    80006808:	00b7f863          	bgeu	a5,a1,80006818 <_ZN15MemoryAllocator11__mem_allocEm+0x40>
        prev = curr;
    8000680c:	00048713          	mv	a4,s1
        curr = curr->next;
    80006810:	0084b483          	ld	s1,8(s1)
    while (curr)
    80006814:	fedff06f          	j	80006800 <_ZN15MemoryAllocator11__mem_allocEm+0x28>
            if (curr->size - size < MEM_BLOCK_SIZE + sizeof(Header))                    // check if the rest of block is big enough to make new block
    80006818:	40b787b3          	sub	a5,a5,a1
    8000681c:	04f00693          	li	a3,79
    80006820:	02f6e263          	bltu	a3,a5,80006844 <_ZN15MemoryAllocator11__mem_allocEm+0x6c>
                if (prev)
    80006824:	00070863          	beqz	a4,80006834 <_ZN15MemoryAllocator11__mem_allocEm+0x5c>
                    prev->next = curr->next;
    80006828:	0084b783          	ld	a5,8(s1)
    8000682c:	00f73423          	sd	a5,8(a4)
    80006830:	0400006f          	j	80006870 <_ZN15MemoryAllocator11__mem_allocEm+0x98>
                    free = curr->next;
    80006834:	0084b783          	ld	a5,8(s1)
    80006838:	00006717          	auipc	a4,0x6
    8000683c:	2af73423          	sd	a5,680(a4) # 8000cae0 <_ZN15MemoryAllocator4freeE>
    80006840:	0300006f          	j	80006870 <_ZN15MemoryAllocator11__mem_allocEm+0x98>
                Header* newBlock = (Header*)(((size_t)curr) + size + sizeof(Header));
    80006844:	00b486b3          	add	a3,s1,a1
    80006848:	01068613          	addi	a2,a3,16
                newBlock->next = curr->next;
    8000684c:	0084b783          	ld	a5,8(s1)
    80006850:	00f63423          	sd	a5,8(a2)
                newBlock->size = curr->size - size - sizeof(Header);
    80006854:	0004b783          	ld	a5,0(s1)
    80006858:	40b787b3          	sub	a5,a5,a1
    8000685c:	ff078793          	addi	a5,a5,-16
    80006860:	00f6b823          	sd	a5,16(a3)
                if (prev)
    80006864:	02070063          	beqz	a4,80006884 <_ZN15MemoryAllocator11__mem_allocEm+0xac>
                    prev->next = newBlock;
    80006868:	00c73423          	sd	a2,8(a4)
                curr->size = size;
    8000686c:	00b4b023          	sd	a1,0(s1)
            __add_occupied(curr);                                       // adds new block to occupied list
    80006870:	00048513          	mv	a0,s1
    80006874:	00000097          	auipc	ra,0x0
    80006878:	f38080e7          	jalr	-200(ra) # 800067ac <_ZN15MemoryAllocator14__add_occupiedEPNS_6HeaderE>
            return (void*)(((size_t)curr) + sizeof(Header));
    8000687c:	01048493          	addi	s1,s1,16
    80006880:	0180006f          	j	80006898 <_ZN15MemoryAllocator11__mem_allocEm+0xc0>
                    free = newBlock;
    80006884:	00006797          	auipc	a5,0x6
    80006888:	24c7be23          	sd	a2,604(a5) # 8000cae0 <_ZN15MemoryAllocator4freeE>
    8000688c:	fe1ff06f          	j	8000686c <_ZN15MemoryAllocator11__mem_allocEm+0x94>
    free = nullptr;
    80006890:	00006797          	auipc	a5,0x6
    80006894:	2407b823          	sd	zero,592(a5) # 8000cae0 <_ZN15MemoryAllocator4freeE>
}
    80006898:	00048513          	mv	a0,s1
    8000689c:	01813083          	ld	ra,24(sp)
    800068a0:	01013403          	ld	s0,16(sp)
    800068a4:	00813483          	ld	s1,8(sp)
    800068a8:	02010113          	addi	sp,sp,32
    800068ac:	00008067          	ret
        return nullptr;
    800068b0:	00000493          	li	s1,0
    800068b4:	fe5ff06f          	j	80006898 <_ZN15MemoryAllocator11__mem_allocEm+0xc0>

00000000800068b8 <_ZN15MemoryAllocator27__check_and_delete_occupiedEPNS_6HeaderE>:

bool MemoryAllocator::__check_and_delete_occupied(Header* ptr) {
    800068b8:	ff010113          	addi	sp,sp,-16
    800068bc:	00813423          	sd	s0,8(sp)
    800068c0:	01010413          	addi	s0,sp,16
    if (!occ)
    800068c4:	00006797          	auipc	a5,0x6
    800068c8:	2247b783          	ld	a5,548(a5) # 8000cae8 <_ZN15MemoryAllocator3occE>
    800068cc:	04078063          	beqz	a5,8000690c <_ZN15MemoryAllocator27__check_and_delete_occupiedEPNS_6HeaderE+0x54>
        return false;

    Header* curr = occ;
    Header* prev = nullptr;
    800068d0:	00000713          	li	a4,0

    while (curr)
    800068d4:	04078063          	beqz	a5,80006914 <_ZN15MemoryAllocator27__check_and_delete_occupiedEPNS_6HeaderE+0x5c>
    {
        if (curr == ptr)
    800068d8:	00a78863          	beq	a5,a0,800068e8 <_ZN15MemoryAllocator27__check_and_delete_occupiedEPNS_6HeaderE+0x30>
            else
                occ = curr->next;

            return true;
        }
        prev = curr;
    800068dc:	00078713          	mv	a4,a5
        curr = curr->next;
    800068e0:	0087b783          	ld	a5,8(a5)
    while (curr)
    800068e4:	ff1ff06f          	j	800068d4 <_ZN15MemoryAllocator27__check_and_delete_occupiedEPNS_6HeaderE+0x1c>
            if (prev)
    800068e8:	00070a63          	beqz	a4,800068fc <_ZN15MemoryAllocator27__check_and_delete_occupiedEPNS_6HeaderE+0x44>
                prev->next = curr->next;
    800068ec:	0087b783          	ld	a5,8(a5)
    800068f0:	00f73423          	sd	a5,8(a4)
            return true;
    800068f4:	00100513          	li	a0,1
    800068f8:	0200006f          	j	80006918 <_ZN15MemoryAllocator27__check_and_delete_occupiedEPNS_6HeaderE+0x60>
                occ = curr->next;
    800068fc:	0087b783          	ld	a5,8(a5)
    80006900:	00006717          	auipc	a4,0x6
    80006904:	1ef73423          	sd	a5,488(a4) # 8000cae8 <_ZN15MemoryAllocator3occE>
    80006908:	fedff06f          	j	800068f4 <_ZN15MemoryAllocator27__check_and_delete_occupiedEPNS_6HeaderE+0x3c>
        return false;
    8000690c:	00000513          	li	a0,0
    80006910:	0080006f          	j	80006918 <_ZN15MemoryAllocator27__check_and_delete_occupiedEPNS_6HeaderE+0x60>
    }

    return false;
    80006914:	00000513          	li	a0,0
}
    80006918:	00813403          	ld	s0,8(sp)
    8000691c:	01010113          	addi	sp,sp,16
    80006920:	00008067          	ret

0000000080006924 <_ZN15MemoryAllocator10__mem_freeEPv>:

int MemoryAllocator::__mem_free(void* ptr) {
    if (ptr == nullptr)
    80006924:	14058463          	beqz	a1,80006a6c <_ZN15MemoryAllocator10__mem_freeEPv+0x148>
int MemoryAllocator::__mem_free(void* ptr) {
    80006928:	fd010113          	addi	sp,sp,-48
    8000692c:	02113423          	sd	ra,40(sp)
    80006930:	02813023          	sd	s0,32(sp)
    80006934:	00913c23          	sd	s1,24(sp)
    80006938:	01213823          	sd	s2,16(sp)
    8000693c:	01313423          	sd	s3,8(sp)
    80006940:	03010413          	addi	s0,sp,48
    80006944:	00058913          	mv	s2,a1
        return 0;

    Header* block = (Header*)(((size_t)ptr) - sizeof(Header));
    80006948:	ff058493          	addi	s1,a1,-16
    8000694c:	00048993          	mv	s3,s1
    if (!__check_and_delete_occupied(block))
    80006950:	00048513          	mv	a0,s1
    80006954:	00000097          	auipc	ra,0x0
    80006958:	f64080e7          	jalr	-156(ra) # 800068b8 <_ZN15MemoryAllocator27__check_and_delete_occupiedEPNS_6HeaderE>
    8000695c:	10050c63          	beqz	a0,80006a74 <_ZN15MemoryAllocator10__mem_freeEPv+0x150>
        return -1;                                                                              // invalid pointer

    if (!free)
    80006960:	00006797          	auipc	a5,0x6
    80006964:	1807b783          	ld	a5,384(a5) # 8000cae0 <_ZN15MemoryAllocator4freeE>
    80006968:	02078663          	beqz	a5,80006994 <_ZN15MemoryAllocator10__mem_freeEPv+0x70>
        free = block;
        free->next = nullptr;
        return 0;
    }

    if ((size_t)block < (size_t)free)
    8000696c:	06f4f663          	bgeu	s1,a5,800069d8 <_ZN15MemoryAllocator10__mem_freeEPv+0xb4>
    {
        if (((size_t)block) + block->size + sizeof(Header) == (size_t)free)
    80006970:	ff093603          	ld	a2,-16(s2)
    80006974:	00c48733          	add	a4,s1,a2
    80006978:	01070713          	addi	a4,a4,16
    8000697c:	02e78663          	beq	a5,a4,800069a8 <_ZN15MemoryAllocator10__mem_freeEPv+0x84>
            block->next = free->next;
            free = block;
        }
        else
        {
            block->next = free;
    80006980:	00f4b423          	sd	a5,8(s1)
            free = block;
    80006984:	00006797          	auipc	a5,0x6
    80006988:	1497be23          	sd	s1,348(a5) # 8000cae0 <_ZN15MemoryAllocator4freeE>
        }
        return 0;
    8000698c:	00000513          	li	a0,0
    80006990:	08c0006f          	j	80006a1c <_ZN15MemoryAllocator10__mem_freeEPv+0xf8>
        free = block;
    80006994:	00006797          	auipc	a5,0x6
    80006998:	1497b623          	sd	s1,332(a5) # 8000cae0 <_ZN15MemoryAllocator4freeE>
        free->next = nullptr;
    8000699c:	0004b423          	sd	zero,8(s1)
        return 0;
    800069a0:	00000513          	li	a0,0
    800069a4:	0780006f          	j	80006a1c <_ZN15MemoryAllocator10__mem_freeEPv+0xf8>
            block->size += sizeof(Header) + free->size;
    800069a8:	0007b783          	ld	a5,0(a5)
    800069ac:	00f60633          	add	a2,a2,a5
    800069b0:	01060613          	addi	a2,a2,16
    800069b4:	fec93823          	sd	a2,-16(s2)
            block->next = free->next;
    800069b8:	00006797          	auipc	a5,0x6
    800069bc:	12078793          	addi	a5,a5,288 # 8000cad8 <_ZN15MemoryAllocator9allocatorE>
    800069c0:	0087b703          	ld	a4,8(a5)
    800069c4:	00873703          	ld	a4,8(a4)
    800069c8:	00e4b423          	sd	a4,8(s1)
            free = block;
    800069cc:	0097b423          	sd	s1,8(a5)
    800069d0:	fbdff06f          	j	8000698c <_ZN15MemoryAllocator10__mem_freeEPv+0x68>
                block->next = block->next->next;
            }

            return 0;
        }
        curr = curr->next;
    800069d4:	00070793          	mv	a5,a4
    while (curr)
    800069d8:	0a078263          	beqz	a5,80006a7c <_ZN15MemoryAllocator10__mem_freeEPv+0x158>
        if ((!curr->next) || (curr->next && (size_t)block < (size_t)curr->next))
    800069dc:	0087b703          	ld	a4,8(a5)
    800069e0:	00070463          	beqz	a4,800069e8 <_ZN15MemoryAllocator10__mem_freeEPv+0xc4>
    800069e4:	fee4f8e3          	bgeu	s1,a4,800069d4 <_ZN15MemoryAllocator10__mem_freeEPv+0xb0>
            if ((Header*)(((size_t)curr) + sizeof(Header) + curr->size) == block)                           // block can be united with previous block
    800069e8:	0007b603          	ld	a2,0(a5)
    800069ec:	00c786b3          	add	a3,a5,a2
    800069f0:	01068693          	addi	a3,a3,16
    800069f4:	05368263          	beq	a3,s3,80006a38 <_ZN15MemoryAllocator10__mem_freeEPv+0x114>
                block->next = curr->next;
    800069f8:	00e4b423          	sd	a4,8(s1)
                curr->next = block;
    800069fc:	0097b423          	sd	s1,8(a5)
            if (block->next && (Header*)(((size_t)block) + sizeof(Header) + block->size) == block->next)    // block can be united with next block
    80006a00:	0089b783          	ld	a5,8(s3)
    80006a04:	00078a63          	beqz	a5,80006a18 <_ZN15MemoryAllocator10__mem_freeEPv+0xf4>
    80006a08:	0009b683          	ld	a3,0(s3)
    80006a0c:	00d98733          	add	a4,s3,a3
    80006a10:	01070713          	addi	a4,a4,16
    80006a14:	02e78e63          	beq	a5,a4,80006a50 <_ZN15MemoryAllocator10__mem_freeEPv+0x12c>
            return 0;
    80006a18:	00000513          	li	a0,0
    }

    return -2;
}
    80006a1c:	02813083          	ld	ra,40(sp)
    80006a20:	02013403          	ld	s0,32(sp)
    80006a24:	01813483          	ld	s1,24(sp)
    80006a28:	01013903          	ld	s2,16(sp)
    80006a2c:	00813983          	ld	s3,8(sp)
    80006a30:	03010113          	addi	sp,sp,48
    80006a34:	00008067          	ret
                curr->size += sizeof(Header) + block->size;
    80006a38:	ff093703          	ld	a4,-16(s2)
    80006a3c:	00e60633          	add	a2,a2,a4
    80006a40:	01060613          	addi	a2,a2,16
    80006a44:	00c7b023          	sd	a2,0(a5)
                block = curr;                                                                   // this is to make block->next = curr->next
    80006a48:	00078993          	mv	s3,a5
    80006a4c:	fb5ff06f          	j	80006a00 <_ZN15MemoryAllocator10__mem_freeEPv+0xdc>
                block->size += block->next->size + sizeof(Header);
    80006a50:	0007b703          	ld	a4,0(a5)
    80006a54:	00e68733          	add	a4,a3,a4
    80006a58:	01070713          	addi	a4,a4,16
    80006a5c:	00e9b023          	sd	a4,0(s3)
                block->next = block->next->next;
    80006a60:	0087b783          	ld	a5,8(a5)
    80006a64:	00f9b423          	sd	a5,8(s3)
    80006a68:	fb1ff06f          	j	80006a18 <_ZN15MemoryAllocator10__mem_freeEPv+0xf4>
        return 0;
    80006a6c:	00000513          	li	a0,0
}
    80006a70:	00008067          	ret
        return -1;                                                                              // invalid pointer
    80006a74:	fff00513          	li	a0,-1
    80006a78:	fa5ff06f          	j	80006a1c <_ZN15MemoryAllocator10__mem_freeEPv+0xf8>
    return -2;
    80006a7c:	ffe00513          	li	a0,-2
    80006a80:	f9dff06f          	j	80006a1c <_ZN15MemoryAllocator10__mem_freeEPv+0xf8>

0000000080006a84 <_ZN15MemoryAllocator19__convert_to_blocksEm>:

size_t MemoryAllocator::__convert_to_blocks(size_t size)
{
    80006a84:	ff010113          	addi	sp,sp,-16
    80006a88:	00813423          	sd	s0,8(sp)
    80006a8c:	01010413          	addi	s0,sp,16
    return (size + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE;
    80006a90:	03f50513          	addi	a0,a0,63
}
    80006a94:	00655513          	srli	a0,a0,0x6
    80006a98:	00813403          	ld	s0,8(sp)
    80006a9c:	01010113          	addi	sp,sp,16
    80006aa0:	00008067          	ret

0000000080006aa4 <_ZN7_buffer13buffer_createEj>:

buffer_t _buffer::putcBuffer = nullptr;
buffer_t _buffer::getcBuffer = nullptr;

buffer_t _buffer::buffer_create(unsigned size)
{
    80006aa4:	fd010113          	addi	sp,sp,-48
    80006aa8:	02113423          	sd	ra,40(sp)
    80006aac:	02813023          	sd	s0,32(sp)
    80006ab0:	00913c23          	sd	s1,24(sp)
    80006ab4:	01213823          	sd	s2,16(sp)
    80006ab8:	01313423          	sd	s3,8(sp)
    80006abc:	03010413          	addi	s0,sp,48
    80006ac0:	00050913          	mv	s2,a0
    buffer_t buffer = (buffer_t)MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(sizeof(_buffer)));
    80006ac4:	00000097          	auipc	ra,0x0
    80006ac8:	c70080e7          	jalr	-912(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80006acc:	00050493          	mv	s1,a0
    80006ad0:	03000513          	li	a0,48
    80006ad4:	00000097          	auipc	ra,0x0
    80006ad8:	fb0080e7          	jalr	-80(ra) # 80006a84 <_ZN15MemoryAllocator19__convert_to_blocksEm>
    80006adc:	00050593          	mv	a1,a0
    80006ae0:	00048513          	mv	a0,s1
    80006ae4:	00000097          	auipc	ra,0x0
    80006ae8:	cf4080e7          	jalr	-780(ra) # 800067d8 <_ZN15MemoryAllocator11__mem_allocEm>
    80006aec:	00050493          	mv	s1,a0
    if (!buffer)
    80006af0:	08050a63          	beqz	a0,80006b84 <_ZN7_buffer13buffer_createEj+0xe0>
        return nullptr;

    buffer->head = buffer->tail = buffer->occupied =  0;
    80006af4:	00052623          	sw	zero,12(a0)
    80006af8:	00052223          	sw	zero,4(a0)
    80006afc:	00052023          	sw	zero,0(a0)
    buffer->size = size;
    80006b00:	01252423          	sw	s2,8(a0)
    buffer->buffer = (char*)MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(size));
    80006b04:	00000097          	auipc	ra,0x0
    80006b08:	c30080e7          	jalr	-976(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80006b0c:	00050993          	mv	s3,a0
    80006b10:	02091513          	slli	a0,s2,0x20
    80006b14:	02055513          	srli	a0,a0,0x20
    80006b18:	00000097          	auipc	ra,0x0
    80006b1c:	f6c080e7          	jalr	-148(ra) # 80006a84 <_ZN15MemoryAllocator19__convert_to_blocksEm>
    80006b20:	00050593          	mv	a1,a0
    80006b24:	00098513          	mv	a0,s3
    80006b28:	00000097          	auipc	ra,0x0
    80006b2c:	cb0080e7          	jalr	-848(ra) # 800067d8 <_ZN15MemoryAllocator11__mem_allocEm>
    80006b30:	00050993          	mv	s3,a0
    80006b34:	00a4b823          	sd	a0,16(s1)
    if (!buffer->buffer)
    80006b38:	06050663          	beqz	a0,80006ba4 <_ZN7_buffer13buffer_createEj+0x100>
    {
        MemoryAllocator::__get_instance()->__mem_free(buffer);
        return nullptr;
    }

    buffer->producer = _sem::semaphore_create(size);
    80006b3c:	00090513          	mv	a0,s2
    80006b40:	fffff097          	auipc	ra,0xfffff
    80006b44:	1f4080e7          	jalr	500(ra) # 80005d34 <_ZN4_sem16semaphore_createEj>
    80006b48:	00050913          	mv	s2,a0
    80006b4c:	00a4bc23          	sd	a0,24(s1)
    if (!buffer->producer)
    80006b50:	06050863          	beqz	a0,80006bc0 <_ZN7_buffer13buffer_createEj+0x11c>
    {
        MemoryAllocator::__get_instance()->__mem_free(buffer->buffer);
        MemoryAllocator::__get_instance()->__mem_free(buffer);
        return nullptr;
    }
    buffer->consumer = _sem::semaphore_create(0);
    80006b54:	00000513          	li	a0,0
    80006b58:	fffff097          	auipc	ra,0xfffff
    80006b5c:	1dc080e7          	jalr	476(ra) # 80005d34 <_ZN4_sem16semaphore_createEj>
    80006b60:	00050913          	mv	s2,a0
    80006b64:	02a4b023          	sd	a0,32(s1)
    if(!buffer->consumer)
    80006b68:	08050463          	beqz	a0,80006bf0 <_ZN7_buffer13buffer_createEj+0x14c>
        MemoryAllocator::__get_instance()->__mem_free(buffer->producer);
        MemoryAllocator::__get_instance()->__mem_free(buffer->buffer);
        MemoryAllocator::__get_instance()->__mem_free(buffer);
        return nullptr;
    }
    buffer->mutex = _sem::semaphore_create(1);
    80006b6c:	00100513          	li	a0,1
    80006b70:	fffff097          	auipc	ra,0xfffff
    80006b74:	1c4080e7          	jalr	452(ra) # 80005d34 <_ZN4_sem16semaphore_createEj>
    80006b78:	00050913          	mv	s2,a0
    80006b7c:	02a4b423          	sd	a0,40(s1)
    if (!buffer->mutex)
    80006b80:	0a050a63          	beqz	a0,80006c34 <_ZN7_buffer13buffer_createEj+0x190>
        MemoryAllocator::__get_instance()->__mem_free(buffer);
        return nullptr;
    }

    return buffer;
}
    80006b84:	00048513          	mv	a0,s1
    80006b88:	02813083          	ld	ra,40(sp)
    80006b8c:	02013403          	ld	s0,32(sp)
    80006b90:	01813483          	ld	s1,24(sp)
    80006b94:	01013903          	ld	s2,16(sp)
    80006b98:	00813983          	ld	s3,8(sp)
    80006b9c:	03010113          	addi	sp,sp,48
    80006ba0:	00008067          	ret
        MemoryAllocator::__get_instance()->__mem_free(buffer);
    80006ba4:	00000097          	auipc	ra,0x0
    80006ba8:	b90080e7          	jalr	-1136(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80006bac:	00048593          	mv	a1,s1
    80006bb0:	00000097          	auipc	ra,0x0
    80006bb4:	d74080e7          	jalr	-652(ra) # 80006924 <_ZN15MemoryAllocator10__mem_freeEPv>
        return nullptr;
    80006bb8:	00098493          	mv	s1,s3
    80006bbc:	fc9ff06f          	j	80006b84 <_ZN7_buffer13buffer_createEj+0xe0>
        MemoryAllocator::__get_instance()->__mem_free(buffer->buffer);
    80006bc0:	00000097          	auipc	ra,0x0
    80006bc4:	b74080e7          	jalr	-1164(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80006bc8:	0104b583          	ld	a1,16(s1)
    80006bcc:	00000097          	auipc	ra,0x0
    80006bd0:	d58080e7          	jalr	-680(ra) # 80006924 <_ZN15MemoryAllocator10__mem_freeEPv>
        MemoryAllocator::__get_instance()->__mem_free(buffer);
    80006bd4:	00000097          	auipc	ra,0x0
    80006bd8:	b60080e7          	jalr	-1184(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80006bdc:	00048593          	mv	a1,s1
    80006be0:	00000097          	auipc	ra,0x0
    80006be4:	d44080e7          	jalr	-700(ra) # 80006924 <_ZN15MemoryAllocator10__mem_freeEPv>
        return nullptr;
    80006be8:	00090493          	mv	s1,s2
    80006bec:	f99ff06f          	j	80006b84 <_ZN7_buffer13buffer_createEj+0xe0>
        MemoryAllocator::__get_instance()->__mem_free(buffer->producer);
    80006bf0:	00000097          	auipc	ra,0x0
    80006bf4:	b44080e7          	jalr	-1212(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80006bf8:	0184b583          	ld	a1,24(s1)
    80006bfc:	00000097          	auipc	ra,0x0
    80006c00:	d28080e7          	jalr	-728(ra) # 80006924 <_ZN15MemoryAllocator10__mem_freeEPv>
        MemoryAllocator::__get_instance()->__mem_free(buffer->buffer);
    80006c04:	00000097          	auipc	ra,0x0
    80006c08:	b30080e7          	jalr	-1232(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80006c0c:	0104b583          	ld	a1,16(s1)
    80006c10:	00000097          	auipc	ra,0x0
    80006c14:	d14080e7          	jalr	-748(ra) # 80006924 <_ZN15MemoryAllocator10__mem_freeEPv>
        MemoryAllocator::__get_instance()->__mem_free(buffer);
    80006c18:	00000097          	auipc	ra,0x0
    80006c1c:	b1c080e7          	jalr	-1252(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80006c20:	00048593          	mv	a1,s1
    80006c24:	00000097          	auipc	ra,0x0
    80006c28:	d00080e7          	jalr	-768(ra) # 80006924 <_ZN15MemoryAllocator10__mem_freeEPv>
        return nullptr;
    80006c2c:	00090493          	mv	s1,s2
    80006c30:	f55ff06f          	j	80006b84 <_ZN7_buffer13buffer_createEj+0xe0>
        MemoryAllocator::__get_instance()->__mem_free(buffer->producer);
    80006c34:	00000097          	auipc	ra,0x0
    80006c38:	b00080e7          	jalr	-1280(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80006c3c:	0184b583          	ld	a1,24(s1)
    80006c40:	00000097          	auipc	ra,0x0
    80006c44:	ce4080e7          	jalr	-796(ra) # 80006924 <_ZN15MemoryAllocator10__mem_freeEPv>
        MemoryAllocator::__get_instance()->__mem_free(buffer->consumer);
    80006c48:	00000097          	auipc	ra,0x0
    80006c4c:	aec080e7          	jalr	-1300(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80006c50:	0204b583          	ld	a1,32(s1)
    80006c54:	00000097          	auipc	ra,0x0
    80006c58:	cd0080e7          	jalr	-816(ra) # 80006924 <_ZN15MemoryAllocator10__mem_freeEPv>
        MemoryAllocator::__get_instance()->__mem_free(buffer->buffer);
    80006c5c:	00000097          	auipc	ra,0x0
    80006c60:	ad8080e7          	jalr	-1320(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80006c64:	0104b583          	ld	a1,16(s1)
    80006c68:	00000097          	auipc	ra,0x0
    80006c6c:	cbc080e7          	jalr	-836(ra) # 80006924 <_ZN15MemoryAllocator10__mem_freeEPv>
        MemoryAllocator::__get_instance()->__mem_free(buffer);
    80006c70:	00000097          	auipc	ra,0x0
    80006c74:	ac4080e7          	jalr	-1340(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80006c78:	00048593          	mv	a1,s1
    80006c7c:	00000097          	auipc	ra,0x0
    80006c80:	ca8080e7          	jalr	-856(ra) # 80006924 <_ZN15MemoryAllocator10__mem_freeEPv>
        return nullptr;
    80006c84:	00090493          	mv	s1,s2
    80006c88:	efdff06f          	j	80006b84 <_ZN7_buffer13buffer_createEj+0xe0>

0000000080006c8c <_ZN7_buffer7produceEPS_cb>:

void _buffer::produce(buffer_t buffer, char c, bool isSysCall)
{
    80006c8c:	fd010113          	addi	sp,sp,-48
    80006c90:	02113423          	sd	ra,40(sp)
    80006c94:	02813023          	sd	s0,32(sp)
    80006c98:	00913c23          	sd	s1,24(sp)
    80006c9c:	01213823          	sd	s2,16(sp)
    80006ca0:	01313423          	sd	s3,8(sp)
    80006ca4:	03010413          	addi	s0,sp,48
    80006ca8:	00050493          	mv	s1,a0
    80006cac:	00058993          	mv	s3,a1
    80006cb0:	00060913          	mv	s2,a2
    int res;
    if (!isSysCall)
    80006cb4:	08061863          	bnez	a2,80006d44 <_ZN7_buffer7produceEPS_cb+0xb8>
        res = sem_wait(buffer->producer);
    80006cb8:	01853503          	ld	a0,24(a0)
    80006cbc:	ffffb097          	auipc	ra,0xffffb
    80006cc0:	ec0080e7          	jalr	-320(ra) # 80001b7c <sem_wait>
    else
        res = _sem::wait(buffer->producer);
    if (res < 0)
    80006cc4:	08054863          	bltz	a0,80006d54 <_ZN7_buffer7produceEPS_cb+0xc8>
        _thread::thread_exit();
    if (!isSysCall)
    80006cc8:	08091c63          	bnez	s2,80006d60 <_ZN7_buffer7produceEPS_cb+0xd4>
        sem_wait(buffer->mutex);
    80006ccc:	0284b503          	ld	a0,40(s1)
    80006cd0:	ffffb097          	auipc	ra,0xffffb
    80006cd4:	eac080e7          	jalr	-340(ra) # 80001b7c <sem_wait>
    else
        _sem::wait(buffer->mutex);
    buffer->buffer[buffer->head] = c;
    80006cd8:	0104b783          	ld	a5,16(s1)
    80006cdc:	0004e703          	lwu	a4,0(s1)
    80006ce0:	00e787b3          	add	a5,a5,a4
    80006ce4:	01378023          	sb	s3,0(a5)
    buffer->head = (buffer->head + 1) % buffer->size;
    80006ce8:	0004a783          	lw	a5,0(s1)
    80006cec:	0017879b          	addiw	a5,a5,1
    80006cf0:	0084a703          	lw	a4,8(s1)
    80006cf4:	02e7f7bb          	remuw	a5,a5,a4
    80006cf8:	00f4a023          	sw	a5,0(s1)
    ++buffer->occupied;
    80006cfc:	00c4a783          	lw	a5,12(s1)
    80006d00:	0017879b          	addiw	a5,a5,1
    80006d04:	00f4a623          	sw	a5,12(s1)
    if (!isSysCall)
    80006d08:	06091463          	bnez	s2,80006d70 <_ZN7_buffer7produceEPS_cb+0xe4>
        sem_signal(buffer->mutex);
    80006d0c:	0284b503          	ld	a0,40(s1)
    80006d10:	ffffb097          	auipc	ra,0xffffb
    80006d14:	ea4080e7          	jalr	-348(ra) # 80001bb4 <sem_signal>
    else
        _sem::signal(buffer->mutex);
    if (!isSysCall)
    80006d18:	06091463          	bnez	s2,80006d80 <_ZN7_buffer7produceEPS_cb+0xf4>
        sem_signal(buffer->consumer);
    80006d1c:	0204b503          	ld	a0,32(s1)
    80006d20:	ffffb097          	auipc	ra,0xffffb
    80006d24:	e94080e7          	jalr	-364(ra) # 80001bb4 <sem_signal>
    else
        _sem::signal(buffer->consumer);
}
    80006d28:	02813083          	ld	ra,40(sp)
    80006d2c:	02013403          	ld	s0,32(sp)
    80006d30:	01813483          	ld	s1,24(sp)
    80006d34:	01013903          	ld	s2,16(sp)
    80006d38:	00813983          	ld	s3,8(sp)
    80006d3c:	03010113          	addi	sp,sp,48
    80006d40:	00008067          	ret
        res = _sem::wait(buffer->producer);
    80006d44:	01853503          	ld	a0,24(a0)
    80006d48:	fffff097          	auipc	ra,0xfffff
    80006d4c:	1ac080e7          	jalr	428(ra) # 80005ef4 <_ZN4_sem4waitEPS_>
    80006d50:	f75ff06f          	j	80006cc4 <_ZN7_buffer7produceEPS_cb+0x38>
        _thread::thread_exit();
    80006d54:	ffffb097          	auipc	ra,0xffffb
    80006d58:	670080e7          	jalr	1648(ra) # 800023c4 <_ZN7_thread11thread_exitEv>
    80006d5c:	f6dff06f          	j	80006cc8 <_ZN7_buffer7produceEPS_cb+0x3c>
        _sem::wait(buffer->mutex);
    80006d60:	0284b503          	ld	a0,40(s1)
    80006d64:	fffff097          	auipc	ra,0xfffff
    80006d68:	190080e7          	jalr	400(ra) # 80005ef4 <_ZN4_sem4waitEPS_>
    80006d6c:	f6dff06f          	j	80006cd8 <_ZN7_buffer7produceEPS_cb+0x4c>
        _sem::signal(buffer->mutex);
    80006d70:	0284b503          	ld	a0,40(s1)
    80006d74:	fffff097          	auipc	ra,0xfffff
    80006d78:	0f4080e7          	jalr	244(ra) # 80005e68 <_ZN4_sem6signalEPS_>
    80006d7c:	f9dff06f          	j	80006d18 <_ZN7_buffer7produceEPS_cb+0x8c>
        _sem::signal(buffer->consumer);
    80006d80:	0204b503          	ld	a0,32(s1)
    80006d84:	fffff097          	auipc	ra,0xfffff
    80006d88:	0e4080e7          	jalr	228(ra) # 80005e68 <_ZN4_sem6signalEPS_>
}
    80006d8c:	f9dff06f          	j	80006d28 <_ZN7_buffer7produceEPS_cb+0x9c>

0000000080006d90 <_ZN7_buffer6isFullEPS_>:

    return c;
}

bool _buffer::isFull(buffer_t buffer)
{
    80006d90:	ff010113          	addi	sp,sp,-16
    80006d94:	00813423          	sd	s0,8(sp)
    80006d98:	01010413          	addi	s0,sp,16
    return buffer->occupied == buffer->size;
    80006d9c:	00c52783          	lw	a5,12(a0)
    80006da0:	00852503          	lw	a0,8(a0)
    80006da4:	40f50533          	sub	a0,a0,a5
}
    80006da8:	00153513          	seqz	a0,a0
    80006dac:	00813403          	ld	s0,8(sp)
    80006db0:	01010113          	addi	sp,sp,16
    80006db4:	00008067          	ret

0000000080006db8 <_ZN7_buffer7consumeEPS_b>:
{
    80006db8:	fd010113          	addi	sp,sp,-48
    80006dbc:	02113423          	sd	ra,40(sp)
    80006dc0:	02813023          	sd	s0,32(sp)
    80006dc4:	00913c23          	sd	s1,24(sp)
    80006dc8:	01213823          	sd	s2,16(sp)
    80006dcc:	01313423          	sd	s3,8(sp)
    80006dd0:	03010413          	addi	s0,sp,48
    80006dd4:	00050493          	mv	s1,a0
    80006dd8:	00058913          	mv	s2,a1
    if (!isSysCall)
    80006ddc:	0a059063          	bnez	a1,80006e7c <_ZN7_buffer7consumeEPS_b+0xc4>
        sem_wait(buffer->consumer);
    80006de0:	02053503          	ld	a0,32(a0)
    80006de4:	ffffb097          	auipc	ra,0xffffb
    80006de8:	d98080e7          	jalr	-616(ra) # 80001b7c <sem_wait>
    if (!isSysCall)
    80006dec:	0a091063          	bnez	s2,80006e8c <_ZN7_buffer7consumeEPS_b+0xd4>
        sem_wait(buffer->mutex);
    80006df0:	0284b503          	ld	a0,40(s1)
    80006df4:	ffffb097          	auipc	ra,0xffffb
    80006df8:	d88080e7          	jalr	-632(ra) # 80001b7c <sem_wait>
    if (buffer == _buffer::getcBuffer)
    80006dfc:	00006517          	auipc	a0,0x6
    80006e00:	cf453503          	ld	a0,-780(a0) # 8000caf0 <_ZN7_buffer10getcBufferE>
    80006e04:	08950c63          	beq	a0,s1,80006e9c <_ZN7_buffer7consumeEPS_b+0xe4>
    char c = buffer->buffer[buffer->tail];
    80006e08:	0104b703          	ld	a4,16(s1)
    80006e0c:	0044a783          	lw	a5,4(s1)
    80006e10:	02079693          	slli	a3,a5,0x20
    80006e14:	0206d693          	srli	a3,a3,0x20
    80006e18:	00d70733          	add	a4,a4,a3
    80006e1c:	00074983          	lbu	s3,0(a4)
    buffer->tail = (buffer->tail + 1) % buffer->size;
    80006e20:	0017879b          	addiw	a5,a5,1
    80006e24:	0084a703          	lw	a4,8(s1)
    80006e28:	02e7f7bb          	remuw	a5,a5,a4
    80006e2c:	00f4a223          	sw	a5,4(s1)
    --buffer->occupied;
    80006e30:	00c4a783          	lw	a5,12(s1)
    80006e34:	fff7879b          	addiw	a5,a5,-1
    80006e38:	00f4a623          	sw	a5,12(s1)
    if (!isSysCall)
    80006e3c:	06091e63          	bnez	s2,80006eb8 <_ZN7_buffer7consumeEPS_b+0x100>
        sem_signal(buffer->mutex);
    80006e40:	0284b503          	ld	a0,40(s1)
    80006e44:	ffffb097          	auipc	ra,0xffffb
    80006e48:	d70080e7          	jalr	-656(ra) # 80001bb4 <sem_signal>
    if (!isSysCall)
    80006e4c:	06091e63          	bnez	s2,80006ec8 <_ZN7_buffer7consumeEPS_b+0x110>
        sem_signal(buffer->producer);
    80006e50:	0184b503          	ld	a0,24(s1)
    80006e54:	ffffb097          	auipc	ra,0xffffb
    80006e58:	d60080e7          	jalr	-672(ra) # 80001bb4 <sem_signal>
}
    80006e5c:	00098513          	mv	a0,s3
    80006e60:	02813083          	ld	ra,40(sp)
    80006e64:	02013403          	ld	s0,32(sp)
    80006e68:	01813483          	ld	s1,24(sp)
    80006e6c:	01013903          	ld	s2,16(sp)
    80006e70:	00813983          	ld	s3,8(sp)
    80006e74:	03010113          	addi	sp,sp,48
    80006e78:	00008067          	ret
        _sem::wait(buffer->consumer);
    80006e7c:	02053503          	ld	a0,32(a0)
    80006e80:	fffff097          	auipc	ra,0xfffff
    80006e84:	074080e7          	jalr	116(ra) # 80005ef4 <_ZN4_sem4waitEPS_>
    80006e88:	f65ff06f          	j	80006dec <_ZN7_buffer7consumeEPS_b+0x34>
        _sem::wait(buffer->mutex);
    80006e8c:	0284b503          	ld	a0,40(s1)
    80006e90:	fffff097          	auipc	ra,0xfffff
    80006e94:	064080e7          	jalr	100(ra) # 80005ef4 <_ZN4_sem4waitEPS_>
    80006e98:	f65ff06f          	j	80006dfc <_ZN7_buffer7consumeEPS_b+0x44>
        if (_buffer::isFull(_buffer::getcBuffer))
    80006e9c:	00000097          	auipc	ra,0x0
    80006ea0:	ef4080e7          	jalr	-268(ra) # 80006d90 <_ZN7_buffer6isFullEPS_>
    80006ea4:	f60502e3          	beqz	a0,80006e08 <_ZN7_buffer7consumeEPS_b+0x50>
            plic_complete(CONSOLE_IRQ);
    80006ea8:	00a00513          	li	a0,10
    80006eac:	00001097          	auipc	ra,0x1
    80006eb0:	c70080e7          	jalr	-912(ra) # 80007b1c <plic_complete>
    80006eb4:	f55ff06f          	j	80006e08 <_ZN7_buffer7consumeEPS_b+0x50>
        _sem::signal(buffer->mutex);
    80006eb8:	0284b503          	ld	a0,40(s1)
    80006ebc:	fffff097          	auipc	ra,0xfffff
    80006ec0:	fac080e7          	jalr	-84(ra) # 80005e68 <_ZN4_sem6signalEPS_>
    80006ec4:	f89ff06f          	j	80006e4c <_ZN7_buffer7consumeEPS_b+0x94>
        _sem::signal(buffer->producer);
    80006ec8:	0184b503          	ld	a0,24(s1)
    80006ecc:	fffff097          	auipc	ra,0xfffff
    80006ed0:	f9c080e7          	jalr	-100(ra) # 80005e68 <_ZN4_sem6signalEPS_>
    80006ed4:	f89ff06f          	j	80006e5c <_ZN7_buffer7consumeEPS_b+0xa4>

0000000080006ed8 <_ZN7_buffer7isEmptyEPS_>:

bool _buffer::isEmpty(buffer_t buffer)
{
    80006ed8:	ff010113          	addi	sp,sp,-16
    80006edc:	00813423          	sd	s0,8(sp)
    80006ee0:	01010413          	addi	s0,sp,16
    return buffer->occupied == 0;
    80006ee4:	00c52503          	lw	a0,12(a0)
}
    80006ee8:	00153513          	seqz	a0,a0
    80006eec:	00813403          	ld	s0,8(sp)
    80006ef0:	01010113          	addi	sp,sp,16
    80006ef4:	00008067          	ret

0000000080006ef8 <_ZN7_buffer11buffer_freeEPS_>:

void _buffer::buffer_free(buffer_t buffer)
{
    80006ef8:	fe010113          	addi	sp,sp,-32
    80006efc:	00113c23          	sd	ra,24(sp)
    80006f00:	00813823          	sd	s0,16(sp)
    80006f04:	00913423          	sd	s1,8(sp)
    80006f08:	02010413          	addi	s0,sp,32
    80006f0c:	00050493          	mv	s1,a0
    _sem::close(buffer->producer, _thread::SEMCLOSED);
    80006f10:	00100593          	li	a1,1
    80006f14:	01853503          	ld	a0,24(a0)
    80006f18:	fffff097          	auipc	ra,0xfffff
    80006f1c:	ea0080e7          	jalr	-352(ra) # 80005db8 <_ZN4_sem5closeEPS_N7_thread14semReturnValueE>
    _sem::close(buffer->consumer, _thread::SEMCLOSED);
    80006f20:	00100593          	li	a1,1
    80006f24:	0204b503          	ld	a0,32(s1)
    80006f28:	fffff097          	auipc	ra,0xfffff
    80006f2c:	e90080e7          	jalr	-368(ra) # 80005db8 <_ZN4_sem5closeEPS_N7_thread14semReturnValueE>
    MemoryAllocator::__get_instance()->__mem_free(buffer->buffer);
    80006f30:	00000097          	auipc	ra,0x0
    80006f34:	804080e7          	jalr	-2044(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80006f38:	0104b583          	ld	a1,16(s1)
    80006f3c:	00000097          	auipc	ra,0x0
    80006f40:	9e8080e7          	jalr	-1560(ra) # 80006924 <_ZN15MemoryAllocator10__mem_freeEPv>
    MemoryAllocator::__get_instance()->__mem_free(buffer);
    80006f44:	fffff097          	auipc	ra,0xfffff
    80006f48:	7f0080e7          	jalr	2032(ra) # 80006734 <_ZN15MemoryAllocator14__get_instanceEv>
    80006f4c:	00048593          	mv	a1,s1
    80006f50:	00000097          	auipc	ra,0x0
    80006f54:	9d4080e7          	jalr	-1580(ra) # 80006924 <_ZN15MemoryAllocator10__mem_freeEPv>
}
    80006f58:	01813083          	ld	ra,24(sp)
    80006f5c:	01013403          	ld	s0,16(sp)
    80006f60:	00813483          	ld	s1,8(sp)
    80006f64:	02010113          	addi	sp,sp,32
    80006f68:	00008067          	ret

0000000080006f6c <_ZN6BufferC1Ei>:
#include "../test/buffer.hpp"
#include "../h/syscall_c.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80006f6c:	fe010113          	addi	sp,sp,-32
    80006f70:	00113c23          	sd	ra,24(sp)
    80006f74:	00813823          	sd	s0,16(sp)
    80006f78:	00913423          	sd	s1,8(sp)
    80006f7c:	01213023          	sd	s2,0(sp)
    80006f80:	02010413          	addi	s0,sp,32
    80006f84:	00050493          	mv	s1,a0
    80006f88:	00058913          	mv	s2,a1
    80006f8c:	0015879b          	addiw	a5,a1,1
    80006f90:	0007851b          	sext.w	a0,a5
    80006f94:	00f4a023          	sw	a5,0(s1)
    80006f98:	0004a823          	sw	zero,16(s1)
    80006f9c:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)__mem_alloc(sizeof(int) * cap);
    80006fa0:	00251513          	slli	a0,a0,0x2
    80006fa4:	ffffb097          	auipc	ra,0xffffb
    80006fa8:	a50080e7          	jalr	-1456(ra) # 800019f4 <__mem_alloc>
    80006fac:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80006fb0:	00000593          	li	a1,0
    80006fb4:	02048513          	addi	a0,s1,32
    80006fb8:	ffffb097          	auipc	ra,0xffffb
    80006fbc:	b50080e7          	jalr	-1200(ra) # 80001b08 <sem_open>
    sem_open(&spaceAvailable, _cap);
    80006fc0:	00090593          	mv	a1,s2
    80006fc4:	01848513          	addi	a0,s1,24
    80006fc8:	ffffb097          	auipc	ra,0xffffb
    80006fcc:	b40080e7          	jalr	-1216(ra) # 80001b08 <sem_open>
    sem_open(&mutexHead, 1);
    80006fd0:	00100593          	li	a1,1
    80006fd4:	02848513          	addi	a0,s1,40
    80006fd8:	ffffb097          	auipc	ra,0xffffb
    80006fdc:	b30080e7          	jalr	-1232(ra) # 80001b08 <sem_open>
    sem_open(&mutexTail, 1);
    80006fe0:	00100593          	li	a1,1
    80006fe4:	03048513          	addi	a0,s1,48
    80006fe8:	ffffb097          	auipc	ra,0xffffb
    80006fec:	b20080e7          	jalr	-1248(ra) # 80001b08 <sem_open>
}
    80006ff0:	01813083          	ld	ra,24(sp)
    80006ff4:	01013403          	ld	s0,16(sp)
    80006ff8:	00813483          	ld	s1,8(sp)
    80006ffc:	00013903          	ld	s2,0(sp)
    80007000:	02010113          	addi	sp,sp,32
    80007004:	00008067          	ret

0000000080007008 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80007008:	fe010113          	addi	sp,sp,-32
    8000700c:	00113c23          	sd	ra,24(sp)
    80007010:	00813823          	sd	s0,16(sp)
    80007014:	00913423          	sd	s1,8(sp)
    80007018:	01213023          	sd	s2,0(sp)
    8000701c:	02010413          	addi	s0,sp,32
    80007020:	00050493          	mv	s1,a0
    80007024:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80007028:	01853503          	ld	a0,24(a0)
    8000702c:	ffffb097          	auipc	ra,0xffffb
    80007030:	b50080e7          	jalr	-1200(ra) # 80001b7c <sem_wait>

    sem_wait(mutexTail);
    80007034:	0304b503          	ld	a0,48(s1)
    80007038:	ffffb097          	auipc	ra,0xffffb
    8000703c:	b44080e7          	jalr	-1212(ra) # 80001b7c <sem_wait>
    buffer[tail] = val;
    80007040:	0084b783          	ld	a5,8(s1)
    80007044:	0144a703          	lw	a4,20(s1)
    80007048:	00271713          	slli	a4,a4,0x2
    8000704c:	00e787b3          	add	a5,a5,a4
    80007050:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80007054:	0144a783          	lw	a5,20(s1)
    80007058:	0017879b          	addiw	a5,a5,1
    8000705c:	0004a703          	lw	a4,0(s1)
    80007060:	02e7e7bb          	remw	a5,a5,a4
    80007064:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80007068:	0304b503          	ld	a0,48(s1)
    8000706c:	ffffb097          	auipc	ra,0xffffb
    80007070:	b48080e7          	jalr	-1208(ra) # 80001bb4 <sem_signal>

    sem_signal(itemAvailable);
    80007074:	0204b503          	ld	a0,32(s1)
    80007078:	ffffb097          	auipc	ra,0xffffb
    8000707c:	b3c080e7          	jalr	-1220(ra) # 80001bb4 <sem_signal>

}
    80007080:	01813083          	ld	ra,24(sp)
    80007084:	01013403          	ld	s0,16(sp)
    80007088:	00813483          	ld	s1,8(sp)
    8000708c:	00013903          	ld	s2,0(sp)
    80007090:	02010113          	addi	sp,sp,32
    80007094:	00008067          	ret

0000000080007098 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80007098:	fe010113          	addi	sp,sp,-32
    8000709c:	00113c23          	sd	ra,24(sp)
    800070a0:	00813823          	sd	s0,16(sp)
    800070a4:	00913423          	sd	s1,8(sp)
    800070a8:	01213023          	sd	s2,0(sp)
    800070ac:	02010413          	addi	s0,sp,32
    800070b0:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    800070b4:	02053503          	ld	a0,32(a0)
    800070b8:	ffffb097          	auipc	ra,0xffffb
    800070bc:	ac4080e7          	jalr	-1340(ra) # 80001b7c <sem_wait>

    sem_wait(mutexHead);
    800070c0:	0284b503          	ld	a0,40(s1)
    800070c4:	ffffb097          	auipc	ra,0xffffb
    800070c8:	ab8080e7          	jalr	-1352(ra) # 80001b7c <sem_wait>

    int ret = buffer[head];
    800070cc:	0084b703          	ld	a4,8(s1)
    800070d0:	0104a783          	lw	a5,16(s1)
    800070d4:	00279693          	slli	a3,a5,0x2
    800070d8:	00d70733          	add	a4,a4,a3
    800070dc:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    800070e0:	0017879b          	addiw	a5,a5,1
    800070e4:	0004a703          	lw	a4,0(s1)
    800070e8:	02e7e7bb          	remw	a5,a5,a4
    800070ec:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    800070f0:	0284b503          	ld	a0,40(s1)
    800070f4:	ffffb097          	auipc	ra,0xffffb
    800070f8:	ac0080e7          	jalr	-1344(ra) # 80001bb4 <sem_signal>

    sem_signal(spaceAvailable);
    800070fc:	0184b503          	ld	a0,24(s1)
    80007100:	ffffb097          	auipc	ra,0xffffb
    80007104:	ab4080e7          	jalr	-1356(ra) # 80001bb4 <sem_signal>

    return ret;
}
    80007108:	00090513          	mv	a0,s2
    8000710c:	01813083          	ld	ra,24(sp)
    80007110:	01013403          	ld	s0,16(sp)
    80007114:	00813483          	ld	s1,8(sp)
    80007118:	00013903          	ld	s2,0(sp)
    8000711c:	02010113          	addi	sp,sp,32
    80007120:	00008067          	ret

0000000080007124 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80007124:	fe010113          	addi	sp,sp,-32
    80007128:	00113c23          	sd	ra,24(sp)
    8000712c:	00813823          	sd	s0,16(sp)
    80007130:	00913423          	sd	s1,8(sp)
    80007134:	01213023          	sd	s2,0(sp)
    80007138:	02010413          	addi	s0,sp,32
    8000713c:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80007140:	02853503          	ld	a0,40(a0)
    80007144:	ffffb097          	auipc	ra,0xffffb
    80007148:	a38080e7          	jalr	-1480(ra) # 80001b7c <sem_wait>
    sem_wait(mutexTail);
    8000714c:	0304b503          	ld	a0,48(s1)
    80007150:	ffffb097          	auipc	ra,0xffffb
    80007154:	a2c080e7          	jalr	-1492(ra) # 80001b7c <sem_wait>

    if (tail >= head) {
    80007158:	0144a783          	lw	a5,20(s1)
    8000715c:	0104a903          	lw	s2,16(s1)
    80007160:	0327ce63          	blt	a5,s2,8000719c <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80007164:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80007168:	0304b503          	ld	a0,48(s1)
    8000716c:	ffffb097          	auipc	ra,0xffffb
    80007170:	a48080e7          	jalr	-1464(ra) # 80001bb4 <sem_signal>
    sem_signal(mutexHead);
    80007174:	0284b503          	ld	a0,40(s1)
    80007178:	ffffb097          	auipc	ra,0xffffb
    8000717c:	a3c080e7          	jalr	-1476(ra) # 80001bb4 <sem_signal>

    return ret;
}
    80007180:	00090513          	mv	a0,s2
    80007184:	01813083          	ld	ra,24(sp)
    80007188:	01013403          	ld	s0,16(sp)
    8000718c:	00813483          	ld	s1,8(sp)
    80007190:	00013903          	ld	s2,0(sp)
    80007194:	02010113          	addi	sp,sp,32
    80007198:	00008067          	ret
        ret = cap - head + tail;
    8000719c:	0004a703          	lw	a4,0(s1)
    800071a0:	4127093b          	subw	s2,a4,s2
    800071a4:	00f9093b          	addw	s2,s2,a5
    800071a8:	fc1ff06f          	j	80007168 <_ZN6Buffer6getCntEv+0x44>

00000000800071ac <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    800071ac:	fe010113          	addi	sp,sp,-32
    800071b0:	00113c23          	sd	ra,24(sp)
    800071b4:	00813823          	sd	s0,16(sp)
    800071b8:	00913423          	sd	s1,8(sp)
    800071bc:	02010413          	addi	s0,sp,32
    800071c0:	00050493          	mv	s1,a0
    putc('\n');
    800071c4:	00a00513          	li	a0,10
    800071c8:	ffffb097          	auipc	ra,0xffffb
    800071cc:	a54080e7          	jalr	-1452(ra) # 80001c1c <putc>
    printString("Buffer deleted!\n");
    800071d0:	00003517          	auipc	a0,0x3
    800071d4:	04050513          	addi	a0,a0,64 # 8000a210 <CONSOLE_STATUS+0x200>
    800071d8:	ffffe097          	auipc	ra,0xffffe
    800071dc:	91c080e7          	jalr	-1764(ra) # 80004af4 <_Z11printStringPKc>
    while (getCnt() > 0) {
    800071e0:	00048513          	mv	a0,s1
    800071e4:	00000097          	auipc	ra,0x0
    800071e8:	f40080e7          	jalr	-192(ra) # 80007124 <_ZN6Buffer6getCntEv>
    800071ec:	02a05c63          	blez	a0,80007224 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    800071f0:	0084b783          	ld	a5,8(s1)
    800071f4:	0104a703          	lw	a4,16(s1)
    800071f8:	00271713          	slli	a4,a4,0x2
    800071fc:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80007200:	0007c503          	lbu	a0,0(a5)
    80007204:	ffffb097          	auipc	ra,0xffffb
    80007208:	a18080e7          	jalr	-1512(ra) # 80001c1c <putc>
        head = (head + 1) % cap;
    8000720c:	0104a783          	lw	a5,16(s1)
    80007210:	0017879b          	addiw	a5,a5,1
    80007214:	0004a703          	lw	a4,0(s1)
    80007218:	02e7e7bb          	remw	a5,a5,a4
    8000721c:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80007220:	fc1ff06f          	j	800071e0 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80007224:	02100513          	li	a0,33
    80007228:	ffffb097          	auipc	ra,0xffffb
    8000722c:	9f4080e7          	jalr	-1548(ra) # 80001c1c <putc>
    putc('\n');
    80007230:	00a00513          	li	a0,10
    80007234:	ffffb097          	auipc	ra,0xffffb
    80007238:	9e8080e7          	jalr	-1560(ra) # 80001c1c <putc>
    __mem_free(buffer);
    8000723c:	0084b503          	ld	a0,8(s1)
    80007240:	ffffa097          	auipc	ra,0xffffa
    80007244:	7f0080e7          	jalr	2032(ra) # 80001a30 <__mem_free>
    sem_close(itemAvailable);
    80007248:	0204b503          	ld	a0,32(s1)
    8000724c:	ffffb097          	auipc	ra,0xffffb
    80007250:	8f8080e7          	jalr	-1800(ra) # 80001b44 <sem_close>
    sem_close(spaceAvailable);
    80007254:	0184b503          	ld	a0,24(s1)
    80007258:	ffffb097          	auipc	ra,0xffffb
    8000725c:	8ec080e7          	jalr	-1812(ra) # 80001b44 <sem_close>
    sem_close(mutexTail);
    80007260:	0304b503          	ld	a0,48(s1)
    80007264:	ffffb097          	auipc	ra,0xffffb
    80007268:	8e0080e7          	jalr	-1824(ra) # 80001b44 <sem_close>
    sem_close(mutexHead);
    8000726c:	0284b503          	ld	a0,40(s1)
    80007270:	ffffb097          	auipc	ra,0xffffb
    80007274:	8d4080e7          	jalr	-1836(ra) # 80001b44 <sem_close>
}
    80007278:	01813083          	ld	ra,24(sp)
    8000727c:	01013403          	ld	s0,16(sp)
    80007280:	00813483          	ld	s1,8(sp)
    80007284:	02010113          	addi	sp,sp,32
    80007288:	00008067          	ret

000000008000728c <start>:
    8000728c:	ff010113          	addi	sp,sp,-16
    80007290:	00813423          	sd	s0,8(sp)
    80007294:	01010413          	addi	s0,sp,16
    80007298:	300027f3          	csrr	a5,mstatus
    8000729c:	ffffe737          	lui	a4,0xffffe
    800072a0:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff0a9f>
    800072a4:	00e7f7b3          	and	a5,a5,a4
    800072a8:	00001737          	lui	a4,0x1
    800072ac:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800072b0:	00e7e7b3          	or	a5,a5,a4
    800072b4:	30079073          	csrw	mstatus,a5
    800072b8:	00000797          	auipc	a5,0x0
    800072bc:	16078793          	addi	a5,a5,352 # 80007418 <system_main>
    800072c0:	34179073          	csrw	mepc,a5
    800072c4:	00000793          	li	a5,0
    800072c8:	18079073          	csrw	satp,a5
    800072cc:	000107b7          	lui	a5,0x10
    800072d0:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800072d4:	30279073          	csrw	medeleg,a5
    800072d8:	30379073          	csrw	mideleg,a5
    800072dc:	104027f3          	csrr	a5,sie
    800072e0:	2227e793          	ori	a5,a5,546
    800072e4:	10479073          	csrw	sie,a5
    800072e8:	fff00793          	li	a5,-1
    800072ec:	00a7d793          	srli	a5,a5,0xa
    800072f0:	3b079073          	csrw	pmpaddr0,a5
    800072f4:	00f00793          	li	a5,15
    800072f8:	3a079073          	csrw	pmpcfg0,a5
    800072fc:	f14027f3          	csrr	a5,mhartid
    80007300:	0200c737          	lui	a4,0x200c
    80007304:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80007308:	0007869b          	sext.w	a3,a5
    8000730c:	00269713          	slli	a4,a3,0x2
    80007310:	000f4637          	lui	a2,0xf4
    80007314:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80007318:	00d70733          	add	a4,a4,a3
    8000731c:	0037979b          	slliw	a5,a5,0x3
    80007320:	020046b7          	lui	a3,0x2004
    80007324:	00d787b3          	add	a5,a5,a3
    80007328:	00c585b3          	add	a1,a1,a2
    8000732c:	00371693          	slli	a3,a4,0x3
    80007330:	00005717          	auipc	a4,0x5
    80007334:	7d070713          	addi	a4,a4,2000 # 8000cb00 <timer_scratch>
    80007338:	00b7b023          	sd	a1,0(a5)
    8000733c:	00d70733          	add	a4,a4,a3
    80007340:	00f73c23          	sd	a5,24(a4)
    80007344:	02c73023          	sd	a2,32(a4)
    80007348:	34071073          	csrw	mscratch,a4
    8000734c:	00000797          	auipc	a5,0x0
    80007350:	6e478793          	addi	a5,a5,1764 # 80007a30 <timervec>
    80007354:	30579073          	csrw	mtvec,a5
    80007358:	300027f3          	csrr	a5,mstatus
    8000735c:	0087e793          	ori	a5,a5,8
    80007360:	30079073          	csrw	mstatus,a5
    80007364:	304027f3          	csrr	a5,mie
    80007368:	0807e793          	ori	a5,a5,128
    8000736c:	30479073          	csrw	mie,a5
    80007370:	f14027f3          	csrr	a5,mhartid
    80007374:	0007879b          	sext.w	a5,a5
    80007378:	00078213          	mv	tp,a5
    8000737c:	30200073          	mret
    80007380:	00813403          	ld	s0,8(sp)
    80007384:	01010113          	addi	sp,sp,16
    80007388:	00008067          	ret

000000008000738c <timerinit>:
    8000738c:	ff010113          	addi	sp,sp,-16
    80007390:	00813423          	sd	s0,8(sp)
    80007394:	01010413          	addi	s0,sp,16
    80007398:	f14027f3          	csrr	a5,mhartid
    8000739c:	0200c737          	lui	a4,0x200c
    800073a0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800073a4:	0007869b          	sext.w	a3,a5
    800073a8:	00269713          	slli	a4,a3,0x2
    800073ac:	000f4637          	lui	a2,0xf4
    800073b0:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800073b4:	00d70733          	add	a4,a4,a3
    800073b8:	0037979b          	slliw	a5,a5,0x3
    800073bc:	020046b7          	lui	a3,0x2004
    800073c0:	00d787b3          	add	a5,a5,a3
    800073c4:	00c585b3          	add	a1,a1,a2
    800073c8:	00371693          	slli	a3,a4,0x3
    800073cc:	00005717          	auipc	a4,0x5
    800073d0:	73470713          	addi	a4,a4,1844 # 8000cb00 <timer_scratch>
    800073d4:	00b7b023          	sd	a1,0(a5)
    800073d8:	00d70733          	add	a4,a4,a3
    800073dc:	00f73c23          	sd	a5,24(a4)
    800073e0:	02c73023          	sd	a2,32(a4)
    800073e4:	34071073          	csrw	mscratch,a4
    800073e8:	00000797          	auipc	a5,0x0
    800073ec:	64878793          	addi	a5,a5,1608 # 80007a30 <timervec>
    800073f0:	30579073          	csrw	mtvec,a5
    800073f4:	300027f3          	csrr	a5,mstatus
    800073f8:	0087e793          	ori	a5,a5,8
    800073fc:	30079073          	csrw	mstatus,a5
    80007400:	304027f3          	csrr	a5,mie
    80007404:	0807e793          	ori	a5,a5,128
    80007408:	30479073          	csrw	mie,a5
    8000740c:	00813403          	ld	s0,8(sp)
    80007410:	01010113          	addi	sp,sp,16
    80007414:	00008067          	ret

0000000080007418 <system_main>:
    80007418:	fe010113          	addi	sp,sp,-32
    8000741c:	00813823          	sd	s0,16(sp)
    80007420:	00913423          	sd	s1,8(sp)
    80007424:	00113c23          	sd	ra,24(sp)
    80007428:	02010413          	addi	s0,sp,32
    8000742c:	00000097          	auipc	ra,0x0
    80007430:	0c4080e7          	jalr	196(ra) # 800074f0 <cpuid>
    80007434:	00005497          	auipc	s1,0x5
    80007438:	5ec48493          	addi	s1,s1,1516 # 8000ca20 <started>
    8000743c:	02050263          	beqz	a0,80007460 <system_main+0x48>
    80007440:	0004a783          	lw	a5,0(s1)
    80007444:	0007879b          	sext.w	a5,a5
    80007448:	fe078ce3          	beqz	a5,80007440 <system_main+0x28>
    8000744c:	0ff0000f          	fence
    80007450:	00003517          	auipc	a0,0x3
    80007454:	09050513          	addi	a0,a0,144 # 8000a4e0 <CONSOLE_STATUS+0x4d0>
    80007458:	00001097          	auipc	ra,0x1
    8000745c:	a74080e7          	jalr	-1420(ra) # 80007ecc <panic>
    80007460:	00001097          	auipc	ra,0x1
    80007464:	9c8080e7          	jalr	-1592(ra) # 80007e28 <consoleinit>
    80007468:	00001097          	auipc	ra,0x1
    8000746c:	154080e7          	jalr	340(ra) # 800085bc <printfinit>
    80007470:	00003517          	auipc	a0,0x3
    80007474:	ef850513          	addi	a0,a0,-264 # 8000a368 <CONSOLE_STATUS+0x358>
    80007478:	00001097          	auipc	ra,0x1
    8000747c:	ab0080e7          	jalr	-1360(ra) # 80007f28 <__printf>
    80007480:	00003517          	auipc	a0,0x3
    80007484:	03050513          	addi	a0,a0,48 # 8000a4b0 <CONSOLE_STATUS+0x4a0>
    80007488:	00001097          	auipc	ra,0x1
    8000748c:	aa0080e7          	jalr	-1376(ra) # 80007f28 <__printf>
    80007490:	00003517          	auipc	a0,0x3
    80007494:	ed850513          	addi	a0,a0,-296 # 8000a368 <CONSOLE_STATUS+0x358>
    80007498:	00001097          	auipc	ra,0x1
    8000749c:	a90080e7          	jalr	-1392(ra) # 80007f28 <__printf>
    800074a0:	00001097          	auipc	ra,0x1
    800074a4:	4a8080e7          	jalr	1192(ra) # 80008948 <kinit>
    800074a8:	00000097          	auipc	ra,0x0
    800074ac:	148080e7          	jalr	328(ra) # 800075f0 <trapinit>
    800074b0:	00000097          	auipc	ra,0x0
    800074b4:	16c080e7          	jalr	364(ra) # 8000761c <trapinithart>
    800074b8:	00000097          	auipc	ra,0x0
    800074bc:	5b8080e7          	jalr	1464(ra) # 80007a70 <plicinit>
    800074c0:	00000097          	auipc	ra,0x0
    800074c4:	5d8080e7          	jalr	1496(ra) # 80007a98 <plicinithart>
    800074c8:	00000097          	auipc	ra,0x0
    800074cc:	078080e7          	jalr	120(ra) # 80007540 <userinit>
    800074d0:	0ff0000f          	fence
    800074d4:	00100793          	li	a5,1
    800074d8:	00003517          	auipc	a0,0x3
    800074dc:	ff050513          	addi	a0,a0,-16 # 8000a4c8 <CONSOLE_STATUS+0x4b8>
    800074e0:	00f4a023          	sw	a5,0(s1)
    800074e4:	00001097          	auipc	ra,0x1
    800074e8:	a44080e7          	jalr	-1468(ra) # 80007f28 <__printf>
    800074ec:	0000006f          	j	800074ec <system_main+0xd4>

00000000800074f0 <cpuid>:
    800074f0:	ff010113          	addi	sp,sp,-16
    800074f4:	00813423          	sd	s0,8(sp)
    800074f8:	01010413          	addi	s0,sp,16
    800074fc:	00020513          	mv	a0,tp
    80007500:	00813403          	ld	s0,8(sp)
    80007504:	0005051b          	sext.w	a0,a0
    80007508:	01010113          	addi	sp,sp,16
    8000750c:	00008067          	ret

0000000080007510 <mycpu>:
    80007510:	ff010113          	addi	sp,sp,-16
    80007514:	00813423          	sd	s0,8(sp)
    80007518:	01010413          	addi	s0,sp,16
    8000751c:	00020793          	mv	a5,tp
    80007520:	00813403          	ld	s0,8(sp)
    80007524:	0007879b          	sext.w	a5,a5
    80007528:	00779793          	slli	a5,a5,0x7
    8000752c:	00006517          	auipc	a0,0x6
    80007530:	60450513          	addi	a0,a0,1540 # 8000db30 <cpus>
    80007534:	00f50533          	add	a0,a0,a5
    80007538:	01010113          	addi	sp,sp,16
    8000753c:	00008067          	ret

0000000080007540 <userinit>:
    80007540:	ff010113          	addi	sp,sp,-16
    80007544:	00813423          	sd	s0,8(sp)
    80007548:	01010413          	addi	s0,sp,16
    8000754c:	00813403          	ld	s0,8(sp)
    80007550:	01010113          	addi	sp,sp,16
    80007554:	ffffe317          	auipc	t1,0xffffe
    80007558:	f4430067          	jr	-188(t1) # 80005498 <main>

000000008000755c <either_copyout>:
    8000755c:	ff010113          	addi	sp,sp,-16
    80007560:	00813023          	sd	s0,0(sp)
    80007564:	00113423          	sd	ra,8(sp)
    80007568:	01010413          	addi	s0,sp,16
    8000756c:	02051663          	bnez	a0,80007598 <either_copyout+0x3c>
    80007570:	00058513          	mv	a0,a1
    80007574:	00060593          	mv	a1,a2
    80007578:	0006861b          	sext.w	a2,a3
    8000757c:	00002097          	auipc	ra,0x2
    80007580:	c58080e7          	jalr	-936(ra) # 800091d4 <__memmove>
    80007584:	00813083          	ld	ra,8(sp)
    80007588:	00013403          	ld	s0,0(sp)
    8000758c:	00000513          	li	a0,0
    80007590:	01010113          	addi	sp,sp,16
    80007594:	00008067          	ret
    80007598:	00003517          	auipc	a0,0x3
    8000759c:	f7050513          	addi	a0,a0,-144 # 8000a508 <CONSOLE_STATUS+0x4f8>
    800075a0:	00001097          	auipc	ra,0x1
    800075a4:	92c080e7          	jalr	-1748(ra) # 80007ecc <panic>

00000000800075a8 <either_copyin>:
    800075a8:	ff010113          	addi	sp,sp,-16
    800075ac:	00813023          	sd	s0,0(sp)
    800075b0:	00113423          	sd	ra,8(sp)
    800075b4:	01010413          	addi	s0,sp,16
    800075b8:	02059463          	bnez	a1,800075e0 <either_copyin+0x38>
    800075bc:	00060593          	mv	a1,a2
    800075c0:	0006861b          	sext.w	a2,a3
    800075c4:	00002097          	auipc	ra,0x2
    800075c8:	c10080e7          	jalr	-1008(ra) # 800091d4 <__memmove>
    800075cc:	00813083          	ld	ra,8(sp)
    800075d0:	00013403          	ld	s0,0(sp)
    800075d4:	00000513          	li	a0,0
    800075d8:	01010113          	addi	sp,sp,16
    800075dc:	00008067          	ret
    800075e0:	00003517          	auipc	a0,0x3
    800075e4:	f5050513          	addi	a0,a0,-176 # 8000a530 <CONSOLE_STATUS+0x520>
    800075e8:	00001097          	auipc	ra,0x1
    800075ec:	8e4080e7          	jalr	-1820(ra) # 80007ecc <panic>

00000000800075f0 <trapinit>:
    800075f0:	ff010113          	addi	sp,sp,-16
    800075f4:	00813423          	sd	s0,8(sp)
    800075f8:	01010413          	addi	s0,sp,16
    800075fc:	00813403          	ld	s0,8(sp)
    80007600:	00003597          	auipc	a1,0x3
    80007604:	f5858593          	addi	a1,a1,-168 # 8000a558 <CONSOLE_STATUS+0x548>
    80007608:	00006517          	auipc	a0,0x6
    8000760c:	5a850513          	addi	a0,a0,1448 # 8000dbb0 <tickslock>
    80007610:	01010113          	addi	sp,sp,16
    80007614:	00001317          	auipc	t1,0x1
    80007618:	5c430067          	jr	1476(t1) # 80008bd8 <initlock>

000000008000761c <trapinithart>:
    8000761c:	ff010113          	addi	sp,sp,-16
    80007620:	00813423          	sd	s0,8(sp)
    80007624:	01010413          	addi	s0,sp,16
    80007628:	00000797          	auipc	a5,0x0
    8000762c:	2f878793          	addi	a5,a5,760 # 80007920 <kernelvec>
    80007630:	10579073          	csrw	stvec,a5
    80007634:	00813403          	ld	s0,8(sp)
    80007638:	01010113          	addi	sp,sp,16
    8000763c:	00008067          	ret

0000000080007640 <usertrap>:
    80007640:	ff010113          	addi	sp,sp,-16
    80007644:	00813423          	sd	s0,8(sp)
    80007648:	01010413          	addi	s0,sp,16
    8000764c:	00813403          	ld	s0,8(sp)
    80007650:	01010113          	addi	sp,sp,16
    80007654:	00008067          	ret

0000000080007658 <usertrapret>:
    80007658:	ff010113          	addi	sp,sp,-16
    8000765c:	00813423          	sd	s0,8(sp)
    80007660:	01010413          	addi	s0,sp,16
    80007664:	00813403          	ld	s0,8(sp)
    80007668:	01010113          	addi	sp,sp,16
    8000766c:	00008067          	ret

0000000080007670 <kerneltrap>:
    80007670:	fe010113          	addi	sp,sp,-32
    80007674:	00813823          	sd	s0,16(sp)
    80007678:	00113c23          	sd	ra,24(sp)
    8000767c:	00913423          	sd	s1,8(sp)
    80007680:	02010413          	addi	s0,sp,32
    80007684:	142025f3          	csrr	a1,scause
    80007688:	100027f3          	csrr	a5,sstatus
    8000768c:	0027f793          	andi	a5,a5,2
    80007690:	10079c63          	bnez	a5,800077a8 <kerneltrap+0x138>
    80007694:	142027f3          	csrr	a5,scause
    80007698:	0207ce63          	bltz	a5,800076d4 <kerneltrap+0x64>
    8000769c:	00003517          	auipc	a0,0x3
    800076a0:	f0450513          	addi	a0,a0,-252 # 8000a5a0 <CONSOLE_STATUS+0x590>
    800076a4:	00001097          	auipc	ra,0x1
    800076a8:	884080e7          	jalr	-1916(ra) # 80007f28 <__printf>
    800076ac:	141025f3          	csrr	a1,sepc
    800076b0:	14302673          	csrr	a2,stval
    800076b4:	00003517          	auipc	a0,0x3
    800076b8:	efc50513          	addi	a0,a0,-260 # 8000a5b0 <CONSOLE_STATUS+0x5a0>
    800076bc:	00001097          	auipc	ra,0x1
    800076c0:	86c080e7          	jalr	-1940(ra) # 80007f28 <__printf>
    800076c4:	00003517          	auipc	a0,0x3
    800076c8:	f0450513          	addi	a0,a0,-252 # 8000a5c8 <CONSOLE_STATUS+0x5b8>
    800076cc:	00001097          	auipc	ra,0x1
    800076d0:	800080e7          	jalr	-2048(ra) # 80007ecc <panic>
    800076d4:	0ff7f713          	andi	a4,a5,255
    800076d8:	00900693          	li	a3,9
    800076dc:	04d70063          	beq	a4,a3,8000771c <kerneltrap+0xac>
    800076e0:	fff00713          	li	a4,-1
    800076e4:	03f71713          	slli	a4,a4,0x3f
    800076e8:	00170713          	addi	a4,a4,1
    800076ec:	fae798e3          	bne	a5,a4,8000769c <kerneltrap+0x2c>
    800076f0:	00000097          	auipc	ra,0x0
    800076f4:	e00080e7          	jalr	-512(ra) # 800074f0 <cpuid>
    800076f8:	06050663          	beqz	a0,80007764 <kerneltrap+0xf4>
    800076fc:	144027f3          	csrr	a5,sip
    80007700:	ffd7f793          	andi	a5,a5,-3
    80007704:	14479073          	csrw	sip,a5
    80007708:	01813083          	ld	ra,24(sp)
    8000770c:	01013403          	ld	s0,16(sp)
    80007710:	00813483          	ld	s1,8(sp)
    80007714:	02010113          	addi	sp,sp,32
    80007718:	00008067          	ret
    8000771c:	00000097          	auipc	ra,0x0
    80007720:	3c8080e7          	jalr	968(ra) # 80007ae4 <plic_claim>
    80007724:	00a00793          	li	a5,10
    80007728:	00050493          	mv	s1,a0
    8000772c:	06f50863          	beq	a0,a5,8000779c <kerneltrap+0x12c>
    80007730:	fc050ce3          	beqz	a0,80007708 <kerneltrap+0x98>
    80007734:	00050593          	mv	a1,a0
    80007738:	00003517          	auipc	a0,0x3
    8000773c:	e4850513          	addi	a0,a0,-440 # 8000a580 <CONSOLE_STATUS+0x570>
    80007740:	00000097          	auipc	ra,0x0
    80007744:	7e8080e7          	jalr	2024(ra) # 80007f28 <__printf>
    80007748:	01013403          	ld	s0,16(sp)
    8000774c:	01813083          	ld	ra,24(sp)
    80007750:	00048513          	mv	a0,s1
    80007754:	00813483          	ld	s1,8(sp)
    80007758:	02010113          	addi	sp,sp,32
    8000775c:	00000317          	auipc	t1,0x0
    80007760:	3c030067          	jr	960(t1) # 80007b1c <plic_complete>
    80007764:	00006517          	auipc	a0,0x6
    80007768:	44c50513          	addi	a0,a0,1100 # 8000dbb0 <tickslock>
    8000776c:	00001097          	auipc	ra,0x1
    80007770:	490080e7          	jalr	1168(ra) # 80008bfc <acquire>
    80007774:	00005717          	auipc	a4,0x5
    80007778:	2b070713          	addi	a4,a4,688 # 8000ca24 <ticks>
    8000777c:	00072783          	lw	a5,0(a4)
    80007780:	00006517          	auipc	a0,0x6
    80007784:	43050513          	addi	a0,a0,1072 # 8000dbb0 <tickslock>
    80007788:	0017879b          	addiw	a5,a5,1
    8000778c:	00f72023          	sw	a5,0(a4)
    80007790:	00001097          	auipc	ra,0x1
    80007794:	538080e7          	jalr	1336(ra) # 80008cc8 <release>
    80007798:	f65ff06f          	j	800076fc <kerneltrap+0x8c>
    8000779c:	00001097          	auipc	ra,0x1
    800077a0:	094080e7          	jalr	148(ra) # 80008830 <uartintr>
    800077a4:	fa5ff06f          	j	80007748 <kerneltrap+0xd8>
    800077a8:	00003517          	auipc	a0,0x3
    800077ac:	db850513          	addi	a0,a0,-584 # 8000a560 <CONSOLE_STATUS+0x550>
    800077b0:	00000097          	auipc	ra,0x0
    800077b4:	71c080e7          	jalr	1820(ra) # 80007ecc <panic>

00000000800077b8 <clockintr>:
    800077b8:	fe010113          	addi	sp,sp,-32
    800077bc:	00813823          	sd	s0,16(sp)
    800077c0:	00913423          	sd	s1,8(sp)
    800077c4:	00113c23          	sd	ra,24(sp)
    800077c8:	02010413          	addi	s0,sp,32
    800077cc:	00006497          	auipc	s1,0x6
    800077d0:	3e448493          	addi	s1,s1,996 # 8000dbb0 <tickslock>
    800077d4:	00048513          	mv	a0,s1
    800077d8:	00001097          	auipc	ra,0x1
    800077dc:	424080e7          	jalr	1060(ra) # 80008bfc <acquire>
    800077e0:	00005717          	auipc	a4,0x5
    800077e4:	24470713          	addi	a4,a4,580 # 8000ca24 <ticks>
    800077e8:	00072783          	lw	a5,0(a4)
    800077ec:	01013403          	ld	s0,16(sp)
    800077f0:	01813083          	ld	ra,24(sp)
    800077f4:	00048513          	mv	a0,s1
    800077f8:	0017879b          	addiw	a5,a5,1
    800077fc:	00813483          	ld	s1,8(sp)
    80007800:	00f72023          	sw	a5,0(a4)
    80007804:	02010113          	addi	sp,sp,32
    80007808:	00001317          	auipc	t1,0x1
    8000780c:	4c030067          	jr	1216(t1) # 80008cc8 <release>

0000000080007810 <devintr>:
    80007810:	142027f3          	csrr	a5,scause
    80007814:	00000513          	li	a0,0
    80007818:	0007c463          	bltz	a5,80007820 <devintr+0x10>
    8000781c:	00008067          	ret
    80007820:	fe010113          	addi	sp,sp,-32
    80007824:	00813823          	sd	s0,16(sp)
    80007828:	00113c23          	sd	ra,24(sp)
    8000782c:	00913423          	sd	s1,8(sp)
    80007830:	02010413          	addi	s0,sp,32
    80007834:	0ff7f713          	andi	a4,a5,255
    80007838:	00900693          	li	a3,9
    8000783c:	04d70c63          	beq	a4,a3,80007894 <devintr+0x84>
    80007840:	fff00713          	li	a4,-1
    80007844:	03f71713          	slli	a4,a4,0x3f
    80007848:	00170713          	addi	a4,a4,1
    8000784c:	00e78c63          	beq	a5,a4,80007864 <devintr+0x54>
    80007850:	01813083          	ld	ra,24(sp)
    80007854:	01013403          	ld	s0,16(sp)
    80007858:	00813483          	ld	s1,8(sp)
    8000785c:	02010113          	addi	sp,sp,32
    80007860:	00008067          	ret
    80007864:	00000097          	auipc	ra,0x0
    80007868:	c8c080e7          	jalr	-884(ra) # 800074f0 <cpuid>
    8000786c:	06050663          	beqz	a0,800078d8 <devintr+0xc8>
    80007870:	144027f3          	csrr	a5,sip
    80007874:	ffd7f793          	andi	a5,a5,-3
    80007878:	14479073          	csrw	sip,a5
    8000787c:	01813083          	ld	ra,24(sp)
    80007880:	01013403          	ld	s0,16(sp)
    80007884:	00813483          	ld	s1,8(sp)
    80007888:	00200513          	li	a0,2
    8000788c:	02010113          	addi	sp,sp,32
    80007890:	00008067          	ret
    80007894:	00000097          	auipc	ra,0x0
    80007898:	250080e7          	jalr	592(ra) # 80007ae4 <plic_claim>
    8000789c:	00a00793          	li	a5,10
    800078a0:	00050493          	mv	s1,a0
    800078a4:	06f50663          	beq	a0,a5,80007910 <devintr+0x100>
    800078a8:	00100513          	li	a0,1
    800078ac:	fa0482e3          	beqz	s1,80007850 <devintr+0x40>
    800078b0:	00048593          	mv	a1,s1
    800078b4:	00003517          	auipc	a0,0x3
    800078b8:	ccc50513          	addi	a0,a0,-820 # 8000a580 <CONSOLE_STATUS+0x570>
    800078bc:	00000097          	auipc	ra,0x0
    800078c0:	66c080e7          	jalr	1644(ra) # 80007f28 <__printf>
    800078c4:	00048513          	mv	a0,s1
    800078c8:	00000097          	auipc	ra,0x0
    800078cc:	254080e7          	jalr	596(ra) # 80007b1c <plic_complete>
    800078d0:	00100513          	li	a0,1
    800078d4:	f7dff06f          	j	80007850 <devintr+0x40>
    800078d8:	00006517          	auipc	a0,0x6
    800078dc:	2d850513          	addi	a0,a0,728 # 8000dbb0 <tickslock>
    800078e0:	00001097          	auipc	ra,0x1
    800078e4:	31c080e7          	jalr	796(ra) # 80008bfc <acquire>
    800078e8:	00005717          	auipc	a4,0x5
    800078ec:	13c70713          	addi	a4,a4,316 # 8000ca24 <ticks>
    800078f0:	00072783          	lw	a5,0(a4)
    800078f4:	00006517          	auipc	a0,0x6
    800078f8:	2bc50513          	addi	a0,a0,700 # 8000dbb0 <tickslock>
    800078fc:	0017879b          	addiw	a5,a5,1
    80007900:	00f72023          	sw	a5,0(a4)
    80007904:	00001097          	auipc	ra,0x1
    80007908:	3c4080e7          	jalr	964(ra) # 80008cc8 <release>
    8000790c:	f65ff06f          	j	80007870 <devintr+0x60>
    80007910:	00001097          	auipc	ra,0x1
    80007914:	f20080e7          	jalr	-224(ra) # 80008830 <uartintr>
    80007918:	fadff06f          	j	800078c4 <devintr+0xb4>
    8000791c:	0000                	unimp
	...

0000000080007920 <kernelvec>:
    80007920:	f0010113          	addi	sp,sp,-256
    80007924:	00113023          	sd	ra,0(sp)
    80007928:	00213423          	sd	sp,8(sp)
    8000792c:	00313823          	sd	gp,16(sp)
    80007930:	00413c23          	sd	tp,24(sp)
    80007934:	02513023          	sd	t0,32(sp)
    80007938:	02613423          	sd	t1,40(sp)
    8000793c:	02713823          	sd	t2,48(sp)
    80007940:	02813c23          	sd	s0,56(sp)
    80007944:	04913023          	sd	s1,64(sp)
    80007948:	04a13423          	sd	a0,72(sp)
    8000794c:	04b13823          	sd	a1,80(sp)
    80007950:	04c13c23          	sd	a2,88(sp)
    80007954:	06d13023          	sd	a3,96(sp)
    80007958:	06e13423          	sd	a4,104(sp)
    8000795c:	06f13823          	sd	a5,112(sp)
    80007960:	07013c23          	sd	a6,120(sp)
    80007964:	09113023          	sd	a7,128(sp)
    80007968:	09213423          	sd	s2,136(sp)
    8000796c:	09313823          	sd	s3,144(sp)
    80007970:	09413c23          	sd	s4,152(sp)
    80007974:	0b513023          	sd	s5,160(sp)
    80007978:	0b613423          	sd	s6,168(sp)
    8000797c:	0b713823          	sd	s7,176(sp)
    80007980:	0b813c23          	sd	s8,184(sp)
    80007984:	0d913023          	sd	s9,192(sp)
    80007988:	0da13423          	sd	s10,200(sp)
    8000798c:	0db13823          	sd	s11,208(sp)
    80007990:	0dc13c23          	sd	t3,216(sp)
    80007994:	0fd13023          	sd	t4,224(sp)
    80007998:	0fe13423          	sd	t5,232(sp)
    8000799c:	0ff13823          	sd	t6,240(sp)
    800079a0:	cd1ff0ef          	jal	ra,80007670 <kerneltrap>
    800079a4:	00013083          	ld	ra,0(sp)
    800079a8:	00813103          	ld	sp,8(sp)
    800079ac:	01013183          	ld	gp,16(sp)
    800079b0:	02013283          	ld	t0,32(sp)
    800079b4:	02813303          	ld	t1,40(sp)
    800079b8:	03013383          	ld	t2,48(sp)
    800079bc:	03813403          	ld	s0,56(sp)
    800079c0:	04013483          	ld	s1,64(sp)
    800079c4:	04813503          	ld	a0,72(sp)
    800079c8:	05013583          	ld	a1,80(sp)
    800079cc:	05813603          	ld	a2,88(sp)
    800079d0:	06013683          	ld	a3,96(sp)
    800079d4:	06813703          	ld	a4,104(sp)
    800079d8:	07013783          	ld	a5,112(sp)
    800079dc:	07813803          	ld	a6,120(sp)
    800079e0:	08013883          	ld	a7,128(sp)
    800079e4:	08813903          	ld	s2,136(sp)
    800079e8:	09013983          	ld	s3,144(sp)
    800079ec:	09813a03          	ld	s4,152(sp)
    800079f0:	0a013a83          	ld	s5,160(sp)
    800079f4:	0a813b03          	ld	s6,168(sp)
    800079f8:	0b013b83          	ld	s7,176(sp)
    800079fc:	0b813c03          	ld	s8,184(sp)
    80007a00:	0c013c83          	ld	s9,192(sp)
    80007a04:	0c813d03          	ld	s10,200(sp)
    80007a08:	0d013d83          	ld	s11,208(sp)
    80007a0c:	0d813e03          	ld	t3,216(sp)
    80007a10:	0e013e83          	ld	t4,224(sp)
    80007a14:	0e813f03          	ld	t5,232(sp)
    80007a18:	0f013f83          	ld	t6,240(sp)
    80007a1c:	10010113          	addi	sp,sp,256
    80007a20:	10200073          	sret
    80007a24:	00000013          	nop
    80007a28:	00000013          	nop
    80007a2c:	00000013          	nop

0000000080007a30 <timervec>:
    80007a30:	34051573          	csrrw	a0,mscratch,a0
    80007a34:	00b53023          	sd	a1,0(a0)
    80007a38:	00c53423          	sd	a2,8(a0)
    80007a3c:	00d53823          	sd	a3,16(a0)
    80007a40:	01853583          	ld	a1,24(a0)
    80007a44:	02053603          	ld	a2,32(a0)
    80007a48:	0005b683          	ld	a3,0(a1)
    80007a4c:	00c686b3          	add	a3,a3,a2
    80007a50:	00d5b023          	sd	a3,0(a1)
    80007a54:	00200593          	li	a1,2
    80007a58:	14459073          	csrw	sip,a1
    80007a5c:	01053683          	ld	a3,16(a0)
    80007a60:	00853603          	ld	a2,8(a0)
    80007a64:	00053583          	ld	a1,0(a0)
    80007a68:	34051573          	csrrw	a0,mscratch,a0
    80007a6c:	30200073          	mret

0000000080007a70 <plicinit>:
    80007a70:	ff010113          	addi	sp,sp,-16
    80007a74:	00813423          	sd	s0,8(sp)
    80007a78:	01010413          	addi	s0,sp,16
    80007a7c:	00813403          	ld	s0,8(sp)
    80007a80:	0c0007b7          	lui	a5,0xc000
    80007a84:	00100713          	li	a4,1
    80007a88:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80007a8c:	00e7a223          	sw	a4,4(a5)
    80007a90:	01010113          	addi	sp,sp,16
    80007a94:	00008067          	ret

0000000080007a98 <plicinithart>:
    80007a98:	ff010113          	addi	sp,sp,-16
    80007a9c:	00813023          	sd	s0,0(sp)
    80007aa0:	00113423          	sd	ra,8(sp)
    80007aa4:	01010413          	addi	s0,sp,16
    80007aa8:	00000097          	auipc	ra,0x0
    80007aac:	a48080e7          	jalr	-1464(ra) # 800074f0 <cpuid>
    80007ab0:	0085171b          	slliw	a4,a0,0x8
    80007ab4:	0c0027b7          	lui	a5,0xc002
    80007ab8:	00e787b3          	add	a5,a5,a4
    80007abc:	40200713          	li	a4,1026
    80007ac0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80007ac4:	00813083          	ld	ra,8(sp)
    80007ac8:	00013403          	ld	s0,0(sp)
    80007acc:	00d5151b          	slliw	a0,a0,0xd
    80007ad0:	0c2017b7          	lui	a5,0xc201
    80007ad4:	00a78533          	add	a0,a5,a0
    80007ad8:	00052023          	sw	zero,0(a0)
    80007adc:	01010113          	addi	sp,sp,16
    80007ae0:	00008067          	ret

0000000080007ae4 <plic_claim>:
    80007ae4:	ff010113          	addi	sp,sp,-16
    80007ae8:	00813023          	sd	s0,0(sp)
    80007aec:	00113423          	sd	ra,8(sp)
    80007af0:	01010413          	addi	s0,sp,16
    80007af4:	00000097          	auipc	ra,0x0
    80007af8:	9fc080e7          	jalr	-1540(ra) # 800074f0 <cpuid>
    80007afc:	00813083          	ld	ra,8(sp)
    80007b00:	00013403          	ld	s0,0(sp)
    80007b04:	00d5151b          	slliw	a0,a0,0xd
    80007b08:	0c2017b7          	lui	a5,0xc201
    80007b0c:	00a78533          	add	a0,a5,a0
    80007b10:	00452503          	lw	a0,4(a0)
    80007b14:	01010113          	addi	sp,sp,16
    80007b18:	00008067          	ret

0000000080007b1c <plic_complete>:
    80007b1c:	fe010113          	addi	sp,sp,-32
    80007b20:	00813823          	sd	s0,16(sp)
    80007b24:	00913423          	sd	s1,8(sp)
    80007b28:	00113c23          	sd	ra,24(sp)
    80007b2c:	02010413          	addi	s0,sp,32
    80007b30:	00050493          	mv	s1,a0
    80007b34:	00000097          	auipc	ra,0x0
    80007b38:	9bc080e7          	jalr	-1604(ra) # 800074f0 <cpuid>
    80007b3c:	01813083          	ld	ra,24(sp)
    80007b40:	01013403          	ld	s0,16(sp)
    80007b44:	00d5179b          	slliw	a5,a0,0xd
    80007b48:	0c201737          	lui	a4,0xc201
    80007b4c:	00f707b3          	add	a5,a4,a5
    80007b50:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80007b54:	00813483          	ld	s1,8(sp)
    80007b58:	02010113          	addi	sp,sp,32
    80007b5c:	00008067          	ret

0000000080007b60 <consolewrite>:
    80007b60:	fb010113          	addi	sp,sp,-80
    80007b64:	04813023          	sd	s0,64(sp)
    80007b68:	04113423          	sd	ra,72(sp)
    80007b6c:	02913c23          	sd	s1,56(sp)
    80007b70:	03213823          	sd	s2,48(sp)
    80007b74:	03313423          	sd	s3,40(sp)
    80007b78:	03413023          	sd	s4,32(sp)
    80007b7c:	01513c23          	sd	s5,24(sp)
    80007b80:	05010413          	addi	s0,sp,80
    80007b84:	06c05c63          	blez	a2,80007bfc <consolewrite+0x9c>
    80007b88:	00060993          	mv	s3,a2
    80007b8c:	00050a13          	mv	s4,a0
    80007b90:	00058493          	mv	s1,a1
    80007b94:	00000913          	li	s2,0
    80007b98:	fff00a93          	li	s5,-1
    80007b9c:	01c0006f          	j	80007bb8 <consolewrite+0x58>
    80007ba0:	fbf44503          	lbu	a0,-65(s0)
    80007ba4:	0019091b          	addiw	s2,s2,1
    80007ba8:	00148493          	addi	s1,s1,1
    80007bac:	00001097          	auipc	ra,0x1
    80007bb0:	a9c080e7          	jalr	-1380(ra) # 80008648 <uartputc>
    80007bb4:	03298063          	beq	s3,s2,80007bd4 <consolewrite+0x74>
    80007bb8:	00048613          	mv	a2,s1
    80007bbc:	00100693          	li	a3,1
    80007bc0:	000a0593          	mv	a1,s4
    80007bc4:	fbf40513          	addi	a0,s0,-65
    80007bc8:	00000097          	auipc	ra,0x0
    80007bcc:	9e0080e7          	jalr	-1568(ra) # 800075a8 <either_copyin>
    80007bd0:	fd5518e3          	bne	a0,s5,80007ba0 <consolewrite+0x40>
    80007bd4:	04813083          	ld	ra,72(sp)
    80007bd8:	04013403          	ld	s0,64(sp)
    80007bdc:	03813483          	ld	s1,56(sp)
    80007be0:	02813983          	ld	s3,40(sp)
    80007be4:	02013a03          	ld	s4,32(sp)
    80007be8:	01813a83          	ld	s5,24(sp)
    80007bec:	00090513          	mv	a0,s2
    80007bf0:	03013903          	ld	s2,48(sp)
    80007bf4:	05010113          	addi	sp,sp,80
    80007bf8:	00008067          	ret
    80007bfc:	00000913          	li	s2,0
    80007c00:	fd5ff06f          	j	80007bd4 <consolewrite+0x74>

0000000080007c04 <consoleread>:
    80007c04:	f9010113          	addi	sp,sp,-112
    80007c08:	06813023          	sd	s0,96(sp)
    80007c0c:	04913c23          	sd	s1,88(sp)
    80007c10:	05213823          	sd	s2,80(sp)
    80007c14:	05313423          	sd	s3,72(sp)
    80007c18:	05413023          	sd	s4,64(sp)
    80007c1c:	03513c23          	sd	s5,56(sp)
    80007c20:	03613823          	sd	s6,48(sp)
    80007c24:	03713423          	sd	s7,40(sp)
    80007c28:	03813023          	sd	s8,32(sp)
    80007c2c:	06113423          	sd	ra,104(sp)
    80007c30:	01913c23          	sd	s9,24(sp)
    80007c34:	07010413          	addi	s0,sp,112
    80007c38:	00060b93          	mv	s7,a2
    80007c3c:	00050913          	mv	s2,a0
    80007c40:	00058c13          	mv	s8,a1
    80007c44:	00060b1b          	sext.w	s6,a2
    80007c48:	00006497          	auipc	s1,0x6
    80007c4c:	f9048493          	addi	s1,s1,-112 # 8000dbd8 <cons>
    80007c50:	00400993          	li	s3,4
    80007c54:	fff00a13          	li	s4,-1
    80007c58:	00a00a93          	li	s5,10
    80007c5c:	05705e63          	blez	s7,80007cb8 <consoleread+0xb4>
    80007c60:	09c4a703          	lw	a4,156(s1)
    80007c64:	0984a783          	lw	a5,152(s1)
    80007c68:	0007071b          	sext.w	a4,a4
    80007c6c:	08e78463          	beq	a5,a4,80007cf4 <consoleread+0xf0>
    80007c70:	07f7f713          	andi	a4,a5,127
    80007c74:	00e48733          	add	a4,s1,a4
    80007c78:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80007c7c:	0017869b          	addiw	a3,a5,1
    80007c80:	08d4ac23          	sw	a3,152(s1)
    80007c84:	00070c9b          	sext.w	s9,a4
    80007c88:	0b370663          	beq	a4,s3,80007d34 <consoleread+0x130>
    80007c8c:	00100693          	li	a3,1
    80007c90:	f9f40613          	addi	a2,s0,-97
    80007c94:	000c0593          	mv	a1,s8
    80007c98:	00090513          	mv	a0,s2
    80007c9c:	f8e40fa3          	sb	a4,-97(s0)
    80007ca0:	00000097          	auipc	ra,0x0
    80007ca4:	8bc080e7          	jalr	-1860(ra) # 8000755c <either_copyout>
    80007ca8:	01450863          	beq	a0,s4,80007cb8 <consoleread+0xb4>
    80007cac:	001c0c13          	addi	s8,s8,1
    80007cb0:	fffb8b9b          	addiw	s7,s7,-1
    80007cb4:	fb5c94e3          	bne	s9,s5,80007c5c <consoleread+0x58>
    80007cb8:	000b851b          	sext.w	a0,s7
    80007cbc:	06813083          	ld	ra,104(sp)
    80007cc0:	06013403          	ld	s0,96(sp)
    80007cc4:	05813483          	ld	s1,88(sp)
    80007cc8:	05013903          	ld	s2,80(sp)
    80007ccc:	04813983          	ld	s3,72(sp)
    80007cd0:	04013a03          	ld	s4,64(sp)
    80007cd4:	03813a83          	ld	s5,56(sp)
    80007cd8:	02813b83          	ld	s7,40(sp)
    80007cdc:	02013c03          	ld	s8,32(sp)
    80007ce0:	01813c83          	ld	s9,24(sp)
    80007ce4:	40ab053b          	subw	a0,s6,a0
    80007ce8:	03013b03          	ld	s6,48(sp)
    80007cec:	07010113          	addi	sp,sp,112
    80007cf0:	00008067          	ret
    80007cf4:	00001097          	auipc	ra,0x1
    80007cf8:	1d8080e7          	jalr	472(ra) # 80008ecc <push_on>
    80007cfc:	0984a703          	lw	a4,152(s1)
    80007d00:	09c4a783          	lw	a5,156(s1)
    80007d04:	0007879b          	sext.w	a5,a5
    80007d08:	fef70ce3          	beq	a4,a5,80007d00 <consoleread+0xfc>
    80007d0c:	00001097          	auipc	ra,0x1
    80007d10:	234080e7          	jalr	564(ra) # 80008f40 <pop_on>
    80007d14:	0984a783          	lw	a5,152(s1)
    80007d18:	07f7f713          	andi	a4,a5,127
    80007d1c:	00e48733          	add	a4,s1,a4
    80007d20:	01874703          	lbu	a4,24(a4)
    80007d24:	0017869b          	addiw	a3,a5,1
    80007d28:	08d4ac23          	sw	a3,152(s1)
    80007d2c:	00070c9b          	sext.w	s9,a4
    80007d30:	f5371ee3          	bne	a4,s3,80007c8c <consoleread+0x88>
    80007d34:	000b851b          	sext.w	a0,s7
    80007d38:	f96bf2e3          	bgeu	s7,s6,80007cbc <consoleread+0xb8>
    80007d3c:	08f4ac23          	sw	a5,152(s1)
    80007d40:	f7dff06f          	j	80007cbc <consoleread+0xb8>

0000000080007d44 <consputc>:
    80007d44:	10000793          	li	a5,256
    80007d48:	00f50663          	beq	a0,a5,80007d54 <consputc+0x10>
    80007d4c:	00001317          	auipc	t1,0x1
    80007d50:	9f430067          	jr	-1548(t1) # 80008740 <uartputc_sync>
    80007d54:	ff010113          	addi	sp,sp,-16
    80007d58:	00113423          	sd	ra,8(sp)
    80007d5c:	00813023          	sd	s0,0(sp)
    80007d60:	01010413          	addi	s0,sp,16
    80007d64:	00800513          	li	a0,8
    80007d68:	00001097          	auipc	ra,0x1
    80007d6c:	9d8080e7          	jalr	-1576(ra) # 80008740 <uartputc_sync>
    80007d70:	02000513          	li	a0,32
    80007d74:	00001097          	auipc	ra,0x1
    80007d78:	9cc080e7          	jalr	-1588(ra) # 80008740 <uartputc_sync>
    80007d7c:	00013403          	ld	s0,0(sp)
    80007d80:	00813083          	ld	ra,8(sp)
    80007d84:	00800513          	li	a0,8
    80007d88:	01010113          	addi	sp,sp,16
    80007d8c:	00001317          	auipc	t1,0x1
    80007d90:	9b430067          	jr	-1612(t1) # 80008740 <uartputc_sync>

0000000080007d94 <consoleintr>:
    80007d94:	fe010113          	addi	sp,sp,-32
    80007d98:	00813823          	sd	s0,16(sp)
    80007d9c:	00913423          	sd	s1,8(sp)
    80007da0:	01213023          	sd	s2,0(sp)
    80007da4:	00113c23          	sd	ra,24(sp)
    80007da8:	02010413          	addi	s0,sp,32
    80007dac:	00006917          	auipc	s2,0x6
    80007db0:	e2c90913          	addi	s2,s2,-468 # 8000dbd8 <cons>
    80007db4:	00050493          	mv	s1,a0
    80007db8:	00090513          	mv	a0,s2
    80007dbc:	00001097          	auipc	ra,0x1
    80007dc0:	e40080e7          	jalr	-448(ra) # 80008bfc <acquire>
    80007dc4:	02048c63          	beqz	s1,80007dfc <consoleintr+0x68>
    80007dc8:	0a092783          	lw	a5,160(s2)
    80007dcc:	09892703          	lw	a4,152(s2)
    80007dd0:	07f00693          	li	a3,127
    80007dd4:	40e7873b          	subw	a4,a5,a4
    80007dd8:	02e6e263          	bltu	a3,a4,80007dfc <consoleintr+0x68>
    80007ddc:	00d00713          	li	a4,13
    80007de0:	04e48063          	beq	s1,a4,80007e20 <consoleintr+0x8c>
    80007de4:	07f7f713          	andi	a4,a5,127
    80007de8:	00e90733          	add	a4,s2,a4
    80007dec:	0017879b          	addiw	a5,a5,1
    80007df0:	0af92023          	sw	a5,160(s2)
    80007df4:	00970c23          	sb	s1,24(a4)
    80007df8:	08f92e23          	sw	a5,156(s2)
    80007dfc:	01013403          	ld	s0,16(sp)
    80007e00:	01813083          	ld	ra,24(sp)
    80007e04:	00813483          	ld	s1,8(sp)
    80007e08:	00013903          	ld	s2,0(sp)
    80007e0c:	00006517          	auipc	a0,0x6
    80007e10:	dcc50513          	addi	a0,a0,-564 # 8000dbd8 <cons>
    80007e14:	02010113          	addi	sp,sp,32
    80007e18:	00001317          	auipc	t1,0x1
    80007e1c:	eb030067          	jr	-336(t1) # 80008cc8 <release>
    80007e20:	00a00493          	li	s1,10
    80007e24:	fc1ff06f          	j	80007de4 <consoleintr+0x50>

0000000080007e28 <consoleinit>:
    80007e28:	fe010113          	addi	sp,sp,-32
    80007e2c:	00113c23          	sd	ra,24(sp)
    80007e30:	00813823          	sd	s0,16(sp)
    80007e34:	00913423          	sd	s1,8(sp)
    80007e38:	02010413          	addi	s0,sp,32
    80007e3c:	00006497          	auipc	s1,0x6
    80007e40:	d9c48493          	addi	s1,s1,-612 # 8000dbd8 <cons>
    80007e44:	00048513          	mv	a0,s1
    80007e48:	00002597          	auipc	a1,0x2
    80007e4c:	79058593          	addi	a1,a1,1936 # 8000a5d8 <CONSOLE_STATUS+0x5c8>
    80007e50:	00001097          	auipc	ra,0x1
    80007e54:	d88080e7          	jalr	-632(ra) # 80008bd8 <initlock>
    80007e58:	00000097          	auipc	ra,0x0
    80007e5c:	7ac080e7          	jalr	1964(ra) # 80008604 <uartinit>
    80007e60:	01813083          	ld	ra,24(sp)
    80007e64:	01013403          	ld	s0,16(sp)
    80007e68:	00000797          	auipc	a5,0x0
    80007e6c:	d9c78793          	addi	a5,a5,-612 # 80007c04 <consoleread>
    80007e70:	0af4bc23          	sd	a5,184(s1)
    80007e74:	00000797          	auipc	a5,0x0
    80007e78:	cec78793          	addi	a5,a5,-788 # 80007b60 <consolewrite>
    80007e7c:	0cf4b023          	sd	a5,192(s1)
    80007e80:	00813483          	ld	s1,8(sp)
    80007e84:	02010113          	addi	sp,sp,32
    80007e88:	00008067          	ret

0000000080007e8c <console_read>:
    80007e8c:	ff010113          	addi	sp,sp,-16
    80007e90:	00813423          	sd	s0,8(sp)
    80007e94:	01010413          	addi	s0,sp,16
    80007e98:	00813403          	ld	s0,8(sp)
    80007e9c:	00006317          	auipc	t1,0x6
    80007ea0:	df433303          	ld	t1,-524(t1) # 8000dc90 <devsw+0x10>
    80007ea4:	01010113          	addi	sp,sp,16
    80007ea8:	00030067          	jr	t1

0000000080007eac <console_write>:
    80007eac:	ff010113          	addi	sp,sp,-16
    80007eb0:	00813423          	sd	s0,8(sp)
    80007eb4:	01010413          	addi	s0,sp,16
    80007eb8:	00813403          	ld	s0,8(sp)
    80007ebc:	00006317          	auipc	t1,0x6
    80007ec0:	ddc33303          	ld	t1,-548(t1) # 8000dc98 <devsw+0x18>
    80007ec4:	01010113          	addi	sp,sp,16
    80007ec8:	00030067          	jr	t1

0000000080007ecc <panic>:
    80007ecc:	fe010113          	addi	sp,sp,-32
    80007ed0:	00113c23          	sd	ra,24(sp)
    80007ed4:	00813823          	sd	s0,16(sp)
    80007ed8:	00913423          	sd	s1,8(sp)
    80007edc:	02010413          	addi	s0,sp,32
    80007ee0:	00050493          	mv	s1,a0
    80007ee4:	00002517          	auipc	a0,0x2
    80007ee8:	6fc50513          	addi	a0,a0,1788 # 8000a5e0 <CONSOLE_STATUS+0x5d0>
    80007eec:	00006797          	auipc	a5,0x6
    80007ef0:	e407a623          	sw	zero,-436(a5) # 8000dd38 <pr+0x18>
    80007ef4:	00000097          	auipc	ra,0x0
    80007ef8:	034080e7          	jalr	52(ra) # 80007f28 <__printf>
    80007efc:	00048513          	mv	a0,s1
    80007f00:	00000097          	auipc	ra,0x0
    80007f04:	028080e7          	jalr	40(ra) # 80007f28 <__printf>
    80007f08:	00002517          	auipc	a0,0x2
    80007f0c:	46050513          	addi	a0,a0,1120 # 8000a368 <CONSOLE_STATUS+0x358>
    80007f10:	00000097          	auipc	ra,0x0
    80007f14:	018080e7          	jalr	24(ra) # 80007f28 <__printf>
    80007f18:	00100793          	li	a5,1
    80007f1c:	00005717          	auipc	a4,0x5
    80007f20:	b0f72623          	sw	a5,-1268(a4) # 8000ca28 <panicked>
    80007f24:	0000006f          	j	80007f24 <panic+0x58>

0000000080007f28 <__printf>:
    80007f28:	f3010113          	addi	sp,sp,-208
    80007f2c:	08813023          	sd	s0,128(sp)
    80007f30:	07313423          	sd	s3,104(sp)
    80007f34:	09010413          	addi	s0,sp,144
    80007f38:	05813023          	sd	s8,64(sp)
    80007f3c:	08113423          	sd	ra,136(sp)
    80007f40:	06913c23          	sd	s1,120(sp)
    80007f44:	07213823          	sd	s2,112(sp)
    80007f48:	07413023          	sd	s4,96(sp)
    80007f4c:	05513c23          	sd	s5,88(sp)
    80007f50:	05613823          	sd	s6,80(sp)
    80007f54:	05713423          	sd	s7,72(sp)
    80007f58:	03913c23          	sd	s9,56(sp)
    80007f5c:	03a13823          	sd	s10,48(sp)
    80007f60:	03b13423          	sd	s11,40(sp)
    80007f64:	00006317          	auipc	t1,0x6
    80007f68:	dbc30313          	addi	t1,t1,-580 # 8000dd20 <pr>
    80007f6c:	01832c03          	lw	s8,24(t1)
    80007f70:	00b43423          	sd	a1,8(s0)
    80007f74:	00c43823          	sd	a2,16(s0)
    80007f78:	00d43c23          	sd	a3,24(s0)
    80007f7c:	02e43023          	sd	a4,32(s0)
    80007f80:	02f43423          	sd	a5,40(s0)
    80007f84:	03043823          	sd	a6,48(s0)
    80007f88:	03143c23          	sd	a7,56(s0)
    80007f8c:	00050993          	mv	s3,a0
    80007f90:	4a0c1663          	bnez	s8,8000843c <__printf+0x514>
    80007f94:	60098c63          	beqz	s3,800085ac <__printf+0x684>
    80007f98:	0009c503          	lbu	a0,0(s3)
    80007f9c:	00840793          	addi	a5,s0,8
    80007fa0:	f6f43c23          	sd	a5,-136(s0)
    80007fa4:	00000493          	li	s1,0
    80007fa8:	22050063          	beqz	a0,800081c8 <__printf+0x2a0>
    80007fac:	00002a37          	lui	s4,0x2
    80007fb0:	00018ab7          	lui	s5,0x18
    80007fb4:	000f4b37          	lui	s6,0xf4
    80007fb8:	00989bb7          	lui	s7,0x989
    80007fbc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80007fc0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80007fc4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80007fc8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80007fcc:	00148c9b          	addiw	s9,s1,1
    80007fd0:	02500793          	li	a5,37
    80007fd4:	01998933          	add	s2,s3,s9
    80007fd8:	38f51263          	bne	a0,a5,8000835c <__printf+0x434>
    80007fdc:	00094783          	lbu	a5,0(s2)
    80007fe0:	00078c9b          	sext.w	s9,a5
    80007fe4:	1e078263          	beqz	a5,800081c8 <__printf+0x2a0>
    80007fe8:	0024849b          	addiw	s1,s1,2
    80007fec:	07000713          	li	a4,112
    80007ff0:	00998933          	add	s2,s3,s1
    80007ff4:	38e78a63          	beq	a5,a4,80008388 <__printf+0x460>
    80007ff8:	20f76863          	bltu	a4,a5,80008208 <__printf+0x2e0>
    80007ffc:	42a78863          	beq	a5,a0,8000842c <__printf+0x504>
    80008000:	06400713          	li	a4,100
    80008004:	40e79663          	bne	a5,a4,80008410 <__printf+0x4e8>
    80008008:	f7843783          	ld	a5,-136(s0)
    8000800c:	0007a603          	lw	a2,0(a5)
    80008010:	00878793          	addi	a5,a5,8
    80008014:	f6f43c23          	sd	a5,-136(s0)
    80008018:	42064a63          	bltz	a2,8000844c <__printf+0x524>
    8000801c:	00a00713          	li	a4,10
    80008020:	02e677bb          	remuw	a5,a2,a4
    80008024:	00002d97          	auipc	s11,0x2
    80008028:	5e4d8d93          	addi	s11,s11,1508 # 8000a608 <digits>
    8000802c:	00900593          	li	a1,9
    80008030:	0006051b          	sext.w	a0,a2
    80008034:	00000c93          	li	s9,0
    80008038:	02079793          	slli	a5,a5,0x20
    8000803c:	0207d793          	srli	a5,a5,0x20
    80008040:	00fd87b3          	add	a5,s11,a5
    80008044:	0007c783          	lbu	a5,0(a5)
    80008048:	02e656bb          	divuw	a3,a2,a4
    8000804c:	f8f40023          	sb	a5,-128(s0)
    80008050:	14c5d863          	bge	a1,a2,800081a0 <__printf+0x278>
    80008054:	06300593          	li	a1,99
    80008058:	00100c93          	li	s9,1
    8000805c:	02e6f7bb          	remuw	a5,a3,a4
    80008060:	02079793          	slli	a5,a5,0x20
    80008064:	0207d793          	srli	a5,a5,0x20
    80008068:	00fd87b3          	add	a5,s11,a5
    8000806c:	0007c783          	lbu	a5,0(a5)
    80008070:	02e6d73b          	divuw	a4,a3,a4
    80008074:	f8f400a3          	sb	a5,-127(s0)
    80008078:	12a5f463          	bgeu	a1,a0,800081a0 <__printf+0x278>
    8000807c:	00a00693          	li	a3,10
    80008080:	00900593          	li	a1,9
    80008084:	02d777bb          	remuw	a5,a4,a3
    80008088:	02079793          	slli	a5,a5,0x20
    8000808c:	0207d793          	srli	a5,a5,0x20
    80008090:	00fd87b3          	add	a5,s11,a5
    80008094:	0007c503          	lbu	a0,0(a5)
    80008098:	02d757bb          	divuw	a5,a4,a3
    8000809c:	f8a40123          	sb	a0,-126(s0)
    800080a0:	48e5f263          	bgeu	a1,a4,80008524 <__printf+0x5fc>
    800080a4:	06300513          	li	a0,99
    800080a8:	02d7f5bb          	remuw	a1,a5,a3
    800080ac:	02059593          	slli	a1,a1,0x20
    800080b0:	0205d593          	srli	a1,a1,0x20
    800080b4:	00bd85b3          	add	a1,s11,a1
    800080b8:	0005c583          	lbu	a1,0(a1)
    800080bc:	02d7d7bb          	divuw	a5,a5,a3
    800080c0:	f8b401a3          	sb	a1,-125(s0)
    800080c4:	48e57263          	bgeu	a0,a4,80008548 <__printf+0x620>
    800080c8:	3e700513          	li	a0,999
    800080cc:	02d7f5bb          	remuw	a1,a5,a3
    800080d0:	02059593          	slli	a1,a1,0x20
    800080d4:	0205d593          	srli	a1,a1,0x20
    800080d8:	00bd85b3          	add	a1,s11,a1
    800080dc:	0005c583          	lbu	a1,0(a1)
    800080e0:	02d7d7bb          	divuw	a5,a5,a3
    800080e4:	f8b40223          	sb	a1,-124(s0)
    800080e8:	46e57663          	bgeu	a0,a4,80008554 <__printf+0x62c>
    800080ec:	02d7f5bb          	remuw	a1,a5,a3
    800080f0:	02059593          	slli	a1,a1,0x20
    800080f4:	0205d593          	srli	a1,a1,0x20
    800080f8:	00bd85b3          	add	a1,s11,a1
    800080fc:	0005c583          	lbu	a1,0(a1)
    80008100:	02d7d7bb          	divuw	a5,a5,a3
    80008104:	f8b402a3          	sb	a1,-123(s0)
    80008108:	46ea7863          	bgeu	s4,a4,80008578 <__printf+0x650>
    8000810c:	02d7f5bb          	remuw	a1,a5,a3
    80008110:	02059593          	slli	a1,a1,0x20
    80008114:	0205d593          	srli	a1,a1,0x20
    80008118:	00bd85b3          	add	a1,s11,a1
    8000811c:	0005c583          	lbu	a1,0(a1)
    80008120:	02d7d7bb          	divuw	a5,a5,a3
    80008124:	f8b40323          	sb	a1,-122(s0)
    80008128:	3eeaf863          	bgeu	s5,a4,80008518 <__printf+0x5f0>
    8000812c:	02d7f5bb          	remuw	a1,a5,a3
    80008130:	02059593          	slli	a1,a1,0x20
    80008134:	0205d593          	srli	a1,a1,0x20
    80008138:	00bd85b3          	add	a1,s11,a1
    8000813c:	0005c583          	lbu	a1,0(a1)
    80008140:	02d7d7bb          	divuw	a5,a5,a3
    80008144:	f8b403a3          	sb	a1,-121(s0)
    80008148:	42eb7e63          	bgeu	s6,a4,80008584 <__printf+0x65c>
    8000814c:	02d7f5bb          	remuw	a1,a5,a3
    80008150:	02059593          	slli	a1,a1,0x20
    80008154:	0205d593          	srli	a1,a1,0x20
    80008158:	00bd85b3          	add	a1,s11,a1
    8000815c:	0005c583          	lbu	a1,0(a1)
    80008160:	02d7d7bb          	divuw	a5,a5,a3
    80008164:	f8b40423          	sb	a1,-120(s0)
    80008168:	42ebfc63          	bgeu	s7,a4,800085a0 <__printf+0x678>
    8000816c:	02079793          	slli	a5,a5,0x20
    80008170:	0207d793          	srli	a5,a5,0x20
    80008174:	00fd8db3          	add	s11,s11,a5
    80008178:	000dc703          	lbu	a4,0(s11)
    8000817c:	00a00793          	li	a5,10
    80008180:	00900c93          	li	s9,9
    80008184:	f8e404a3          	sb	a4,-119(s0)
    80008188:	00065c63          	bgez	a2,800081a0 <__printf+0x278>
    8000818c:	f9040713          	addi	a4,s0,-112
    80008190:	00f70733          	add	a4,a4,a5
    80008194:	02d00693          	li	a3,45
    80008198:	fed70823          	sb	a3,-16(a4)
    8000819c:	00078c93          	mv	s9,a5
    800081a0:	f8040793          	addi	a5,s0,-128
    800081a4:	01978cb3          	add	s9,a5,s9
    800081a8:	f7f40d13          	addi	s10,s0,-129
    800081ac:	000cc503          	lbu	a0,0(s9)
    800081b0:	fffc8c93          	addi	s9,s9,-1
    800081b4:	00000097          	auipc	ra,0x0
    800081b8:	b90080e7          	jalr	-1136(ra) # 80007d44 <consputc>
    800081bc:	ffac98e3          	bne	s9,s10,800081ac <__printf+0x284>
    800081c0:	00094503          	lbu	a0,0(s2)
    800081c4:	e00514e3          	bnez	a0,80007fcc <__printf+0xa4>
    800081c8:	1a0c1663          	bnez	s8,80008374 <__printf+0x44c>
    800081cc:	08813083          	ld	ra,136(sp)
    800081d0:	08013403          	ld	s0,128(sp)
    800081d4:	07813483          	ld	s1,120(sp)
    800081d8:	07013903          	ld	s2,112(sp)
    800081dc:	06813983          	ld	s3,104(sp)
    800081e0:	06013a03          	ld	s4,96(sp)
    800081e4:	05813a83          	ld	s5,88(sp)
    800081e8:	05013b03          	ld	s6,80(sp)
    800081ec:	04813b83          	ld	s7,72(sp)
    800081f0:	04013c03          	ld	s8,64(sp)
    800081f4:	03813c83          	ld	s9,56(sp)
    800081f8:	03013d03          	ld	s10,48(sp)
    800081fc:	02813d83          	ld	s11,40(sp)
    80008200:	0d010113          	addi	sp,sp,208
    80008204:	00008067          	ret
    80008208:	07300713          	li	a4,115
    8000820c:	1ce78a63          	beq	a5,a4,800083e0 <__printf+0x4b8>
    80008210:	07800713          	li	a4,120
    80008214:	1ee79e63          	bne	a5,a4,80008410 <__printf+0x4e8>
    80008218:	f7843783          	ld	a5,-136(s0)
    8000821c:	0007a703          	lw	a4,0(a5)
    80008220:	00878793          	addi	a5,a5,8
    80008224:	f6f43c23          	sd	a5,-136(s0)
    80008228:	28074263          	bltz	a4,800084ac <__printf+0x584>
    8000822c:	00002d97          	auipc	s11,0x2
    80008230:	3dcd8d93          	addi	s11,s11,988 # 8000a608 <digits>
    80008234:	00f77793          	andi	a5,a4,15
    80008238:	00fd87b3          	add	a5,s11,a5
    8000823c:	0007c683          	lbu	a3,0(a5)
    80008240:	00f00613          	li	a2,15
    80008244:	0007079b          	sext.w	a5,a4
    80008248:	f8d40023          	sb	a3,-128(s0)
    8000824c:	0047559b          	srliw	a1,a4,0x4
    80008250:	0047569b          	srliw	a3,a4,0x4
    80008254:	00000c93          	li	s9,0
    80008258:	0ee65063          	bge	a2,a4,80008338 <__printf+0x410>
    8000825c:	00f6f693          	andi	a3,a3,15
    80008260:	00dd86b3          	add	a3,s11,a3
    80008264:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80008268:	0087d79b          	srliw	a5,a5,0x8
    8000826c:	00100c93          	li	s9,1
    80008270:	f8d400a3          	sb	a3,-127(s0)
    80008274:	0cb67263          	bgeu	a2,a1,80008338 <__printf+0x410>
    80008278:	00f7f693          	andi	a3,a5,15
    8000827c:	00dd86b3          	add	a3,s11,a3
    80008280:	0006c583          	lbu	a1,0(a3)
    80008284:	00f00613          	li	a2,15
    80008288:	0047d69b          	srliw	a3,a5,0x4
    8000828c:	f8b40123          	sb	a1,-126(s0)
    80008290:	0047d593          	srli	a1,a5,0x4
    80008294:	28f67e63          	bgeu	a2,a5,80008530 <__printf+0x608>
    80008298:	00f6f693          	andi	a3,a3,15
    8000829c:	00dd86b3          	add	a3,s11,a3
    800082a0:	0006c503          	lbu	a0,0(a3)
    800082a4:	0087d813          	srli	a6,a5,0x8
    800082a8:	0087d69b          	srliw	a3,a5,0x8
    800082ac:	f8a401a3          	sb	a0,-125(s0)
    800082b0:	28b67663          	bgeu	a2,a1,8000853c <__printf+0x614>
    800082b4:	00f6f693          	andi	a3,a3,15
    800082b8:	00dd86b3          	add	a3,s11,a3
    800082bc:	0006c583          	lbu	a1,0(a3)
    800082c0:	00c7d513          	srli	a0,a5,0xc
    800082c4:	00c7d69b          	srliw	a3,a5,0xc
    800082c8:	f8b40223          	sb	a1,-124(s0)
    800082cc:	29067a63          	bgeu	a2,a6,80008560 <__printf+0x638>
    800082d0:	00f6f693          	andi	a3,a3,15
    800082d4:	00dd86b3          	add	a3,s11,a3
    800082d8:	0006c583          	lbu	a1,0(a3)
    800082dc:	0107d813          	srli	a6,a5,0x10
    800082e0:	0107d69b          	srliw	a3,a5,0x10
    800082e4:	f8b402a3          	sb	a1,-123(s0)
    800082e8:	28a67263          	bgeu	a2,a0,8000856c <__printf+0x644>
    800082ec:	00f6f693          	andi	a3,a3,15
    800082f0:	00dd86b3          	add	a3,s11,a3
    800082f4:	0006c683          	lbu	a3,0(a3)
    800082f8:	0147d79b          	srliw	a5,a5,0x14
    800082fc:	f8d40323          	sb	a3,-122(s0)
    80008300:	21067663          	bgeu	a2,a6,8000850c <__printf+0x5e4>
    80008304:	02079793          	slli	a5,a5,0x20
    80008308:	0207d793          	srli	a5,a5,0x20
    8000830c:	00fd8db3          	add	s11,s11,a5
    80008310:	000dc683          	lbu	a3,0(s11)
    80008314:	00800793          	li	a5,8
    80008318:	00700c93          	li	s9,7
    8000831c:	f8d403a3          	sb	a3,-121(s0)
    80008320:	00075c63          	bgez	a4,80008338 <__printf+0x410>
    80008324:	f9040713          	addi	a4,s0,-112
    80008328:	00f70733          	add	a4,a4,a5
    8000832c:	02d00693          	li	a3,45
    80008330:	fed70823          	sb	a3,-16(a4)
    80008334:	00078c93          	mv	s9,a5
    80008338:	f8040793          	addi	a5,s0,-128
    8000833c:	01978cb3          	add	s9,a5,s9
    80008340:	f7f40d13          	addi	s10,s0,-129
    80008344:	000cc503          	lbu	a0,0(s9)
    80008348:	fffc8c93          	addi	s9,s9,-1
    8000834c:	00000097          	auipc	ra,0x0
    80008350:	9f8080e7          	jalr	-1544(ra) # 80007d44 <consputc>
    80008354:	ff9d18e3          	bne	s10,s9,80008344 <__printf+0x41c>
    80008358:	0100006f          	j	80008368 <__printf+0x440>
    8000835c:	00000097          	auipc	ra,0x0
    80008360:	9e8080e7          	jalr	-1560(ra) # 80007d44 <consputc>
    80008364:	000c8493          	mv	s1,s9
    80008368:	00094503          	lbu	a0,0(s2)
    8000836c:	c60510e3          	bnez	a0,80007fcc <__printf+0xa4>
    80008370:	e40c0ee3          	beqz	s8,800081cc <__printf+0x2a4>
    80008374:	00006517          	auipc	a0,0x6
    80008378:	9ac50513          	addi	a0,a0,-1620 # 8000dd20 <pr>
    8000837c:	00001097          	auipc	ra,0x1
    80008380:	94c080e7          	jalr	-1716(ra) # 80008cc8 <release>
    80008384:	e49ff06f          	j	800081cc <__printf+0x2a4>
    80008388:	f7843783          	ld	a5,-136(s0)
    8000838c:	03000513          	li	a0,48
    80008390:	01000d13          	li	s10,16
    80008394:	00878713          	addi	a4,a5,8
    80008398:	0007bc83          	ld	s9,0(a5)
    8000839c:	f6e43c23          	sd	a4,-136(s0)
    800083a0:	00000097          	auipc	ra,0x0
    800083a4:	9a4080e7          	jalr	-1628(ra) # 80007d44 <consputc>
    800083a8:	07800513          	li	a0,120
    800083ac:	00000097          	auipc	ra,0x0
    800083b0:	998080e7          	jalr	-1640(ra) # 80007d44 <consputc>
    800083b4:	00002d97          	auipc	s11,0x2
    800083b8:	254d8d93          	addi	s11,s11,596 # 8000a608 <digits>
    800083bc:	03ccd793          	srli	a5,s9,0x3c
    800083c0:	00fd87b3          	add	a5,s11,a5
    800083c4:	0007c503          	lbu	a0,0(a5)
    800083c8:	fffd0d1b          	addiw	s10,s10,-1
    800083cc:	004c9c93          	slli	s9,s9,0x4
    800083d0:	00000097          	auipc	ra,0x0
    800083d4:	974080e7          	jalr	-1676(ra) # 80007d44 <consputc>
    800083d8:	fe0d12e3          	bnez	s10,800083bc <__printf+0x494>
    800083dc:	f8dff06f          	j	80008368 <__printf+0x440>
    800083e0:	f7843783          	ld	a5,-136(s0)
    800083e4:	0007bc83          	ld	s9,0(a5)
    800083e8:	00878793          	addi	a5,a5,8
    800083ec:	f6f43c23          	sd	a5,-136(s0)
    800083f0:	000c9a63          	bnez	s9,80008404 <__printf+0x4dc>
    800083f4:	1080006f          	j	800084fc <__printf+0x5d4>
    800083f8:	001c8c93          	addi	s9,s9,1
    800083fc:	00000097          	auipc	ra,0x0
    80008400:	948080e7          	jalr	-1720(ra) # 80007d44 <consputc>
    80008404:	000cc503          	lbu	a0,0(s9)
    80008408:	fe0518e3          	bnez	a0,800083f8 <__printf+0x4d0>
    8000840c:	f5dff06f          	j	80008368 <__printf+0x440>
    80008410:	02500513          	li	a0,37
    80008414:	00000097          	auipc	ra,0x0
    80008418:	930080e7          	jalr	-1744(ra) # 80007d44 <consputc>
    8000841c:	000c8513          	mv	a0,s9
    80008420:	00000097          	auipc	ra,0x0
    80008424:	924080e7          	jalr	-1756(ra) # 80007d44 <consputc>
    80008428:	f41ff06f          	j	80008368 <__printf+0x440>
    8000842c:	02500513          	li	a0,37
    80008430:	00000097          	auipc	ra,0x0
    80008434:	914080e7          	jalr	-1772(ra) # 80007d44 <consputc>
    80008438:	f31ff06f          	j	80008368 <__printf+0x440>
    8000843c:	00030513          	mv	a0,t1
    80008440:	00000097          	auipc	ra,0x0
    80008444:	7bc080e7          	jalr	1980(ra) # 80008bfc <acquire>
    80008448:	b4dff06f          	j	80007f94 <__printf+0x6c>
    8000844c:	40c0053b          	negw	a0,a2
    80008450:	00a00713          	li	a4,10
    80008454:	02e576bb          	remuw	a3,a0,a4
    80008458:	00002d97          	auipc	s11,0x2
    8000845c:	1b0d8d93          	addi	s11,s11,432 # 8000a608 <digits>
    80008460:	ff700593          	li	a1,-9
    80008464:	02069693          	slli	a3,a3,0x20
    80008468:	0206d693          	srli	a3,a3,0x20
    8000846c:	00dd86b3          	add	a3,s11,a3
    80008470:	0006c683          	lbu	a3,0(a3)
    80008474:	02e557bb          	divuw	a5,a0,a4
    80008478:	f8d40023          	sb	a3,-128(s0)
    8000847c:	10b65e63          	bge	a2,a1,80008598 <__printf+0x670>
    80008480:	06300593          	li	a1,99
    80008484:	02e7f6bb          	remuw	a3,a5,a4
    80008488:	02069693          	slli	a3,a3,0x20
    8000848c:	0206d693          	srli	a3,a3,0x20
    80008490:	00dd86b3          	add	a3,s11,a3
    80008494:	0006c683          	lbu	a3,0(a3)
    80008498:	02e7d73b          	divuw	a4,a5,a4
    8000849c:	00200793          	li	a5,2
    800084a0:	f8d400a3          	sb	a3,-127(s0)
    800084a4:	bca5ece3          	bltu	a1,a0,8000807c <__printf+0x154>
    800084a8:	ce5ff06f          	j	8000818c <__printf+0x264>
    800084ac:	40e007bb          	negw	a5,a4
    800084b0:	00002d97          	auipc	s11,0x2
    800084b4:	158d8d93          	addi	s11,s11,344 # 8000a608 <digits>
    800084b8:	00f7f693          	andi	a3,a5,15
    800084bc:	00dd86b3          	add	a3,s11,a3
    800084c0:	0006c583          	lbu	a1,0(a3)
    800084c4:	ff100613          	li	a2,-15
    800084c8:	0047d69b          	srliw	a3,a5,0x4
    800084cc:	f8b40023          	sb	a1,-128(s0)
    800084d0:	0047d59b          	srliw	a1,a5,0x4
    800084d4:	0ac75e63          	bge	a4,a2,80008590 <__printf+0x668>
    800084d8:	00f6f693          	andi	a3,a3,15
    800084dc:	00dd86b3          	add	a3,s11,a3
    800084e0:	0006c603          	lbu	a2,0(a3)
    800084e4:	00f00693          	li	a3,15
    800084e8:	0087d79b          	srliw	a5,a5,0x8
    800084ec:	f8c400a3          	sb	a2,-127(s0)
    800084f0:	d8b6e4e3          	bltu	a3,a1,80008278 <__printf+0x350>
    800084f4:	00200793          	li	a5,2
    800084f8:	e2dff06f          	j	80008324 <__printf+0x3fc>
    800084fc:	00002c97          	auipc	s9,0x2
    80008500:	0ecc8c93          	addi	s9,s9,236 # 8000a5e8 <CONSOLE_STATUS+0x5d8>
    80008504:	02800513          	li	a0,40
    80008508:	ef1ff06f          	j	800083f8 <__printf+0x4d0>
    8000850c:	00700793          	li	a5,7
    80008510:	00600c93          	li	s9,6
    80008514:	e0dff06f          	j	80008320 <__printf+0x3f8>
    80008518:	00700793          	li	a5,7
    8000851c:	00600c93          	li	s9,6
    80008520:	c69ff06f          	j	80008188 <__printf+0x260>
    80008524:	00300793          	li	a5,3
    80008528:	00200c93          	li	s9,2
    8000852c:	c5dff06f          	j	80008188 <__printf+0x260>
    80008530:	00300793          	li	a5,3
    80008534:	00200c93          	li	s9,2
    80008538:	de9ff06f          	j	80008320 <__printf+0x3f8>
    8000853c:	00400793          	li	a5,4
    80008540:	00300c93          	li	s9,3
    80008544:	dddff06f          	j	80008320 <__printf+0x3f8>
    80008548:	00400793          	li	a5,4
    8000854c:	00300c93          	li	s9,3
    80008550:	c39ff06f          	j	80008188 <__printf+0x260>
    80008554:	00500793          	li	a5,5
    80008558:	00400c93          	li	s9,4
    8000855c:	c2dff06f          	j	80008188 <__printf+0x260>
    80008560:	00500793          	li	a5,5
    80008564:	00400c93          	li	s9,4
    80008568:	db9ff06f          	j	80008320 <__printf+0x3f8>
    8000856c:	00600793          	li	a5,6
    80008570:	00500c93          	li	s9,5
    80008574:	dadff06f          	j	80008320 <__printf+0x3f8>
    80008578:	00600793          	li	a5,6
    8000857c:	00500c93          	li	s9,5
    80008580:	c09ff06f          	j	80008188 <__printf+0x260>
    80008584:	00800793          	li	a5,8
    80008588:	00700c93          	li	s9,7
    8000858c:	bfdff06f          	j	80008188 <__printf+0x260>
    80008590:	00100793          	li	a5,1
    80008594:	d91ff06f          	j	80008324 <__printf+0x3fc>
    80008598:	00100793          	li	a5,1
    8000859c:	bf1ff06f          	j	8000818c <__printf+0x264>
    800085a0:	00900793          	li	a5,9
    800085a4:	00800c93          	li	s9,8
    800085a8:	be1ff06f          	j	80008188 <__printf+0x260>
    800085ac:	00002517          	auipc	a0,0x2
    800085b0:	04450513          	addi	a0,a0,68 # 8000a5f0 <CONSOLE_STATUS+0x5e0>
    800085b4:	00000097          	auipc	ra,0x0
    800085b8:	918080e7          	jalr	-1768(ra) # 80007ecc <panic>

00000000800085bc <printfinit>:
    800085bc:	fe010113          	addi	sp,sp,-32
    800085c0:	00813823          	sd	s0,16(sp)
    800085c4:	00913423          	sd	s1,8(sp)
    800085c8:	00113c23          	sd	ra,24(sp)
    800085cc:	02010413          	addi	s0,sp,32
    800085d0:	00005497          	auipc	s1,0x5
    800085d4:	75048493          	addi	s1,s1,1872 # 8000dd20 <pr>
    800085d8:	00048513          	mv	a0,s1
    800085dc:	00002597          	auipc	a1,0x2
    800085e0:	02458593          	addi	a1,a1,36 # 8000a600 <CONSOLE_STATUS+0x5f0>
    800085e4:	00000097          	auipc	ra,0x0
    800085e8:	5f4080e7          	jalr	1524(ra) # 80008bd8 <initlock>
    800085ec:	01813083          	ld	ra,24(sp)
    800085f0:	01013403          	ld	s0,16(sp)
    800085f4:	0004ac23          	sw	zero,24(s1)
    800085f8:	00813483          	ld	s1,8(sp)
    800085fc:	02010113          	addi	sp,sp,32
    80008600:	00008067          	ret

0000000080008604 <uartinit>:
    80008604:	ff010113          	addi	sp,sp,-16
    80008608:	00813423          	sd	s0,8(sp)
    8000860c:	01010413          	addi	s0,sp,16
    80008610:	100007b7          	lui	a5,0x10000
    80008614:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80008618:	f8000713          	li	a4,-128
    8000861c:	00e781a3          	sb	a4,3(a5)
    80008620:	00300713          	li	a4,3
    80008624:	00e78023          	sb	a4,0(a5)
    80008628:	000780a3          	sb	zero,1(a5)
    8000862c:	00e781a3          	sb	a4,3(a5)
    80008630:	00700693          	li	a3,7
    80008634:	00d78123          	sb	a3,2(a5)
    80008638:	00e780a3          	sb	a4,1(a5)
    8000863c:	00813403          	ld	s0,8(sp)
    80008640:	01010113          	addi	sp,sp,16
    80008644:	00008067          	ret

0000000080008648 <uartputc>:
    80008648:	00004797          	auipc	a5,0x4
    8000864c:	3e07a783          	lw	a5,992(a5) # 8000ca28 <panicked>
    80008650:	00078463          	beqz	a5,80008658 <uartputc+0x10>
    80008654:	0000006f          	j	80008654 <uartputc+0xc>
    80008658:	fd010113          	addi	sp,sp,-48
    8000865c:	02813023          	sd	s0,32(sp)
    80008660:	00913c23          	sd	s1,24(sp)
    80008664:	01213823          	sd	s2,16(sp)
    80008668:	01313423          	sd	s3,8(sp)
    8000866c:	02113423          	sd	ra,40(sp)
    80008670:	03010413          	addi	s0,sp,48
    80008674:	00004917          	auipc	s2,0x4
    80008678:	3bc90913          	addi	s2,s2,956 # 8000ca30 <uart_tx_r>
    8000867c:	00093783          	ld	a5,0(s2)
    80008680:	00004497          	auipc	s1,0x4
    80008684:	3b848493          	addi	s1,s1,952 # 8000ca38 <uart_tx_w>
    80008688:	0004b703          	ld	a4,0(s1)
    8000868c:	02078693          	addi	a3,a5,32
    80008690:	00050993          	mv	s3,a0
    80008694:	02e69c63          	bne	a3,a4,800086cc <uartputc+0x84>
    80008698:	00001097          	auipc	ra,0x1
    8000869c:	834080e7          	jalr	-1996(ra) # 80008ecc <push_on>
    800086a0:	00093783          	ld	a5,0(s2)
    800086a4:	0004b703          	ld	a4,0(s1)
    800086a8:	02078793          	addi	a5,a5,32
    800086ac:	00e79463          	bne	a5,a4,800086b4 <uartputc+0x6c>
    800086b0:	0000006f          	j	800086b0 <uartputc+0x68>
    800086b4:	00001097          	auipc	ra,0x1
    800086b8:	88c080e7          	jalr	-1908(ra) # 80008f40 <pop_on>
    800086bc:	00093783          	ld	a5,0(s2)
    800086c0:	0004b703          	ld	a4,0(s1)
    800086c4:	02078693          	addi	a3,a5,32
    800086c8:	fce688e3          	beq	a3,a4,80008698 <uartputc+0x50>
    800086cc:	01f77693          	andi	a3,a4,31
    800086d0:	00005597          	auipc	a1,0x5
    800086d4:	67058593          	addi	a1,a1,1648 # 8000dd40 <uart_tx_buf>
    800086d8:	00d586b3          	add	a3,a1,a3
    800086dc:	00170713          	addi	a4,a4,1
    800086e0:	01368023          	sb	s3,0(a3)
    800086e4:	00e4b023          	sd	a4,0(s1)
    800086e8:	10000637          	lui	a2,0x10000
    800086ec:	02f71063          	bne	a4,a5,8000870c <uartputc+0xc4>
    800086f0:	0340006f          	j	80008724 <uartputc+0xdc>
    800086f4:	00074703          	lbu	a4,0(a4)
    800086f8:	00f93023          	sd	a5,0(s2)
    800086fc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80008700:	00093783          	ld	a5,0(s2)
    80008704:	0004b703          	ld	a4,0(s1)
    80008708:	00f70e63          	beq	a4,a5,80008724 <uartputc+0xdc>
    8000870c:	00564683          	lbu	a3,5(a2)
    80008710:	01f7f713          	andi	a4,a5,31
    80008714:	00e58733          	add	a4,a1,a4
    80008718:	0206f693          	andi	a3,a3,32
    8000871c:	00178793          	addi	a5,a5,1
    80008720:	fc069ae3          	bnez	a3,800086f4 <uartputc+0xac>
    80008724:	02813083          	ld	ra,40(sp)
    80008728:	02013403          	ld	s0,32(sp)
    8000872c:	01813483          	ld	s1,24(sp)
    80008730:	01013903          	ld	s2,16(sp)
    80008734:	00813983          	ld	s3,8(sp)
    80008738:	03010113          	addi	sp,sp,48
    8000873c:	00008067          	ret

0000000080008740 <uartputc_sync>:
    80008740:	ff010113          	addi	sp,sp,-16
    80008744:	00813423          	sd	s0,8(sp)
    80008748:	01010413          	addi	s0,sp,16
    8000874c:	00004717          	auipc	a4,0x4
    80008750:	2dc72703          	lw	a4,732(a4) # 8000ca28 <panicked>
    80008754:	02071663          	bnez	a4,80008780 <uartputc_sync+0x40>
    80008758:	00050793          	mv	a5,a0
    8000875c:	100006b7          	lui	a3,0x10000
    80008760:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80008764:	02077713          	andi	a4,a4,32
    80008768:	fe070ce3          	beqz	a4,80008760 <uartputc_sync+0x20>
    8000876c:	0ff7f793          	andi	a5,a5,255
    80008770:	00f68023          	sb	a5,0(a3)
    80008774:	00813403          	ld	s0,8(sp)
    80008778:	01010113          	addi	sp,sp,16
    8000877c:	00008067          	ret
    80008780:	0000006f          	j	80008780 <uartputc_sync+0x40>

0000000080008784 <uartstart>:
    80008784:	ff010113          	addi	sp,sp,-16
    80008788:	00813423          	sd	s0,8(sp)
    8000878c:	01010413          	addi	s0,sp,16
    80008790:	00004617          	auipc	a2,0x4
    80008794:	2a060613          	addi	a2,a2,672 # 8000ca30 <uart_tx_r>
    80008798:	00004517          	auipc	a0,0x4
    8000879c:	2a050513          	addi	a0,a0,672 # 8000ca38 <uart_tx_w>
    800087a0:	00063783          	ld	a5,0(a2)
    800087a4:	00053703          	ld	a4,0(a0)
    800087a8:	04f70263          	beq	a4,a5,800087ec <uartstart+0x68>
    800087ac:	100005b7          	lui	a1,0x10000
    800087b0:	00005817          	auipc	a6,0x5
    800087b4:	59080813          	addi	a6,a6,1424 # 8000dd40 <uart_tx_buf>
    800087b8:	01c0006f          	j	800087d4 <uartstart+0x50>
    800087bc:	0006c703          	lbu	a4,0(a3)
    800087c0:	00f63023          	sd	a5,0(a2)
    800087c4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800087c8:	00063783          	ld	a5,0(a2)
    800087cc:	00053703          	ld	a4,0(a0)
    800087d0:	00f70e63          	beq	a4,a5,800087ec <uartstart+0x68>
    800087d4:	01f7f713          	andi	a4,a5,31
    800087d8:	00e806b3          	add	a3,a6,a4
    800087dc:	0055c703          	lbu	a4,5(a1)
    800087e0:	00178793          	addi	a5,a5,1
    800087e4:	02077713          	andi	a4,a4,32
    800087e8:	fc071ae3          	bnez	a4,800087bc <uartstart+0x38>
    800087ec:	00813403          	ld	s0,8(sp)
    800087f0:	01010113          	addi	sp,sp,16
    800087f4:	00008067          	ret

00000000800087f8 <uartgetc>:
    800087f8:	ff010113          	addi	sp,sp,-16
    800087fc:	00813423          	sd	s0,8(sp)
    80008800:	01010413          	addi	s0,sp,16
    80008804:	10000737          	lui	a4,0x10000
    80008808:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000880c:	0017f793          	andi	a5,a5,1
    80008810:	00078c63          	beqz	a5,80008828 <uartgetc+0x30>
    80008814:	00074503          	lbu	a0,0(a4)
    80008818:	0ff57513          	andi	a0,a0,255
    8000881c:	00813403          	ld	s0,8(sp)
    80008820:	01010113          	addi	sp,sp,16
    80008824:	00008067          	ret
    80008828:	fff00513          	li	a0,-1
    8000882c:	ff1ff06f          	j	8000881c <uartgetc+0x24>

0000000080008830 <uartintr>:
    80008830:	100007b7          	lui	a5,0x10000
    80008834:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80008838:	0017f793          	andi	a5,a5,1
    8000883c:	0a078463          	beqz	a5,800088e4 <uartintr+0xb4>
    80008840:	fe010113          	addi	sp,sp,-32
    80008844:	00813823          	sd	s0,16(sp)
    80008848:	00913423          	sd	s1,8(sp)
    8000884c:	00113c23          	sd	ra,24(sp)
    80008850:	02010413          	addi	s0,sp,32
    80008854:	100004b7          	lui	s1,0x10000
    80008858:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000885c:	0ff57513          	andi	a0,a0,255
    80008860:	fffff097          	auipc	ra,0xfffff
    80008864:	534080e7          	jalr	1332(ra) # 80007d94 <consoleintr>
    80008868:	0054c783          	lbu	a5,5(s1)
    8000886c:	0017f793          	andi	a5,a5,1
    80008870:	fe0794e3          	bnez	a5,80008858 <uartintr+0x28>
    80008874:	00004617          	auipc	a2,0x4
    80008878:	1bc60613          	addi	a2,a2,444 # 8000ca30 <uart_tx_r>
    8000887c:	00004517          	auipc	a0,0x4
    80008880:	1bc50513          	addi	a0,a0,444 # 8000ca38 <uart_tx_w>
    80008884:	00063783          	ld	a5,0(a2)
    80008888:	00053703          	ld	a4,0(a0)
    8000888c:	04f70263          	beq	a4,a5,800088d0 <uartintr+0xa0>
    80008890:	100005b7          	lui	a1,0x10000
    80008894:	00005817          	auipc	a6,0x5
    80008898:	4ac80813          	addi	a6,a6,1196 # 8000dd40 <uart_tx_buf>
    8000889c:	01c0006f          	j	800088b8 <uartintr+0x88>
    800088a0:	0006c703          	lbu	a4,0(a3)
    800088a4:	00f63023          	sd	a5,0(a2)
    800088a8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800088ac:	00063783          	ld	a5,0(a2)
    800088b0:	00053703          	ld	a4,0(a0)
    800088b4:	00f70e63          	beq	a4,a5,800088d0 <uartintr+0xa0>
    800088b8:	01f7f713          	andi	a4,a5,31
    800088bc:	00e806b3          	add	a3,a6,a4
    800088c0:	0055c703          	lbu	a4,5(a1)
    800088c4:	00178793          	addi	a5,a5,1
    800088c8:	02077713          	andi	a4,a4,32
    800088cc:	fc071ae3          	bnez	a4,800088a0 <uartintr+0x70>
    800088d0:	01813083          	ld	ra,24(sp)
    800088d4:	01013403          	ld	s0,16(sp)
    800088d8:	00813483          	ld	s1,8(sp)
    800088dc:	02010113          	addi	sp,sp,32
    800088e0:	00008067          	ret
    800088e4:	00004617          	auipc	a2,0x4
    800088e8:	14c60613          	addi	a2,a2,332 # 8000ca30 <uart_tx_r>
    800088ec:	00004517          	auipc	a0,0x4
    800088f0:	14c50513          	addi	a0,a0,332 # 8000ca38 <uart_tx_w>
    800088f4:	00063783          	ld	a5,0(a2)
    800088f8:	00053703          	ld	a4,0(a0)
    800088fc:	04f70263          	beq	a4,a5,80008940 <uartintr+0x110>
    80008900:	100005b7          	lui	a1,0x10000
    80008904:	00005817          	auipc	a6,0x5
    80008908:	43c80813          	addi	a6,a6,1084 # 8000dd40 <uart_tx_buf>
    8000890c:	01c0006f          	j	80008928 <uartintr+0xf8>
    80008910:	0006c703          	lbu	a4,0(a3)
    80008914:	00f63023          	sd	a5,0(a2)
    80008918:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000891c:	00063783          	ld	a5,0(a2)
    80008920:	00053703          	ld	a4,0(a0)
    80008924:	02f70063          	beq	a4,a5,80008944 <uartintr+0x114>
    80008928:	01f7f713          	andi	a4,a5,31
    8000892c:	00e806b3          	add	a3,a6,a4
    80008930:	0055c703          	lbu	a4,5(a1)
    80008934:	00178793          	addi	a5,a5,1
    80008938:	02077713          	andi	a4,a4,32
    8000893c:	fc071ae3          	bnez	a4,80008910 <uartintr+0xe0>
    80008940:	00008067          	ret
    80008944:	00008067          	ret

0000000080008948 <kinit>:
    80008948:	fc010113          	addi	sp,sp,-64
    8000894c:	02913423          	sd	s1,40(sp)
    80008950:	fffff7b7          	lui	a5,0xfffff
    80008954:	00006497          	auipc	s1,0x6
    80008958:	40b48493          	addi	s1,s1,1035 # 8000ed5f <end+0xfff>
    8000895c:	02813823          	sd	s0,48(sp)
    80008960:	01313c23          	sd	s3,24(sp)
    80008964:	00f4f4b3          	and	s1,s1,a5
    80008968:	02113c23          	sd	ra,56(sp)
    8000896c:	03213023          	sd	s2,32(sp)
    80008970:	01413823          	sd	s4,16(sp)
    80008974:	01513423          	sd	s5,8(sp)
    80008978:	04010413          	addi	s0,sp,64
    8000897c:	000017b7          	lui	a5,0x1
    80008980:	01100993          	li	s3,17
    80008984:	00f487b3          	add	a5,s1,a5
    80008988:	01b99993          	slli	s3,s3,0x1b
    8000898c:	06f9e063          	bltu	s3,a5,800089ec <kinit+0xa4>
    80008990:	00005a97          	auipc	s5,0x5
    80008994:	3d0a8a93          	addi	s5,s5,976 # 8000dd60 <end>
    80008998:	0754ec63          	bltu	s1,s5,80008a10 <kinit+0xc8>
    8000899c:	0734fa63          	bgeu	s1,s3,80008a10 <kinit+0xc8>
    800089a0:	00088a37          	lui	s4,0x88
    800089a4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800089a8:	00004917          	auipc	s2,0x4
    800089ac:	09890913          	addi	s2,s2,152 # 8000ca40 <kmem>
    800089b0:	00ca1a13          	slli	s4,s4,0xc
    800089b4:	0140006f          	j	800089c8 <kinit+0x80>
    800089b8:	000017b7          	lui	a5,0x1
    800089bc:	00f484b3          	add	s1,s1,a5
    800089c0:	0554e863          	bltu	s1,s5,80008a10 <kinit+0xc8>
    800089c4:	0534f663          	bgeu	s1,s3,80008a10 <kinit+0xc8>
    800089c8:	00001637          	lui	a2,0x1
    800089cc:	00100593          	li	a1,1
    800089d0:	00048513          	mv	a0,s1
    800089d4:	00000097          	auipc	ra,0x0
    800089d8:	5e4080e7          	jalr	1508(ra) # 80008fb8 <__memset>
    800089dc:	00093783          	ld	a5,0(s2)
    800089e0:	00f4b023          	sd	a5,0(s1)
    800089e4:	00993023          	sd	s1,0(s2)
    800089e8:	fd4498e3          	bne	s1,s4,800089b8 <kinit+0x70>
    800089ec:	03813083          	ld	ra,56(sp)
    800089f0:	03013403          	ld	s0,48(sp)
    800089f4:	02813483          	ld	s1,40(sp)
    800089f8:	02013903          	ld	s2,32(sp)
    800089fc:	01813983          	ld	s3,24(sp)
    80008a00:	01013a03          	ld	s4,16(sp)
    80008a04:	00813a83          	ld	s5,8(sp)
    80008a08:	04010113          	addi	sp,sp,64
    80008a0c:	00008067          	ret
    80008a10:	00002517          	auipc	a0,0x2
    80008a14:	c1050513          	addi	a0,a0,-1008 # 8000a620 <digits+0x18>
    80008a18:	fffff097          	auipc	ra,0xfffff
    80008a1c:	4b4080e7          	jalr	1204(ra) # 80007ecc <panic>

0000000080008a20 <freerange>:
    80008a20:	fc010113          	addi	sp,sp,-64
    80008a24:	000017b7          	lui	a5,0x1
    80008a28:	02913423          	sd	s1,40(sp)
    80008a2c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80008a30:	009504b3          	add	s1,a0,s1
    80008a34:	fffff537          	lui	a0,0xfffff
    80008a38:	02813823          	sd	s0,48(sp)
    80008a3c:	02113c23          	sd	ra,56(sp)
    80008a40:	03213023          	sd	s2,32(sp)
    80008a44:	01313c23          	sd	s3,24(sp)
    80008a48:	01413823          	sd	s4,16(sp)
    80008a4c:	01513423          	sd	s5,8(sp)
    80008a50:	01613023          	sd	s6,0(sp)
    80008a54:	04010413          	addi	s0,sp,64
    80008a58:	00a4f4b3          	and	s1,s1,a0
    80008a5c:	00f487b3          	add	a5,s1,a5
    80008a60:	06f5e463          	bltu	a1,a5,80008ac8 <freerange+0xa8>
    80008a64:	00005a97          	auipc	s5,0x5
    80008a68:	2fca8a93          	addi	s5,s5,764 # 8000dd60 <end>
    80008a6c:	0954e263          	bltu	s1,s5,80008af0 <freerange+0xd0>
    80008a70:	01100993          	li	s3,17
    80008a74:	01b99993          	slli	s3,s3,0x1b
    80008a78:	0734fc63          	bgeu	s1,s3,80008af0 <freerange+0xd0>
    80008a7c:	00058a13          	mv	s4,a1
    80008a80:	00004917          	auipc	s2,0x4
    80008a84:	fc090913          	addi	s2,s2,-64 # 8000ca40 <kmem>
    80008a88:	00002b37          	lui	s6,0x2
    80008a8c:	0140006f          	j	80008aa0 <freerange+0x80>
    80008a90:	000017b7          	lui	a5,0x1
    80008a94:	00f484b3          	add	s1,s1,a5
    80008a98:	0554ec63          	bltu	s1,s5,80008af0 <freerange+0xd0>
    80008a9c:	0534fa63          	bgeu	s1,s3,80008af0 <freerange+0xd0>
    80008aa0:	00001637          	lui	a2,0x1
    80008aa4:	00100593          	li	a1,1
    80008aa8:	00048513          	mv	a0,s1
    80008aac:	00000097          	auipc	ra,0x0
    80008ab0:	50c080e7          	jalr	1292(ra) # 80008fb8 <__memset>
    80008ab4:	00093703          	ld	a4,0(s2)
    80008ab8:	016487b3          	add	a5,s1,s6
    80008abc:	00e4b023          	sd	a4,0(s1)
    80008ac0:	00993023          	sd	s1,0(s2)
    80008ac4:	fcfa76e3          	bgeu	s4,a5,80008a90 <freerange+0x70>
    80008ac8:	03813083          	ld	ra,56(sp)
    80008acc:	03013403          	ld	s0,48(sp)
    80008ad0:	02813483          	ld	s1,40(sp)
    80008ad4:	02013903          	ld	s2,32(sp)
    80008ad8:	01813983          	ld	s3,24(sp)
    80008adc:	01013a03          	ld	s4,16(sp)
    80008ae0:	00813a83          	ld	s5,8(sp)
    80008ae4:	00013b03          	ld	s6,0(sp)
    80008ae8:	04010113          	addi	sp,sp,64
    80008aec:	00008067          	ret
    80008af0:	00002517          	auipc	a0,0x2
    80008af4:	b3050513          	addi	a0,a0,-1232 # 8000a620 <digits+0x18>
    80008af8:	fffff097          	auipc	ra,0xfffff
    80008afc:	3d4080e7          	jalr	980(ra) # 80007ecc <panic>

0000000080008b00 <kfree>:
    80008b00:	fe010113          	addi	sp,sp,-32
    80008b04:	00813823          	sd	s0,16(sp)
    80008b08:	00113c23          	sd	ra,24(sp)
    80008b0c:	00913423          	sd	s1,8(sp)
    80008b10:	02010413          	addi	s0,sp,32
    80008b14:	03451793          	slli	a5,a0,0x34
    80008b18:	04079c63          	bnez	a5,80008b70 <kfree+0x70>
    80008b1c:	00005797          	auipc	a5,0x5
    80008b20:	24478793          	addi	a5,a5,580 # 8000dd60 <end>
    80008b24:	00050493          	mv	s1,a0
    80008b28:	04f56463          	bltu	a0,a5,80008b70 <kfree+0x70>
    80008b2c:	01100793          	li	a5,17
    80008b30:	01b79793          	slli	a5,a5,0x1b
    80008b34:	02f57e63          	bgeu	a0,a5,80008b70 <kfree+0x70>
    80008b38:	00001637          	lui	a2,0x1
    80008b3c:	00100593          	li	a1,1
    80008b40:	00000097          	auipc	ra,0x0
    80008b44:	478080e7          	jalr	1144(ra) # 80008fb8 <__memset>
    80008b48:	00004797          	auipc	a5,0x4
    80008b4c:	ef878793          	addi	a5,a5,-264 # 8000ca40 <kmem>
    80008b50:	0007b703          	ld	a4,0(a5)
    80008b54:	01813083          	ld	ra,24(sp)
    80008b58:	01013403          	ld	s0,16(sp)
    80008b5c:	00e4b023          	sd	a4,0(s1)
    80008b60:	0097b023          	sd	s1,0(a5)
    80008b64:	00813483          	ld	s1,8(sp)
    80008b68:	02010113          	addi	sp,sp,32
    80008b6c:	00008067          	ret
    80008b70:	00002517          	auipc	a0,0x2
    80008b74:	ab050513          	addi	a0,a0,-1360 # 8000a620 <digits+0x18>
    80008b78:	fffff097          	auipc	ra,0xfffff
    80008b7c:	354080e7          	jalr	852(ra) # 80007ecc <panic>

0000000080008b80 <kalloc>:
    80008b80:	fe010113          	addi	sp,sp,-32
    80008b84:	00813823          	sd	s0,16(sp)
    80008b88:	00913423          	sd	s1,8(sp)
    80008b8c:	00113c23          	sd	ra,24(sp)
    80008b90:	02010413          	addi	s0,sp,32
    80008b94:	00004797          	auipc	a5,0x4
    80008b98:	eac78793          	addi	a5,a5,-340 # 8000ca40 <kmem>
    80008b9c:	0007b483          	ld	s1,0(a5)
    80008ba0:	02048063          	beqz	s1,80008bc0 <kalloc+0x40>
    80008ba4:	0004b703          	ld	a4,0(s1)
    80008ba8:	00001637          	lui	a2,0x1
    80008bac:	00500593          	li	a1,5
    80008bb0:	00048513          	mv	a0,s1
    80008bb4:	00e7b023          	sd	a4,0(a5)
    80008bb8:	00000097          	auipc	ra,0x0
    80008bbc:	400080e7          	jalr	1024(ra) # 80008fb8 <__memset>
    80008bc0:	01813083          	ld	ra,24(sp)
    80008bc4:	01013403          	ld	s0,16(sp)
    80008bc8:	00048513          	mv	a0,s1
    80008bcc:	00813483          	ld	s1,8(sp)
    80008bd0:	02010113          	addi	sp,sp,32
    80008bd4:	00008067          	ret

0000000080008bd8 <initlock>:
    80008bd8:	ff010113          	addi	sp,sp,-16
    80008bdc:	00813423          	sd	s0,8(sp)
    80008be0:	01010413          	addi	s0,sp,16
    80008be4:	00813403          	ld	s0,8(sp)
    80008be8:	00b53423          	sd	a1,8(a0)
    80008bec:	00052023          	sw	zero,0(a0)
    80008bf0:	00053823          	sd	zero,16(a0)
    80008bf4:	01010113          	addi	sp,sp,16
    80008bf8:	00008067          	ret

0000000080008bfc <acquire>:
    80008bfc:	fe010113          	addi	sp,sp,-32
    80008c00:	00813823          	sd	s0,16(sp)
    80008c04:	00913423          	sd	s1,8(sp)
    80008c08:	00113c23          	sd	ra,24(sp)
    80008c0c:	01213023          	sd	s2,0(sp)
    80008c10:	02010413          	addi	s0,sp,32
    80008c14:	00050493          	mv	s1,a0
    80008c18:	10002973          	csrr	s2,sstatus
    80008c1c:	100027f3          	csrr	a5,sstatus
    80008c20:	ffd7f793          	andi	a5,a5,-3
    80008c24:	10079073          	csrw	sstatus,a5
    80008c28:	fffff097          	auipc	ra,0xfffff
    80008c2c:	8e8080e7          	jalr	-1816(ra) # 80007510 <mycpu>
    80008c30:	07852783          	lw	a5,120(a0)
    80008c34:	06078e63          	beqz	a5,80008cb0 <acquire+0xb4>
    80008c38:	fffff097          	auipc	ra,0xfffff
    80008c3c:	8d8080e7          	jalr	-1832(ra) # 80007510 <mycpu>
    80008c40:	07852783          	lw	a5,120(a0)
    80008c44:	0004a703          	lw	a4,0(s1)
    80008c48:	0017879b          	addiw	a5,a5,1
    80008c4c:	06f52c23          	sw	a5,120(a0)
    80008c50:	04071063          	bnez	a4,80008c90 <acquire+0x94>
    80008c54:	00100713          	li	a4,1
    80008c58:	00070793          	mv	a5,a4
    80008c5c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80008c60:	0007879b          	sext.w	a5,a5
    80008c64:	fe079ae3          	bnez	a5,80008c58 <acquire+0x5c>
    80008c68:	0ff0000f          	fence
    80008c6c:	fffff097          	auipc	ra,0xfffff
    80008c70:	8a4080e7          	jalr	-1884(ra) # 80007510 <mycpu>
    80008c74:	01813083          	ld	ra,24(sp)
    80008c78:	01013403          	ld	s0,16(sp)
    80008c7c:	00a4b823          	sd	a0,16(s1)
    80008c80:	00013903          	ld	s2,0(sp)
    80008c84:	00813483          	ld	s1,8(sp)
    80008c88:	02010113          	addi	sp,sp,32
    80008c8c:	00008067          	ret
    80008c90:	0104b903          	ld	s2,16(s1)
    80008c94:	fffff097          	auipc	ra,0xfffff
    80008c98:	87c080e7          	jalr	-1924(ra) # 80007510 <mycpu>
    80008c9c:	faa91ce3          	bne	s2,a0,80008c54 <acquire+0x58>
    80008ca0:	00002517          	auipc	a0,0x2
    80008ca4:	98850513          	addi	a0,a0,-1656 # 8000a628 <digits+0x20>
    80008ca8:	fffff097          	auipc	ra,0xfffff
    80008cac:	224080e7          	jalr	548(ra) # 80007ecc <panic>
    80008cb0:	00195913          	srli	s2,s2,0x1
    80008cb4:	fffff097          	auipc	ra,0xfffff
    80008cb8:	85c080e7          	jalr	-1956(ra) # 80007510 <mycpu>
    80008cbc:	00197913          	andi	s2,s2,1
    80008cc0:	07252e23          	sw	s2,124(a0)
    80008cc4:	f75ff06f          	j	80008c38 <acquire+0x3c>

0000000080008cc8 <release>:
    80008cc8:	fe010113          	addi	sp,sp,-32
    80008ccc:	00813823          	sd	s0,16(sp)
    80008cd0:	00113c23          	sd	ra,24(sp)
    80008cd4:	00913423          	sd	s1,8(sp)
    80008cd8:	01213023          	sd	s2,0(sp)
    80008cdc:	02010413          	addi	s0,sp,32
    80008ce0:	00052783          	lw	a5,0(a0)
    80008ce4:	00079a63          	bnez	a5,80008cf8 <release+0x30>
    80008ce8:	00002517          	auipc	a0,0x2
    80008cec:	94850513          	addi	a0,a0,-1720 # 8000a630 <digits+0x28>
    80008cf0:	fffff097          	auipc	ra,0xfffff
    80008cf4:	1dc080e7          	jalr	476(ra) # 80007ecc <panic>
    80008cf8:	01053903          	ld	s2,16(a0)
    80008cfc:	00050493          	mv	s1,a0
    80008d00:	fffff097          	auipc	ra,0xfffff
    80008d04:	810080e7          	jalr	-2032(ra) # 80007510 <mycpu>
    80008d08:	fea910e3          	bne	s2,a0,80008ce8 <release+0x20>
    80008d0c:	0004b823          	sd	zero,16(s1)
    80008d10:	0ff0000f          	fence
    80008d14:	0f50000f          	fence	iorw,ow
    80008d18:	0804a02f          	amoswap.w	zero,zero,(s1)
    80008d1c:	ffffe097          	auipc	ra,0xffffe
    80008d20:	7f4080e7          	jalr	2036(ra) # 80007510 <mycpu>
    80008d24:	100027f3          	csrr	a5,sstatus
    80008d28:	0027f793          	andi	a5,a5,2
    80008d2c:	04079a63          	bnez	a5,80008d80 <release+0xb8>
    80008d30:	07852783          	lw	a5,120(a0)
    80008d34:	02f05e63          	blez	a5,80008d70 <release+0xa8>
    80008d38:	fff7871b          	addiw	a4,a5,-1
    80008d3c:	06e52c23          	sw	a4,120(a0)
    80008d40:	00071c63          	bnez	a4,80008d58 <release+0x90>
    80008d44:	07c52783          	lw	a5,124(a0)
    80008d48:	00078863          	beqz	a5,80008d58 <release+0x90>
    80008d4c:	100027f3          	csrr	a5,sstatus
    80008d50:	0027e793          	ori	a5,a5,2
    80008d54:	10079073          	csrw	sstatus,a5
    80008d58:	01813083          	ld	ra,24(sp)
    80008d5c:	01013403          	ld	s0,16(sp)
    80008d60:	00813483          	ld	s1,8(sp)
    80008d64:	00013903          	ld	s2,0(sp)
    80008d68:	02010113          	addi	sp,sp,32
    80008d6c:	00008067          	ret
    80008d70:	00002517          	auipc	a0,0x2
    80008d74:	8e050513          	addi	a0,a0,-1824 # 8000a650 <digits+0x48>
    80008d78:	fffff097          	auipc	ra,0xfffff
    80008d7c:	154080e7          	jalr	340(ra) # 80007ecc <panic>
    80008d80:	00002517          	auipc	a0,0x2
    80008d84:	8b850513          	addi	a0,a0,-1864 # 8000a638 <digits+0x30>
    80008d88:	fffff097          	auipc	ra,0xfffff
    80008d8c:	144080e7          	jalr	324(ra) # 80007ecc <panic>

0000000080008d90 <holding>:
    80008d90:	00052783          	lw	a5,0(a0)
    80008d94:	00079663          	bnez	a5,80008da0 <holding+0x10>
    80008d98:	00000513          	li	a0,0
    80008d9c:	00008067          	ret
    80008da0:	fe010113          	addi	sp,sp,-32
    80008da4:	00813823          	sd	s0,16(sp)
    80008da8:	00913423          	sd	s1,8(sp)
    80008dac:	00113c23          	sd	ra,24(sp)
    80008db0:	02010413          	addi	s0,sp,32
    80008db4:	01053483          	ld	s1,16(a0)
    80008db8:	ffffe097          	auipc	ra,0xffffe
    80008dbc:	758080e7          	jalr	1880(ra) # 80007510 <mycpu>
    80008dc0:	01813083          	ld	ra,24(sp)
    80008dc4:	01013403          	ld	s0,16(sp)
    80008dc8:	40a48533          	sub	a0,s1,a0
    80008dcc:	00153513          	seqz	a0,a0
    80008dd0:	00813483          	ld	s1,8(sp)
    80008dd4:	02010113          	addi	sp,sp,32
    80008dd8:	00008067          	ret

0000000080008ddc <push_off>:
    80008ddc:	fe010113          	addi	sp,sp,-32
    80008de0:	00813823          	sd	s0,16(sp)
    80008de4:	00113c23          	sd	ra,24(sp)
    80008de8:	00913423          	sd	s1,8(sp)
    80008dec:	02010413          	addi	s0,sp,32
    80008df0:	100024f3          	csrr	s1,sstatus
    80008df4:	100027f3          	csrr	a5,sstatus
    80008df8:	ffd7f793          	andi	a5,a5,-3
    80008dfc:	10079073          	csrw	sstatus,a5
    80008e00:	ffffe097          	auipc	ra,0xffffe
    80008e04:	710080e7          	jalr	1808(ra) # 80007510 <mycpu>
    80008e08:	07852783          	lw	a5,120(a0)
    80008e0c:	02078663          	beqz	a5,80008e38 <push_off+0x5c>
    80008e10:	ffffe097          	auipc	ra,0xffffe
    80008e14:	700080e7          	jalr	1792(ra) # 80007510 <mycpu>
    80008e18:	07852783          	lw	a5,120(a0)
    80008e1c:	01813083          	ld	ra,24(sp)
    80008e20:	01013403          	ld	s0,16(sp)
    80008e24:	0017879b          	addiw	a5,a5,1
    80008e28:	06f52c23          	sw	a5,120(a0)
    80008e2c:	00813483          	ld	s1,8(sp)
    80008e30:	02010113          	addi	sp,sp,32
    80008e34:	00008067          	ret
    80008e38:	0014d493          	srli	s1,s1,0x1
    80008e3c:	ffffe097          	auipc	ra,0xffffe
    80008e40:	6d4080e7          	jalr	1748(ra) # 80007510 <mycpu>
    80008e44:	0014f493          	andi	s1,s1,1
    80008e48:	06952e23          	sw	s1,124(a0)
    80008e4c:	fc5ff06f          	j	80008e10 <push_off+0x34>

0000000080008e50 <pop_off>:
    80008e50:	ff010113          	addi	sp,sp,-16
    80008e54:	00813023          	sd	s0,0(sp)
    80008e58:	00113423          	sd	ra,8(sp)
    80008e5c:	01010413          	addi	s0,sp,16
    80008e60:	ffffe097          	auipc	ra,0xffffe
    80008e64:	6b0080e7          	jalr	1712(ra) # 80007510 <mycpu>
    80008e68:	100027f3          	csrr	a5,sstatus
    80008e6c:	0027f793          	andi	a5,a5,2
    80008e70:	04079663          	bnez	a5,80008ebc <pop_off+0x6c>
    80008e74:	07852783          	lw	a5,120(a0)
    80008e78:	02f05a63          	blez	a5,80008eac <pop_off+0x5c>
    80008e7c:	fff7871b          	addiw	a4,a5,-1
    80008e80:	06e52c23          	sw	a4,120(a0)
    80008e84:	00071c63          	bnez	a4,80008e9c <pop_off+0x4c>
    80008e88:	07c52783          	lw	a5,124(a0)
    80008e8c:	00078863          	beqz	a5,80008e9c <pop_off+0x4c>
    80008e90:	100027f3          	csrr	a5,sstatus
    80008e94:	0027e793          	ori	a5,a5,2
    80008e98:	10079073          	csrw	sstatus,a5
    80008e9c:	00813083          	ld	ra,8(sp)
    80008ea0:	00013403          	ld	s0,0(sp)
    80008ea4:	01010113          	addi	sp,sp,16
    80008ea8:	00008067          	ret
    80008eac:	00001517          	auipc	a0,0x1
    80008eb0:	7a450513          	addi	a0,a0,1956 # 8000a650 <digits+0x48>
    80008eb4:	fffff097          	auipc	ra,0xfffff
    80008eb8:	018080e7          	jalr	24(ra) # 80007ecc <panic>
    80008ebc:	00001517          	auipc	a0,0x1
    80008ec0:	77c50513          	addi	a0,a0,1916 # 8000a638 <digits+0x30>
    80008ec4:	fffff097          	auipc	ra,0xfffff
    80008ec8:	008080e7          	jalr	8(ra) # 80007ecc <panic>

0000000080008ecc <push_on>:
    80008ecc:	fe010113          	addi	sp,sp,-32
    80008ed0:	00813823          	sd	s0,16(sp)
    80008ed4:	00113c23          	sd	ra,24(sp)
    80008ed8:	00913423          	sd	s1,8(sp)
    80008edc:	02010413          	addi	s0,sp,32
    80008ee0:	100024f3          	csrr	s1,sstatus
    80008ee4:	100027f3          	csrr	a5,sstatus
    80008ee8:	0027e793          	ori	a5,a5,2
    80008eec:	10079073          	csrw	sstatus,a5
    80008ef0:	ffffe097          	auipc	ra,0xffffe
    80008ef4:	620080e7          	jalr	1568(ra) # 80007510 <mycpu>
    80008ef8:	07852783          	lw	a5,120(a0)
    80008efc:	02078663          	beqz	a5,80008f28 <push_on+0x5c>
    80008f00:	ffffe097          	auipc	ra,0xffffe
    80008f04:	610080e7          	jalr	1552(ra) # 80007510 <mycpu>
    80008f08:	07852783          	lw	a5,120(a0)
    80008f0c:	01813083          	ld	ra,24(sp)
    80008f10:	01013403          	ld	s0,16(sp)
    80008f14:	0017879b          	addiw	a5,a5,1
    80008f18:	06f52c23          	sw	a5,120(a0)
    80008f1c:	00813483          	ld	s1,8(sp)
    80008f20:	02010113          	addi	sp,sp,32
    80008f24:	00008067          	ret
    80008f28:	0014d493          	srli	s1,s1,0x1
    80008f2c:	ffffe097          	auipc	ra,0xffffe
    80008f30:	5e4080e7          	jalr	1508(ra) # 80007510 <mycpu>
    80008f34:	0014f493          	andi	s1,s1,1
    80008f38:	06952e23          	sw	s1,124(a0)
    80008f3c:	fc5ff06f          	j	80008f00 <push_on+0x34>

0000000080008f40 <pop_on>:
    80008f40:	ff010113          	addi	sp,sp,-16
    80008f44:	00813023          	sd	s0,0(sp)
    80008f48:	00113423          	sd	ra,8(sp)
    80008f4c:	01010413          	addi	s0,sp,16
    80008f50:	ffffe097          	auipc	ra,0xffffe
    80008f54:	5c0080e7          	jalr	1472(ra) # 80007510 <mycpu>
    80008f58:	100027f3          	csrr	a5,sstatus
    80008f5c:	0027f793          	andi	a5,a5,2
    80008f60:	04078463          	beqz	a5,80008fa8 <pop_on+0x68>
    80008f64:	07852783          	lw	a5,120(a0)
    80008f68:	02f05863          	blez	a5,80008f98 <pop_on+0x58>
    80008f6c:	fff7879b          	addiw	a5,a5,-1
    80008f70:	06f52c23          	sw	a5,120(a0)
    80008f74:	07853783          	ld	a5,120(a0)
    80008f78:	00079863          	bnez	a5,80008f88 <pop_on+0x48>
    80008f7c:	100027f3          	csrr	a5,sstatus
    80008f80:	ffd7f793          	andi	a5,a5,-3
    80008f84:	10079073          	csrw	sstatus,a5
    80008f88:	00813083          	ld	ra,8(sp)
    80008f8c:	00013403          	ld	s0,0(sp)
    80008f90:	01010113          	addi	sp,sp,16
    80008f94:	00008067          	ret
    80008f98:	00001517          	auipc	a0,0x1
    80008f9c:	6e050513          	addi	a0,a0,1760 # 8000a678 <digits+0x70>
    80008fa0:	fffff097          	auipc	ra,0xfffff
    80008fa4:	f2c080e7          	jalr	-212(ra) # 80007ecc <panic>
    80008fa8:	00001517          	auipc	a0,0x1
    80008fac:	6b050513          	addi	a0,a0,1712 # 8000a658 <digits+0x50>
    80008fb0:	fffff097          	auipc	ra,0xfffff
    80008fb4:	f1c080e7          	jalr	-228(ra) # 80007ecc <panic>

0000000080008fb8 <__memset>:
    80008fb8:	ff010113          	addi	sp,sp,-16
    80008fbc:	00813423          	sd	s0,8(sp)
    80008fc0:	01010413          	addi	s0,sp,16
    80008fc4:	1a060e63          	beqz	a2,80009180 <__memset+0x1c8>
    80008fc8:	40a007b3          	neg	a5,a0
    80008fcc:	0077f793          	andi	a5,a5,7
    80008fd0:	00778693          	addi	a3,a5,7
    80008fd4:	00b00813          	li	a6,11
    80008fd8:	0ff5f593          	andi	a1,a1,255
    80008fdc:	fff6071b          	addiw	a4,a2,-1
    80008fe0:	1b06e663          	bltu	a3,a6,8000918c <__memset+0x1d4>
    80008fe4:	1cd76463          	bltu	a4,a3,800091ac <__memset+0x1f4>
    80008fe8:	1a078e63          	beqz	a5,800091a4 <__memset+0x1ec>
    80008fec:	00b50023          	sb	a1,0(a0)
    80008ff0:	00100713          	li	a4,1
    80008ff4:	1ae78463          	beq	a5,a4,8000919c <__memset+0x1e4>
    80008ff8:	00b500a3          	sb	a1,1(a0)
    80008ffc:	00200713          	li	a4,2
    80009000:	1ae78a63          	beq	a5,a4,800091b4 <__memset+0x1fc>
    80009004:	00b50123          	sb	a1,2(a0)
    80009008:	00300713          	li	a4,3
    8000900c:	18e78463          	beq	a5,a4,80009194 <__memset+0x1dc>
    80009010:	00b501a3          	sb	a1,3(a0)
    80009014:	00400713          	li	a4,4
    80009018:	1ae78263          	beq	a5,a4,800091bc <__memset+0x204>
    8000901c:	00b50223          	sb	a1,4(a0)
    80009020:	00500713          	li	a4,5
    80009024:	1ae78063          	beq	a5,a4,800091c4 <__memset+0x20c>
    80009028:	00b502a3          	sb	a1,5(a0)
    8000902c:	00700713          	li	a4,7
    80009030:	18e79e63          	bne	a5,a4,800091cc <__memset+0x214>
    80009034:	00b50323          	sb	a1,6(a0)
    80009038:	00700e93          	li	t4,7
    8000903c:	00859713          	slli	a4,a1,0x8
    80009040:	00e5e733          	or	a4,a1,a4
    80009044:	01059e13          	slli	t3,a1,0x10
    80009048:	01c76e33          	or	t3,a4,t3
    8000904c:	01859313          	slli	t1,a1,0x18
    80009050:	006e6333          	or	t1,t3,t1
    80009054:	02059893          	slli	a7,a1,0x20
    80009058:	40f60e3b          	subw	t3,a2,a5
    8000905c:	011368b3          	or	a7,t1,a7
    80009060:	02859813          	slli	a6,a1,0x28
    80009064:	0108e833          	or	a6,a7,a6
    80009068:	03059693          	slli	a3,a1,0x30
    8000906c:	003e589b          	srliw	a7,t3,0x3
    80009070:	00d866b3          	or	a3,a6,a3
    80009074:	03859713          	slli	a4,a1,0x38
    80009078:	00389813          	slli	a6,a7,0x3
    8000907c:	00f507b3          	add	a5,a0,a5
    80009080:	00e6e733          	or	a4,a3,a4
    80009084:	000e089b          	sext.w	a7,t3
    80009088:	00f806b3          	add	a3,a6,a5
    8000908c:	00e7b023          	sd	a4,0(a5)
    80009090:	00878793          	addi	a5,a5,8
    80009094:	fed79ce3          	bne	a5,a3,8000908c <__memset+0xd4>
    80009098:	ff8e7793          	andi	a5,t3,-8
    8000909c:	0007871b          	sext.w	a4,a5
    800090a0:	01d787bb          	addw	a5,a5,t4
    800090a4:	0ce88e63          	beq	a7,a4,80009180 <__memset+0x1c8>
    800090a8:	00f50733          	add	a4,a0,a5
    800090ac:	00b70023          	sb	a1,0(a4)
    800090b0:	0017871b          	addiw	a4,a5,1
    800090b4:	0cc77663          	bgeu	a4,a2,80009180 <__memset+0x1c8>
    800090b8:	00e50733          	add	a4,a0,a4
    800090bc:	00b70023          	sb	a1,0(a4)
    800090c0:	0027871b          	addiw	a4,a5,2
    800090c4:	0ac77e63          	bgeu	a4,a2,80009180 <__memset+0x1c8>
    800090c8:	00e50733          	add	a4,a0,a4
    800090cc:	00b70023          	sb	a1,0(a4)
    800090d0:	0037871b          	addiw	a4,a5,3
    800090d4:	0ac77663          	bgeu	a4,a2,80009180 <__memset+0x1c8>
    800090d8:	00e50733          	add	a4,a0,a4
    800090dc:	00b70023          	sb	a1,0(a4)
    800090e0:	0047871b          	addiw	a4,a5,4
    800090e4:	08c77e63          	bgeu	a4,a2,80009180 <__memset+0x1c8>
    800090e8:	00e50733          	add	a4,a0,a4
    800090ec:	00b70023          	sb	a1,0(a4)
    800090f0:	0057871b          	addiw	a4,a5,5
    800090f4:	08c77663          	bgeu	a4,a2,80009180 <__memset+0x1c8>
    800090f8:	00e50733          	add	a4,a0,a4
    800090fc:	00b70023          	sb	a1,0(a4)
    80009100:	0067871b          	addiw	a4,a5,6
    80009104:	06c77e63          	bgeu	a4,a2,80009180 <__memset+0x1c8>
    80009108:	00e50733          	add	a4,a0,a4
    8000910c:	00b70023          	sb	a1,0(a4)
    80009110:	0077871b          	addiw	a4,a5,7
    80009114:	06c77663          	bgeu	a4,a2,80009180 <__memset+0x1c8>
    80009118:	00e50733          	add	a4,a0,a4
    8000911c:	00b70023          	sb	a1,0(a4)
    80009120:	0087871b          	addiw	a4,a5,8
    80009124:	04c77e63          	bgeu	a4,a2,80009180 <__memset+0x1c8>
    80009128:	00e50733          	add	a4,a0,a4
    8000912c:	00b70023          	sb	a1,0(a4)
    80009130:	0097871b          	addiw	a4,a5,9
    80009134:	04c77663          	bgeu	a4,a2,80009180 <__memset+0x1c8>
    80009138:	00e50733          	add	a4,a0,a4
    8000913c:	00b70023          	sb	a1,0(a4)
    80009140:	00a7871b          	addiw	a4,a5,10
    80009144:	02c77e63          	bgeu	a4,a2,80009180 <__memset+0x1c8>
    80009148:	00e50733          	add	a4,a0,a4
    8000914c:	00b70023          	sb	a1,0(a4)
    80009150:	00b7871b          	addiw	a4,a5,11
    80009154:	02c77663          	bgeu	a4,a2,80009180 <__memset+0x1c8>
    80009158:	00e50733          	add	a4,a0,a4
    8000915c:	00b70023          	sb	a1,0(a4)
    80009160:	00c7871b          	addiw	a4,a5,12
    80009164:	00c77e63          	bgeu	a4,a2,80009180 <__memset+0x1c8>
    80009168:	00e50733          	add	a4,a0,a4
    8000916c:	00b70023          	sb	a1,0(a4)
    80009170:	00d7879b          	addiw	a5,a5,13
    80009174:	00c7f663          	bgeu	a5,a2,80009180 <__memset+0x1c8>
    80009178:	00f507b3          	add	a5,a0,a5
    8000917c:	00b78023          	sb	a1,0(a5)
    80009180:	00813403          	ld	s0,8(sp)
    80009184:	01010113          	addi	sp,sp,16
    80009188:	00008067          	ret
    8000918c:	00b00693          	li	a3,11
    80009190:	e55ff06f          	j	80008fe4 <__memset+0x2c>
    80009194:	00300e93          	li	t4,3
    80009198:	ea5ff06f          	j	8000903c <__memset+0x84>
    8000919c:	00100e93          	li	t4,1
    800091a0:	e9dff06f          	j	8000903c <__memset+0x84>
    800091a4:	00000e93          	li	t4,0
    800091a8:	e95ff06f          	j	8000903c <__memset+0x84>
    800091ac:	00000793          	li	a5,0
    800091b0:	ef9ff06f          	j	800090a8 <__memset+0xf0>
    800091b4:	00200e93          	li	t4,2
    800091b8:	e85ff06f          	j	8000903c <__memset+0x84>
    800091bc:	00400e93          	li	t4,4
    800091c0:	e7dff06f          	j	8000903c <__memset+0x84>
    800091c4:	00500e93          	li	t4,5
    800091c8:	e75ff06f          	j	8000903c <__memset+0x84>
    800091cc:	00600e93          	li	t4,6
    800091d0:	e6dff06f          	j	8000903c <__memset+0x84>

00000000800091d4 <__memmove>:
    800091d4:	ff010113          	addi	sp,sp,-16
    800091d8:	00813423          	sd	s0,8(sp)
    800091dc:	01010413          	addi	s0,sp,16
    800091e0:	0e060863          	beqz	a2,800092d0 <__memmove+0xfc>
    800091e4:	fff6069b          	addiw	a3,a2,-1
    800091e8:	0006881b          	sext.w	a6,a3
    800091ec:	0ea5e863          	bltu	a1,a0,800092dc <__memmove+0x108>
    800091f0:	00758713          	addi	a4,a1,7
    800091f4:	00a5e7b3          	or	a5,a1,a0
    800091f8:	40a70733          	sub	a4,a4,a0
    800091fc:	0077f793          	andi	a5,a5,7
    80009200:	00f73713          	sltiu	a4,a4,15
    80009204:	00174713          	xori	a4,a4,1
    80009208:	0017b793          	seqz	a5,a5
    8000920c:	00e7f7b3          	and	a5,a5,a4
    80009210:	10078863          	beqz	a5,80009320 <__memmove+0x14c>
    80009214:	00900793          	li	a5,9
    80009218:	1107f463          	bgeu	a5,a6,80009320 <__memmove+0x14c>
    8000921c:	0036581b          	srliw	a6,a2,0x3
    80009220:	fff8081b          	addiw	a6,a6,-1
    80009224:	02081813          	slli	a6,a6,0x20
    80009228:	01d85893          	srli	a7,a6,0x1d
    8000922c:	00858813          	addi	a6,a1,8
    80009230:	00058793          	mv	a5,a1
    80009234:	00050713          	mv	a4,a0
    80009238:	01088833          	add	a6,a7,a6
    8000923c:	0007b883          	ld	a7,0(a5)
    80009240:	00878793          	addi	a5,a5,8
    80009244:	00870713          	addi	a4,a4,8
    80009248:	ff173c23          	sd	a7,-8(a4)
    8000924c:	ff0798e3          	bne	a5,a6,8000923c <__memmove+0x68>
    80009250:	ff867713          	andi	a4,a2,-8
    80009254:	02071793          	slli	a5,a4,0x20
    80009258:	0207d793          	srli	a5,a5,0x20
    8000925c:	00f585b3          	add	a1,a1,a5
    80009260:	40e686bb          	subw	a3,a3,a4
    80009264:	00f507b3          	add	a5,a0,a5
    80009268:	06e60463          	beq	a2,a4,800092d0 <__memmove+0xfc>
    8000926c:	0005c703          	lbu	a4,0(a1)
    80009270:	00e78023          	sb	a4,0(a5)
    80009274:	04068e63          	beqz	a3,800092d0 <__memmove+0xfc>
    80009278:	0015c603          	lbu	a2,1(a1)
    8000927c:	00100713          	li	a4,1
    80009280:	00c780a3          	sb	a2,1(a5)
    80009284:	04e68663          	beq	a3,a4,800092d0 <__memmove+0xfc>
    80009288:	0025c603          	lbu	a2,2(a1)
    8000928c:	00200713          	li	a4,2
    80009290:	00c78123          	sb	a2,2(a5)
    80009294:	02e68e63          	beq	a3,a4,800092d0 <__memmove+0xfc>
    80009298:	0035c603          	lbu	a2,3(a1)
    8000929c:	00300713          	li	a4,3
    800092a0:	00c781a3          	sb	a2,3(a5)
    800092a4:	02e68663          	beq	a3,a4,800092d0 <__memmove+0xfc>
    800092a8:	0045c603          	lbu	a2,4(a1)
    800092ac:	00400713          	li	a4,4
    800092b0:	00c78223          	sb	a2,4(a5)
    800092b4:	00e68e63          	beq	a3,a4,800092d0 <__memmove+0xfc>
    800092b8:	0055c603          	lbu	a2,5(a1)
    800092bc:	00500713          	li	a4,5
    800092c0:	00c782a3          	sb	a2,5(a5)
    800092c4:	00e68663          	beq	a3,a4,800092d0 <__memmove+0xfc>
    800092c8:	0065c703          	lbu	a4,6(a1)
    800092cc:	00e78323          	sb	a4,6(a5)
    800092d0:	00813403          	ld	s0,8(sp)
    800092d4:	01010113          	addi	sp,sp,16
    800092d8:	00008067          	ret
    800092dc:	02061713          	slli	a4,a2,0x20
    800092e0:	02075713          	srli	a4,a4,0x20
    800092e4:	00e587b3          	add	a5,a1,a4
    800092e8:	f0f574e3          	bgeu	a0,a5,800091f0 <__memmove+0x1c>
    800092ec:	02069613          	slli	a2,a3,0x20
    800092f0:	02065613          	srli	a2,a2,0x20
    800092f4:	fff64613          	not	a2,a2
    800092f8:	00e50733          	add	a4,a0,a4
    800092fc:	00c78633          	add	a2,a5,a2
    80009300:	fff7c683          	lbu	a3,-1(a5)
    80009304:	fff78793          	addi	a5,a5,-1
    80009308:	fff70713          	addi	a4,a4,-1
    8000930c:	00d70023          	sb	a3,0(a4)
    80009310:	fec798e3          	bne	a5,a2,80009300 <__memmove+0x12c>
    80009314:	00813403          	ld	s0,8(sp)
    80009318:	01010113          	addi	sp,sp,16
    8000931c:	00008067          	ret
    80009320:	02069713          	slli	a4,a3,0x20
    80009324:	02075713          	srli	a4,a4,0x20
    80009328:	00170713          	addi	a4,a4,1
    8000932c:	00e50733          	add	a4,a0,a4
    80009330:	00050793          	mv	a5,a0
    80009334:	0005c683          	lbu	a3,0(a1)
    80009338:	00178793          	addi	a5,a5,1
    8000933c:	00158593          	addi	a1,a1,1
    80009340:	fed78fa3          	sb	a3,-1(a5)
    80009344:	fee798e3          	bne	a5,a4,80009334 <__memmove+0x160>
    80009348:	f89ff06f          	j	800092d0 <__memmove+0xfc>
	...
