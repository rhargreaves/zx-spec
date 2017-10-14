
assert_pass		macro
			call	assert_pass_r
			endm

assert_fail		macro
			call	assert_fail_r
			endm

assert_pass_r		proc
			ld		hl,num_pass
			inc		(hl)
			print_char	period
			ret
			endp
			
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

assert_a_equals		macro	val			
local 			passes, done
			push	af		; store copy of A as it gets overwitten
			cp	val		; does A = val?
			jp	z,passes	; pass if so
			assert_fail		; otherwise, fail
			print_text expected_txt, expected_txt_end
			ld	b,0
			ld	c,val
			call	out_num_1
			print_text actual_txt, actual_txt_end
			pop	af		; restore A for printing actual value
			ld	b,0
			ld	c,a
			call	out_num_1
			print_char	nl
			print_char	nl
			jp	done
passes			assert_pass
done
			endm

assert_a_not_equals	macro	val
local 			passes, done
			push	af
			cp	val		; does A = val?
			jp	nz,passes	; pass if it doesn't
			assert_fail		; otherwise, fail
			jp	done
passes			assert_pass
done
			endm

assert_a_is_zero	macro
			assert_a_equals 0
			endm

assert_a_is_not_zero	macro
			assert_a_not_equals 0
			endm