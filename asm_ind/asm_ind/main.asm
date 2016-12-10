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
	andnpd
endm

.data

.code
_global proc
	call main
_global endp

main proc
	push rbp
	mov rbp, rsp
	


	pop rbp
	ret
main endp

f1 proc
	ret
f1 endp

f2 proc
	ret
f2 endp

ALU proc
	push rbp
	mov rbp, rsp
	mov rax, [rpb + 16] 
	test rax, 10h
	je  @continue
	and rax, 1Fh
	@continue:
	
	cmp rax, 10h	
	je @switch
	cmp rax, 11h
	je @switch + 6

	@switch:
	call f1
	jmp @end_switch
	call f2
	jmp @end_switch

	jmp @end_switch


	@end_switch:

	pop rbp
	ret
ALU endp

end _global