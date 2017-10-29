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

		it 'Returns price for AA'
			clear_b
			load_items	'AA'

			call	price

			assert_b_equal	100


		it 'Returns price for ABC'
			clear_b
			load_items	'ABC'

			call	price

			assert_b_equal	100

			spec_end

single_price		proc	; The single price routine
				; ------------------------
				; Input: HL = item address
				; Output: B = price
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

price			proc	; The price routine
				; -----------------
				; Input: HL = items start address, DE = items length
				; Output: B = total price
			local	loop
			ld	a,e	; Prepare to check items length
			cp	0	; Is items length zero?
			jr	nz,check_item	; Check item if length non-zero
			ld	b,0	; Return early 0 if so.
			ret
check_item		ld	b,e	; B = string length
			ld	a,0	; Accumulator set to 0
loop			push	bc	; Save B
			push	af
			call	single_price	; Get price of item in HL; store in B
			pop	af
			add	a,b	; Add B to accumulator
			pop	bc	; Restore B
			inc	hl	; Next char
			djnz	loop	; Decrement B; loop when != 0
			ld	b,a	; Copy A (total price) into B
			ret
			endp

			end	8000h