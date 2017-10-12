			org	8000h

include src/zx-spec.asm

			spec_init

test_assert_a_equals:
			ld	a,0
			assert_a_equals 0

			spec_end

			ret
			end	8000h
