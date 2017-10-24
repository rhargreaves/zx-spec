; ROM Routine Addresses
_zxspec_rom_cl_all		equ	0dafh		; clear screen
_zxspec_rom_chan_open		equ	1601h		; open channel
_zxspec_rom_pr_string		equ	203ch		; print string (DE = start, BC = length)
_zxspec_rom_stack_bc		equ	2d2bh
_zxspec_rom_print_fb		equ	2de3h		; Print FP number
_zxspec_rom_border_int		equ	229bh		; Set border colour

; System Variable Addresses
attr_p			equ	5c8dh		; permanent set colours

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
comma			equ	','
d_quote			equ	$22		; double quote

; Border Constants
border_port		equ	0feh
red_border		equ	2
green_border		equ	4

; Printing
print_text		macro	txt_start, txt_end 	; Prints text
			print_text_with_len	txt_start,txt_end-txt_start
			endm

print_text_with_len	macro	txt_start, txt_len	; Supports NN or (NN)
			push	de
			push	bc
			ld	de,txt_start		; text address
			ld	bc,txt_len		; string length
			push	af
			call	_zxspec_rom_pr_string		; print string
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
			ld		hl,_zxspec_num_fail
			ld		c,(hl)
			ld		hl,_zxspec_num_pass
			ld		a,(hl)
			add		a,c
			ld		b,0
			ld		c,a
			call		print_bc_as_dec	; print number of total tests
			endm

print_summary		proc
			local	set_fail_colour, print_line
			print_newline
			ld	a,(_zxspec_num_fail)
			cp	0
			jr	nz, set_fail_colour
			print_text	_zxspec_text_pass_ink, _zxspec_text_pass_ink_end
			jr	print_line
set_fail_colour		print_text	_zxspec_text_fail_ink, _zxspec_text_fail_ink_end
print_line		print_text	_zxspec_text_pass, _zxspec_text_pass_end
			print_value	_zxspec_num_pass	; print number of passing tests		
			print_text	_zxspec_text_fail, _zxspec_text_fail_end
			print_value	_zxspec_num_fail	; print number of failing tests
			print_text	_zxspec_text_total, _zxspec_text_total_end
			print_total
			print_newline
			ret
			endp

print_zx_spec_test_end	macro
			print_text	_zxspec_text_exit, _zxspec_text_exit_end
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
			call	_zxspec_rom_stack_bc
			call	_zxspec_rom_print_fb
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

print_num_in_c		proc
			if defined display_numbers_as_hex
				push	af
				call	print_c_as_hex
				pop	af
			else
				push	bc
				ld	b,0
				call	print_bc_as_dec
				pop	bc
			endif
			ret
			endp			

print_hl_as_hex		proc
			local	conv
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

print_bytes		macro	start, length
			local	loop, done
			ld	b,length	; B = length
			ld	hl,start	; HL = start
			call	print_bytes_r			
			endm

print_bytes_r		proc			; Input: HL = start addr, B = length
			local	loop, done
loop			ld	a,(hl)		; A = current byte
			ld	c,a		; Copy A into C
			call	print_c_as_hex	; Print C
			ld	a,b		; Load length into accumulator
			cp	1		; Is 1?
			jr	z,done		; If 1 - we're done
			print_char	comma	; Print comma otherwise
			inc	hl		; Next byte
			djnz	loop
done			ret		
			endp			

normal_ink		macro
			print_text _zxspec_text_normal_ink, _zxspec_text_normal_ink_end
			endm

pass_ink		macro
			print_text _zxspec_text_pass_ink, _zxspec_text_pass_ink_end
			endm

fail_ink		macro
			print_text _zxspec_text_fail_ink, _zxspec_text_fail_ink_end
			endm

; Border Painting
paint_border		macro	colour
			push	af
			ld	a,colour
			out	(border_port),a
			pop	af
			endm

update_border		macro
local			update_border_end
			push	af
			ld	a,(_zxspec_num_fail)
			cp	0
			jp	nz,update_border_end
			paint_border	green_border
update_border_end	equ	$
			pop	af
			endm					