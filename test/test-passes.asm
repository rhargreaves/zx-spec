			org	8000h

include src/zx-spec.asm

			spec_init

	describe 'assert_pass'
		it 'passes test'
			assert_pass

	describe 'assert_hl_equals'
		it 'passes for same value'
			ld	hl,$0102
			assert_hl_equals $0102

		it "doesn't affect value of hl"
			ld	hl,$0102
			assert_hl_equals $0102
			assert_hl_equals $0102

	describe 'assert_bc_equals'
		it 'passes for same value'
			ld	bc,$0102
			assert_bc_equals $0102

		it "doesn't affect value of bc"
			ld	bc,$0102
			assert_bc_equals $0102
			assert_bc_equals $0102

	describe 'assert_de_equals'
		it 'passes for same value'
			ld	de,$0102
			assert_de_equals $0102

		it "doesn't affect value of de"
			ld	de,$0102
			assert_de_equals $0102
			assert_de_equals $0102					

	describe 'assert_a_equals'
		it 'passes for same value'
			ld	a,5
			assert_a_equals 5

		it "doesn't affect value of a"
			ld	a,5
			assert_a_equals 5	
			assert_a_equals 5

	describe 'assert_b_equals'
		it 'passes for same value'
			ld	b,5
			assert_b_equals 5

		it "doesn't affect value of b"
			ld	b,5
			assert_a_equals 5		
			assert_a_equals 5
			
	describe 'assert_c_equals'
		it 'passes for same value'
			ld	c,5
			assert_c_equals 5

		it "doesn't affect value of c"
			ld	c,5
			assert_a_equals 5		
			assert_a_equals 5

	describe 'assert_d_equals'
		it 'passes for same value'
			ld	d,5
			assert_d_equals 5

		it "doesn't affect value of d"
			ld	d,5
			assert_d_equals 5		
			assert_d_equals 5

	describe 'assert_e_equals'
		it 'passes for same value'
			ld	e,5
			assert_e_equals 5

		it "doesn't affect value of e"
			ld	e,5
			assert_e_equals 5		
			assert_e_equals 5

	describe 'assert_h_equals'
		it 'passes for same value'
			ld	h,5
			assert_h_equals 5

		it "doesn't affect value of h"
			ld	h,5
			assert_h_equals 5		
			assert_h_equals 5

	describe 'assert_l_equals'
		it 'passes for same value'
			ld	l,5
			assert_l_equals 5

		it "doesn't affect value of l"
			ld	l,5
			assert_l_equals 5		
			assert_l_equals 5

	describe 'assert_a_not_equals'
		it 'passes for different value'
			ld	a,0
			assert_a_not_equals 5

	describe 'assert_b_not_equals'
		it 'passes for different value'
			ld	b,0
			assert_b_not_equals 5

	describe 'assert_c_not_equals'
		it 'passes for different value'
			ld	c,0
			assert_c_not_equals 5

	describe 'assert_d_not_equals'
		it 'passes for different value'
			ld	d,0
			assert_d_not_equals 5

	describe 'assert_e_not_equals'
		it 'passes for different value'
			ld	e,0
			assert_e_not_equals 5

	describe 'assert_h_not_equals'
		it 'passes for different value'
			ld	h,0
			assert_h_not_equals 5

	describe 'assert_l_not_equals'
		it 'passes for different value'
			ld	l,0
			assert_l_not_equals 5

	describe 'assert_hl_not_equals'
		it 'passes for different value'
			ld	hl,$0002
			assert_hl_not_equals $0103

	describe 'assert_bc_not_equals'
		it 'passes for different value'
			ld	bc,$0002
			assert_bc_not_equals $0103

	describe 'assert_de_not_equals'
		it 'passes for different value'
			ld	de,$0002
			assert_de_not_equals $0103							

	describe 'assert_a_is_zero'
		it 'passes for zero'
			ld	a,0
			assert_a_is_zero

	describe 'assert_a_is_not_zero'
		it 'passes for non-zero'
			ld	a,5
			assert_a_is_not_zero

			spec_end

			ret
			end	8000h
