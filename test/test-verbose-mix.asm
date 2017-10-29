			org	8000h
zxspec_config_verbose_output	equ	$FF

include src/zx-spec.asm

			spec_init

	describe 'assert_pass'
		it 'passes test'
			assert_pass

	describe 'assert_a_equal'
		it 'passes for same value'
			ld	a,5
			assert_a_equal 5			

	describe 'assert_a_equal'
		it 'fails for different value'
			ld	a,5
			assert_a_equal 255

		it 'fails again'
			ld	a,5
			assert_a_equal 255

			spec_end

			ret
			end	8000h
