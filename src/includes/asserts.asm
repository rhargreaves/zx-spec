;-------------------------
; Public
;-------------------------

assert_pass		macro
			call	assert_pass_r
			endm

assert_fail		macro
			call	assert_fail_r
			endm

assert_a_equal		macro	val
			push	bc		
			ld	c,val		; Store expected in C
			call	assert_a_equal_r
			pop	bc
			endm			

assert_b_equal		macro	val			
			assert_reg_equal val, b
			endm

assert_c_equal		macro	val			
			assert_reg_equal val, c
			endm

assert_d_equal		macro	val			
			assert_reg_equal val, d
			endm

assert_e_equal		macro	val			
			assert_reg_equal val, e
			endm

assert_h_equal		macro	val
			push	hl	
			assert_reg_equal val, h
			pop	hl
			endm

assert_l_equal		macro	val	
			push	hl		
			assert_reg_equal val, l
			pop	hl
			endm

assert_a_not_equal	macro	val
			push	bc
			ld	c,val
			call	assert_a_not_equal_r
			pop	bc
			endm

assert_b_not_equal	macro	val
			assert_reg_not_equal	val, b
			endm

assert_c_not_equal	macro	val
			assert_reg_not_equal	val, c
			endm

assert_d_not_equal	macro	val
			assert_reg_not_equal	val, d
			endm

assert_e_not_equal	macro	val
			assert_reg_not_equal	val, e
			endm

assert_h_not_equal	macro	val
			assert_reg_not_equal	val, h
			endm

assert_l_not_equal	macro	val
			assert_reg_not_equal	val, l
			endm

assert_a_is_zero	macro
			assert_a_equal 0
			endm

assert_a_is_not_zero	macro
			assert_a_not_equal 0
			endm			

assert_hl_equal		macro	val			
			push	bc
			ld	bc,val
			call	assert_hl_equal_r
			pop	bc
			endm

assert_bc_equal		macro	val			
			push	hl
			ld	h,b
			ld	l,c
			assert_hl_equal	val
			pop	hl
			endm

assert_de_equal		macro	val			
			push	hl
			ld	h,d
			ld	l,e
			assert_hl_equal	val
			pop	hl
			endm

assert_ix_equal		macro	val		
			push	de
			ld	d,ixh
			ld	e,ixl
			assert_de_equal	val
			pop	de
			endm

assert_hl_not_equal	macro	val			
			push	bc
			ld	bc,val
			call	assert_hl_not_equal_r
			pop	bc
			endm	

assert_bc_not_equal	macro	val			
			push	hl
			ld	h,b
			ld	l,c
			assert_hl_not_equal	val
			pop	hl
			endm

assert_de_not_equal	macro	val
			push	hl
			ld	h,d
			ld	l,e
			assert_hl_not_equal	val
			pop	hl
			endm

assert_ix_not_equal	macro	val		
			push	de
			ld	d,ixh
			ld	e,ixl
			assert_de_not_equal	val
			pop	de
			endm					

assert_z_set		macro	val
			assert_cond	val, z
			endm

assert_z_reset		macro	val
			assert_cond	val, nz
			endm

assert_carry_set	macro	val
			assert_cond	val, c
			endm

assert_carry_reset	macro	val
			assert_cond	val, nc
			endm

assert_s_set		macro	val
			assert_cond	val, m
			endm

assert_s_reset		macro	val
			assert_cond	val, p
			endm

assert_p_v_set		macro	val
			assert_cond	val, pe
			endm

assert_p_v_reset	macro	val
			assert_cond	val, po
			endm		

assert_byte_equal	macro	mem_addr, val
			push	af
			ld	a,(mem_addr)
			assert_a_equal	val
			pop	af
			endm

assert_byte_not_equal	macro	mem_addr, val
			push	af
			ld	a,(mem_addr)
			assert_a_not_equal	val
			pop	af
			endm

assert_word_equal	macro	mem_addr, val
			push	hl
			ld	hl,(mem_addr)
			assert_hl_equal	val
			pop	hl
			endm

assert_word_not_equal	macro	mem_addr, val
			push	hl
			ld	hl,(mem_addr)
			assert_hl_not_equal	val
			pop	hl
			endm

assert_bytes_equal	macro	bytes_1_start, bytes_1_length, bytes_2_start
			local	fail, done
			ld	b,bytes_1_length	; B = bytes length
			ld	hl,bytes_1_start	; HL = Actual start
			ld	de,bytes_2_start	; DE = Expected start
			call	comp_bytes		; Compare bytes
			jr	nz,fail			; If Z not set, bytes not equal, fail test
			assert_pass
			jr	done
fail			assert_fail
			fail_ink
			print_text _zxspec_text_expected, _zxspec_text_expected_end
			print_bytes bytes_2_start, bytes_1_length
			print_text _zxspec_text_actual, _zxspec_text_actual_end
			print_bytes bytes_1_start, bytes_1_length
			print_newline
			print_newline
			normal_ink
done			equ	$
			endm

assert_bytes_not_equal	macro	bytes_1_start, bytes_1_length, bytes_2_start
			local	pass, done
			ld	b,bytes_1_length	; B = bytes length
			ld	hl,bytes_1_start	; HL = Actual start
			ld	de,bytes_2_start	; DE = Expected start
			call	comp_bytes		; Compare bytes
			jr	nz,pass			; If Z not set, bytes not equal, pass test
			assert_fail
			jr	done
pass			assert_pass
done			equ	$
			endm					

assert_str_equal	macro	str_addr, val
			local	val_start, val_end, fail, done
			jr	val_end
