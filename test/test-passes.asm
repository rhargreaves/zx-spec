			org	8000h

include src/zx-spec.asm

			spec_init

test_assert_a_equals:

			ld	a,5
			assert_a_equals 5

test_assert_a_not_equals:

			ld	a,0
			assert_a_not_equals 5

test_assert_a_is_zero:

			ld	a,0
			assert_a_is_zero

			spec_end

			ret
			end	8000h
