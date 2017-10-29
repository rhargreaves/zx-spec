; Based on http://codekata.com/kata/kata09-back-to-the-checkout/

			org	8000h

include src/zx-spec.asm

			spec_init

	describe 'price'
		it 'Returns 0 for no items'

			ld	a,$FF
			call	price
			assert_a_equal	0

			spec_end

price			proc
			ret
			endp

			end	8000h