			org	8000h

include src/zx-spec.asm

			spec_init

	describe 'assert_fail'
		it 'fails test'
			assert_fail

	describe 'assert_hl_equal'
		it 'fails for different value'
			ld	hl,500
			assert_hl_equal 502
			assert_hl_equal 503

		it 'fails for different value'
			ld	hl,1
			assert_hl_equal 2
			assert_hl_equal 3

	describe 'assert_bc_equal'
		it 'fails for different value'
			ld	bc,500
			assert_bc_equal 502
			assert_bc_equal 503

	describe 'assert_de_equal'
		it 'fails for different value'
			ld	de,500
			assert_de_equal 502
			assert_de_equal 503

	describe 'assert_ix_equal'
		it 'fails for different value'
			ld	ix,$0102
			assert_ix_equal $0103
			assert_ix_equal $0104

	describe 'assert_a_equal'
		it 'fails for different value'
			ld	a,5
			assert_a_equal 250

	describe 'assert_b_equal'
		it 'fails for different value'
			ld	b,5
			assert_a_equal 250

	describe 'assert_c_equal'
		it 'fails for different value'
			ld	c,5
			assert_a_equal 250

	describe 'assert_d_equal'
		it 'fails for different value'
			ld	d,5
			assert_d_equal 250

	describe 'assert_e_equal'
		it 'fails for different value'
			ld	e,5
			assert_e_equal 250

	describe 'assert_h_equal'
		it 'fails for different value'
			ld	h,5
			assert_h_equal 250

	describe 'assert_l_equal'
		it 'fails for different value'
			ld	l,5
			assert_l_equal 250

	describe 'assert_a_not_equal'
		it 'fails for same value'
			ld	a,5
			assert_a_not_equal 5

	describe 'assert_b_not_equal'
		it 'fails for same value'
			ld	b,5
			assert_b_not_equal 5

	describe 'assert_c_not_equal'
		it 'fails for same value'
			ld	c,5
			assert_c_not_equal 5

	describe 'assert_d_not_equal'
		it 'fails for same value'
			ld	d,5
			assert_d_not_equal 5

	describe 'assert_e_not_equal'
		it 'fails for same value'
			ld	e,5
			assert_e_not_equal 5

	describe 'assert_h_not_equal'
		it 'fails for same value'
			ld	h,5
			assert_h_not_equal 5

	describe 'assert_l_not_equal'
		it 'fails for same value'
			ld	l,5
			assert_l_not_equal 5

	describe 'assert_hl_not_equal'
		it 'fails for same value'
			ld	hl,$0102
			assert_hl_not_equal $0102

	describe 'assert_bc_not_equal'
		it 'fails for same value'
			ld	bc,$0102
			assert_bc_not_equal $0102

	describe 'assert_de_not_equal'
		it 'fails for same value'
			ld	de,$0102
			assert_de_not_equal $0102

	describe 'assert_ix_not_equal'
		it 'fails for same value'
			ld	ix,$0102
			assert_ix_not_equal $0102

	describe 'assert_a_is_zero'
		it 'fails for non-zero'
			ld	a,255
			assert_a_is_zero

	describe 'assert_a_is_not_zero'
		it 'fails for zero'
			ld	a,0
			assert_a_is_not_zero

	describe 'assert_mem_equal'
		it 'fails for different value'
			assert_mem_equal  tmp_1, $FF

	describe 'assert_mem_not_equal'
		it 'fails for same value'
			assert_mem_not_equal  tmp_1, $CC

	describe 'assert_word_equal'
		it 'fails for different value'
			assert_word_equal  tmp_2, $0102

	describe 'assert_word_not_equal'
		it 'fails for same value'
			assert_word_not_equal  tmp_2, $0103

	describe 'assert_str_equal'
		it 'fails for different value'
			assert_str_equal  tmp_str, 'diff test string'

	describe 'assert_str_not_equal'
		it 'fails for same value'
			assert_str_not_equal  tmp_str, 'test string'		
								
			spec_end

			ret
tmp_1			db	$CC
tmp_2			dw	$0103
tmp_str			db	'test string'
tmp_str_end		equ	$	
			end	8000h
