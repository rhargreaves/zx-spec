			org	8000h

include src/zx-spec.asm

			spec_init

test_a_equals_max:
			ld	a,255
			assert_a_equals 5

test_a_equals_min:
			ld	a,-254
			assert_a_equals 5

test_a_is_zero_max:
			ld	a,255
			assert_a_is_zero

test_a_is_zero_min:
			ld	a,-254
			assert_a_is_zero

			spec_end

			ret
			end	8000h
