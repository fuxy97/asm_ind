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
	ErrorMessage1 db "ќшибка! ¬ведите значение 0 до 1.", 0Dh, 0Ah
	ErrorMessage2 db "ќшибка! ¬ведите значение 0 до F (в 16 с/с).", 0Dh, 0Ah
.code
global proc 
	call main
global endp

main proc
	push rbp
	mov rbp, rsp
	sub rsp, 56

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

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 3
	lea r9, [rbp - 56]
	push 0
	call ReadConsoleA

	cmp byte ptr [rbp - 32], 31h
	jg @error

	push 1
	push [rbp - 32]
	call ASCIIStringToRax
	mov r10, rax
	shl r10, 1
	;-----M
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message2
	mov r8, 11
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 3
	lea r9, [rbp - 56]
	push 0
	call ReadConsoleA

	cmp byte ptr [rbp - 32], 31h
	jg @error

	push 1
	push [rbp - 32]
	call ASCIIStringToRax
	add r10, rax
	shl r10, 1
	;----s0
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message3
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA

	cmp byte ptr [rbp - 32], 31h
	jg @error

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 3
	lea r9, [rbp - 56]
	push 0
	call ReadConsoleA

	cmp byte ptr [rbp - 32], 31h
	jg @error

	push 1
	push [rbp - 32]
	call ASCIIStringToRax
	add r10, rax
	shl r10, 1
	;-------s1
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message4
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 3
	lea r9, [rbp - 56]
	push 0
	call ReadConsoleA

	cmp byte ptr [rbp - 32], 31h
	jg @error

	push 1
	push [rbp - 32]
	call ASCIIStringToRax
	add r10, rax
	shl r10, 1

	;-------s2
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message5
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 3
	lea r9, [rbp - 56]
	push 0
	call ReadConsoleA

	cmp byte ptr [rbp - 32], 31h
	jg @error

	push 1
	push [rbp - 32]
	call ASCIIStringToRax
	add r10, rax
	shl r10, 1

	;-------s3
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message6
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 3
	lea r9, [rbp - 56]
	push 0
	call ReadConsoleA

	cmp byte ptr [rbp - 32], 31h
	jg @error

	push 1
	push [rbp - 32]
	call ASCIIStringToRax
	add r10, rax

	;-------x0
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message7
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 32
	lea r9, qword ptr [rbp - 56]
	push 0
	call ReadConsoleA

	cmp qword ptr [rbp - 56], 32
	jle @continue11
	mov qword ptr [rbp - 56], 32
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

	push [rbp - 48]
	push [rbp - 56]
	call ASCIIStringToXmm
	movaps xmm8,xmm0

	;-------x1
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message8
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 32
	lea r9, qword ptr [rbp - 56]
	push 0
	call ReadConsoleA

	cmp qword ptr [rbp - 56], 32
	jle @continue12
	mov qword ptr [rbp - 56], 32
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

	push [rbp - 48]
	push [rbp - 56]
	call ASCIIStringToXmm
	movaps xmm1,xmm0
	
	;-------x2
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message9
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 32
	lea r9, qword ptr [rbp - 56]
	push 0
	call ReadConsoleA

	cmp qword ptr [rbp - 56], 32
	jle @continue13
	mov qword ptr [rbp - 56], 32
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

	push [rbp - 48]
	push [rbp - 56]
	call ASCIIStringToXmm
	movaps xmm2,xmm0

		;-------x3
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message10
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 32
	lea r9, qword ptr [rbp - 56]
	push 0
	call ReadConsoleA

	cmp qword ptr [rbp - 56], 32
	jle @continue14
	mov qword ptr [rbp - 56], 32
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

	push [rbp - 48]
	push [rbp - 56]
	call ASCIIStringToXmm
	movaps xmm3,xmm0

	;-------y0
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message11
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 32
	lea r9, qword ptr [rbp - 56]
	push 0
	call ReadConsoleA

	cmp qword ptr [rbp - 56], 32
	jle @continue15
	mov qword ptr [rbp - 56], 32
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

	push [rbp - 48]
	push [rbp - 56]
	call ASCIIStringToXmm
	movaps xmm4,xmm0

	;-------y1
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message12
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 32
	lea r9, qword ptr [rbp - 56]
	push 0
	call ReadConsoleA

	cmp qword ptr [rbp - 56], 32
	jle @continue16
	mov qword ptr [rbp - 56], 32
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

	push [rbp - 48]
	push [rbp - 56]
	call ASCIIStringToXmm
	movaps xmm5,xmm0

	;-------y2
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message13
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 32
	lea r9, qword ptr [rbp - 56]
	push 0
	call ReadConsoleA

	cmp qword ptr [rbp - 56], 32
	jle @continue17
	mov qword ptr [rbp - 56], 32
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

	push [rbp - 48]
	push [rbp - 56]
	call ASCIIStringToXmm
	movaps xmm6,xmm0

	;-------y3
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset Message14
	mov r8, 12
	lea r9, [rbp - 56]
	push 0
	call WriteConsoleA

	mov rcx, qword ptr [rbp - 16]
	lea rdx, [rbp - 48]
	mov r8, 32
	lea r9, qword ptr [rbp - 56]
	push 0
	call ReadConsoleA

	cmp qword ptr [rbp - 56], 32
	jle @continue18
	mov qword ptr [rbp - 56], 32
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

	push [rbp - 48]
	push [rbp - 56]
	call ASCIIStringToXmm
	movaps xmm7,xmm0
	movaps xmm0,xmm8
	jmp @end

	@error:
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset ErrorMessage1
	mov r8, 34
	lea r9, [rbp - 40]
	push 0
	call WriteConsoleA
	jmp @end

	@error1:
	mov rcx, qword ptr [rbp - 8]
	mov rdx, offset ErrorMessage2
	mov r8, 45
	lea r9, [rbp - 40]
	push 0
	call WriteConsoleA

	@end:
	xor rcx, rcx
	call ExitProcess
	pop rbp
	ret
