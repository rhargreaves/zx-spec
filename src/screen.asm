; ROM Routines
cl_all			equ	0dafh		; clear screen
chan_open		equ	1601h		; open channel
pr_string		equ	203ch		; print string (DE = start, BC = length)
out_num_1		equ	1a1bh		; print line number (BC = number)

; Stream Constants
screen_stream		equ	2
printer_stream		equ	3
if not defined output_stream
	output_stream	equ	screen_stream	; Definable via Pasmo command line
endif

; Characters
space			equ	' '
nl			equ	13		; New line character
cross			equ	'x'
period			equ	'.'

; Border Constants
border_port		equ	0feh
red_border		equ	2
green_border		equ	4

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

print_char		macro	code
			ld	a,code
			rst	16
			endm

print_newline		macro
			print_char nl
			endm

print_value_at_hl	ld	b,0
			ld	c,(hl)
			call	out_num_1
			ret

print_summary		print_text	ok_txt, ok_txt_end
			print_value	num_pass	; print number of passing tests		
			print_text	fail_txt, fail_txt_end
			print_value	num_fail	; print number of failing tests
			print_text	total_txt, total_txt_end
			ld		hl,num_fail
			ld		c,(hl)
			ld		hl,num_pass
			ld		a,(hl)
			add		a,c
			ld		b,0
			ld		c,a
			call		out_num_1	; print number of total tests
			print_text	pause_txt, pause_txt_end
			ret

wait_for_key		proc
local			loop
			ld	hl,23560	; LAST K system variable.
			ld	(hl),0		; put null value there.
loop			ld	a,(hl)		; new value of LAST K.
			cp	0		; is it still zero?
			jr	z,loop		; yes, so no key pressed.
			ret			; key was pressed.
			endp

set_border_colour	macro	colour
			ld	a,colour
			out	(border_port),a
			endm

update_border		macro
local			update_border_end
			ld	a,(num_fail)
			cp	0
			jp	nz,update_border_end
			set_border_colour	green_border
update_border_end	equ	$
			endm