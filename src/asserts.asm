
assert_a_equals		macro	val			
local 			passes, done
			cp	val		; does A = val?
			jp	z,passes	; pass if so
			call	inc_fail	; otherwise, fail
			jp	done
passes			call	inc_pass
done
			endm