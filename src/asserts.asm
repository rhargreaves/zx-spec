proc			
local 			passes
assert_a_is_zero	cp	0		; does A = 0?
			jp	z,passes	; pass if so
			call	inc_fail	; otherwise, fail
			ret
passes			call	inc_pass
			ret
endp