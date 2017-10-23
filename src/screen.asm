; ROM Routines
cl_all			equ	0dafh		; clear screen
chan_open		equ	1601h		; open channel
pr_string		equ	203ch		; print string (DE = start, BC = length)
stack_bc		equ	2d2bh
print_fb		equ	2de3h		; Print FP number

; System Variables
attr_p			equ	5c8dh		; permanent set colours
attr_t			equ	5c8fh		; temporary set colours

; Stream Constants
screen_stream		equ	2
printer_stream		equ	3
if defined zx_spec_test_mode			; Definable via Pasmo command line
	output_stream	equ	printer_stream
else
	output_stream	equ	screen_stream
endif

; Characters
space			equ	' '
nl			equ	13		; New line character
cross			equ	'x'
period			equ	'.'
d_quote			equ	$22		; double quote

; Border Constants
border_port		equ	0feh
red_border		equ	2
green_border		equ	4

; Macros
print_text		macro	txt_start, txt_end 	; Prints text
			print_text_with_len	txt_start,txt_end-txt_start
			endm

print_text_with_len	macro	txt_start, txt_len	; Supports NN or (NN)
			push	de
			push	bc
			ld	de,txt_start		; text address
			ld	bc,txt_len		; string length
			push	af
			call	pr_string		; print string
			pop	af
			pop	bc
			pop	de
			endm

print_value		macro	addr		; Prints value at memory location
			push	hl
			ld	hl,addr
			call	print_value_at_hl
			pop	hl
			endm

print_char		macro	code
			push	af
			ld	a,code
			rst	16
			pop	af
			endm

print_newline		macro
			print_char nl
			endm

print_value_at_hl	push	bc
			ld	b,0
			ld	c,(hl)
			call	print_bc_as_dec
			pop	bc
			ret

print_total		macro
			ld		hl,num_fail
			ld		c,(hl)
			ld		hl,num_pass
			ld		a,(hl)
			add		a,c
			ld		b,0
			ld		c,a
			call		print_bc_as_dec	; print number of total tests
			endm

print_summary		proc
			print_text	ok_txt, ok_txt_end
			print_value	num_pass	; print number of passing tests		
			print_text	fail_txt, fail_txt_end
			print_value	num_fail	; print number of failing tests
			print_text	total_txt, total_txt_end
			print_total
			print_newline
			ret
			endp

set_border_colour	macro	colour
			push	af
			ld	a,colour
			out	(border_port),a
			pop	af
			endm

update_border		macro
local			update_border_end
			push	af
			ld	a,(num_fail)
			cp	0
			jp	nz,update_border_end
			set_border_colour	green_border
update_border_end	equ	$
			pop	af
			endm

print_zx_spec_test_end	macro
			print_text	exit_txt, exit_txt_end
			endm

print_bc_as_hex		proc
			push	hl
			ld	h,b
			ld	l,c
			call	print_hl_as_hex
			pop	hl
			ret
			endp

print_bc_as_dec		proc
			push	af
			push	bc
			push	de
			call	stack_bc
			call	print_fb
			pop	de
			pop	bc
			pop	af
			ret
			endp			

print_num_in_bc		proc
			if defined display_numbers_as_hex
				call	print_bc_as_hex
			else
				call	print_bc_as_dec
			endif
			ret
			endp

print_hl_as_hex		proc
			local	conv, print_c_as_hex
			ld	c,h
			call	print_c_as_hex
			ld	c,l
print_c_as_hex		ld	a,c
			rra
			rra
			rra
			rra
			call	conv
			ld	a,c
conv			and	$0F
			add	a,$90
			daa
			adc	a,$40
			daa
			rst	16
			ret
			endp