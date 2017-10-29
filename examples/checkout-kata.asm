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
			clear_a
			ld	hl,0		; Any mem address
			ld	de,0		; Zero length items

			call	price

			assert_a_equal	0

		it 'Returns price for item A'
			clear_a
			load_items	'A'

			call	price

			assert_a_equal	50

		it 'Returns price for item B'
			clear_a
			load_items	'B'

			call	price

			assert_a_equal	30

		it 'Returns price for item C'
			clear_a
			load_items	'C'

			call	price

			assert_a_equal	20

			spec_end

price			proc	; The price routine
				; -----------------
				; Input: HL = items start address, DE = items length
				; Output: A = total price
			ld	a,(hl)		; Load first char
			cp	'A'		; Is A?
			jr	z,ret_A		; Return price for A
			cp	'B'		; Otherwise, is B?
			jr	z,ret_B		; Return price for B
			cp	'C'		; Otherwise, is C?
			jr	z,ret_C		; Return price for C
			ld	a,0		; Otherwise, return 0
			ret
ret_A			ld	a,50
			ret
ret_B			ld	a,30
			ret
ret_C			ld	a,20
			ret
			endp

			end	8000h