val_start		db	val
val_end			equ	$
			ld	b,val_end-val_start	; B = string length
			ld	hl,str_addr		; HL = Actual start
			ld	de,val_start		; DE = Expected start
			call	comp_str		; Compare string
			jr	nz,fail			; If Z not set, string not equal, fail test
			assert_pass
			jr	done
fail			assert_fail
			fail_ink
			print_text _zxspec_text_expected, _zxspec_text_expected_end
			print_char d_quote
			print_text val_start, val_end
			print_char d_quote
			print_text _zxspec_text_actual, _zxspec_text_actual_end
			print_char d_quote
			print_text_with_len str_addr, val_end-val_start
			print_char d_quote
			print_newline
			print_newline
			normal_ink
done			equ	$
			endm

assert_str_not_equal	macro	str_addr, val
			local	val_start, val_end, done, loop, pass
			jr	val_end
val_start		db	val
val_end			ld	b,val_end-val_start	; B = string length
			ld	hl,str_addr		; HL = Actual start
			ld	de,val_start		; DE = Expected start
			call	comp_str		; Compare string
			jr	nz,pass			; If Z not set, string not equal, pass test
			assert_fail
			jr	done
pass			assert_pass
done			equ	$
			endm

;-------------------------
; Private
;-------------------------

inc_done		macro		num_done, done_txt_start, done_txt_end
			push		hl
			ld		hl,num_done
			inc		(hl)				; Increment number done
			print_text	done_txt_start, done_txt_end	; Print 'done' indicator
			pop		hl
			endm

assert_pass_r		proc
			inc_done	num_pass, _zxspec_text_pass_mark, _zxspec_text_pass_mark_end	; Increment number passed
			ret
			endp
			
assert_fail_r		proc
			local		print_group_end
			paint_border	red_border
			inc_done	num_fail, _zxspec_text_fail_mark, _zxspec_text_fail_mark_end	; Increment number failed
			fail_ink
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
			print_char space				; indent test name
			print_text_with_len	(cur_test_name_addr), (cur_test_name_len)
			print_newline
			print_newline
			normal_ink
			ret
			endp

assert_cond		macro	val, cond
			local	passes, done
			jp	cond,passes	; pass if flag set
			assert_fail		; otherwise, fail
			jr	done
passes			assert_pass
done			equ	$
			endm					

assert_a_equal_r	proc			; C = expected, A = actual
			local	passes, done
			cp	c		; does A = expected?
			jp	z,passes	; pass if so
			assert_fail		; otherwise, fail
			fail_ink
			print_text _zxspec_text_expected, _zxspec_text_expected_end
			call	print_num_in_c
			print_text _zxspec_text_actual, _zxspec_text_actual_end
			ld	c,a
			call	print_num_in_c
			print_newline
			print_newline
			normal_ink
			jr	done
passes			assert_pass
done			ret
			endp

assert_a_not_equal_r	proc			; C = not expected, A = actual
			local	passes, done
			cp	c		; does A = not expected?
			jr	nz,passes	; pass if it doesn't
			assert_fail		; otherwise, fail
			jr	done
passes			assert_pass
done			ret
			endp

assert_hl_equal_r	proc			; HL = actual, BC = expected
			local	passes, done
			push	hl
			push	hl
			sbc	hl,bc		; Subtract val from HL
			pop	hl
			jp	z,passes	; pass if same
			push	hl
			assert_fail		; otherwise, fail
			fail_ink
			print_text _zxspec_text_expected, _zxspec_text_expected_end
			call	print_num_in_bc
			print_text _zxspec_text_actual, _zxspec_text_actual_end
			pop	bc		; pop HL into BC
			call	print_num_in_bc
			print_newline
			print_newline
			normal_ink
			jp	done
passes			assert_pass
done			pop	hl
			ret
			endp

assert_hl_not_equal_r	proc			; HL = actual, BC = unexpected
			local	passes, done
			push	hl
			sbc	hl,bc		; Subtract val from HL
			jp	nz,passes	; pass if different
			assert_fail		; otherwise, fail
			jr	done
passes			assert_pass
done			pop	hl
			ret
			endp			

comp_str		proc	; Compares two strings
				; Inputs: B = string length, HL = actual start, DE = expected start 
				; Outputs: Z flag: 1 = string equal, 0 = not equal
			local	loop, done
loop			ld	c,(hl)			; C = Actual char
			res	7,c			; Remove any string termination bit
			ld	a,(de)			; A = Expected char
			cp	c			; Compare actual with expected char
			jp	nz,done			; Not equal.
			inc	hl			; Next actual char
			inc	de			; Next expected char
			djnz	loop			; Decrement string length, loop if <> 0
done			ret
			endp

comp_bytes		proc	; Compares two sequence of bytes
				; Inputs: B = length, HL = actual start, DE = expected start 
				; Outputs: Z flag: 1 = string equal, 0 = not equal
			local	loop, done
loop			ld	c,(hl)			; C = Actual byte
			ld	a,(de)			; A = Expected byte
			cp	c			; Compare actual with expected byte
			jp	nz,done			; Not equal.
			inc	hl			; Next actual byte
			inc	de			; Next expected byte
			djnz	loop			; Decrement length, loop if <> 0
done			ret
			endp			

assert_reg_equal	macro	val, reg			
			push	af		; Backup A
			ld	a,reg		; Copy register into A
			assert_a_equal	val
			pop	af		; Restore A
			endm

assert_reg_not_equal	macro	val, reg
			push	af		; Backup A
			ld	a,reg		; Copy register into A
			assert_a_not_equal	val
			pop	af		; Restore A
			endm