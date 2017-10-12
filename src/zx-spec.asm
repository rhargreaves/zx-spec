; Constants
prog_start	equ	8000h
stream_scr	equ	2		; screen stream
nl		equ	13		; ASCII New Line

; ROM Routines
cl_all		equ	0dafh		; clear screen
chan_open	equ	1601h		; open channel
pr_string	equ	203ch		; print string (DE = start, BC = length)
out_num_1	equ	1a1bh		; print line number (BC = number)
		
; Macros
pr_res		macro	txt_start, txt_end 	; Prints text
		ld	de,txt_start		; text address
		ld	bc,txt_end-txt_start	; string length
		call	pr_string		; print string
		endm

pr_val		macro	loc		; Prints value at memory location
		ld	hl,loc
		call	pr_hl_val	; print number at HL
		endm

; Start
		org	prog_start

proc
init		call	cl_all		; clear screen
		ld	a,stream_scr	; upper screen
		call	chan_open	; open channel
		pr_res	banner_txt,banner_txt_end
		pr_res	ok_txt,ok_txt_end
		pr_val	num_pass	; print number of passing tests		
		pr_res	fail_txt,fail_txt_end
		pr_val	num_fail	; print number of failing tests		
endp
		ret

; Routines
pr_hl_val	ld	b,0		; Print byte ref by HL
		ld	c,(hl)
		call	out_num_1
		ret

; State
num_pass	db	0
num_fail	db	0

; Resources
banner_txt	db	'ZX Spec - The TDD Framework', nl, nl
banner_txt_end	equ	$
ok_txt		db	'Pass: '
ok_txt_end	equ	$
fail_txt	db	', Fail: '
fail_txt_end	equ	$	

; End
		end	prog_start
