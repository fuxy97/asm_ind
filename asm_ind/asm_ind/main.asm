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
	movhpd xmm16, rax 
	mov rax, r12

	movlpd rdx, xmm9
	movlpd r11, xmm13
	lea r10, [rip]
	add r10, 0x1
	jmp @init_loop
	movlpd xmm17, rax 
	mov rax, r12

	movhpd rdx, xmm9
	movhpd r11, xmm13
	lea r10, [rip]
	add r10, 0x1
	jmp @init_loop
	movhpd xmm17, rax 
	mov rax, r12

	movlpd rdx, xmm10
	movlpd r11, xmm14
	lea r10, [rip]
	add r10, 0x1
	jmp @init_loop
	movlpd xmm18, rax 
	mov rax, r12

	movhpd rdx, xmm10
	movhpd r11, xmm14
	lea r10, [rip]
	add r10, 0x1
	jmp @init_loop
	movhpd xmm18, rax 
	mov rax, r12

	movlpd rdx, xmm11
	movlpd r11, xmm15
	lea r10, [rip]
	add r10, 0x1
	jmp @init_loop
	movlpd xmm19, rax 
	mov rax, r12

	movhpd rdx, xmm11
	movhpd r11, xmm15
	mov r10, 0x0
	jmp @init_loop
	movhpd xmm19, rax 
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

PgGg proc
	push rbp
	mov rbp, rsp
	movlps xmm0, [rbp + 16]
	movhps xmm0, [rbp + 32]
	movlps xmm1, [rbp + 40]
	movhps xmm1, [rbp + 48]
	movlps xmm2, [rbp + 56]
	movhps xmm2, [rbp + 64]
	movlps xmm3, [rbp + 72]
	movhps xmm3, [rbp + 80]
	movlps xmm4, [rbp + 16]
	movhps xmm4, [rbp + 32]
	movlps xmm5, [rbp + 40]
	movhps xmm5, [rbp + 48]
	movlps xmm6, [rbp + 56]
	movhps xmm6, [rbp + 64]
	movlps xmm7, [rbp + 72]
	movhps xmm7, [rbp + 80]
	
	xorps xmm10, xmm7
	movaps xmm9, xmm3
	movaps xmm8, xmm3
	mov rcx, 128	
	@loop:
	pslldq xmm8, 1			
	pslldq xmm10, 1
	andps xmm9, xmm8
	andps xmm10, xmm9 
	orps xmm7, xmm10
	loop @loop

	movaps xmm10, xmm6
	movaps xmm8, xmm2
	mov rcx, 128
	@loop:
	pslldq xmm8, 1			
	pslldq xmm10, 1
	andps xmm9, xmm8
	andps xmm10, xmm9 
	orps xmm7, xmm10
	loop @loop

	movaps xmm10, xmm5
	movaps xmm8, xmm1
	mov rcx, 128
	@loop:
	pslldq xmm8, 1			
	pslldq xmm10, 1
	andps xmm9, xmm8
	andps xmm10, xmm9 
	orps xmm7, xmm10
	loop @loop

	movaps xmm10, xmm4
	movaps xmm8, xmm0
	mov rcx, 128
	@loop:
	pslldq xmm8, 1			
	pslldq xmm10, 1
	andps xmm9, xmm8
	andps xmm10, xmm9 
	orps xmm7, xmm10
	loop @loop

	movlps rax, xmm9
	movlps rdx, xmm7
	pop rbp
	ret
