
assert_pass		macro
			call	assert_pass_r
			endm

assert_fail		macro
			call	assert_fail_r
			endm

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