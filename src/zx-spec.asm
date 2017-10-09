; Constants
prog_start	equ	8000h

; Start
		org	prog_start

proc
init		call	0dafh		; clear screen
		ld	a,2		; Upper screen
		call	1601h		; open channel
		ld	de,banner_txt	; text address
		ld	bc,banner_txt_end-banner_txt	; string length
		call	203ch		; print string
endp
		ret

banner_txt	defb	'ZX Spec - The TDD Framework'
banner_txt_end	equ	$

		end	prog_start
