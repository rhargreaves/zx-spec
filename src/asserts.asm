
assert_a_equals		macro	val			
local 			passes, done
			cp	val		; does A = val?
			jp	z,passes	; pass if so
			call	inc_fail	; otherwise, fail
			jp	done
passes			call	inc_pass
done
			endm

assert_a_not_equals	macro	val
local 			passes, done
			cp	val		; does A = val?
			jp	nz,passes	; pass if it doesn't
			call	inc_fail	; otherwise, fail
			jp	done
passes			call	inc_pass
done
			endm

assert_a_is_zero	macro
			assert_a_equals 0
			endm

assert_a_is_not_zero	macro
			assert_a_not_equals 0
			endm