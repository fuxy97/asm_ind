STD_OUTPUT_HANDLE equ -11
STD_INPUT_HANDLE equ -10

extrn AllocConsole:proc
extrn GetStdHandle:proc
extrn WriteConsoleA:proc
extrn ReadConsoleA:proc
extrn ExitProcess:proc
extrn SetConsoleCP:proc
extrn SetConsoleOutputCP:proc

andm macro x, y, z
	 movaps z, x
	 andpd z, y
endm

orm macro x, y, z
	 movapd z, x
	 orpd z, y
endm

orrm macro x, y, z
	 movapd xmm15, x
	 orpd xmm15, y
	 movaps z,xmm15
endm

xorm macro x, y, res
	 movaps res, x
	 xorps res, y
endm

xorrm macro x, y, res
	movaps xmm4, x
	xorps xmm4, y
	movaps res, xmm4
endm

nandm macro x, y, z
	 movapd z, x
	 andnpd z, y
endm

notm macro x, y
	pcmpeqb xmm15,xmm15
	xorpd xmm15,x
	movaps y,xmm15
endm

ornm macro x, y, z
	movapd z, x
	orpd z, y
	andnpd z, z
endm

ifm macro s0, s1, s2, s3, m, c0
	mov rbx, rsp
	and rsp, -16
	push rbx
	push rbp
	mov rbp, rsp
	sub rsp, 288
	movdqu xmmword ptr [rbp - 16], s0
	movdqu xmmword ptr [rbp - 32], s1
	movdqu xmmword ptr [rbp - 48], s2
	movdqu xmmword ptr [rbp - 64], s3
	movdqu xmmword ptr [rbp - 80], m
	movdqu xmmword ptr [rbp - 96], c0
	movdqu xmmword ptr [rbp - 176], xmm0
	movdqu xmmword ptr [rbp - 192], xmm1
	movdqu xmmword ptr [rbp - 208], xmm2
	movdqu xmmword ptr [rbp - 224], xmm3
	movdqu xmmword ptr [rbp - 240], xmm4
	movdqu xmmword ptr [rbp - 256], xmm5
	movdqu xmmword ptr [rbp - 272], xmm6
	movdqu xmmword ptr [rbp - 288], xmm7

	;_x
	notm xmm0, xmm0
	notm xmm1, xmm1
	notm xmm2, xmm2
	notm xmm3, xmm3
	xor rax,rax

	notm xmmword ptr [rbp - 16], xmm4
	notm xmmword ptr [rbp - 32], xmm5
	notm xmmword ptr [rbp - 48], xmm6
	notm xmmword ptr [rbp - 64], xmm7
	notm xmmword ptr [rbp - 96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	pand xmm4, xmmword ptr [rbp - 80]
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8
	
	;_(xy)
	movdqu xmm0, xmmword ptr [rbp - 176]
	movdqu xmm1, xmmword ptr [rbp - 192]
	movdqu xmm2, xmmword ptr [rbp - 208]
	movdqu xmm3, xmmword ptr [rbp - 224]
	movdqu xmm4, xmmword ptr [rbp - 240]
	movdqu xmm5, xmmword ptr [rbp - 256]
	movdqu xmm6, xmmword ptr [rbp - 272]
	movdqu xmm7, xmmword ptr [rbp - 288]
	andm xmm0, xmm4,xmm0
	andm xmm1, xmm5,xmm1
	andm xmm2, xmm6,xmm2
	andm xmm3, xmm7,xmm3
	notm xmm0,xmm0
	notm xmm1,xmm1
	notm xmm2,xmm2
	notm xmm3,xmm3
	xor rax,rax

	movdqu  xmm4,xmmword ptr [rbp -16]
	notm xmmword ptr [rbp -32], xmm5
	notm xmmword ptr [rbp -48], xmm6
	notm xmmword ptr [rbp -64], xmm7
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	pand xmm4, xmmword ptr [rbp -80]
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8
	
	;_xUy
	notm xmm0, xmm0
	notm xmm1, xmm1
	notm xmm2, xmm2
	notm xmm3, xmm3
	orm xmm0, xmm4,xmm0
	orm xmm1, xmm5,xmm1
	orm xmm2, xmm6,xmm2
	orm xmm3, xmm7,xmm3
	xor rax,rax

	notm xmmword ptr [rbp -16], xmm4
	movdqu  xmm5,xmmword ptr [rbp -32]
	notm xmmword ptr [rbp -48], xmm6
	notm xmmword ptr [rbp -64], xmm7
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	pand xmm4, xmmword ptr [rbp -80]
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8


	;1
	xorm xmm0, xmm0,xmm0
	xorm xmm1, xmm1,xmm1
	xorm xmm2, xmm2,xmm2
	xorm xmm3, xmm3,xmm3
	mov edx, 0001h
	pinsrb xmm3, edx, 0h
	xor rax,rax

	movdqu  xmm4,xmmword ptr [rbp -16]
	movdqu  xmm5,xmmword ptr [rbp -32]
	notm xmmword ptr [rbp -48], xmm6
	notm xmmword ptr [rbp -64], xmm7
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	pand xmm4, xmmword ptr [rbp -80]
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;_(xUy)
	orm xmm0, xmm4,xmm0
	orm xmm1, xmm5,xmm1
	orm xmm2, xmm6,xmm2
	orm xmm3, xmm7,xmm3
	notm xmm0, xmm0
	notm xmm1, xmm1
	notm xmm2, xmm2
	notm xmm3, xmm3
	xor rax,rax
	
	notm xmmword ptr [rbp -16], xmm4
	notm xmmword ptr [rbp -32], xmm5
	movdqu  xmm6,xmmword ptr [rbp -48]
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	pand xmm4, xmmword ptr [rbp -80]
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;_y
	notm xmm4, xmm0
	notm xmm5, xmm1
	notm xmm5, xmm2
	notm xmm6, xmm3
	xor rax,rax

	movdqu  xmm4,xmmword ptr [rbp -16]
	notm xmmword ptr [rbp -32], xmm5
	movdqu  xmm6,xmmword ptr [rbp -48]
	notm xmmword ptr [rbp -64], xmm7
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	pand xmm4, xmmword ptr [rbp -80]
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;_(x|+|y)
	xorm xmm0, xmm4,xmm0
	xorm xmm1, xmm5,xmm1
	xorm xmm2, xmm6,xmm2
	xorm xmm3, xmm7,xmm3
	notm xmm0, xmm0
	notm xmm1, xmm1
	notm xmm2, xmm2
	notm xmm3, xmm3
	xor rax,rax
	
	notm xmmword ptr [rbp -16], xmm4
	movdqu  xmm5,xmmword ptr [rbp -32]
	movdqu  xmm6,xmmword ptr [rbp -48]
	notm xmmword ptr [rbp -64], xmm7
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	pand xmm4, xmmword ptr [rbp -80]
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;xU_y
	notm xmm4, xmm4
	notm xmm5, xmm5
	notm xmm6, xmm6
	notm xmm7, xmm7
	orm xmm0, xmm4,xmm0
	orm xmm1, xmm5,xmm1
	orm xmm2, xmm6,xmm2
	orm xmm3, xmm7,xmm3
	
	movdqu  xmm4,xmmword ptr [rbp -16]
	movdqu  xmm5,xmmword ptr [rbp -32]
	movdqu  xmm6,xmmword ptr [rbp -48]
	notm xmmword ptr [rbp -64], xmm7
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	pand xmm4, xmmword ptr [rbp -80]
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;_xy
	notm xmm0,xmm0
	notm xmm1,xmm1
	notm xmm2,xmm2
	notm xmm3,xmm3
	andm xmm0,xmm4,xmm0
	andm xmm1,xmm5,xmm1
	andm xmm2,xmm6,xmm2
	andm xmm3,xmm7,xmm3
	xor rax,rax
	
	notm xmmword ptr [rbp -16], xmm4
	notm xmmword ptr [rbp -32], xmm5
	notm xmmword ptr [rbp -48], xmm6
	movdqu xmm7,xmmword ptr [rbp-64] 
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	pand xmm4, xmmword ptr [rbp -80]
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;x|+|y
	xorm xmm0, xmm4,xmm0
	xorm xmm1, xmm5,xmm1
	xorm xmm2, xmm6,xmm2
	xorm xmm3, xmm7,xmm3
	xor rax,rax

	movdqu xmm4,xmmword ptr [rbp -16] 
	notm xmmword ptr [rbp -32], xmm5
	notm xmmword ptr [rbp -48], xmm6
	movdqu xmm7,xmmword ptr [rbp -64] 
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	pand xmm4, xmmword ptr [rbp -80]
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;y
	movaps xmm0,xmm4
	movaps xmm1,xmm5
	movaps xmm2,xmm6
	movaps xmm3,xmm7
	xor rax,rax

	notm xmmword ptr [rbp -16], xmm4
	movdqu xmm5,xmmword ptr [rbp-32] 
	notm xmmword ptr [rbp -48], xmm6
	movdqu xmm7,xmmword ptr [rbp -64] 
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	pand xmm4, xmmword ptr [rbp -80]
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;xUy
	orm xmm0, xmm4, xmm0
	orm xmm1, xmm5, xmm1
	orm xmm2, xmm6, xmm2
	orm xmm3, xmm7, xmm3
	xor rax,rax

	movdqu xmm4,xmmword ptr [rbp -16] 
	movdqu xmm5,xmmword ptr [rbp -32] 
	notm xmmword ptr [rbp -48], xmm6
	movdqu xmm7,xmmword ptr [rbp -64] 
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	pand xmm4, xmmword ptr [rbp -80]
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;0
	xorm xmm0,xmm0,xmm0
	xorm xmm1,xmm1,xmm1
	xorm xmm2,xmm2,xmm2
	xorm xmm3,xmm3,xmm3
	xor rax,rax
	
	notm xmmword ptr [rbp -16], xmm4
	notm xmmword ptr [rbp -32], xmm5
	movdqu xmm6,xmmword ptr [rbp -48] 
	movdqu xmm7,xmmword ptr [rbp -64] 
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	pand xmm4, xmmword ptr [rbp -80]
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;x_y
	notm xmm4, xmm4,xmm4
	notm xmm5, xmm5,xmm5
	notm xmm6, xmm6,xmm6
	notm xmm7, xmm7,xmm7
	andm xmm0, xmm4,xmm0
	andm xmm1, xmm5,xmm1
	andm xmm2, xmm6,xmm2
	andm xmm3, xmm7,xmm3
	xor rax,rax

	movdqu xmm4,xmmword ptr [rbp-16] 
	notm xmmword ptr [rbp -32], xmm5
	movdqu xmm6,xmmword ptr [rbp -48] 
	movdqu xmm7,xmmword ptr [rbp -64] 
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	pand xmm4, xmmword ptr [rbp -80]
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;xy
	andm xmm0, xmm4,xmm0
	andm xmm1, xmm5,xmm1
	andm xmm2, xmm6,xmm2
	andm xmm3, xmm7,xmm3
	xor rax,rax

	notm xmmword ptr [rbp -16], xmm4
	movdqu xmm5,xmmword ptr [rbp -32] 
	movdqu xmm6,xmmword ptr [rbp -48] 
	movdqu xmm7,xmmword ptr [rbp -64] 
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	pand xmm4, xmmword ptr [rbp -80]
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;x
	xor rax,rax
	movdqu xmm4,xmmword ptr [rbp -16] 
	movdqu xmm5,xmmword ptr [rbp -32] 
	movdqu xmm6,xmmword ptr [rbp -48] 
	movdqu xmm7,xmmword ptr [rbp -64] 
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	pand xmm4, xmmword ptr [rbp -80]
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;x-1
	pextrq rdx, xmm3, 1h
	mov rcx, 8000000000000000h
	test rdx, rcx
	je @skip2
	notm xmm0, xmm0
	notm xmm1, xmm1
	notm xmm2, xmm2
	notm xmm3, xmm3

	sub rsp, 128
	cld
	xor rax, rax
	lea rdi, [rsp + 64]
	mov rcx, 8
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	rep stosq
	push 1
	call fastCarry
	add rsp, 136
	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	push rbp
	mov rbp, qword ptr [rbp]
	movdqu xmm4, xmmword ptr [rbp - 16]
	pop rbp
	por xmm3, xmm4
	@skip2:
	pcmpeqb xmm4,xmm4
	pcmpeqb xmm5,xmm5
	pcmpeqb xmm6,xmm6
	pcmpeqb xmm7,xmm7
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm4
	movdqu xmmword ptr [rsp + 80], xmm5
	movdqu xmmword ptr [rsp + 96], xmm6
	movdqu xmmword ptr [rsp + 112], xmm7
	push 0
	call fastCarry
	add rsp, 136

	;calling PgGg
	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80
	;end calling PgGg

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	pextrq rdx, xmm3, 1h
	rcl rdx, 1
	jnc @skip
	notm xmm0, xmm0
	notm xmm1, xmm1
	notm xmm2, xmm2
	notm xmm3, xmm3

	sub rsp, 128
	cld
	xor rax, rax
	lea rdi, [rsp + 64]
	mov rcx, 8
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	rep stosq
	push 1
	call fastCarry
	add rsp, 136
	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	push rbp
	mov rbp, qword ptr [rbp]
	movdqu xmm4, xmmword ptr [rbp - 16]
	pop rbp
	por xmm3, xmm4
	@skip:
	
	notm xmmword ptr [rbp -16], xmm4
	notm xmmword ptr [rbp -32], xmm5
	notm xmmword ptr [rbp -48], xmm6
	notm xmmword ptr [rbp -64], xmm7
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,  xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;(xy)-1
	andm xmm0,xmm4,xmm0
	andm xmm1,xmm5,xmm1
	andm xmm2,xmm6,xmm2
	andm xmm3,xmm7,xmm3
	pextrq rdx, xmm3, 1h
	mov rcx, 8000000000000000h
	test rdx, rcx
	je @skip21
	notm xmm0, xmm0
	notm xmm1, xmm1
	notm xmm2, xmm2
	notm xmm3, xmm3

	sub rsp, 128
	cld
	xor rax, rax
	lea rdi, [rsp + 64]
	mov rcx, 8
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	rep stosq
	push 1
	call fastCarry
	add rsp, 136
	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	movdqu xmm4, xmmword ptr [rbp - 16]
	por xmm3, xmm4
	@skip21:
	pcmpeqb xmm4,xmm4
	pcmpeqb xmm5,xmm5
	pcmpeqb xmm6,xmm6
	pcmpeqb xmm7,xmm7
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm4
	movdqu xmmword ptr [rsp + 80], xmm5
	movdqu xmmword ptr [rsp + 96], xmm6
	movdqu xmmword ptr [rsp + 112], xmm7
	push 0
	call fastCarry
	add rsp, 136

	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	pextrq rdx, xmm3, 1h
	rcl rdx, 1
	jnc @skip20
	notm xmm0, xmm0
	notm xmm1, xmm1
	notm xmm2, xmm2
	notm xmm3, xmm3

	sub rsp, 128
	cld
	xor rax, rax
	lea rdi, [rsp + 64]
	mov rcx, 8
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	rep stosq
	push 1
	call fastCarry
	add rsp, 136
	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	movdqu xmm4, xmmword ptr [rbp - 16]
	por xmm3, xmm4
	@skip20:
	
	movdqu xmm4, xmmword ptr [rbp -16]
	notm xmmword ptr [rbp -32], xmm5
	notm xmmword ptr [rbp -48], xmm6
	notm xmmword ptr [rbp -64], xmm7
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,  xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;(x_y)-1
	notm xmm4,xmm4
	notm xmm5,xmm5
	notm xmm6,xmm6
	notm xmm7,xmm7
	andm xmm0,xmm4,xmm0
	andm xmm1,xmm5,xmm1
	andm xmm2,xmm6,xmm2
	andm xmm3,xmm7,xmm3
	pextrq rdx, xmm3, 1h
	mov rcx, 8000000000000000h
	test rdx, rcx
	je @skip31
	notm xmm0, xmm0
	notm xmm1, xmm1
	notm xmm2, xmm2
	notm xmm3, xmm3

	sub rsp, 128
	cld
	xor rax, rax
	lea rdi, [rsp + 64]
	mov rcx, 8
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	rep stosq
	push 1
	call fastCarry
	add rsp, 136
	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	movdqu xmm4, xmmword ptr [rbp - 16]
	por xmm3, xmm4
	@skip31:
	pcmpeqb xmm4,xmm4
	pcmpeqb xmm5,xmm5
	pcmpeqb xmm6,xmm6
	pcmpeqb xmm7,xmm7
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm4
	movdqu xmmword ptr [rsp + 80], xmm5
	movdqu xmmword ptr [rsp + 96], xmm6
	movdqu xmmword ptr [rsp + 112], xmm7
	push 0
	call fastCarry
	add rsp, 136

	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	pextrq rdx, xmm3, 1h
	rcl rdx, 1
	jnc @skip30
	notm xmm0, xmm0
	notm xmm1, xmm1
	notm xmm2, xmm2
	notm xmm3, xmm3

	sub rsp, 128
	cld
	xor rax, rax
	lea rdi, [rsp + 64]
	mov rcx, 8
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	rep stosq
	push 1
	call fastCarry
	add rsp, 136
	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	movdqu xmm4, xmmword ptr [rbp - 16]
	por xmm3, xmm4
	@skip30:
	
	notm xmmword ptr [rbp -16], xmm4
	movdqu xmm5, xmmword ptr [rbp -32]
	notm xmmword ptr [rbp -48], xmm6
	notm xmmword ptr [rbp -64], xmm7
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,  xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;-1
	xorrm xmm0,xmm0,xmm0
	xorrm xmm1,xmm1,xmm1
	xorrm xmm2,xmm2,xmm2
	xorrm xmm3,xmm3,xmm3
	mov rax, 1h
	pinsrq xmm0, rax, 0h
	mov rax, 8000000000000000h
	pinsrq xmm3, rax, 1h
	xor rax,rax

	movdqu xmm4, xmmword ptr [rbp -16]
	movdqu xmm5, xmmword ptr [rbp -32]
	notm xmmword ptr [rbp -48], xmm6
	notm xmmword ptr [rbp -64], xmm7
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,  xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;x+(xU_y)
	notm xmm4,xmm4
	notm xmm5,xmm5
	notm xmm6,xmm6
	notm xmm7,xmm7
	orrm xmm0, xmm4, xmm4
	orrm xmm1, xmm5, xmm5
	orrm xmm2, xmm6, xmm6
	orrm xmm3, xmm7, xmm7
	pextrq rdx, xmm3, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	pextrq rdx, xmm7, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm7, rdx, 1h
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm4
	movdqu xmmword ptr [rsp + 80], xmm5
	movdqu xmmword ptr [rsp + 96], xmm6
	movdqu xmmword ptr [rsp + 112], xmm7
	push 0
	call fastCarry
	add rsp, 136

	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	pextrb rax, xmm3, 0Fh
	mov rdx, rax
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	shr rax, 7
	
	notm xmmword ptr [rbp -16], xmm4
	notm xmmword ptr [rbp -32], xmm5
	movdqu xmm6, xmmword ptr [rbp -48]
	notm xmmword ptr [rbp -64], xmm7
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,  xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;xy+(xU_y)
	movaps xmm8, xmm4 
	movaps xmm9, xmm5
	movaps xmm10, xmm5  
	movaps xmm11, xmm6 
	notm xmm4,xmm4
	notm xmm5,xmm5
	notm xmm6,xmm6
	notm xmm7,xmm7
	orrm xmm0, xmm4, xmm4
	orrm xmm1, xmm5, xmm5
	orrm xmm2, xmm6, xmm6
	orrm xmm3, xmm7, xmm7
	andm xmm0, xmm8,xmm0
	andm xmm1, xmm9,xmm1
	andm xmm2, xmm10,xmm2
	andm xmm3, xmm11,xmm3
	pextrq rdx, xmm3, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	pextrq rdx, xmm7, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm7, rdx, 1h
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm4
	movdqu xmmword ptr [rsp + 80], xmm5
	movdqu xmmword ptr [rsp + 96], xmm6
	movdqu xmmword ptr [rsp + 112], xmm7
	push 0
	call fastCarry
	add rsp, 136

	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	pextrb rax, xmm3, 0Fh
	mov rdx, rax
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	shr rax, 7
	
	movdqu xmm4, xmmword ptr [rbp -16]
	notm xmmword ptr [rbp -32], xmm5
	movdqu xmm6, xmmword ptr [rbp -48]
	notm xmmword ptr [rbp -64], xmm7
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,  xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;(x-y)-1
	pextrq rdx, xmm3, 1h
	mov rcx, 8000000000000000h
	test rdx, rcx
	je @skip3
	notm xmm0, xmm0
	notm xmm1, xmm1
	notm xmm2, xmm2
	notm xmm3, xmm3

	sub rsp, 64
	movdqu xmmword ptr [rsp], xmm4
	movdqu xmmword ptr [rsp+16], xmm5
	movdqu xmmword ptr [rsp+32], xmm6
	movdqu xmmword ptr [rsp+48], xmm7
	sub rsp, 128
	cld
	xor rax, rax
	lea rdi, [rsp + 64]
	mov rcx, 8
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	rep stosq
	push 1
	call fastCarry
	add rsp, 136
	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	movdqu xmm4, xmmword ptr [rbp - 16]
	por xmm3, xmm4
	movdqu xmm4,xmmword ptr [rsp]
	movdqu xmm5,xmmword ptr [rsp+16]
	movdqu xmm6,xmmword ptr [rsp+32]
	movdqu xmm7,xmmword ptr [rsp+48]
	add rsp,64
	@skip3:
	pextrb rdx, xmm7, 0Fh
	and dl, 7Fh
	pinsrb xmm7, rdx, 0Fh
	notm xmm4,xmm4
	notm xmm5,xmm5
	notm xmm6,xmm6
	notm xmm7,xmm7
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	sub rsp, 128
	cld
	xor rax, rax
	lea rdi, [rsp + 64]
	mov rcx, 8
	movdqu xmmword ptr [rsp], xmm4
	movdqu xmmword ptr [rsp + 16], xmm5
	movdqu xmmword ptr [rsp + 32], xmm6
	movdqu xmmword ptr [rsp + 48], xmm7
	rep stosq
	push 1
	call fastCarry
	add rsp, 136
	xorrm xmm12, xmm0, xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	xorrm xmm13, xmm1, xmm5
	xorrm xmm14, xmm2, xmm6
	xorrm xmm15, xmm3, xmm7
	movdqu xmm4, xmmword ptr [rsp]
	add rsp, 16 
	movdqu xmm8, xmmword ptr [rbp - 16]
	por xmm7, xmm8
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	add rsp, 128
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm4
	movdqu xmmword ptr [rsp + 80], xmm5
	movdqu xmmword ptr [rsp + 96], xmm6
	movdqu xmmword ptr [rsp + 112], xmm7
	push 0
	call fastCarry
	add rsp, 136
	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3	
	pcmpeqb xmm4,xmm4
	pcmpeqb xmm5,xmm5
	pcmpeqb xmm6,xmm6
	pcmpeqb xmm7,xmm7
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm4
	movdqu xmmword ptr [rsp + 80], xmm5
	movdqu xmmword ptr [rsp + 96], xmm6
	movdqu xmmword ptr [rsp + 112], xmm7
	push 0
	call fastCarry
	add rsp, 136
	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	pextrq rdx, xmm3, 1h
	rcl rdx, 1
	jnc @skip4
	notm xmm0, xmm0
	notm xmm1, xmm1
	notm xmm2, xmm2
	notm xmm3, xmm3
	sub rsp, 128
	cld
	xor rax, rax
	lea rdi, [rsp + 64]
	mov rcx, 8
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	rep stosq
	push 1
	call fastCarry
	add rsp, 136

	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	movdqu xmm4, xmmword ptr [rbp - 16]
	por xmm3, xmm4
	@skip4:
	
	notm xmmword ptr [rbp -16], xmm4
	movdqu xmm5, xmmword ptr [rbp -32]
	movdqu xmm6, xmmword ptr [rbp -48]
	notm xmmword ptr [rbp -64], xmm7
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,  xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;xU_y
	notm xmm4, xmm4
	notm xmm5, xmm5
	notm xmm6, xmm6
	notm xmm7, xmm7
	orm xmm0, xmm4,xmm0
	orm xmm1, xmm5,xmm1
	orm xmm2, xmm6,xmm2
	orm xmm3, xmm7,xmm3
	
	movdqu  xmm4,xmmword ptr [rbp -16]
	movdqu  xmm5,xmmword ptr [rbp -32]
	movdqu  xmm6,xmmword ptr [rbp -48]
	notm xmmword ptr [rbp -64], xmm7
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9, xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;x+(xUy)
	orrm xmm0, xmm4, xmm4
	orrm xmm1, xmm5, xmm5
	orrm xmm2, xmm6, xmm6
	orrm xmm3, xmm7, xmm7
	pextrq rdx, xmm3, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	pextrq rdx, xmm7, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm7, rdx, 1h
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm4
	movdqu xmmword ptr [rsp + 80], xmm5
	movdqu xmmword ptr [rsp + 96], xmm6
	movdqu xmmword ptr [rsp + 112], xmm7
	push 0
	call fastCarry
	add rsp, 136

	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	pextrb rax, xmm3, 0Fh
	mov rdx, rax
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	shr rax, 7
	
	notm xmmword ptr [rbp -16], xmm4
	notm xmmword ptr [rbp -32], xmm5
	notm xmmword ptr [rbp -48], xmm6
	movdqu  xmm7,xmmword ptr [rbp -64]
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9, xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;x+y
	pextrq rdx, xmm3, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	pextrq rdx, xmm7, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm7, rdx, 1h
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm4
	movdqu xmmword ptr [rsp + 80], xmm5
	movdqu xmmword ptr [rsp + 96], xmm6
	movdqu xmmword ptr [rsp + 112], xmm7
	push 0
	call fastCarry
	add rsp, 136

	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	pextrb rax, xmm3, 0Fh
	mov rdx, rax
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	shr rax, 7
	
	movdqu  xmm4,xmmword ptr [rbp -16]
	notm xmmword ptr [rbp -32], xmm5
	notm xmmword ptr [rbp -48], xmm6
	movdqu  xmm7,xmmword ptr [rbp -64]
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9, xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;(x_y)+(xUy)
	movaps xmm8, xmm4
	movaps xmm9, xmm5
	movaps xmm10, xmm6
	movaps xmm11, xmm7
	orrm xmm0, xmm4, xmm4
	orrm xmm1, xmm5, xmm5
	orrm xmm2, xmm6, xmm6
	orrm xmm3, xmm7, xmm7
	notm xmm8,xmm8
	notm xmm9,xmm9
	notm xmm10,xmm10
	notm xmm11,xmm11
	andm xmm0, xmm8, xmm0
	andm xmm1, xmm9, xmm1
	andm xmm2, xmm10, xmm2
	andm xmm3, xmm11, xmm3
	pextrq rdx, xmm3, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	pextrq rdx, xmm7, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm7, rdx, 1h
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm4
	movdqu xmmword ptr [rsp + 80], xmm5
	movdqu xmmword ptr [rsp + 96], xmm6
	movdqu xmmword ptr [rsp + 112], xmm7
	push 0
	call fastCarry
	add rsp, 136

	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	pextrb rax, xmm3, 0Fh
	mov rdx, rax
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	shr rax, 7
	
	notm xmmword ptr [rbp -16], xmm4
	movdqu  xmm5,xmmword ptr [rbp -32]
	notm xmmword ptr [rbp + 48], xmm6
	movdqu  xmm7,xmmword ptr [rbp -64]
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9, xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;xUy
	orm xmm0, xmm4, xmm0
	orm xmm1, xmm5, xmm1
	orm xmm2, xmm6, xmm2
	orm xmm3, xmm7, xmm3
	xor rax,rax

	movdqu xmm4,xmmword ptr [rbp -16] 
	movdqu xmm5,xmmword ptr [rbp -32] 
	notm xmmword ptr [rbp -48], xmm6
	movdqu xmm7,xmmword ptr [rbp -64] 
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;x+x
	pextrq rdx, xmm3, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	pextrq rdx, xmm7, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm7, rdx, 1h
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm0
	movdqu xmmword ptr [rsp + 80], xmm1
	movdqu xmmword ptr [rsp + 96], xmm2
	movdqu xmmword ptr [rsp + 112], xmm3
	push 0
	call fastCarry
	add rsp, 136

	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	pextrb rax, xmm3, 0Fh
	mov rdx, rax
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	shr rax, 7
	
	notm xmmword ptr [rbp -16], xmm4
	notm xmmword ptr [rbp -32], xmm5
	movdqu xmm6,xmmword ptr [rbp -48] 
	movdqu xmm7,xmmword ptr [rbp -64] 
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;xy+x
	andm xmm0 ,xmm4, xmm4
	andm xmm1 ,xmm5, xmm5
	andm xmm2 ,xmm6, xmm6
	andm xmm3 ,xmm7, xmm7
	pextrq rdx, xmm3, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	pextrq rdx, xmm7, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm7, rdx, 1h
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm4
	movdqu xmmword ptr [rsp + 80], xmm5
	movdqu xmmword ptr [rsp + 96], xmm6
	movdqu xmmword ptr [rsp + 112], xmm7
	push 0
	call fastCarry
	add rsp, 136

	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	pextrb rax, xmm3, 0Fh
	mov rdx, rax
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	shr rax, 7
	
	movdqu xmm4,xmmword ptr [rbp -16] 
	notm xmmword ptr [rbp -32], xmm5
	movdqu xmm6,xmmword ptr [rbp -48] 
	movdqu xmm7,xmmword ptr [rbp -64] 
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;x_y+x
	notm xmm4,xmm4
	notm xmm5,xmm5
	notm xmm6,xmm6
	notm xmm7,xmm7
	andm xmm0 ,xmm4, xmm4
	andm xmm1 ,xmm5, xmm5
	andm xmm2 ,xmm6, xmm6
	andm xmm3 ,xmm7, xmm7
	pextrq rdx, xmm3, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	pextrq rdx, xmm7, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm7, rdx, 1h
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm4
	movdqu xmmword ptr [rsp + 80], xmm5
	movdqu xmmword ptr [rsp + 96], xmm6
	movdqu xmmword ptr [rsp + 112], xmm7
	push 0
	call fastCarry
	add rsp, 136

	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	pextrb rax, xmm3, 0Fh
	mov rdx, rax
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	shr rax, 7
	
	notm xmmword ptr [rbp -16], xmm4
	movdqu xmm5,xmmword ptr [rbp -32] 
	movdqu xmm6,xmmword ptr [rbp -48] 
	movdqu xmm7,xmmword ptr [rbp -64] 
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8
	
	;x
	xor rax,rax
	movdqu xmm4,xmmword ptr [rbp -16]
	movdqu xmm5,xmmword ptr [rbp -32] 
	movdqu xmm6,xmmword ptr [rbp -48] 
	movdqu xmm7,xmmword ptr [rbp -64] 
	notm xmmword ptr [rbp -96], xmm8
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmm8
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;x
	xor rax,rax
	notm xmmword ptr [rbp -16], xmm4
	notm xmmword ptr [rbp -32], xmm5
	notm xmmword ptr [rbp -48], xmm6
	notm xmmword ptr [rbp -64], xmm7
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmmword ptr [rbp -96]
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;xy
	andm xmm0, xmm4,xmm0
	andm xmm1, xmm5,xmm1
	andm xmm2, xmm6,xmm2
	andm xmm3, xmm7,xmm3
	xor rax,rax

	movdqu xmm4, xmmword ptr [rbp -16]
	notm xmmword ptr [rbp -32], xmm5
	notm xmmword ptr [rbp -48], xmm6
	notm xmmword ptr [rbp -64], xmm7
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmmword ptr [rbp -96]
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;x_y
	notm xmm4, xmm4,xmm4
	notm xmm5, xmm5,xmm5
	notm xmm6, xmm6,xmm6
	notm xmm7, xmm7,xmm7
	andm xmm0, xmm4,xmm0
	andm xmm1, xmm5,xmm1
	andm xmm2, xmm6,xmm2
	andm xmm3, xmm7,xmm3
	xor rax,rax

	notm xmmword ptr [rbp -16], xmm4
	movdqu xmm5, xmmword ptr [rbp -32]
	notm xmmword ptr [rbp -48], xmm6
	notm xmmword ptr [rbp -64], xmm7
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmmword ptr [rbp -96]
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8
	
	;0
	xorm xmm0,xmm0,xmm0
	xorm xmm1,xmm1,xmm1
	xorm xmm2,xmm2,xmm2
	xorm xmm3,xmm3,xmm3
	xor rax,rax
	
	movdqu xmm4, xmmword ptr [rbp -16]
	movdqu xmm5, xmmword ptr [rbp -32]
	notm xmmword ptr [rbp -48], xmm6
	notm xmmword ptr [rbp-64], xmm7
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmmword ptr [rbp -96]
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;x+(xU_y)+1
	notm xmm4,xmm4
	notm xmm5,xmm5
	notm xmm6,xmm6
	notm xmm7,xmm7
	orrm xmm0, xmm4, xmm4
	orrm xmm1, xmm5, xmm5
	orrm xmm2, xmm6, xmm6
	orrm xmm3, xmm7, xmm7
	pextrq rdx, xmm3, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	pextrq rdx, xmm7, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm7, rdx, 1h
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm4
	movdqu xmmword ptr [rsp + 80], xmm5
	movdqu xmmword ptr [rsp + 96], xmm6
	movdqu xmmword ptr [rsp + 112], xmm7
	shr rax,5
	push rax
	call fastCarry
	add rsp, 136

	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3

	pextrb rax, xmm3, 0Fh
	mov rdx, rax
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	shr rax, 7
	
	notm xmmword ptr [rbp -16], xmm4
	notm xmmword ptr [rbp -32], xmm5
	movdqu xmm6, xmmword ptr [rbp -48]
	notm xmmword ptr [rbp -64], xmm7
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmmword ptr [rbp -96]
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;xy+(xU_y)+1
	movaps xmm8, xmm4 
	movaps xmm9, xmm5
	movaps xmm10, xmm5  
	movaps xmm11, xmm6 
	notm xmm4,xmm4
	notm xmm5,xmm5
	notm xmm6,xmm6
	notm xmm7,xmm7
	orrm xmm0, xmm4, xmm4
	orrm xmm1, xmm5, xmm5
	orrm xmm2, xmm6, xmm6
	orrm xmm3, xmm7, xmm7
	andm xmm0, xmm8,xmm0
	andm xmm1, xmm9,xmm1
	andm xmm2, xmm10,xmm2
	andm xmm3, xmm11,xmm3
	pextrq rdx, xmm3, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	pextrq rdx, xmm7, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm7, rdx, 1h
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm4
	movdqu xmmword ptr [rsp + 80], xmm5
	movdqu xmmword ptr [rsp + 96], xmm6
	movdqu xmmword ptr [rsp + 112], xmm7
	shr rax,5
	push rax
	call fastCarry
	add rsp, 136

	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	pextrb rax, xmm3, 0Fh
	mov rdx, rax
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	shr rax, 7
	
	movdqu xmm4, xmmword ptr [rbp -16]
	notm xmmword ptr [rbp -32], xmm5
	movdqu xmm6, xmmword ptr [rbp -48]
	notm xmmword ptr [rbp -64], xmm7
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmmword ptr [rbp -96]
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;x-y
	pextrq rdx, xmm3, 1h
	mov rcx, 8000000000000000h
	test rdx, rcx
	je @skip344
	notm xmm0, xmm0
	notm xmm1, xmm1
	notm xmm2, xmm2
	notm xmm3, xmm3

	sub rsp, 64
	movdqu xmmword ptr [rsp], xmm4
	movdqu xmmword ptr [rsp+16], xmm5
	movdqu xmmword ptr [rsp+32], xmm6
	movdqu xmmword ptr [rsp+48], xmm7
	sub rsp, 128
	cld
	xor rax, rax
	lea rdi, [rsp + 64]
	mov rcx, 8
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	rep stosq
	push 1
	call fastCarry
	add rsp, 136
	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	movdqu xmm4, xmmword ptr [rbp - 16]
	por xmm3, xmm4

	movdqu xmm4,xmmword ptr [rsp]
	movdqu xmm5,xmmword ptr [rsp+16]
	movdqu xmm6,xmmword ptr [rsp+32]
	movdqu xmm7,xmmword ptr [rsp+48]
	add rsp,64
	@skip344:
	pextrb rdx, xmm7, 0Fh
	and dl, 7Fh
	pinsrb xmm7, rdx, 0Fh
	notm xmm4,xmm4
	notm xmm5,xmm5
	notm xmm6,xmm6
	notm xmm7,xmm7
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	sub rsp, 128
	cld
	xor rax, rax
	lea rdi, [rsp + 64]
	mov rcx, 8
	movdqu xmmword ptr [rsp], xmm4
	movdqu xmmword ptr [rsp + 16], xmm5
	movdqu xmmword ptr [rsp + 32], xmm6
	movdqu xmmword ptr [rsp + 48], xmm7
	rep stosq
	push 1
	call fastCarry
	add rsp, 136
	xorrm xmm12, xmm0, xmm4
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm4
	xorrm xmm13, xmm1, xmm5
	xorrm xmm14, xmm2, xmm6
	xorrm xmm15, xmm3, xmm7
	movdqu xmm4, xmmword ptr [rsp]
	add rsp, 16 
	movdqu xmm8, xmmword ptr [rbp - 16]
	por xmm7, xmm8
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	add rsp, 128

	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm4
	movdqu xmmword ptr [rsp + 80], xmm5
	movdqu xmmword ptr [rsp + 96], xmm6
	movdqu xmmword ptr [rsp + 112], xmm7
	push 0
	call fastCarry
	add rsp, 136


	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	
	pextrq rdx, xmm3, 1h
	rcl rdx, 1
	jnc @skip444
	notm xmm0, xmm0
	notm xmm1, xmm1
	notm xmm2, xmm2
	notm xmm3, xmm3

	sub rsp, 128
	cld
	xor rax, rax
	lea rdi, [rsp + 64]
	mov rcx, 8
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	rep stosq
	push 1
	call fastCarry
	add rsp, 136
	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	movdqu xmm4, xmmword ptr [rbp - 16]
	por xmm3, xmm4
	@skip444:

	notm xmmword ptr [rbp -16], xmm4
	movdqu xmm5, xmmword ptr [rbp -32]
	movdqu xmm6, xmmword ptr [rbp -48]
	notm xmmword ptr [rbp -64], xmm7
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmmword ptr [rbp -96]
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;xU_y+1
	notm xmm4, xmm4
	notm xmm5, xmm5
	notm xmm6, xmm6
	notm xmm7, xmm7
	orrm xmm0, xmm4,xmm0
	orrm xmm1, xmm5,xmm1
	orrm xmm2, xmm6,xmm2
	orrm xmm3, xmm7,xmm3
	sub rsp, 128
	cld
	xor rax, rax
	lea rdi, [rsp + 64]
	mov rcx, 8
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	rep stosq
	push 1
	call fastCarry
	add rsp, 136

	
	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	test rax, 1h
	jne @loopnew
	pextrb rax, xmm3, 0Fh
	mov rdx, rax
	shr rax, 7
	jmp new
	@loopnew:
	pextrb rdx, xmm3, 1h
	new:
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	
	movdqu xmm4, xmmword ptr [rbp -16]
	movdqu xmm5, xmmword ptr [rbp -32]
	movdqu xmm6, xmmword ptr [rbp -48]
	notm xmmword ptr [rbp -64], xmm7
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmmword ptr [rbp -96]
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;x+(xUy)+1
	orrm xmm0, xmm4, xmm4
	orrm xmm1, xmm5, xmm5
	orrm xmm2, xmm6, xmm6
	orrm xmm3, xmm7, xmm7
	pextrq rdx, xmm3, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	pextrq rdx, xmm7, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm7, rdx, 1h
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm4
	movdqu xmmword ptr [rsp + 80], xmm5
	movdqu xmmword ptr [rsp + 96], xmm6
	movdqu xmmword ptr [rsp + 112], xmm7
	push 1
	call fastCarry
	add rsp, 136

	
	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	pextrb rax, xmm3, 0Fh
	mov rdx, rax
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	shr rax, 7
	
	notm xmmword ptr [rbp -16], xmm4
	notm xmmword ptr [rbp -32], xmm5
	notm xmmword ptr [rbp -48], xmm6
	movdqu xmm7, xmmword ptr [rbp -64]
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,xmmword ptr [rbp +-80]
	pand xmm4, xmm9
	pand xmm4, xmmword ptr [rbp -96]
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;x+y+1
	pextrq rdx, xmm3, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	pextrq rdx, xmm7, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm7, rdx, 1h
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm4
	movdqu xmmword ptr [rsp + 80], xmm5
	movdqu xmmword ptr [rsp + 96], xmm6
	movdqu xmmword ptr [rsp + 112], xmm7
	push 1
	call fastCarry
	add rsp, 136

	
	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	pextrb rax, xmm3, 0Fh
	mov rdx, rax
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	shr rax, 7
	
	movdqu xmm4, xmmword ptr [rbp -16]
	notm xmmword ptr [rbp -32], xmm5
	notm xmmword ptr [rbp -48], xmm6
	movdqu xmm7, xmmword ptr [rbp -64]
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmmword ptr [rbp -96]
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;(x_y)+(xUy)+1
	movaps xmm8, xmm4
	movaps xmm9, xmm5
	movaps xmm10, xmm6
	movaps xmm11, xmm7
	orrm xmm0, xmm4, xmm4
	orrm xmm1, xmm5, xmm5
	orrm xmm2, xmm6, xmm6
	orrm xmm3, xmm7, xmm7
	notm xmm8,xmm8
	notm xmm9,xmm9
	notm xmm10,xmm10
	notm xmm11,xmm11
	andm xmm0, xmm8, xmm0
	andm xmm1, xmm9, xmm1
	andm xmm2, xmm10, xmm2
	andm xmm3, xmm11, xmm3
	pextrq rdx, xmm3, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	pextrq rdx, xmm7, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm7, rdx, 1h
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm4
	movdqu xmmword ptr [rsp + 80], xmm5
	movdqu xmmword ptr [rsp + 96], xmm6
	movdqu xmmword ptr [rsp + 112], xmm7
	push 1
	call fastCarry
	add rsp, 136

	
	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	pextrb rax, xmm3, 0Fh
	mov rdx, rax
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	shr rax, 7
	
	notm xmmword ptr [rbp -16], xmm4
	movdqu xmm5, xmmword ptr [rbp -32]
	notm xmmword ptr [rbp -48], xmm6
	movdqu xmm7, xmmword ptr [rbp -64]
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmmword ptr [rbp -96]
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;xUy+1
	orrm xmm0, xmm4,xmm0
	orrm xmm1, xmm5,xmm1
	orrm xmm2, xmm6,xmm2
	orrm xmm3, xmm7,xmm3
	sub rsp, 128
	cld
	xor rax, rax
	lea rdi, [rsp + 64]
	mov rcx, 8
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	rep stosq
	push 1
	call fastCarry
	add rsp, 136

	
	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	test rax, 1h
	jne @loopnew2
	pextrb rax, xmm3, 0Fh
	mov rdx, rax
	shr rax, 7
	jmp new2
	@loopnew2:
	pextrb rdx, xmm3, 1h
	new2:
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	
	movdqu xmm4, xmmword ptr [rbp -16]
	movdqu xmm5, xmmword ptr [rbp -32]
	notm xmmword ptr [rbp -48], xmm6
	movdqu xmm7, xmmword ptr [rbp -64]
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmmword ptr [rbp -96]
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;x+x+1
	pextrq rdx, xmm3, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	pextrq rdx, xmm7, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm7, rdx, 1h
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm0
	movdqu xmmword ptr [rsp + 80], xmm1
	movdqu xmmword ptr [rsp + 96], xmm2
	movdqu xmmword ptr [rsp + 112], xmm3
	push 1
	call fastCarry
	add rsp, 136

	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	pextrb rax, xmm3, 0Fh
	mov rdx, rax
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	shr rax, 7
	
	notm xmmword ptr [rbp -16], xmm4
	notm xmmword ptr [rbp -32], xmm5
	movdqu xmm6, xmmword ptr [rbp -48]
	movdqu xmm7, xmmword ptr [rbp -64]
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmmword ptr [rbp -96]
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;xy+x+1
	andm xmm0 ,xmm4, xmm4
	andm xmm1 ,xmm5, xmm5
	andm xmm2 ,xmm6, xmm6
	andm xmm3 ,xmm7, xmm7
	pextrq rdx, xmm3, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	pextrq rdx, xmm7, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm7, rdx, 1h
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm4
	movdqu xmmword ptr [rsp + 80], xmm5
	movdqu xmmword ptr [rsp + 96], xmm6
	movdqu xmmword ptr [rsp + 112], xmm7
	push 1
	call fastCarry
	add rsp, 136

	
	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	pextrb rax, xmm3, 0Fh
	mov rdx, rax
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	shr rax, 7
	
	movdqu xmm4, xmmword ptr [rbp -16]
	notm xmmword ptr [rbp -32], xmm5
	movdqu xmm6, xmmword ptr [rbp -48]
	movdqu xmm7, xmmword ptr [rbp -64]
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmmword ptr [rbp -96]
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;x_y+x+1
	notm xmm4,xmm4
	notm xmm5,xmm5
	notm xmm6,xmm6
	notm xmm7,xmm7
	andm xmm0 ,xmm4, xmm4
	andm xmm1 ,xmm5, xmm5
	andm xmm2 ,xmm6, xmm6
	andm xmm3 ,xmm7, xmm7
	pextrq rdx, xmm3, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	pextrq rdx, xmm7, 1h
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm7, rdx, 1h
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm4
	movdqu xmmword ptr [rsp + 80], xmm5
	movdqu xmmword ptr [rsp + 96], xmm6
	movdqu xmmword ptr [rsp + 112], xmm7
	push 0
	call fastCarry
	add rsp, 136

	
	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	pextrb rax, xmm3, 0Fh
	mov rdx, rax
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	shr rax, 7
	
	notm xmmword ptr [rbp -16], xmm4
	movdqu xmm5, xmmword ptr [rbp -32]
	movdqu xmm6, xmmword ptr [rbp -48]
	movdqu xmm7, xmmword ptr [rbp -64]
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmmword ptr [rbp -96]
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8

	;x+1
	sub rsp, 128
	cld
	xor rax, rax
	lea rdi, [rsp + 64]
	mov rcx, 8
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	rep stosq
	push 1
	call fastCarry
	add rsp, 136

	
	sub rsp, 80
	movdqu xmmword ptr [rsp], xmm0
	movdqu xmmword ptr [rsp + 16], xmm1
	movdqu xmmword ptr [rsp + 32], xmm2
	movdqu xmmword ptr [rsp + 48], xmm3
	movdqu xmmword ptr [rsp + 64], xmm15
	push rax
	sub rsp, 128
	movdqu xmmword ptr [rsp], xmm12
	movdqu xmmword ptr [rsp + 16], xmm13
	movdqu xmmword ptr [rsp + 32], xmm14
	movdqu xmmword ptr [rsp + 48], xmm15
	movdqu xmmword ptr [rsp + 64], xmm8
	movdqu xmmword ptr [rsp + 80], xmm9
	movdqu xmmword ptr [rsp + 96], xmm10
	movdqu xmmword ptr [rsp + 112], xmm11
	call PgGg
	add rsp, 128
	mov r12, rax
	pop rax
	shl rax, 1
	or rax, r12
	shl rax, 1
	or rax, rdx
	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	movdqu xmm15, xmmword ptr [rsp + 64]
	add rsp, 80

	movdqu xmm0, xmmword ptr [rsp]
	movdqu xmm1, xmmword ptr [rsp + 16]
	movdqu xmm2, xmmword ptr [rsp + 32]
	movdqu xmm3, xmmword ptr [rsp + 48]
	add rsp, 64

	xorrm xmm12, xmm0, xmm0
	xorrm xmm13, xmm1, xmm1
	xorrm xmm14, xmm2, xmm2
	xorrm xmm15, xmm3, xmm3
	test rax, 4h
	jne @loopnew3
	pextrb rax, xmm3, 0Fh
	mov rdx, rax
	shr rax, 7
	jmp new3
	@loopnew3:
	pextrb rdx, xmm3, 1h
	new3:
	mov r12, 7FFFFFFFFFFFFFFFh
	and rdx, r12
	pinsrq xmm3, rdx, 1h
	
	movdqu xmm4, xmmword ptr [rbp -16]
	movdqu xmm5, xmmword ptr [rbp -32]
	movdqu xmm6, xmmword ptr [rbp -48]
	movdqu xmm7, xmmword ptr [rbp -64]
	pand xmm4, xmm5
	pand xmm4, xmm6
	pand xmm4, xmm7
	por xmm9,xmmword ptr [rbp -80]
	pand xmm4, xmm9
	pand xmm4, xmmword ptr [rbp -96]
	pand xmm0, xmm4
	pand xmm1, xmm4
	pand xmm2, xmm4
	pand xmm3, xmm4
	movdqu xmm5, xmmword ptr [rbp - 112]
	movdqu xmm6, xmmword ptr [rbp - 128]
	movdqu xmm7, xmmword ptr [rbp - 144]
	movdqu xmm8, xmmword ptr [rbp - 160]
	por xmm5, xmm0
	por xmm6, xmm1
	por xmm7, xmm2
	por xmm8, xmm3
	movdqu xmmword ptr [rbp - 112], xmm5
	movdqu xmmword ptr [rbp - 128], xmm6
	movdqu xmmword ptr [rbp - 144], xmm7
	movdqu xmmword ptr [rbp - 160], xmm8
	movdqu xmm0, xmm5
	movdqu xmm1, xmm6
	movdqu xmm2, xmm7
	movdqu xmm3, xmm8
	add rsp, 224
	pop rbp
	pop rsp
endm

.data
	Message1 db "¬ведите c0: "
	Message2 db "¬ведите M: "
	Message3 db "¬ведите s0: "
	Message4 db "¬ведите s1: "
	Message5 db "¬ведите s2: "
	Message6 db "¬ведите s3: "
	Message7 db "¬ведите x0: "
	Message8 db "¬ведите x1: "
	Message9 db "¬ведите x2: "
	Message10 db "¬ведите x3: "
	Message11 db "¬ведите y0: "
	Message12 db "¬ведите y1: "
	Message13 db "¬ведите y2: "
	Message14 db "¬ведите y3: "
	Message15 db "F0: "
	Message16 db 0Dh, 0Ah, "F1: "
	Message17 db 0Dh, 0Ah, "F2: "
	Message18 db 0Dh, 0Ah, "F3: "
	Message19 db 0Dh, 0Ah, "c4: "
	Message20 db 0Dh, 0Ah, "PG: "
	Message21 db 0Dh, 0Ah, "GG: "
	Message22 db 0Dh, 0Ah, "eq: "
	ErrorMessage1 db "ќшибка! ¬ведите значение 0 до 1.", 0Dh, 0Ah
	ErrorMessage2 db "ќшибка! ¬ведите значение 0 до F (в 16 с/с).", 0Dh, 0Ah
.code
global proc 
	call main
global endp

main proc
	push rbp
	mov rbp, rsp
	sub rsp, 86

	call AllocConsole

	mov rcx, 1251
	call SetConsoleCP

	mov rcx, 1251
	call SetConsoleOutputCP

	mov rcx, STD_OUTPUT_HANDLE
	call GetStdHandle
	mov [rbp - 8], rax

	mov rcx, STD_INPUT_HANDLE
	call GetStdHandle
	mov [rbp - 16], rax

	;----c0
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message1 
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8
	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 3
	lea r9, [rbp - 56]
	push 0
	call ReadConsoleA
	add rsp, 8
	cmp byte ptr [rbp - 48], 31h
	jg @error
	push 1
	push [rbp - 48]
	call ASCIIStringToRax
	add rsp, 16
	mov r12, rax
	shl r12, 1

	;-----M
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message2
	mov r8, 11
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 3
	lea r9, [rbp - 56]
	push 0
	call ReadConsoleA
	add rsp, 8

	cmp byte ptr [rbp - 48], 31h
	jg @error

	push 1
	push [rbp - 48]
	call ASCIIStringToRax
	add rsp, 16
	or r12, rax
	shl r12, 1
	;----s0
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message3
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	cmp byte ptr [rbp - 48], 31h
	jg @error

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 3
	lea r9, [rbp - 56]
	push 0
	call ReadConsoleA
	add rsp, 8

	cmp byte ptr [rbp - 48], 31h
	jg @error

	push 1
	push [rbp - 48]
	call ASCIIStringToRax
	add rsp, 16
	or r12, rax
	shl r12, 1
	;-------s1
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message4
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 3
	lea r9, [rbp - 56]
	push 0
	call ReadConsoleA
	add rsp, 8

	cmp byte ptr [rbp - 48], 31h
	jg @error

	push 1
	push [rbp - 48]
	call ASCIIStringToRax
	add rsp, 16
	or r12, rax
	shl r12, 1

	;-------s2
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message5
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 3
	lea r9, [rbp - 56]
	push 0
	call ReadConsoleA
	add rsp, 8

	cmp byte ptr [rbp - 48], 31h
	jg @error

	push 1
	push [rbp - 48]
	call ASCIIStringToRax
	add rsp, 16
	or r12, rax
	shl r12, 1

	;-------s3
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message6
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 3
	lea r9, [rbp - 56]
	push 0
	call ReadConsoleA
	add rsp, 8

	cmp byte ptr [rbp - 48], 31h
	jg @error

	push 1
	push [rbp - 48]
	call ASCIIStringToRax
	add rsp, 16
	or r12, rax

	;-------x0
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message7
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	lea rdi, [rbp - 48]
	xor rax, rax
	mov rcx, 4
	rep stosq

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 32
	lea r9, qword ptr [rbp - 56]
	push 0
	call ReadConsoleA
	add rsp, 8

	cmp qword ptr [rbp - 56], 32
	jl @continue11
	mov qword ptr [rbp - 56], 34
	@continue11:
	sub qword ptr [rbp - 56], 2
	mov rcx, qword ptr [rbp - 56] 
	xor rdi, rdi
	@loop11:
	;s[rdi] >= 0x30 && s[rdi] <= 0x39 || s[rdi] >= 0x41 && s[rdi] <= 0x46
	cmp byte ptr [rbp + rdi - 48], 30h
	jl @error1
	cmp byte ptr [rbp + rdi - 48], 39h
	jg @continue31
	sub byte ptr [rbp + rdi - 48], 30h
	jmp @continue21
	@continue31:
	cmp byte ptr [rbp + rdi - 48], 41h
	jl @error1
	cmp byte ptr [rbp + rdi - 48], 46h
	jg @error1
	sub byte ptr [rbp + rdi - 48], 37h
	@continue21:
	inc rdi
	loop @loop11

	mov rbx, rbp
	sub rbx, 48
	push rbx
	push [rbp - 56]
	call ASCIIStringToXmm
	add rsp, 16
	movaps xmm8,xmm13

	;-------x1
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message8
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 32
	lea r9, qword ptr [rbp - 56]
	push 0
	call ReadConsoleA
	add rsp, 8

	cmp qword ptr [rbp - 56], 32
	jl @continue12
	mov qword ptr [rbp - 56], 34
	@continue12:
	sub qword ptr [rbp - 56], 2
	mov rcx, qword ptr [rbp - 56] 
	xor rdi, rdi
	@loop12:
	;s[rdi] >= 0x30 && s[rdi] <= 0x39 || s[rdi] >= 0x41 && s[rdi] <= 0x46
	cmp byte ptr [rbp + rdi - 48], 30h
	jl @error1
	cmp byte ptr [rbp + rdi - 48], 39h
	jg @continue32
	sub byte ptr [rbp + rdi - 48], 30h
	jmp @continue22
	@continue32:
	cmp byte ptr [rbp + rdi - 48], 41h
	jl @error1
	cmp byte ptr [rbp + rdi - 48], 46h
	jg @error1
	sub byte ptr [rbp + rdi - 48], 37h
	@continue22:
	inc rdi
	loop @loop12
	mov rbx, rbp
	sub rbx, 48
	push rbx
	push [rbp - 56]
	call ASCIIStringToXmm
	add rsp, 16
	movaps xmm9,xmm13
	
	;-------x2
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message9
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8
	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 32
	lea r9, qword ptr [rbp - 56]
	push 0
	call ReadConsoleA
	add rsp, 8
	cmp qword ptr [rbp - 56], 32
	jl @continue13
	mov qword ptr [rbp - 56], 34
	@continue13:
	sub qword ptr [rbp - 56], 2
	mov rcx, qword ptr [rbp - 56] 
	xor rdi, rdi
	@loop13:
	;s[rdi] >= 0x30 && s[rdi] <= 0x39 || s[rdi] >= 0x41 && s[rdi] <= 0x46
	cmp byte ptr [rbp + rdi - 48], 30h
	jl @error1
	cmp byte ptr [rbp + rdi - 48], 39h
	jg @continue33
	sub byte ptr [rbp + rdi - 48], 30h
	jmp @continue23
	@continue33:
	cmp byte ptr [rbp + rdi - 48], 41h
	jl @error1
	cmp byte ptr [rbp + rdi - 48], 46h
	jg @error1
	sub byte ptr [rbp + rdi - 48], 37h
	@continue23:
	inc rdi
	loop @loop13
	mov rbx, rbp
	sub rbx, 48
	push rbx
	push [rbp - 56]
	call ASCIIStringToXmm
	add rsp, 16
	movaps xmm10,xmm13

	;-------x3
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message10
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 32
	lea r9, qword ptr [rbp - 56]
	push 0
	call ReadConsoleA
	add rsp, 8

	cmp qword ptr [rbp - 56], 32
	jl @continue14
	mov qword ptr [rbp - 56], 34
	@continue14:
	sub qword ptr [rbp - 56], 2
	mov rcx, qword ptr [rbp - 56] 
	xor rdi, rdi
	@loop14:
	;s[rdi] >= 0x30 && s[rdi] <= 0x39 || s[rdi] >= 0x41 && s[rdi] <= 0x46
	cmp byte ptr [rbp + rdi - 48], 30h
	jl @error1
	cmp byte ptr [rbp + rdi - 48], 39h
	jg @continue34
	sub byte ptr [rbp + rdi - 48], 30h
	jmp @continue24
	@continue34:
	cmp byte ptr [rbp + rdi - 48], 41h
	jl @error1
	cmp byte ptr [rbp + rdi - 48], 46h
	jg @error1
	sub byte ptr [rbp + rdi - 48], 37h
	@continue24:
	inc rdi
	loop @loop14

	mov rbx, rbp
	sub rbx, 48
	push rbx
	push [rbp - 56]
	call ASCIIStringToXmm
	add rsp, 16
	movaps xmm11,xmm13

	;-------y0
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message11
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 32
	lea r9, qword ptr [rbp - 56]
	push 0
	call ReadConsoleA
	add rsp, 8

	cmp qword ptr [rbp - 56], 32
	jl @continue15
	mov qword ptr [rbp - 56], 34
	@continue15:
	sub qword ptr [rbp - 56], 2
	mov rcx, qword ptr [rbp - 56] 
	xor rdi, rdi
	@loop15:
	;s[rdi] >= 0x30 && s[rdi] <= 0x39 || s[rdi] >= 0x41 && s[rdi] <= 0x46
	cmp byte ptr [rbp + rdi - 48], 30h
	jl @error1
	cmp byte ptr [rbp + rdi - 48], 39h
	jg @continue35
	sub byte ptr [rbp + rdi - 48], 30h
	jmp @continue25
	@continue35:
	cmp byte ptr [rbp + rdi - 48], 41h
	jl @error1
	cmp byte ptr [rbp + rdi - 48], 46h
	jg @error1
	sub byte ptr [rbp + rdi - 48], 37h
	@continue25:
	inc rdi
	loop @loop15

	mov rbx, rbp
	sub rbx, 48
	push rbx
	push [rbp - 56]
	call ASCIIStringToXmm
	add rsp, 16
	movaps xmm12,xmm13

	;-------y1
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message12
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 32
	lea r9, qword ptr [rbp - 56]
	push 0
	call ReadConsoleA
	add rsp, 8

	cmp qword ptr [rbp - 56], 32
	jl @continue16
	mov qword ptr [rbp - 56], 34
	@continue16:
	sub qword ptr [rbp - 56], 2
	mov rcx, qword ptr [rbp - 56] 
	xor rdi, rdi
	@loop16:
	;s[rdi] >= 0x30 && s[rdi] <= 0x39 || s[rdi] >= 0x41 && s[rdi] <= 0x46
	cmp byte ptr [rbp + rdi - 48], 30h
	jl @error1
	cmp byte ptr [rbp + rdi - 48], 39h
	jg @continue36
	sub byte ptr [rbp + rdi - 48], 30h
	jmp @continue26
	@continue36:
	cmp byte ptr [rbp + rdi - 48], 41h
	jl @error1
	cmp byte ptr [rbp + rdi - 48], 46h
	jg @error1
	sub byte ptr [rbp + rdi - 48], 37h
	@continue26:
	inc rdi
	loop @loop16

	mov rbx, rbp
	sub rbx, 48
	push rbx
	push [rbp - 56]
	call ASCIIStringToXmm
	add rsp, 16
	movaps xmm14,xmm13

	;-------y2
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message13
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 32
	lea r9, qword ptr [rbp - 56]
	push 0
	call ReadConsoleA
	add rsp, 8

	cmp qword ptr [rbp - 56], 32
	jl @continue17
	mov qword ptr [rbp - 56], 34
	@continue17:
	sub qword ptr [rbp - 56], 2
	mov rcx, qword ptr [rbp - 56] 
	xor rdi, rdi
	@loop17:
	;s[rdi] >= 0x30 && s[rdi] <= 0x39 || s[rdi] >= 0x41 && s[rdi] <= 0x46
	cmp byte ptr [rbp + rdi - 48], 30h
	jl @error1
	cmp byte ptr [rbp + rdi - 48], 39h
	jg @continue37
	sub byte ptr [rbp + rdi - 48], 30h
	jmp @continue27
	@continue37:
	cmp byte ptr [rbp + rdi - 48], 41h
	jl @error1
	cmp byte ptr [rbp + rdi - 48], 46h
	jg @error1
	sub byte ptr [rbp + rdi - 48], 37h
	@continue27:
	inc rdi
	loop @loop17

	mov rbx, rbp
	sub rbx, 48
	push rbx
	push [rbp - 56]
	call ASCIIStringToXmm
	add rsp, 16
	movaps xmm6,xmm13

	;-------y3
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message14
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 32
	lea r9, qword ptr [rbp - 56]
	push 0
	call ReadConsoleA
	add rsp, 8

	cmp qword ptr [rbp - 56], 32
	jl @continue18
	mov qword ptr [rbp - 56], 34
	@continue18:
	sub qword ptr [rbp - 56], 2
	mov rcx, qword ptr [rbp - 56] 
	xor rdi, rdi
	@loop18:
	;s[rdi] >= 0x30 && s[rdi] <= 0x39 || s[rdi] >= 0x41 && s[rdi] <= 0x46
	cmp byte ptr [rbp + rdi - 48], 30h
	jl @error1
	cmp byte ptr [rbp + rdi - 48], 39h
	jg @continue38
	sub byte ptr [rbp + rdi - 48], 30h
	jmp @continue28
	@continue38:
	cmp byte ptr [rbp + rdi - 48], 41h
	jl @error1
	cmp byte ptr [rbp + rdi - 48], 46h
	jg @error1
	sub byte ptr [rbp + rdi - 48], 37h
	@continue28:
	inc rdi
	loop @loop18

	mov rbx, rbp
	sub rbx, 48
	push rbx
	push [rbp - 56]
	call ASCIIStringToXmm
	add rsp, 16
	movaps xmm7,xmm13

	sub rsp, 128
	movdqu xmmword ptr [rsp+112], xmm7
	movdqu xmmword ptr [rsp + 96], xmm6
	movdqu xmmword ptr [rsp + 80], xmm14
	movdqu xmmword ptr [rsp + 64], xmm12
	movdqu xmmword ptr [rsp + 48], xmm11
	movdqu xmmword ptr [rsp + 32], xmm10
	movdqu xmmword ptr [rsp + 16], xmm9
	movdqu xmmword ptr [rsp], xmm8
	push r12
	call ALU
	add rsp, 136

	push rax
	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm0
	lea rbx, [rbp - 48]
	push rbx
	call XmmToASCIIString
	add rsp, 24

	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message15
	mov r8, 4
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	mov rcx, qword ptr [rbp - 8]
	lea rdx, [rbp - 48]
	mov r8, 32
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm1
	lea rbx, [rbp - 48]
	push rbx
	call XmmToASCIIString
	add rsp, 24

	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message16
	mov r8, 6
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	mov rcx, qword ptr [rbp - 8]
	lea rdx, [rbp - 48]
	mov r8, 32
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm2
	lea rbx, [rbp - 48]
	push rbx
	call XmmToASCIIString
	add rsp, 24

	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message17
	mov r8, 6
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	mov rcx, qword ptr [rbp - 8]
	lea rdx, [rbp - 48]
	mov r8, 32
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	sub rsp, 16
	movdqu xmmword ptr [rsp], xmm3
	lea rbx, [rbp - 48]
	push rbx
	call XmmToASCIIString
	add rsp, 24

	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message18
	mov r8, 6
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	mov rcx, qword ptr [rbp - 8]
	lea rdx, [rbp - 48]
	mov r8, 32
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	pop rax
	mov rdx, rax
	lea rdi, [rbp - 48]
	shr rax, 3
	add rax, 30h
	stosb

	push rdx
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message19
	mov r8, 6
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	mov rcx, qword ptr [rbp - 8]
	lea rdx, [rbp - 48]
	mov r8, 1
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	pop rdx
	mov rax, rdx
	lea rdi, [rbp - 48]
	shr rax, 2
	and rax, 1h
	add rax, 30h
	stosb

	push rdx
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message20
	mov r8, 6
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	mov rcx, qword ptr [rbp - 8]
	lea rdx, [rbp - 48]
	mov r8, 1
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	pop rdx
	mov rax, rdx
	lea rdi, [rbp - 48]
	shr rax, 1
	and rax, 1h
	add rax, 30h
	stosb

	push rdx
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message21
	mov r8, 6
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	mov rcx, qword ptr [rbp - 8]
	lea rdx, [rbp - 48]
	mov r8, 1
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	pop rdx
	mov rax, rdx
	lea rdi, [rbp - 48]
	and rax, 1h
	add rax, 30h
	stosb
	mov rax, 0Dh
	stosb
	mov rax, 0Ah
	stosb

	push rdx
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message22
	mov r8, 6
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8

	mov rcx, qword ptr [rbp - 8]
	lea rdx, [rbp - 48]
	mov r8, 3
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA
	add rsp, 8
	
	jmp @end

	@error:
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset ErrorMessage1
	mov r8, 34
	lea r9, [rbp - 40]
	push 0
	call WriteConsoleA
	add rsp, 8
	jmp @end

	@error1:
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset ErrorMessage2
	mov r8, 45
	lea r9, [rbp - 40]
	push 0
	call WriteConsoleA
	add rsp, 8

	@end:
	xor rcx, rcx
	call ExitProcess
	add rsp, 86
	pop rbp
	ret
main endp

XmmToASCIIString proc
	push rbp
	mov rbp, rsp
	cld
	lea rsi, [rbp + 24]
	mov rcx, 16

	mov rdi, [rbp + 16]

	@loopXmmToASCIIString:
	lodsb
	mov dl, al
	and al, 0Fh
	;s[rsi] <= 0x9
	cmp al, 9h
	jg @continueXmmToASCIIString
	add al, 30h
	stosb
	jmp @continueXmmToASCIIString2
	@continueXmmToASCIIString:
	;s[rsi] > 0xA
	add al, 37h
	stosb
	@continueXmmToASCIIString2:
	;s[rsi] <= 0x9
	shr dl, 4
	cmp dl, 9h
	jg @continueXmmToASCIIString4
	mov al, dl
	add al, 30h
	stosb
	jmp @continueXmmToASCIIString3
	@continueXmmToASCIIString4:
	;s[rsi] > 0xA
	mov al, dl	
	add al, 37h
	stosb
	@continueXmmToASCIIString3:
	loop @loopXmmToASCIIString

	pop rbp
	ret
XmmToASCIIString endp

ASCIIStringToXmm proc
	push rbp
	mov rbp, rsp
	mov rcx, [rbp + 16]
	xorpd xmm13, xmm13
	cld

	add rcx, 1
	shr rcx, 1
	mov rsi, [rbp + 24]
	@loop128:
	xor dl, dl
	lodsb
	shl al, 4
	or dl, al
	lodsb
	or dl, al
	pslldq xmm13, 1
	pinsrb xmm13, edx, 0h
	loop @loop128

	test qword ptr [rbp + 16], 1h
	jz @exitASCIIStringToXmm
	pshufd xmm15, xmm13, 4eh
	psrlq xmm13, 4
	psllq xmm15, 60
	pinsrb xmm15, rcx, 15
	por xmm13, xmm15

	@exitASCIIStringToXmm:
	pop rbp
	ret
ASCIIStringToXmm endp

ASCIIStringToRax proc
	push rbp
	mov rbp, rsp
	lea rbx, [rbp + 16]
	mov rcx, [rbp + 24]
	xor rax, rax

	cmp rcx, 64
	jg @exit1

	xor rdi, rdi
	@loop10:
	mov al, byte ptr [rbx + rdi]
	sub al, 30h
	rcl rax, 8
	inc rdi
	loop @loop10
	rcr rax, 8
	@exit1:
	pop rbp
	ret
ASCIIStringToRax endp

fastCarry proc
	push rbp
	mov rbp, rsp

	mov rax, [rbp + 16]
	movdqu xmm0, xmmword ptr [rbp + 24]
	movdqu xmm1, xmmword ptr [rbp + 40]
	movdqu xmm2, xmmword ptr [rbp + 56]
	movdqu xmm3, xmmword ptr [rbp + 72]
	movdqu xmm4, xmmword ptr [rbp + 88]
	movdqu xmm5, xmmword ptr [rbp + 104]
	movdqu xmm6, xmmword ptr [rbp + 120]
	movdqu xmm7, xmmword ptr [rbp + 136]
	
	;g
	andm xmm0, xmm4, xmm8
	andm xmm1, xmm5, xmm9
	andm xmm2, xmm6, xmm10
	andm xmm3, xmm7, xmm11
	;p
	xorm xmm0, xmm4, xmm12
	xorm xmm1, xmm5, xmm13
	xorm xmm2, xmm6, xmm14
	xorm xmm3, xmm7, xmm15

	movd rdx, xmm8
	movd r11, xmm12
	call @dummy1
	@dummy1:
	pop r10
	add r10, 0Bh
	jmp @init_loop
	pinsrq xmm0, rax, 0h
	mov rax, r11
	
	pextrq rdx, xmm8, 1h
	pextrq r11, xmm12, 1h
	call @dummy2
	@dummy2:
	pop r10
	add r10, 0Bh
	jmp @init_loop
	pinsrq xmm0, rax, 1h 
	mov rax, r11

	movd rdx, xmm9
	movd r11, xmm13
	call @dummy3
	@dummy3:
	pop r10
	add r10, 0Bh
	jmp @init_loop
	pinsrq xmm1, rax, 0h
	mov rax, r11

	pextrq rdx, xmm9, 1h
	pextrq r11, xmm13, 1h
	call @dummy4
	@dummy4:
	pop r10
	add r10, 0Bh
	jmp @init_loop
	pinsrq xmm1, rax, 1h
	mov rax, r11

	movd rdx, xmm10
	movd r11, xmm14
	call @dummy5
	@dummy5:
	pop r10
	add r10, 08h
	jmp @init_loop
	pinsrq xmm2, rax, 0h
	mov rax, r11


	pextrq rdx, xmm10, 1h
	pextrq r11, xmm14, 1h
	call @dummy6
	@dummy6:
	pop r10
	add r10, 08h
	jmp @init_loop
	pinsrq xmm2, rax, 1h
	mov rax, r11

	movd rdx, xmm11
	movd r11, xmm15
	call @dummy7
	@dummy7:
	pop r10
	add r10, 08h
	jmp @init_loop
	pinsrq xmm3, rax, 0h
	mov rax, r11
	pextrq rdx, xmm11, 1h
	pextrq r11, xmm15, 1h
	xor r10, r10
	jmp @init_loop


	@init_loop:	
	mov rbx, 1h
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
	and r11, rax
	or r11, rdx
	mov r13, 8000000000000000h
	and r11, r13
	rcl r11, 2		

	test r10, 0ffffffffffffffffh
	je @exit
	jmp r10
	@exit:
	pinsrq xmm3, rax, 1h
	mov rax, r11

	pop rbp
	ret
fastCarry endp

PgGg proc
	push rbp
	mov rbp, rsp
	movdqu xmm0, xmmword ptr [rbp + 16]
	movdqu xmm1, xmmword ptr [rbp + 32]
	movdqu xmm2, xmmword ptr [rbp + 48]
	movdqu xmm3, xmmword ptr [rbp + 64]
	movdqu xmm4, xmmword ptr [rbp + 80]
	movdqu xmm5, xmmword ptr [rbp + 96]
	movdqu xmm6, xmmword ptr [rbp + 112]
	movdqu xmm7, xmmword ptr [rbp + 128]
	
	xorps xmm10, xmm7
	movaps xmm9, xmm3
	movaps xmm8, xmm3
	mov rcx, 128	
	@loop1:
	pshufd xmm15, xmm8, 4eh
	psrlq xmm8, 1
	psllq xmm15, 63
	por xmm8, xmm15
	pshufd xmm15, xmm10, 4eh
	psrlq xmm10, 1
	psllq xmm15, 63
	por xmm10, xmm15
	andps xmm9, xmm8
	andps xmm10, xmm9 
	orps xmm7, xmm10
	loop @loop1

	movaps xmm10, xmm6
	movaps xmm8, xmm2
	mov rcx, 128
	@loop2:
	pshufd xmm15, xmm8, 4eh
	psrlq xmm8, 1
	psllq xmm15, 63
	por xmm8, xmm15
	pshufd xmm15, xmm10, 4eh
	psrlq xmm10, 1
	psllq xmm15, 63
	por xmm10, xmm15
	andps xmm9, xmm8
	andps xmm10, xmm9 
	orps xmm7, xmm10
	loop @loop2

	movaps xmm10, xmm5
	movaps xmm8, xmm1
	mov rcx, 128
	@loop3:
	pshufd xmm15, xmm8, 4eh
	psrlq xmm8, 1
	psllq xmm15, 63
	por xmm8, xmm15
	pshufd xmm15, xmm10, 4eh
	psrlq xmm10, 1
	psllq xmm15, 63
	por xmm10, xmm15
	andps xmm9, xmm8
	andps xmm10, xmm9 
	orps xmm7, xmm10
	loop @loop3

	movaps xmm10, xmm4
	movaps xmm8, xmm0
	mov rcx, 128
	@loop4:
	pshufd xmm15, xmm8, 4eh
	psrlq xmm8, 1
	psllq xmm15, 63
	por xmm8, xmm15
	pshufd xmm15, xmm10, 4eh
	psrlq xmm10, 1
	psllq xmm15, 63
	por xmm10, xmm15
	andps xmm9, xmm8
	andps xmm10, xmm9 
	orps xmm7, xmm10
	loop @loop4

	movd rax, xmm9
	movd rdx, xmm7
	pop rbp
	ret
PgGg endp

ALU proc
	push rbp
	mov rbp, rsp
	sub rsp, 16
	cld
	lea rdi, [rbp - 16]
	mov rcx, 15
	mov al, 00h
	rep stosb
	mov al, 80h
	stosb

	mov rax, [rbp + 16] 
	movdqu xmm0, xmmword ptr [rbp + 24]
	movdqu xmm1, xmmword ptr [rbp + 40]
	movdqu xmm2, xmmword ptr [rbp + 56]
	movdqu xmm3, xmmword ptr [rbp + 72]
	movdqu xmm4, xmmword ptr [rbp + 88]
	movdqu xmm5, xmmword ptr [rbp + 104]
	movdqu xmm6, xmmword ptr [rbp + 120]
	movdqu xmm7, xmmword ptr [rbp + 136]
	test rax, 10h
	je  @continue
	and rax, 1Fh
	@continue:
	
	movaps xmm8, xmm4
	pcmpeqb xmm8, xmm0
	pextrq rdx, xmm8, 0h
	pextrq r10, xmm8, 1h
	mov rcx, 64
	@loopALU1:
	rcl rdx, 1
	jnc @not_eq
	rcl r10, 1
	jnc @not_eq 
	loop @loopALU1

	movaps xmm8, xmm5
	pcmpeqb xmm8, xmm1
	pextrq rdx, xmm8, 0h
	pextrq r10, xmm8, 1h
	mov rcx, 64
	@loopALU2:
	rcl rdx, 1
	jnc @not_eq
	rcl r10, 1
	jnc @not_eq 
	loop @loopALU2

	movaps xmm8, xmm6
	pcmpeqb xmm8, xmm2
	pextrq rdx, xmm8, 0h
	pextrq r10, xmm8, 1h
	mov rcx, 64
	@loopALU3:
	rcl rdx, 1
	jnc @not_eq
	rcl r10, 1
	jnc @not_eq 
	loop @loopALU3

	movaps xmm8, xmm7
	pcmpeqb xmm8, xmm3
	pextrq rdx, xmm8, 0h
	pextrq r10, xmm8, 1h
	mov rcx, 64
	@loopALU4:
	rcl rdx, 1
	jnc @not_eq
	rcl r10, 1
	jnc @not_eq 
	loop @loopALU4

	mov r15, 1h

	jmp @continue1
	@not_eq:
	mov r15, 0h
	@continue1:

	;M=1
	cmp rax, 10h	
	je @f1
	cmp rax, 18h
	je @f2
	cmp rax, 14h
	je @f3
	cmp rax, 1Ch
	je @f4
	cmp rax, 12h
	je @f5
	cmp rax, 1Ah
	je @f6
	cmp rax, 16h
	je @f7
	cmp rax, 1Eh
	je @f8
	cmp rax, 11h
	je @f9
	cmp rax, 19h
	je @f10
	cmp rax, 15h
	je @f11
	cmp rax, 1Dh
	je @f12
	cmp rax, 13h
	je @f13
	cmp rax, 1Bh
	je @f14
	cmp rax, 17h
	je @f15
	cmp rax, 1Fh
	je @f16

	;c=0 M=0
	cmp rax, 0h	
	je @f17
	cmp rax, 8h
	je @f18
	cmp rax, 4h
	je @f19
	cmp rax, 0Ch
	je @f20
	cmp rax, 2h
	je @f21
	cmp rax, 0Ah
	je @f22
	cmp rax, 6h
	je @f23
	cmp rax, 0Eh
	je @f24
	cmp rax, 1h
	je @f25
	cmp rax, 9h
	je @f26
	cmp rax, 5h
	je @f27
	cmp rax, 0Dh
	je @f28
	cmp rax, 3h
	je @f29
	cmp rax, 0Bh
	je @f30
	cmp rax, 7h
	je @f31
	cmp rax, 0Fh
	je @f32

	;c=1 M=0
	cmp rax, 20h	
	je @f33
	cmp rax, 28h
	je @f34
	cmp rax, 24h
	je @f35
	cmp rax, 2Ch
	je @f36
	cmp rax, 22h
	je @f37
	cmp rax, 2Ah
	je @f38
	cmp rax, 26h
	je @f39
	cmp rax, 2Eh
	je @f40
	cmp rax, 21h
	je @f41
	cmp rax, 29h
	je @f42
	cmp rax, 25h
	je @f43
	cmp rax, 2Dh
	je @f44
	cmp rax, 23h
	je @f45
	cmp rax, 2Bh
	je @f46
	cmp rax, 27h
	je @f47
	cmp rax, 2Fh
	je @f48

	@f1:
	pxor xmm10, xmm10
	pxor xmm11, xmm11
	pxor xmm12, xmm12
	pxor xmm13, xmm13
	pcmpeqb xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f2:
	pcmpeqb xmm10, xmm10
	pxor xmm11, xmm11
	pxor xmm12, xmm12
	pxor xmm13, xmm13
	pcmpeqb xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch
	
	@f3:
	pxor xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pxor xmm12, xmm12
	pxor xmm13, xmm13
	pcmpeqb xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f4:
	pcmpeqb xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pxor xmm12, xmm12
	pxor xmm13, xmm13
	pcmpeqb xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f5:
	pxor xmm10, xmm10
	pxor xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pxor xmm13, xmm13
	pcmpeqb xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f6:
	pcmpeqb xmm10, xmm10
	pxor xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pxor xmm13, xmm13
	pcmpeqb xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f7:
	pxor xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pxor xmm13, xmm13
	pcmpeqb xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f8:
	pcmpeqb xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pxor xmm13, xmm13
	pcmpeqb xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f9:
	pxor xmm10, xmm10
	pxor xmm11, xmm11
	pxor xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pcmpeqb xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f10:
	pcmpeqb xmm10, xmm10
	pxor xmm11, xmm11
	pxor xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pcmpeqb xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f11:
	pxor xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pxor xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pcmpeqb xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f12:
	pcmpeqb xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pxor xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pcmpeqb xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f13:
	pxor xmm10, xmm10
	pxor xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pcmpeqb xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f14:
	pcmpeqb xmm10, xmm10
	pxor xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pcmpeqb xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f15:
	pxor xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pcmpeqb xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f16:
	pcmpeqb xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pcmpeqb xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	;-------------------
	@f17:
	pxor xmm10, xmm10
	pxor xmm11, xmm11
	pxor xmm12, xmm12
	pxor xmm13, xmm13
	pxor xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f18:
	pcmpeqb xmm10, xmm10
	pxor xmm11, xmm11
	pxor xmm12, xmm12
	pxor xmm13, xmm13
	pxor xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch
	
	@f19:
	pxor xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pxor xmm12, xmm12
	pxor xmm13, xmm13
	pxor xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f20:
	pcmpeqb xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pxor xmm12, xmm12
	pxor xmm13, xmm13
	pxor xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f21:
	pxor xmm10, xmm10
	pxor xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pxor xmm13, xmm13
	pxor xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f22:
	pcmpeqb xmm10, xmm10
	pxor xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pxor xmm13, xmm13
	pxor xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f23:
	pxor xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pxor xmm13, xmm13
	pxor xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f24:
	pcmpeqb xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pxor xmm13, xmm13
	pxor xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f25:
	pxor xmm10, xmm10
	pxor xmm11, xmm11
	pxor xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pxor xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f26:
	pcmpeqb xmm10, xmm10
	pxor xmm11, xmm11
	pxor xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pxor xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f27:
	pxor xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pxor xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pxor xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f28:
	pcmpeqb xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pxor xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pxor xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f29:
	pxor xmm10, xmm10
	pxor xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pxor xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f30:
	pcmpeqb xmm10, xmm10
	pxor xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pxor xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f31:
	pxor xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pxor xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch

	@f32:
	pcmpeqb xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pxor xmm14, xmm14
	pxor xmm15, xmm15
	jmp @end_switch
	;-------------------
	@f33:
	pxor xmm10, xmm10
	pxor xmm11, xmm11
	pxor xmm12, xmm12
	pxor xmm13, xmm13
	pxor xmm14, xmm14
	pcmpeqb xmm15, xmm15
	jmp @end_switch

	@f34:
	pcmpeqb xmm10, xmm10
	pxor xmm11, xmm11
	pxor xmm12, xmm12
	pxor xmm13, xmm13
	pxor xmm14, xmm14
	pcmpeqb xmm15, xmm15
	jmp @end_switch
	
	@f35:
	pxor xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pxor xmm12, xmm12
	pxor xmm13, xmm13
	pxor xmm14, xmm14
	pcmpeqb xmm15, xmm15
	jmp @end_switch

	@f36:
	pcmpeqb xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pxor xmm12, xmm12
	pxor xmm13, xmm13
	pxor xmm14, xmm14
	pcmpeqb xmm15, xmm15
	jmp @end_switch

	@f37:
	pxor xmm10, xmm10
	pxor xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pxor xmm13, xmm13
	pxor xmm14, xmm14
	pcmpeqb xmm15, xmm15
	jmp @end_switch

	@f38:
	pcmpeqb xmm10, xmm10
	pxor xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pxor xmm13, xmm13
	pxor xmm14, xmm14
	pcmpeqb xmm15, xmm15
	jmp @end_switch

	@f39:
	pxor xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pxor xmm13, xmm13
	pxor xmm14, xmm14
	pcmpeqb xmm15, xmm15
	jmp @end_switch

	@f40:
	pcmpeqb xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pxor xmm13, xmm13
	pxor xmm14, xmm14
	pcmpeqb xmm15, xmm15
	jmp @end_switch

	@f41:
	pxor xmm10, xmm10
	pxor xmm11, xmm11
	pxor xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pxor xmm14, xmm14
	pcmpeqb xmm15, xmm15
	jmp @end_switch

	@f42:
	pcmpeqb xmm10, xmm10
	pxor xmm11, xmm11
	pxor xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pxor xmm14, xmm14
	pcmpeqb xmm15, xmm15
	jmp @end_switch

	@f43:
	pxor xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pxor xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pxor xmm14, xmm14
	pcmpeqb xmm15, xmm15
	jmp @end_switch

	@f44:
	pcmpeqb xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pxor xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pxor xmm14, xmm14
	pcmpeqb xmm15, xmm15
	jmp @end_switch

	@f45:
	pxor xmm10, xmm10
	pxor xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pxor xmm14, xmm14
	pcmpeqb xmm15, xmm15
	jmp @end_switch

	@f46:
	pcmpeqb xmm10, xmm10
	pxor xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pxor xmm14, xmm14
	pcmpeqb xmm15, xmm15
	jmp @end_switch

	@f47:
	pxor xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pxor xmm14, xmm14
	pcmpeqb xmm15, xmm15
	jmp @end_switch

	@f48:
	pcmpeqb xmm10, xmm10
	pcmpeqb xmm11, xmm11
	pcmpeqb xmm12, xmm12
	pcmpeqb xmm13, xmm13
	pxor xmm14, xmm14
	pcmpeqb xmm15, xmm15
	jmp @end_switch

	@end_switch:
	ifm xmm10, xmm11, xmm12, xmm13, xmm14, xmm15
	shl rax, 1
	or rax, r15
	add rsp, 16
	pop rbp
	ret
ALU endp

end