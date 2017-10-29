			org	8000h
zxspec_config_display_numbers_as_hex	equ	$FF

include src/zx-spec.asm

			spec_init

	describe 'assert_byte_equal'
		it 'fails for different value'
			assert_byte_equal tmp_2, $3B

	describe 'assert_word_equal'
		it 'fails for different value'
			assert_word_equal tmp_1, $0000
			assert_word_equal tmp_1, $ACDC

			spec_end

			ret
tmp_1			dw	$FFFF
tmp_2			db	$2A
			end	8000h
