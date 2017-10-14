; Routines
assert_pass_r		ld		hl,num_pass
			inc		(hl)
			print_char	period
			ret

assert_fail_r		proc
local			print_group_end
			set_border_colour	red_border	; Set border to red
			ld	hl,num_fail
			inc	(hl)
			print_char	cross
			ld	hl,shown_names
			bit	0,(hl)				; Group name shown already?
			jp	nz,(print_group_end)
			ld	de,(cur_group_name_addr)	; text address
			ld	bc,(cur_group_name_len)		; string length
			ld	a,c
			cp	0				; is group name undefined?
			jp	z,(print_group_end)		; skip printing of name if so
			print_newline
			call	pr_string
			ld	hl,shown_names
			set	0,(hl)				; Set shown group name
print_group_end		print_newline
			print_char space			; indent test name
			ld	de,(cur_test_name_addr)		; text address
			ld	bc,(cur_test_name_len)		; string length
			call	pr_string			; print string
			print_newline
			print_newline
			ret
			endp

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

proc
local			loop
wait_for_key		ld	hl,23560	; LAST K system variable.
			ld	(hl),0		; put null value there.
loop			ld	a,(hl)		; new value of LAST K.
			cp	0		; is it still zero?
			jr	z,loop		; yes, so no key pressed.
			ret			; key was pressed.
endp
