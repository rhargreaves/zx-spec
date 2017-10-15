			org	8000h

include src/zx-spec.asm

			spec_init

	describe 'assert_pass'

		it 'passes test'

			assert_pass

	describe 'assert_a_equals'

		it 'passes for same value'

			ld	a,5
			assert_a_equals 5

	describe 'assert_b_equals'

		it 'passes for same value'

			ld	b,5
			assert_b_equals 5

	describe 'assert_a_not_equals'
		
		it 'passes for different value'

			ld	a,0
			assert_a_not_equals 5

	describe 'assert_b_not_equals'
		
		it 'passes for different value'

			ld	b,0
			assert_b_not_equals 5

	describe 'assert_a_is_zero'

		it 'passes for zero'

			ld	a,0
			assert_a_is_zero

	describe 'assert_a_is_not_zero'

		it 'passes for non-zero'

			ld	a,5
			assert_a_is_not_zero

			spec_end

			ret
			end	8000h
