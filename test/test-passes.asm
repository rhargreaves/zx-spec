			org	8000h

include src/zx-spec.asm

			spec_init

test_1			ld	a,0
			call	assert_a_is_zero

			spec_end

			ret
			end	8000h
