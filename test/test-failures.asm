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

	describe 'assert_a_not_equals'

		it 'fails for same value'

			ld	a,5
			assert_a_not_equals 5

	describe 'assert_a_is_zero'

		it 'fails for non-zero'

			ld	a,255
			assert_a_is_zero

	describe 'assert_a_is_not_zero'

		it 'fails for zero'

			ld	a,0
			assert_a_is_not_zero

			spec_end

			print_zx_spec_test_end
			ret
			end	8000h
