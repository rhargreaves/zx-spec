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

spec_init		macro
			call	cl_all		; clear screen
			ld	a,output_stream	; upper screen
			call	chan_open	; open channel
			endm

set_border_colour	macro
local			set_green_border, set_border
			ld	a,(num_fail)
			cp	0
			jp	z,set_green_border
			ld	a,red_border
			jp	set_border
set_green_border	ld	a,green_border
set_border		out	(border_port),a
			endm

spec_end		macro
			set_border_colour
			call	print_summary
			call	wait_for_key
			endm