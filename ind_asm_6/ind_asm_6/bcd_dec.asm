.686
.model flat

.stack

notm macro x
	not x
	and x, 1h
endm

.code
_bcdDec proc
	push ebp
	mov ebp, esp
	notm dword ptr [ebp + 8]
	notm dword ptr [ebp + 12]
	notm dword ptr [ebp + 16]
	notm dword ptr [ebp + 20]
	mov eax, [ebp + 8]

	;x0
	notm eax
	shl eax, 1
	or eax, [ebp + 8]
	mov edx, eax
	shl eax, 2
	or eax, edx
	mov edx, eax
	shl eax, 4
	or eax, edx
	shl eax, 2
	or eax, edx

	;x1
	mov ebx, [ebp + 12]
	mov edx, ebx
	shl ebx, 1
	or ebx, edx
	mov edx, ebx
	mov ecx, edx
	not edx
	and edx, 3h
	shl ebx, 2
	or ebx, edx
	mov edx, ebx
	shl ebx, 4
	or ebx, edx
	shl ebx, 2
	or ebx, ecx

	;x2
	mov ecx, [ebp + 16]
	mov edx, ecx
	shl ecx, 1
	or ecx, edx
	mov edx, ecx
	shl ecx, 2
	not edx
	and edx, 3h
	or ecx, edx
	shl ecx, 2
	or ecx, edx
	mov edx, ecx
	not edx
	and edx, 0Fh
	shl ecx, 4
	or ecx, edx

	push eax
	;x3
	mov edx, [ebp + 20]
	notm edx
	mov eax, edx
	shl edx, 1
	or edx, eax
	mov eax, edx
	not eax
	and eax, 3h
	shl edx, 2
	or edx, eax
	shl edx, 2
	or edx, eax
	shl edx, 2
	or edx, eax
	shl edx, 2
	or edx, eax
	
	pop eax
	and eax, ebx
	and eax, ecx
	and eax, edx
	not eax
	and eax, 3FFh

	pop ebp
	ret
_bcdDec endp
end
