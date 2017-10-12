; Constants
program_start		equ	8000h
screen_stream		equ	2
printer_stream		equ	3
;output_stream		equ	screen_stream	; Defined by Pasmo command line
nl			equ	13		; New line character

; ROM Routines
cl_all			equ	0dafh		; clear screen
chan_open		equ	1601h		; open channel
pr_string		equ	203ch		; print string (DE = start, BC = length)
out_num_1		equ	1a1bh		; print line number (BC = number)

; Macros
print_text		macro	txt_start, txt_end 	; Prints text
			ld	de,txt_start		; text address
			ld	bc,txt_end - txt_start	; string length
			call	pr_string		; print string
			endm

print_value		macro	addr		; Prints value at memory location
			ld	hl,addr
			call	print_value_at_hl
			endm

; Start
			org	program_start
init:
			call	cl_all		; clear screen
			ld	a,output_stream	; upper screen
			call	chan_open	; open channel

set_a			ld	a,0

assert_a_is_zero	cp	0		; does A = 0?
			jp	z,test_passes	; pass if so
test_fails		call	inc_fail	; otherwise, fail
			jp	end_test
test_passes		call	inc_pass
			jp	end_test
end_test:

print_summary:
			print_text	banner_txt, banner_txt_end
			print_text	ok_txt, ok_txt_end
			print_value	num_pass	; print number of passing tests		
			print_text	fail_txt, fail_txt_end
			print_value	num_fail	; print number of failing tests		

			ret

; Routines
inc_pass		ld	hl,num_pass
			inc	(hl)
			ret

inc_fail		ld	hl,num_fail
			inc	(hl)
			ret

print_value_at_hl	ld	b,0
			ld	c,(hl)
			call	out_num_1
			ret

; State
num_pass		db	0
num_fail		db	0

; Resources
banner_txt		db	'ZX Spec - The TDD Framework', nl, nl
banner_txt_end		equ	$
ok_txt			db	'Pass: '
ok_txt_end		equ	$
fail_txt		db	', Fail: '
fail_txt_end		equ	$	

; End
		end	program_start
