			org	8000h

include src/zx-spec.asm

			spec_init

		it 'assert_a_equals fails for different value'

			ld	a,5
			assert_a_equals 255

		it 'assert_a_not_equals fails for same value'

			ld	a,5
			assert_a_not_equals 5

		it 'assert_a_is_zero fails for non-zero'

			ld	a,255
			assert_a_is_zero

		it 'assert_a_is_not_zero fails for zero'

			ld	a,0
			assert_a_is_not_zero

			spec_end

			ret
			end	8000h