main endp

ASCIIStringToXmm proc
	push rbp
	mov rbp, rsp
	mov rcx, [rbp + 16]
	;movdqu xmm1, xmmword ptr [rbp + 16]
	;movdqu xmm2, xmmword ptr [rbp + 32]
	xorpd xmm0, xmm0

	shr rcx, 1
	lea rsi, byte ptr [rbp + 24]
	@loop12:
	xor dl, dl
	lodsb
	shl al, 4
	or dl, al
	lodsb
	or dl, al
	pslldq xmm0, 1
	pinsrb xmm0, edx, 0h
	loop @loop12

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
	orm xmm0, xmm4, xmm12
	orm xmm1, xmm5, xmm13
	orm xmm2, xmm6, xmm14
	orm xmm3, xmm7, xmm15

	movd rdx, xmm8
	movd r11, xmm12
	call @dummy1
	@dummy1:
	pop r10
	;lea r10, [rip]
	inc rax
	jmp @init_loop
	pinsrq xmm0, rax, 0h
	mov rax, r12
	
	;movhpd xmm4, xmm8
	pextrq rdx, xmm4, 1h
	;movd rdx, xmm4
	;movhpd xmm4, xmm12
	pextrq r11, xmm4, 1h
	;movd r11, xmm4
	call @dummy2
	@dummy2:
	pop r10
	;lea r10, [rip]
	inc r10
	jmp @init_loop
	pinsrq xmm0, rax, 1h 
	mov rax, r12

	movd rdx, xmm9
	movd r11, xmm13
	call @dummy3
	@dummy3:
	pop r10
	;lea r10, [rip]
	inc r10
	jmp @init_loop
	pinsrq xmm1, rax, 0h
	;movlpd xmm1, rax 
	mov rax, r12

	;movhpd xmm4, xmm9
	pextrq rdx, xmm4, 1h
	;movd rdx, xmm4
	;movhpd xmm4, xmm13
	pextrq rdx, xmm4, 1h
	;movd r11, xmm4
	call @dummy4
	@dummy4:
	pop r10
	;lea r10, [rip]
	inc r10
	jmp @init_loop
	;movhpd xmm1, rax 
	pinsrq xmm1, rax, 1h
	mov rax, r12

	movd rdx, xmm10
	movd r11, xmm14
	call @dummy5
	@dummy5:
	pop r10
	;lea r10, [rip]
	inc r10
	jmp @init_loop
	;movlpd xmm2, rax 
	pinsrq xmm2, rax, 0h
	mov rax, r12


	;movhpd xmm4, xmm10
	;movd rdx, xmm4
	pextrq rdx, xmm4, 1h
	;movhpd xmm4, xmm14
	;movd r11, xmm4
	pextrq r11, xmm4, 1h
	call @dummy6
	@dummy6:
	pop r10
	;lea r10, [rip]
	inc r10
	jmp @init_loop
	pinsrq xmm2, rax, 1h
	;movhpd xmm2, rax 
	mov rax, r12

	movd rdx, xmm11
	movd r11, xmm15
	call @dummy7
	@dummy7:
	pop r10
	;lea r10, [rip]
	inc r10
	jmp @init_loop
	pinsrq xmm3, rax, 0h
	;movlpd xmm3, rax 
	mov rax, r12

	;movhpd xmm4, xmm11
	;movd rdx, xmm4
	;movhpd xmm4, xmm15
	;movd r11, xmm4
	pextrq rdx, xmm4, 1h
	pextrq r11, xmm4, 1h
	xor rax, rax
	jmp @init_loop
	pinsrq xmm3, rax, 1h
	;movhpd xmm3, rax 
	mov rax, r12

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
	mov r12, r11
	and r12, rax
	or r12, rdx
	mov r13, 8000000000000000h
	and r12, r13
	rcl r12, 1		

	test r10, 0ffffffffffffffffh
	je @exit
	jmp r10
	@exit:

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
	pslldq xmm8, 1			
	pslldq xmm10, 1
	andps xmm9, xmm8
	andps xmm10, xmm9 
	orps xmm7, xmm10
	loop @loop1

	movaps xmm10, xmm6
	movaps xmm8, xmm2
	mov rcx, 128
	@loop2:
	pslldq xmm8, 1			
	pslldq xmm10, 1
	andps xmm9, xmm8
	andps xmm10, xmm9 
	orps xmm7, xmm10
	loop @loop2

	movaps xmm10, xmm5
	movaps xmm8, xmm1
	mov rcx, 128
	@loop3:
	pslldq xmm8, 1			
	pslldq xmm10, 1
	andps xmm9, xmm8
	andps xmm10, xmm9 
	orps xmm7, xmm10
	loop @loop3

	movaps xmm10, xmm4
	movaps xmm8, xmm0
	mov rcx, 128
	@loop4:
	pslldq xmm8, 1			
	pslldq xmm10, 1
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
	cmp rax, 07h
	je @switch + 154
	cmp rax, 08h
	je @switch + 160
	cmp rax, 09h
	je @switch + 166
	cmp rax, 0Ah
	je @switch + 72
	cmp rax, 0Bh
	je @switch + 80
	cmp rax, 0Ch
	je @switch + 88
	cmp rax, 0Dh
	je @switch + 96
	cmp rax, 0Eh
	je @switch + 104
	cmp rax, 0Fh
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
	andnpd xmm0, xmm4
	andnpd xmm1, xmm5
	andnpd xmm2, xmm6
	andnpd xmm3, xmm7
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
	xorpd xmm0, xmm0
	xorpd xmm1, xmm1
	xorpd xmm2, xmm2
	xorpd xmm3, xmm3
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
	xorm xmm0,xmm0,xmm0
	xorm xmm1,xmm1,xmm1
	xorm xmm2,xmm2,xmm2
	xorm xmm3,xmm3,xmm3
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
	xorm xmm4, xmm4, xmm4
	notm xmm4, xmm4 
	xorm xmm5, xmm5, xmm5
	notm xmm5, xmm5
	xorm xmm6, xmm6, xmm6
	notm xmm6, xmm6
	xorm xmm7, xmm7, xmm7
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
	jmp @end_switch

	;(xy)-1
	andm xmm0, xmm4, xmm0
	andm xmm1, xmm4, xmm1
	andm xmm2, xmm4, xmm2
	andm xmm3, xmm4, xmm3
	xorpd xmm4, xmm4
	notm xmm4, xmm4 
	xorpd xmm5, xmm5
	notm xmm5, xmm5
	xorpd xmm6, xmm6
	notm xmm6, xmm6
	xorpd xmm7, xmm7
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
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

	xorpd xmm4, xmm4
	notm xmm4, xmm4 
	xorpd xmm5, xmm5
	notm xmm5, xmm5
	xorpd xmm6, xmm6
	notm xmm6, xmm6
	xorpd xmm7, xmm7
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
	
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
	
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
	
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
	
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
	
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
	
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
	jmp @end_switch

	;x+x+1
	movaps xmm8,xmm0
	movaps xmm9,xmm1
	movaps xmm10, xmm2
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
	
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
	
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
	
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
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
	orm xmm12, xmm0, xmm0
	orm xmm13, xmm1, xmm1
	orm xmm14, xmm2, xmm2
	orm xmm15, xmm3, xmm3
	jmp @end_switch

	@end_switch:
	pop rbp
	ret
ALU endp

end