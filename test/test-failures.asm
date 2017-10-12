			org	8000h

include src/zx-spec.asm

			spec_init

test_a_equals_max:
			ld	a,255
			assert_a_equals 0

test_a_equals_min:
			ld	a,-254
			assert_a_equals 0

			spec_end

			ret
			end	8000h
