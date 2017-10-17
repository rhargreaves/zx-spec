
assert_pass		macro
			call	assert_pass_r
			endm

assert_fail		macro
			call	assert_fail_r
			endm

inc_done		macro		num_done, done_char
			push		hl
			ld		hl,num_done
			inc		(hl)			; Increment number done
			print_char	done_char		; Print done char
			pop		hl
			endm

assert_pass_r		proc
			inc_done	num_pass, period	; Increment number passed
			ret
			endp
			
assert_fail_r		proc
			local		print_group_end
			set_border_colour	red_border	; Set border to red
			inc_done	num_fail, cross		; Increment number failed
			ld		hl,shown_names
			bit		0,(hl)				; Group name shown already?
			jp		nz,print_group_end		; Skip if so.
			push		de
			ld		de,(cur_group_name_len)		; get string length
			inc		e				; +1 -1 = 0
			dec		e				; sets Z if group name undefined
			pop		de
			jp		z,print_group_end		; skip printing of name if so
			print_newline
			print_text_with_len	(cur_group_name_addr), (cur_group_name_len)
			ld		hl,shown_names
			set		0,(hl)				; Set shown group name
print_group_end		print_newline
			print_char space			; indent test name
			print_text_with_len	(cur_test_name_addr), (cur_test_name_len)
			print_newline
			print_newline
			ret
			endp

assert_a_equals_r	proc			; C = expected, A = actual
			local	passes, done
			cp	c		; does A = val?
			jp	z,passes	; pass if so
			assert_fail		; otherwise, fail
			print_text expected_txt, expected_txt_end
			ld	b,0
			call	safe_out_num_1
			print_text actual_txt, actual_txt_end
			ld	b,0
			ld	c,a
			call	safe_out_num_1
			print_char	nl
			print_char	nl
			jp	done
passes			assert_pass
done			ret
			endp

assert_hl_equals	macro	val			
			local	passes, done
			push	hl		; Backup HL & BC
			ld	bc,val
			push	hl
			sbc	hl,bc		; Subtract val from HL
			pop	hl
			jp	z,passes	; pass if zero
			push	hl		; store copy of HL as it gets overwitten
			push	bc		; store copy of BC as it gets overwitten by assert_fail
			assert_fail		; otherwise, fail
			print_text expected_txt, expected_txt_end
			pop	bc
			call	safe_out_num_1
			print_text actual_txt, actual_txt_end
			pop	hl		; restore HL for printing actual value
			ld	b,h
			ld	c,l
			call	safe_out_num_1
			print_char	nl
			print_char	nl
			jp	done
passes			assert_pass
done			pop	hl		; Restore HL
			endm

assert_a_equals		macro	val
			push	bc		
			ld	c,val		; Store expected in C
			call	assert_a_equals_r
			pop	bc
			endm

assert_reg_equals	macro	val, reg			
			push	af		; Backup A
			ld	a,reg		; Copy register into A
			assert_a_equals	val
			pop	af		; Restore A
			endm

assert_b_equals		macro	val			
			assert_reg_equals val, b
			endm

assert_c_equals		macro	val			
			assert_reg_equals val, c
			endm

assert_d_equals		macro	val			
			assert_reg_equals val, d
			endm

assert_e_equals		macro	val			
			assert_reg_equals val, e
			endm

assert_h_equals		macro	val
			push	hl	
			assert_reg_equals val, h
			pop	hl
			endm

assert_l_equals		macro	val	
			push	hl		
			assert_reg_equals val, l
			pop	hl
			endm

assert_a_not_equals	macro	val
			local	passes, done
			cp	val		; does A = val?
			jr	nz,passes	; pass if it doesn't
			assert_fail		; otherwise, fail
			jr	done
passes			assert_pass
done
			endm

assert_reg_not_equals	macro	val, reg
			push	af		; Backup A
			ld	a,reg		; Copy register into A
			assert_a_not_equals	val
			pop	af		; Restore A
			endm

assert_b_not_equals	macro	val
			assert_reg_not_equals	val, b
			endm

assert_c_not_equals	macro	val
			assert_reg_not_equals	val, c
			endm

assert_d_not_equals	macro	val
			assert_reg_not_equals	val, d
			endm

assert_e_not_equals	macro	val
			assert_reg_not_equals	val, e
			endm

assert_h_not_equals	macro	val
			assert_reg_not_equals	val, h
			endm

assert_l_not_equals	macro	val
			assert_reg_not_equals	val, l
			endm

assert_a_is_zero	macro
			assert_a_equals 0
			endm

assert_a_is_not_zero	macro
			assert_a_not_equals 0
			endm