PgGg endp

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
	;-x
	notm xmm0, xmm0
	notm xmm1, xmm1
	notm xmm2, xmm2
	notm xmm3, xmm3
	jmp @end_switch
	;-(xy)
	andnpd xmm0, xmm4,xmm0
	andnpd xmm1, xmm5,xmm1
	andnpd xmm2, xmm6,xmm2
	andnpd xmm3, xmm7,xmm3
	jmp @end_switch
	;-xUy
	notm xmm0, xmm0
	notm xmm1, xmm1
	notm xmm2, xmm2
	notm xmm3, xmm3
	orm xmm0, xmm4,xmm0
	orm xmm1, xmm5,xmm1
	orm xmm2, xmm6,xmm2
	orm xmm3, xmm7,xmm3
	jmp @end_switch
	;1
	xorpd xmm0, xmm0,xmm0
	xorpd xmm1, xmm1,xmm1
	xorpd xmm2, xmm2,xmm2
	xorpd xmm3, xmm3,xmm3
	;-------------------------
	jmp @end_switch
	;-(xUy)
	orm xmm0, xmm4,xmm0
	orm xmm1, xmm5,xmm1
	orm xmm2, xmm6,xmm2
	orm xmm3, xmm7,xmm3
	notm xmm0, xmm0
	notm xmm1, xmm1
	notm xmm2, xmm2
	notm xmm3, xmm3
	jmp @end_switch
	;-y
	notm xmm4, xmm4
	notm xmm5, xmm5
	notm xmm5, xmm6
	notm xmm6, xmm7
	jmp @end_switch
	;-(x+y)
	xorm xmm0, xmm4,xmm0
	xorm xmm1, xmm5,xmm1
	xorm xmm2, xmm6,xmm2
	xorm xmm3, xmm7,xmm3
	notm xmm0, xmm0
	notm xmm1, xmm1
	notm xmm2, xmm2
	notm xmm3, xmm3
	jmp @end_switch
	;xU-y
	notm xmm4, xmm4
	notm xmm5, xmm5
	notm xmm6, xmm6
	notm xmm7, xmm7
	orm xmm0, xmm4,xmm0
	orm xmm1, xmm5,xmm1
	orm xmm2, xmm6,xmm2
	orm xmm3, xmm7,xmm3
	jmp @end_switch
	;-xy
	notm xmm0, xmm0,xmm0
	notm xmm1, xmm1,xmm1
	notm xmm2, xmm2,xmm2
	notm xmm3, xmm3,xmm3
	andm xmm0, xmm4,xmm0
	andm xmm1, xmm5,xmm1
	andm xmm2, xmm6,xmm2
	andm xmm3, xmm7,xmm3
	jmp @end_switch
	;x+y
	xorm xmm0, xmm4,xmm0
	xorm xmm1, xmm5,xmm1
	xorm xmm2, xmm6,xmm2
	xorm xmm3, xmm7,xmm3
	jmp @end_switch
	;y
	movaps xmm0,xmm4
	movaps xmm1,xmm5
	movaps xmm2,xmm6
	movaps xmm3,xmm7
	jmp @end_switch
	;xUy
	orm xmm0, xmm4, xmm0
	orm xmm1, xmm5, xmm1
	orm xmm2, xmm6, xmm2
	orm xmm3, xmm7, xmm3
	jmp @end_switch

	;0
	xorm xmm0,xmm0
	xorm xmm1,xmm1
	xorm xmm2,xmm2
	xorm xmm3,xmm3
	jmp @end_switch
	;x-y
	notm xmm4, xmm4,xmm4
	notm xmm5, xmm5,xmm5
	notm xmm6, xmm6,xmm6
	notm xmm7, xmm7,xmm7
	andm xmm0, xmm4,xmm0
	andm xmm1, xmm5,xmm1
	andm xmm2, xmm6,xmm2
	andm xmm3, xmm7,xmm3
	jmp @end_switch

	;xy
	andm xmm0, xmm4,xmm0
	andm xmm1, xmm5,xmm1
	andm xmm2, xmm6,xmm2
	andm xmm3, xmm7,xmm3
	jmp @end_switch

	;x
	jmp @end_switch

	;x-1
	xor xmm4, xmm4
	notm xmm4, xmm4 
	xor xmm5, xmm5
	notm xmm5, xmm5
	xor xmm6, xmm6
	notm xmm6, xmm6
	xor xmm7, xmm7
	notm xmm7, xmm7
	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch

	;(xy)-1
	andm xmm0, xmm4, xmm0
	andm xmm1, xmm4, xmm1
	andm xmm2, xmm4, xmm2
	andm xmm3, xmm4, xmm3
	xor xmm4, xmm4
	notm xmm4, xmm4 
	xor xmm5, xmm5
	notm xmm5, xmm5
	xor xmm6, xmm6
	notm xmm6, xmm6
	xor xmm7, xmm7
	notm xmm7, xmm7
	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch

	;(x -y)-1
	notm xmm4, xmm4
	notm xmm5, xmm5
	notm xmm6, xmm6
	notm xmm7, xmm7
	andm xmm0, xmm4, xmm0
	andm xmm1, xmm4, xmm1
	andm xmm2, xmm4, xmm2
	andm xmm3, xmm4, xmm3

	xor xmm4, xmm4
	notm xmm4, xmm4 
	xor xmm5, xmm5
	notm xmm5, xmm5
	xor xmm6, xmm6
	notm xmm6, xmm6
	xor xmm7, xmm7
	notm xmm7, xmm7
	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch

	;-1-------------------------------------
	xorm xmm0,xmm0,xmm0
	xorm xmm1,xmm1,xmm1
	xorm xmm2,xmm2,xmm2
	xorm xmm3,xmm3,xmm3
	notm xmm0, xmm0
	notm xmm1, xmm1
	notm xmm2, xmm2
	notm xmm3, xmm3
	jmp @end_switch

	;x+(xU-y)
	notm xmm4,xmm4
	notm xmm5,xmm5
	notm xmm6,xmm6
	notm xmm7,xmm7
	orm xmm0, xmm4, xmm4
	orm xmm1, xmm5, xmm5
	orm xmm2, xmm6, xmm6
	orm xmm3, xmm7, xmm7
	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch

	;xy+(xU-y)
	andm xmm4, xmm0,xmm8
	andm xmm5, xmm1,xmm9
	andm xmm6, xmm2,xmm10
	andm xmm7, xmm3,xmm11

	notm xmm4,xmm4
	notm xmm5,xmm5
	notm xmm6,xmm6
	notm xmm7,xmm7
	orm xmm0, xmm4,xmm4
	orm xmm1, xmm5, xmm5
	orm xmm2, xmm6, xmm6
	orm xmm3, xmm7, xmm7

	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm8
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm9
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm10
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm11
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch

	;(x-y)-1---------------------------------------
	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3

	xorm xmm4, xmm4,xmm4
	xorm xmm5, xmm5,xmm5
	xorm xmm6, xmm6,xmm6
	xorm xmm7, xmm7,xmm7
	notm xmm4, xmm4
	notm xmm5, xmm5
	notm xmm6, xmm6
	notm xmm7, xmm7
	push rax
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch

	;xU_y
	notm xmm4, xmm4
	notm xmm5, xmm5
	notm xmm6, xmm6
	notm xmm7, xmm7
	orm xmm0, xmm4,xmm0
	orm xmm1, xmm5,xmm1
	orm xmm2, xmm6,xmm2
	orm xmm3, xmm7,xmm3
	jmp @end_switch

	;x+(xUy)
	orm xmm0, xmm4, xmm4
	orm xmm1, xmm5, xmm5
	orm xmm2, xmm6, xmm6
	orm xmm3, xmm7, xmm7
	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch

	;x+y
	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch

	;(x_y)+(xUy)
	notm xmm4, xmm8
	notm xmm5, xmm9
	notm xmm6, xmm10
	notm xmm7, xmm11
	andm xmm8, xmm0, xmm8
	andm xmm9, xmm1, xmm9
	andm xmm10, xmm2, xmm10
	andm xmm11, xmm3, xmm11

	orm xmm0, xmm4, xmm0
	orm xmm1, xmm5, xmm1
	orm xmm2, xmm6, xmm2
	orm xmm3, xmm7, xmm3
	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm8
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm9
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm10
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm11
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch

	;xUy
	orm xmm0, xmm4, xmm0
	orm xmm1, xmm5, xmm1
	orm xmm2, xmm6, xmm2
	orm xmm3, xmm7, xmm3
	jmp @end_switch

	;x+x
	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch

	;xy+x
	andm xmm0, xmm4, xmm4 
	andm xmm1, xmm5, xmm5
	andm xmm2, xmm6, xmm6
	andm xmm3, xmm7, xmm7

	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch

	;x_y+x
	notm xmm4, xmm4
	notm xmm5, xmm5
	notm xmm6, xmm6
	notm xmm7, xmm7
	andm xmm0, xmm4, xmm4 
	andm xmm1, xmm5, xmm5
	andm xmm2, xmm6, xmm6
	andm xmm3, xmm7, xmm7

	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch

	;x
	jmp @end_switch

	;x
	jmp @end_switch

	;xy
	andm xmm0,xmm4,xmm0
	andm xmm1,xmm5,xmm1
	andm xmm2,xmm6,xmm2
	andm xmm3,xmm7,xmm3
	jmp @end_switch

	;x_y
	notm xmm4,xmm4
	notm xmm5,xmm5
	notm xmm6,xmm6
	notm xmm7,xmm7
	andm xmm0,xmm4,xmm0
	andm xmm1,xmm5,xmm1
	andm xmm2,xmm6,xmm2
	andm xmm3,xmm7,xmm3
	jmp @end_switch

	;0
	xorm xmm0,xmm0,xmm0
	xorm xmm1,xmm1,xmm1
	xorm xmm2,xmm2,xmm2
	xorm xmm3,xmm3,xmm3
	jmp @end_switch

	;x+(xU_y)+1
	notm xmm4,xmm4
	notm xmm5,xmm5
	notm xmm6,xmm6
	notm xmm7,xmm7
	orm xmm0, xmm4, xmm4
	orm xmm1, xmm5, xmm5
	orm xmm2, xmm6, xmm6
	orm xmm3, xmm7, xmm7
	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3

	xorm xmm4,xmm4,xmm4
	xorm xmm5, xmm5,xmm5
	xorm xmm6, xmm6,xmm6
	xorm xmm7, xmm7,xmm7
	notm xmm4,xmm4
	notm xmm5,xmm5
	notm xmm6,xmm6
	notm xmm7,xmm7
	push rax
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch


	;xy+(xU_y)+1
	andm xmm0, xmm4, xmm8
	andm xmm1, xmm5, xmm9
	andm xmm2, xmm6, xmm10
	andm xmm3, xmm7, xmm11
	notm xmm4,xmm4
	notm xmm5,xmm5
	notm xmm6,xmm6
	notm xmm7,xmm7
	orm xmm0, xmm4, xmm4
	orm xmm1, xmm5, xmm5
	orm xmm2, xmm6, xmm6
	orm xmm3, xmm7, xmm7
	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm8
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm9
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm10
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm11
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3

	xorm xmm4,xmm4,xmm4
	xorm xmm5, xmm5,xmm5
	xorm xmm6, xmm6,xmm6
	xorm xmm7, xmm7,xmm7
	notm xmm4,xmm4
	notm xmm5,xmm5
	notm xmm6,xmm6
	notm xmm7,xmm7
	push rax
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch

	;x-y---------------------------------------
	notm xmm4,xmm4
	notm xmm5,xmm5
	notm xmm6,xmm6
	notm xmm7,xmm7
	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch

	;xU_y+x
	notm xmm4, xmm4
	notm xmm5, xmm5
	notm xmm6, xmm6
	notm xmm7, xmm7
	orm xmm0, xmm4,xmm4
	orm xmm1, xmm5,xmm5
	orm xmm2, xmm6,xmm6
	orm xmm3, xmm7,xmm7
	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch


	;x+(xUy)+1
	orm xmm0, xmm4, xmm4
	orm xmm1, xmm5, xmm5
	orm xmm2, xmm6, xmm6
	orm xmm3, xmm7, xmm7
	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3

	xorm xmm4, xmm4, xmm4
	xorm xmm5, xmm5, xmm5
	xorm xmm6, xmm6, xmm6
	xorm xmm7, xmm7, xmm7
	push rax
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch

	;x+y+1
	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3

	xorm xmm4,xmm4,xmm4
	xorm xmm5,xmm5,xmm5
	xorm xmm6,xmm6,xmm6
	xorm xmm7,xmm7,xmm7
	push rax
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch

	;(x_y)+(xUy)+1
	notm xmm4, xmm8
	notm xmm5, xmm9
	notm xmm6, xmm10
	notm xmm7, xmm11
	andm xmm8, xmm0, xmm8
	andm xmm9, xmm1, xmm9
	andm xmm10, xmm2, xmm10
	andm xmm11, xmm3, xmm11

	orm xmm0, xmm4, xmm0
	orm xmm1, xmm5, xmm1
	orm xmm2, xmm6, xmm2
	orm xmm3, xmm7, xmm3
	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm8
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm9
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm10
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm11
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3

	xorm xmm4,xmm4,xmm4
	xorm xmm5,xmm5,xmm5
	xorm xmm6,xmm6,xmm6
	xorm xmm7,xmm7,xmm7
	push rax
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch

	;xUy+1
	orm xmm0, xmm4, xmm0
	orm xmm1, xmm5, xmm1
	orm xmm2, xmm6, xmm2
	orm xmm3, xmm7, xmm3
	xorm xmm4,xmm4,xmm4
	xorm xmm5,xmm5,xmm5
	xorm xmm6,xmm6,xmm6
	xorm xmm7,xmm7,xmm7
	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm8
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm9
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm10
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm11
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch

	;x+x+1
	movaps xmm8,xmm0
	movaps xmm9,xmm1
	mavaps xmm10, xmm2
	movaps xmm11, xmm3
	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm8
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm9
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm10
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm11
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3

	xorm xmm4,xmm4,xmm4
	xorm xmm5,xmm5,xmm5
	xorm xmm6,xmm6,xmm6
	xorm xmm7,xmm7,xmm7
	push rax
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch


	;xy+x+1
	orm xmm0,xmm4,xmm4
	orm xmm1,xmm5,xmm5
	orm xmm2,xmm6,xmm6
	orm xmm3,xmm7,xmm7
	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3

	xorm xmm4,xmm4,xmm4
	xorm xmm5,xmm5,xmm5
	xorm xmm6,xmm6,xmm6
	xorm xmm7,xmm7,xmm7
	push rax
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch

	;x_y+x+1
	notm xmm4,xmm4
	notm xmm5,xmm5
	notm xmm6,xmm6
	notm xmm7,xmm7
	andm xmm0,xmm4,xmm4
	andm xmm1,xmm5,xmm5
	andm xmm2,xmm6,xmm6
	andm xmm3,xmm7,xmm7
	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3

	xorm xmm4,xmm4,xmm4
	xorm xmm5,xmm5,xmm5
	xorm xmm6,xmm6,xmm6
	xorm xmm7,xmm7,xmm7
	push rax
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch

	;x+1
	xorm xmm4,xmm4,xmm4
	xorm xmm5,xmm5,xmm5
	xorm xmm6,xmm6,xmm6
	xorm xmm7,xmm7,xmm7
	mov rdx, rax
	shl rdx, 5
	push rdx
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm5
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm6
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm7
	call fastCarry
	add rsp, 136
	orm xmm12, xmm16, xmm0
	orm xmm13, xmm17, xmm1
	orm xmm14, xmm18, xmm2
	orm xmm15, xmm19, xmm3
	jmp @end_switch

	@end_switch:
	pop rbp
	ret
ALU endp

end _global