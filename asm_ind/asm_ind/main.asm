.686

.model stdcall, flat

.stack

andm macro x, y, z
	 movapd z, x
	 andpd z, y
endm

orm macro x, y, z
	 movapd z, x
	 orpd z, y
endm

xorm macro x, y, res
	 movaps res, x
	 xorps res, y
endm

nandm macro x, y, z
	 movapd z, x
	 andnpd z, y
endm

notm macro x, y
	movapd y, x
	andnpd y, y
endm

ornm macro x, y, z
	movapd z, x
	orpd z, y
	andnpd z, z
endm

.data

.code
_global proc
	call main
_global endp

main proc
	push rbp
	mov rbp, rsp
	
	mov 

	pop rbp
	ret
main endp

fastCarry proc
	push rbp
	mov rbp, rsp
	mov rax, [rbp + 16]
	movlps xmm0, [rbp + 24]
	movhps xmm0, [rbp + 32]
	movlps xmm1, [rbp + 40]
	movhps xmm1, [rbp + 48]
	movlps xmm2, [rbp + 56]
	movhps xmm2, [rbp + 64]
	movlps xmm3, [rbp + 72]
	movhps xmm3, [rbp + 80]
	movlps xmm4, [rbp + 88]
	movhps xmm4, [rbp + 96]
	movlps xmm5, [rbp + 104]
	movhps xmm5, [rbp + 112]
	movlps xmm6, [rbp + 120]
	movhps xmm6, [rbp + 128]
	movlps xmm6, [rbp + 136]
	movhps xmm6, [rbp + 144]
	movlps xmm7, [rbp + 152]
	movhps xmm7, [rbp + 160]
	
	;g
	andm xmm0, xmm4, xmm8
	andm xmm1, xmm5, xmm9
	andm xmm2, xmm6, xmm10
	andm xmm3, xmm7, xmm11
	;p
	orm xmm0, xmm4, xmm12
	orm xmm1, xmm5, xmm13
	orm xmm2, xmm6, xmm14
	orm xmm3, xmm7, xmm15

	movlpd rdx, xmm8
	movlpd r11, xmm12
	lea r10, [rip]
	add r10, 0x1
	jmp @init_loop
	movlpd xmm16, rax 
	mov rax, r12

	movhpd rdx, xmm8
	movhpd r11, xmm12
	lea r10, [rip]
	add r10, 0x1
	jmp @init_loop
	movhpd xmm16, r12 
	mov rax, r12

	@init_loop:
	mov rbx, 0x1
	mov rcx, 63
	@loop:
		mov r12, r11
		and r12, rax
		or r12, rdx
		and r12, rbx
		shl r12, 1
		or rax, r12
		shl rbx, 1
	loop @loop
	mov r12, r11
	and r12, rax
	or r12, rdx
	and r12, 80000000h
	rcl r12, 1		

	test r10, 0xFFFFFFFF
	jne r10

	pop rbp
	ret
fastCarry endp

ALU proc
	push rbp
	mov rbp, rsp
	mov rax, [rpb + 16] 
	movlps xmm0, [rbp + 24]
	movhps xmm0, [rbp + 32]
	movlps xmm1, [rbp + 40]
	movhps xmm1, [rbp + 48]
	movlps xmm2, [rbp + 56]
	movhps xmm2, [rbp + 64]
	movlps xmm3, [rbp + 72]
	movhps xmm3, [rbp + 80]
	movlps xmm4, [rbp + 88]
	movhps xmm4, [rbp + 96]
	movlps xmm5, [rbp + 104]
	movhps xmm5, [rbp + 112]
	movlps xmm6, [rbp + 120]
	movhps xmm6, [rbp + 128]
	movlps xmm6, [rbp + 136]
	movhps xmm6, [rbp + 144]
	movlps xmm7, [rbp + 152]
	movhps xmm7, [rbp + 160]
	test rax, 10h
	je  @continue
	and rax, 1Fh
	@continue:
	
	;c=0 M=1
	cmp rax, 10h	
	je @switch
	cmp rax, 11h
	je @switch + 6
	cmp rax, 12h
	je @switch + 12
	cmp rax, 13h
	je @switch + 18
	cmp rax, 14h
	je @switch + 24
	cmp rax, 15h
	je @switch + 32
	cmp rax, 16h
	je @switch + 40
	cmp rax, 17h
	je @switch + 48
	cmp rax, 18h
	je @switch + 56
	cmp rax, 19h
	je @switch + 64
	cmp rax, 1Ah
	je @switch + 72
	cmp rax, 1Bh
	je @switch + 80
	cmp rax, 1Ch
	je @switch + 88
	cmp rax, 1Dh
	je @switch + 96
	cmp rax, 1Eh
	je @switch + 104
	cmp rax, 1Fh
	je @switch + 112
	cmp rax, 1Fh
	je @switch + 112

	;c=0 M=0
	cmp rax, 0h	
	je @switch
	cmp rax, 1h
	je @switch + 118
	cmp rax, 2h
	je @switch + 124
	cmp rax, 3h
	je @switch + 130
	cmp rax, 4h
	je @switch + 136
	cmp rax, 5h
	je @switch + 142
	cmp rax, 6h
	je @switch + 148
	cmp rax, 7h
	je @switch + 154
	cmp rax, 8h
	je @switch + 160
	cmp rax, 9h
	je @switch + 166
	cmp rax, Ah
	je @switch + 72
	cmp rax, Bh
	je @switch + 80
	cmp rax, Ch
	je @switch + 88
	cmp rax, Dh
	je @switch + 96
	cmp rax, Eh
	je @switch + 104
	cmp rax, Fh
	je @switch + 112

	;c=1 M=0
	cmp rax, 20h	
	je @switch
	cmp rax, 21h
	je @switch + 6
	cmp rax, 22h
	je @switch + 12
	cmp rax, 23h
	je @switch + 18
	cmp rax, 24h
	je @switch + 24
	cmp rax, 25h
	je @switch + 32
	cmp rax, 26h
	je @switch + 40
	cmp rax, 27h
	je @switch + 48
	cmp rax, 28h
	je @switch + 56
	cmp rax, 29h
	je @switch + 64
	cmp rax, 2Ah
	je @switch + 72
	cmp rax, 2Bh
	je @switch + 80
	cmp rax, 2Ch
	je @switch + 88
	cmp rax, 2Dh
	je @switch + 96
	cmp rax, 2Eh
	je @switch + 104
	cmp rax, 2Fh
	je @switch + 112

	@switch:
	notm xmm0, xmm0
	notm xmm1, xmm1
	notm xmm2, xmm2
	notm xmm3, xmm3
	jmp @end_switch
	andnpd xmm0, xmm4
	andnpd xmm1, xmm5
	andnpd xmm2, xmm6
	andnpd xmm3, xmm7
	jmp @end_switch
	call f3
	jmp @end_switch
	call f4
	jmp @end_switch
	call f5
	jmp @end_switch
	call f6
	jmp @end_switch
	call f7
	jmp @end_switch
	call f8
	jmp @end_switch
	call f9
	jmp @end_switch
	call f10
	jmp @end_switch
	call f11
	jmp @end_switch
	call f12
	jmp @end_switch
	call f13
	jmp @end_switch
	call f14
	jmp @end_switch
	jmp @end_switch

	@end_switch:

	pop rbp
	ret
ALU endp

end _global