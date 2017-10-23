			org	8000h
display_numbers_as_hex	equ	$FF

include src/zx-spec.asm

			spec_init

	describe 'assert_byte_equal'
		it 'fails for different value'
			assert_byte_equal tmp_2, $34

	describe 'assert_word_equal'
		it 'fails for different value'
			assert_word_equal tmp_1, $0000
			assert_word_equal tmp_1, $ACDC

			spec_end

			ret
tmp_1			dw	$FFFF
tmp_2			db	$12
			end	8000h
