; Constants
prog_start	equ	8000h
stream_scr	equ	2		; screen stream

; ROM Routines
cl_all		equ	0dafh		; clear screen
chan_open	equ	1601h		; open channel
pr_string	equ	203ch		; print string (DE = start, BC = length)
out_num_1	equ	1a1bh		; print line number (BC = number)

; Start
		org	prog_start

proc
init		call	cl_all		; clear screen
		ld	a,stream_scr	; upper screen
		call	chan_open	; open channel
		ld	de,banner_txt	; text address
		ld	bc,banner_txt_end-banner_txt	; string length
		call	pr_string	; print string
		ld	hl,num_pass
		call	pr_hl_val	; print number of passing tests	
endp
		ret

; Routines
pr_hl_val	ld	b,0		; Print byte ref by HL
		ld	c,(hl)
		call	out_num_1
		ret

; State
num_pass	defb	0

; Resources
banner_txt	defb	'ZX Spec - The TDD Framework', 13, 13, 'OK: '
banner_txt_end	equ	$

; End
		end	prog_start
