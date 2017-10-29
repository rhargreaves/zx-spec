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

clear_a			macro
			ld	a,$FF		; Set A to something other than a valid price
			endm			

	describe 'price'
		it 'Returns 0 for no items'

			clear_a
			ld	hl,0		; Any mem address
			ld	de,0		; Zero length items

			call	price

			assert_a_equal	0

		it 'Returns price for item A'

			proc
			local	items, items_end
			clear_a
			ld	hl,items		; Items string start address
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
			ld	a,(hl)		; Load first char
			cp	'A'		; Is A?
			jr	z,ret_50	; Return 50 if so
ret_0			ld	a,0		; Otherwise, return 0
			ret
ret_50			ld	a,50
			ret
			endp

			end	8000h