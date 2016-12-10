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
_main proc
_main endp
end _main