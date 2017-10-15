			org	8000h

include src/zx-spec.asm

			spec_init

	describe 'assert_fail'

		it 'fails test'

			assert_fail

	describe 'assert_a_equals'

		it 'fails for different value'

			ld	a,5
			assert_a_equals 255

	describe 'assert_b_equals'

		it 'fails for different value'

			ld	b,5
			assert_a_equals 255

	describe 'assert_c_equals'

		it 'fails for different value'

			ld	c,5
			assert_a_equals 255

	describe 'assert_d_equals'

		it 'fails for different value'

			ld	d,5
			assert_d_equals 255

	describe 'assert_e_equals'

		it 'fails for different value'

			ld	e,5
			assert_e_equals 255

	describe 'assert_h_equals'

		it 'fails for different value'

			ld	h,5
			assert_h_equals 255

	describe 'assert_l_equals'

		it 'fails for different value'

			ld	l,5
			assert_l_equals 255

	describe 'assert_a_not_equals'

		it 'fails for same value'

			ld	a,5
			assert_a_not_equals 5

	describe 'assert_b_not_equals'

		it 'fails for same value'

			ld	b,5
			assert_b_not_equals 5

	describe 'assert_c_not_equals'

		it 'fails for same value'

			ld	c,5
			assert_c_not_equals 5

	describe 'assert_d_not_equals'

		it 'fails for same value'

			ld	d,5
			assert_d_not_equals 5

	describe 'assert_e_not_equals'

		it 'fails for same value'

			ld	e,5
			assert_e_not_equals 5

	describe 'assert_h_not_equals'

		it 'fails for same value'

			ld	h,5
			assert_h_not_equals 5

	describe 'assert_l_not_equals'

		it 'fails for same value'

			ld	l,5
			assert_l_not_equals 5

	describe 'assert_a_is_zero'

		it 'fails for non-zero'

			ld	a,255
			assert_a_is_zero

	describe 'assert_a_is_not_zero'

		it 'fails for zero'

			ld	a,0
			assert_a_is_not_zero

			spec_end

			ret
			end	8000h
