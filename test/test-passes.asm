			org	8000h

include src/zx-spec.asm

			spec_init

	describe 'assert_pass'
		it 'passes test'
			assert_pass

	describe 'assert_hl_equal'
		it 'passes for same value'
			ld	hl,$0102
			assert_hl_equal $0102

		it "doesn't affect value of hl"
			ld	hl,$0102
			assert_hl_equal $0102
			assert_hl_equal $0102

	describe 'assert_bc_equal'
		it 'passes for same value'
			ld	bc,$0102
			assert_bc_equal $0102

		it "doesn't affect value of bc"
			ld	bc,$0102
			assert_bc_equal $0102
			assert_bc_equal $0102

	describe 'assert_de_equal'
		it 'passes for same value'
			ld	de,$0102
			assert_de_equal $0102

		it "doesn't affect value of de"
			ld	de,$0102
			assert_de_equal $0102
			assert_de_equal $0102

	describe 'assert_ix_equal'
		it 'passes for same value'
			ld	ix,$0102
			assert_ix_equal $0102

		it "doesn't affect value of ix"
			ld	ix,$0102
			assert_ix_equal $0102
			assert_ix_equal $0102

	describe 'assert_a_equal'
		it 'passes for same value'
			ld	a,5
			assert_a_equal 5

		it "doesn't affect value of a"
			ld	a,5
			assert_a_equal 5	
			assert_a_equal 5

	describe 'assert_b_equal'
		it 'passes for same value'
			ld	b,5
			assert_b_equal 5

		it "doesn't affect value of b"
			ld	b,5
			assert_a_equal 5		
			assert_a_equal 5
			
	describe 'assert_c_equal'
		it 'passes for same value'
			ld	c,5
			assert_c_equal 5

		it "doesn't affect value of c"
			ld	c,5
			assert_a_equal 5		
			assert_a_equal 5

	describe 'assert_d_equal'
		it 'passes for same value'
			ld	d,5
			assert_d_equal 5

		it "doesn't affect value of d"
			ld	d,5
			assert_d_equal 5		
			assert_d_equal 5

	describe 'assert_e_equal'
		it 'passes for same value'
			ld	e,5
			assert_e_equal 5

		it "doesn't affect value of e"
			ld	e,5
			assert_e_equal 5		
			assert_e_equal 5

	describe 'assert_h_equal'
		it 'passes for same value'
			ld	h,5
			assert_h_equal 5

		it "doesn't affect value of h"
			ld	h,5
			assert_h_equal 5		
			assert_h_equal 5

	describe 'assert_l_equal'
		it 'passes for same value'
			ld	l,5
			assert_l_equal 5

		it "doesn't affect value of l"
			ld	l,5
			assert_l_equal 5		
			assert_l_equal 5

	describe 'assert_a_not_equal'
		it 'passes for different value'
			ld	a,0
			assert_a_not_equal 5

	describe 'assert_b_not_equal'
		it 'passes for different value'
			ld	b,0
			assert_b_not_equal 5

	describe 'assert_c_not_equal'
		it 'passes for different value'
			ld	c,0
			assert_c_not_equal 5

	describe 'assert_d_not_equal'
		it 'passes for different value'
			ld	d,0
			assert_d_not_equal 5

	describe 'assert_e_not_equal'
		it 'passes for different value'
			ld	e,0
			assert_e_not_equal 5

	describe 'assert_h_not_equal'
		it 'passes for different value'
			ld	h,0
			assert_h_not_equal 5

	describe 'assert_l_not_equal'
		it 'passes for different value'
			ld	l,0
			assert_l_not_equal 5

	describe 'assert_hl_not_equal'
		it 'passes for different value'
			ld	hl,$0002
			assert_hl_not_equal $0103

	describe 'assert_bc_not_equal'
		it 'passes for different value'
			ld	bc,$0002
			assert_bc_not_equal $0103

	describe 'assert_de_not_equal'
		it 'passes for different value'
			ld	de,$0002
			assert_de_not_equal $0103

	describe 'assert_ix_not_equal'
		it 'passes for different value'
			ld	ix,$0002
			assert_ix_not_equal $0103

	describe 'assert_a_is_zero'
		it 'passes for zero'
			ld	a,0
			assert_a_is_zero

	describe 'assert_a_is_not_zero'
		it 'passes for non-zero'
			ld	a,5
			assert_a_is_not_zero

	describe 'assert_mem_equal'
		it 'passes for same value'
			assert_mem_equal  tmp_1, $CC

	describe 'assert_mem_not_equal'
		it 'passes for different value'
			assert_mem_not_equal  tmp_1, $DD

	describe 'assert_word_equal'
		it 'passes for same value'
			assert_word_equal  tmp_2, $DDEE

	describe 'assert_word_not_equal'
		it 'passes for different value'
			assert_word_not_equal  tmp_2, $FFAA

	describe 'assert_str_equal'
		it 'passes for same value'
			assert_str_equal  tmp_str, 'test string'

		it 'supports spectrum terminated string'
			assert_str_equal  copyright_rom_addr, "\x7f 1982 Sinclair Research Ltd"

	describe 'assert_str_not_equal'
		it 'passes for different value'
			assert_str_not_equal  tmp_str, 'diff string'

	describe 'assert_z_set'
		it "passes when zero flag set"
			ld	a,0
			or	a
			assert_z_set

	describe 'assert_z_reset'
		it "passes when zero flag reset"
			ld	a,5
			or	0
			assert_z_reset

	describe 'assert_carry_set'
		it "passes when carry flag set"
			ld	a,$FF
			add	a,1
			assert_carry_set

	describe 'assert_carry_reset'
		it "passes when carry flag reset"
			ld	a,$00
			add	a,1
			assert_carry_reset

	describe 'assert_s_set'
		it "passes when signed flag set"
			ld	a,$00
			dec	a
			assert_s_set

	describe 'assert_s_reset'
		it "passes when signed flag reset"
			ld	a,$00
			inc	a
			assert_s_reset

	describe 'assert_p_v_set'
		it "passes when overflow flag set"
			ld	a,$7F
			inc	a
			assert_p_v_set

	describe 'assert_p_v_reset'
		it "passes when overflow flag reset"
			ld	a,$80
			inc	a
			assert_p_v_reset					

			spec_end
			ret

tmp_1			db	$CC
tmp_2			dw	$DDEE
tmp_str			db	'test string'
tmp_str_end		equ	$
copyright_rom_addr	equ	1539h
			end	8000h
