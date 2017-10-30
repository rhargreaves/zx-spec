; Based on http://codekata.com/kata/kata09-back-to-the-checkout/

;   Item    Unit     Special
;           Price    Price
;   --------------------------
;     A     50       3 for 130
;     B     30       2 for 45
;     C     20
;     D     15

			org	8000h

zxspec_config_verbose_output	equ	$FF
include src/zx-spec.asm

reset_item_count	macro			; Resets item counts for items A->D
			ld	a,0
			rept	4, index
			ld	(item_counts+index),a
			endm
			endm

load_items		macro	items		; Loads item string.
						; Output: HL = start, DE = length
			local	_start, _end
			reset_item_count
			jp	_end
_start			db	items
_end			equ	$
			ld	hl,_start
			ld	de,_end-_start
			endm

			spec_init

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

		it 'Applies discount for AAA'
			load_items	'AAA'

			call	price

			assert_b_equal	130

		it 'Applies discount for AAAA'
			load_items	'AAAA'

			call	price

			assert_b_equal	180

		it 'Applies discount for BB'
			load_items	'BB'

			call	price

			assert_b_equal	45

		it 'Applies discounts for AAABB'
			load_items	'AAABB'

			call	price

			assert_b_equal	175

		it 'Applies discounts for BBBB'
			load_items	'BBBB'

			call	price

			assert_b_equal	90							

	describe 'inc_item'
		it 'Increments item count for AA'
			load_items	'A'
			
			call	inc_item
			call	inc_item

			assert_byte_equal item_counts, 2

		it 'Increments item count for B'
			load_items	'B'
			
			call	inc_item

			assert_byte_equal item_counts, 0
			assert_byte_equal item_counts+1, 1

		it 'Does not apply discount for AA'
			load_items	'A'
			
			ld	b,50
			call	inc_item
			call	inc_item

			assert_b_equal 50
	
		it 'Applies discount for AAA'
			load_items	'A'
			
			ld	b,50
			call	inc_item
			call	inc_item
			call	inc_item

			assert_b_equal 30			

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
			call	unit_price	; Get price of item in HL; store in B
			call	inc_item	; Increment item count; deduct discounts from B		
			pop	af
			add	a,b		; Add B to accumulator
			pop	bc
			inc	hl		; Next char
			djnz	loop		; Decrement B; loop when != 0
			ld	b,a		; Copy A (total price) into B
			ret
			endp

apply_any_discount	macro	item_index, threshold, discount
			local	done
			ld	a,(hl)		; Load item count into acc
			cp	threshold	; Is at threshold for discount?
			jr	nz,done		; No? We're done.
			ld	a,b		; Load total price into A
			sub	discount	; Discount item
			ld	b,a		; Store total price back into B
			ld	a,0
			ld	(item_counts+item_index),a	; Reset A item count to 0.
done			equ	$
			endm

inc_item		proc	; Increment item count & apply any discount
				; -----------------------------------------
				; Input: HL = item address
				; Output: B = total price minus any deductions
			local	done
			push	hl
			ld	a,(hl)		; Load char into acc.
			sub	'A'		; Convert item into index (Item A = 0, B = 1, C = 2...)
			push	bc
			ld	b,0
			ld	c,a
			ld	hl,item_counts	; HL = mem address of top of item counts
			add	hl,bc		; HL = mem address of item count
			pop	bc
			inc	(hl)		; Increment item count
			; From here: A = Item Index, (HL) = Item Count
			cp	0
			jr	z,is_a		; Is A?
			cp	1
			jr	z,is_b		; Is B?
			jr	done		; Otherwise, apply no discount
is_a			apply_any_discount	0, 3, 20
			jr	done
is_b			apply_any_discount	1, 2, 15
			jr	done			
done			pop	hl
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

item_counts		db	0,0,0,0		; Enough room for 4 item SKUs :o

			end	8000h