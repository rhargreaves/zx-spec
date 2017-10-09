; Constants
prog_start	equ	8000h
stream_scr	equ	2		; Screen stream

; ROM Routines
cl_all		equ	0dafh
chan_open	equ	1601h
pr_string	equ	203ch

; Start
		org	prog_start

proc
init		call	cl_all		; clear screen
		ld	a,stream_scr	; Upper screen
		call	chan_open	; open channel
		ld	de,banner_txt	; text address
		ld	bc,banner_txt_end-banner_txt	; string length
		call	pr_string	; print string
endp
		ret

banner_txt	defb	'ZX Spec - The TDD Framework'
banner_txt_end	equ	$

		end	prog_start
