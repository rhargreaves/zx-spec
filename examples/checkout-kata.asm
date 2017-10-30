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

load_items		macro	items		; Loads item string.
						; Output: HL = start, DE = length
			local	_start, _end
			jp	_end
_start			db	items
_end			equ	$
			ld	hl,_start
			ld	de,_end-_start
			endm

reset_item_count	macro			; Resets item counts for items A->D
			ld	a,0
			ld	(item_counts),a
			ld	(item_counts+1),a
			ld	(item_counts+2),a
			ld	(item_counts+3),a
			endm

	describe 'price'
		it 'Returns 0 for no items'
			ld	hl,0		; Any mem address
			ld	de,0		; Zero length items

			call	price

			assert_b_equal	0

		it 'Returns price for item A'
			load_items	'A'

			call	price

			assert_b_equal	50

		it 'Returns price for item B'
			load_items	'B'

			call	price

			assert_b_equal	30

		it 'Returns price for item C'
			load_items	'C'

			call	price

			assert_b_equal	20

		it 'Returns price for item D'
			load_items	'D'

			call	price

			assert_b_equal	15

		it 'Returns price for AA'
			load_items	'AA'

			call	price

			assert_b_equal	100


		it 'Returns price for ABCD'
			load_items	'ABCD'

			call	price

			assert_b_equal	115

		; it 'Adds deduction for AAA'
		; 	load_items	'AAA'

		; 	call	price

		; 	assert_b_equal	130

	describe 'inc_item'
		reset_item_count

		it 'Increments item count for AA'
			load_items	'A'
			
			call	inc_item
			call	inc_item

			assert_byte_equal item_counts, 2

		it 'Increments item count for B'
			load_items	'B'
			
			call	inc_item

			assert_byte_equal item_counts+1, 1				

			spec_end

price			proc	; The price routine
				; -----------------
				; Input: HL = items start address, DE = items length
				; Output: B = total price
			call	subtotal_prices
			ret
			endp

subtotal_prices		proc	; The sub-total price routine
				; Calculates cost of all items pre-deductions
				; --------------------------------------------------
				; Input: HL = items start address, DE = items length
				; Output: B = total price
			local	loop
			ld	a,e		; Prepare to check items length
			cp	0		; Is items length zero?
			jr	nz,check_item	; Check item if length non-zero
			ld	b,0		; Return early 0 if so.
			ret
check_item		ld	b,e		; B = string length
			ld	a,0		; Accumulator set to 0
loop			push	bc
			push	af
			call	inc_item	; Increment item count
			call	unit_price	; Get price of item in HL; store in B
			pop	af
			add	a,b		; Add B to accumulator
			pop	bc
			inc	hl		; Next char
			djnz	loop		; Decrement B; loop when != 0
			ld	b,a		; Copy A (total price) into B
			ret
			endp

inc_item		proc	; Increment item count
				; --------------------
				; Input: HL = item address
				; Output: <none>
			push	hl
			ld	a,(hl)		; Load char into acc.
			sub	'A'		; Convert item into index (A = 0, B = 1, C = 2...)
			ld	b,0
			ld	c,a
			ld	hl,item_counts	; HL = mem address of top of item counts
			add	hl,bc		; HL = mem address of item count
			inc	(hl)		; Increment item count
			pop	hl
			ret
			endp

unit_price		proc	; The unit price routine
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
			cp	'D'		; Otherwise, is D?
			ld	b,15		; Load up return value
			ret	z		; Return if D
			ld	b,0		; Otherwise, return 0
			ret
			endp

item_counts		equ	$		

			end	8000h