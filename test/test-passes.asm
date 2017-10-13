			org	8000h

include src/zx-spec.asm

			spec_init

		it 'assert_pass passes test'

			assert_pass

		it 'assert_a_equals works for same value'

			ld	a,5
			assert_a_equals 5

		it 'assert_a_not_equals works for different value'

			ld	a,0
			assert_a_not_equals 5

		it 'assert_a_is_zero works for zero'

			ld	a,0
			assert_a_is_zero

		it 'assert_a_is_not_zero works for non-zero'

			ld	a,5
			assert_a_is_not_zero

			spec_end

			ret
			end	8000h
