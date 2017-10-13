
assert_pass		macro
			call	inc_pass
			endm

assert_fail		macro
			call	inc_fail
			ld	de,(cur_test_name_addr)		; text address
			ld	bc,(cur_test_name_len)		; string length
			call	pr_string			; print string
			endm

assert_a_equals		macro	val			
local 			passes, done
			cp	val		; does A = val?
			jp	z,passes	; pass if so
			assert_fail		; otherwise, fail
			jp	done
passes			assert_pass
done
			endm

assert_a_not_equals	macro	val
local 			passes, done
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