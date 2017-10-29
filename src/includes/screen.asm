; ROM Routine Addresses
_zxspec_rom_cl_all		equ	0dafh		; clear screen
_zxspec_rom_chan_open		equ	1601h		; open channel
_zxspec_rom_pr_string		equ	203ch		; print string (DE = start, BC = length)
_zxspec_rom_stack_bc		equ	2d2bh
_zxspec_rom_print_fb		equ	2de3h		; Print FP number
_zxspec_rom_border_int		equ	229bh		; Set border colour

; System Variable Addresses
_zxspec_attr_p			equ	5c8dh		; permanent set colours

; Stream Constants
_zxspec_screen_stream		equ	2
_zxspec_printer_stream		equ	3
if defined zxspec_test_mode				; Definable via Pasmo command line
	_zxspec_output_stream	equ	_zxspec_printer_stream
else
	_zxspec_output_stream	equ	_zxspec_screen_stream
endif

; Characters
_space			equ	' '
_nl			equ	13	; New line character
_cross			equ	'x'
_period			equ	'.'
_comma			equ	','
_d_quote		equ	$22	; double quote

; Border Constants
_zxspec_border_port	equ	0feh
_zxspec_red_border	equ	2
_zxspec_green_border	equ	4

; Printing
_print_text		macro	txt_start, txt_end 	; Prints text
			_print_text_with_len	txt_start,txt_end-txt_start
			endm

_print_text_with_len	macro	txt_start, txt_len	; Supports NN or (NN)
			push	de
			push	bc
			ld	de,txt_start		; text address
			ld	bc,txt_len		; string length
			push	af
			call	_zxspec_rom_pr_string	; print string
			pop	af
			pop	bc
			pop	de
			endm

_print_value		macro	addr		; Prints value at memory location
			push	hl
			ld	hl,addr
			push	bc
			ld	b,0
			ld	c,(hl)
			call	_print_bc_as_dec
			pop	bc
			pop	hl
			endm

_print_char		macro	code
			push	af
			ld	a,code
			rst	16
			pop	af
			endm

_print_newline		macro
			_print_char _nl
			endm

_print_total		macro
			ld	hl,_zxspec_num_fail
			ld	c,(hl)
			ld	hl,_zxspec_num_pass
			ld	a,(hl)
			add	a,c
			ld	b,0
			ld	c,a
			call	_print_bc_as_dec	; print number of total tests
			endm

_print_summary		proc
			local	set_fail_colour, print_line
			_print_newline
			ld	a,(_zxspec_num_fail)
			cp	0
			jr	nz, set_fail_colour
			_print_text	_zxspec_text_pass_ink, _zxspec_text_pass_ink_end
			jr	print_line
set_fail_colour		_print_text	_zxspec_text_fail_ink, _zxspec_text_fail_ink_end
print_line		_print_text	_zxspec_text_pass, _zxspec_text_pass_end
			_print_value	_zxspec_num_pass	; print number of passing tests		
			_print_text	_zxspec_text_fail, _zxspec_text_fail_end
			_print_value	_zxspec_num_fail	; print number of failing tests
			_print_text	_zxspec_text_total, _zxspec_text_total_end
			_print_total
			_print_newline
			ret
			endp

_print_zxspec_test_end	macro
			_print_text	_zxspec_text_exit, _zxspec_text_exit_end
			endm

_print_bc_as_hex	proc
			push	hl
			ld	h,b
			ld	l,c
			call	_print_hl_as_hex
			pop	hl
			ret
			endp

_print_bc_as_dec	proc
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

_print_num_in_bc	proc
			if defined zxspec_config_display_numbers_as_hex
				call	_print_bc_as_hex
			else
				call	_print_bc_as_dec
			endif
			ret
			endp

_print_num_in_c		proc
			if defined zxspec_config_display_numbers_as_hex
				push	af
				call	_print_c_as_hex
				pop	af
			else
				push	bc
				ld	b,0
				call	_print_bc_as_dec
				pop	bc
			endif
			ret
			endp			

_print_hl_as_hex	proc
			local	conv
			ld	c,h
			call	_print_c_as_hex
			ld	c,l
_print_c_as_hex		ld	a,c
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

_print_bytes		macro	start, length
			local	loop, done
			ld	b,length	; B = length
			ld	hl,start	; HL = start
			call	_print_bytes_r			
			endm

_print_bytes_r		proc			; Input: HL = start addr, B = length
			local	loop, done
loop			ld	a,(hl)		; A = current byte
			ld	c,a		; Copy A into C
			call	_print_c_as_hex	; Print C
			ld	a,b		; Load length into accumulator
			cp	1		; Is 1?
			jr	z,done		; If 1 - we're done
			_print_char	_comma	; Print _comma otherwise
			inc	hl		; Next byte
			djnz	loop
done			ret		
			endp			

_normal_ink		macro
			_print_text _zxspec_text_normal_ink, _zxspec_text_normal_ink_end
			endm

_pass_ink		macro
			_print_text _zxspec_text_pass_ink, _zxspec_text_pass_ink_end
			endm

_fail_ink		macro
			_print_text _zxspec_text_fail_ink, _zxspec_text_fail_ink_end
			endm

; Border Painting
_paint_border		macro	colour
			push	af
			ld	a,colour
			out	(_zxspec_border_port),a
			pop	af
			endm

_update_border		macro
local			update_border_end
			push	af
			ld	a,(_zxspec_num_fail)
			cp	0
			jp	nz,update_border_end
			_paint_border	_zxspec_green_border
update_border_end	equ	$
			pop	af
			endm					