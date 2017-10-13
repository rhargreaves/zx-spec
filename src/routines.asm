; Routines
inc_pass		ld		hl,num_pass
			inc		(hl)
			print_char	period
			ret

inc_fail		ld		hl,num_fail
			inc		(hl)
			print_char	cross
			ret

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
