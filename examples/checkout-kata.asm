; Based on http://codekata.com/kata/kata09-back-to-the-checkout/

;   Item    Unit     Special
;           Price    Price
;   --------------------------
;     A     50       3 for 130
;     B     30       2 for 45
;     C     20
;     D     15

			org	8000h

include src/zx-spec.asm

			spec_init

	describe 'price'
		it 'Returns 0 for no items'

			ld	a,$FF		; Set A to something other than correct result
			ld	de,0		; Zero length items
			ld	hl,0		; Any mem address

			call	price

			assert_a_equal	0

		it 'Returns price for item A'

			proc
			local	items, items_end
			ld	a,$FF			; Set A to something other than correct result
			ld	hl,(items)		; Items string start address
			ld	de,items_end-items	; Items length (1)

			call	price

			assert_a_equal	50

			jp	items_end
items			db	'A'
items_end		equ	$
			endp

			spec_end			

price			proc	; The price routine
				; -----------------
				; Input: HL = items start address, DE = items length
				; Output: A = total price
			ld	a,0	; Set price to 0
			ret
			endp

			end	8000h