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

clear_b			macro
			ld	b,$FF		; Set B to something other than a valid price
			endm			

load_items		macro	items		; Loads item string.
						; Output: HL = start, DE = length
			local	_start, _end
			jp	_end
_start			db	items
_end			equ	$
			ld	hl,_start
			ld	de,_end-_start
			endm

	describe 'price'
		it 'Returns 0 for no items'
			clear_b
			ld	hl,0		; Any mem address
			ld	de,0		; Zero length items

			call	price

			assert_b_equal	0

		it 'Returns price for item A'
			clear_b
			load_items	'A'

			call	price

			assert_b_equal	50

		it 'Returns price for item B'
			clear_b
			load_items	'B'

			call	price

			assert_b_equal	30

		it 'Returns price for item C'
			clear_b
			load_items	'C'

			call	price

			assert_b_equal	20

			spec_end

price			proc	; The price routine
				; -----------------
				; Input: HL = items start address, DE = items length
				; Output: A = total price
			ld	a,(hl)		; Load first char
			cp	'A'		; Is A?
			ld	b,50		; Load up return value
			ret	z		; Return if A.
			cp	'B'		; Otherwise, is B?
			ld	b,30		; Load up return value
			ret	z		; Return if B.
			cp	'C'		; Otherwise, is C?
			ld	b,20		; Load up return value
			ret	z		; Return if C
			ld	b,0		; Otherwise, return 0
			ret
			endp

			end	8000h