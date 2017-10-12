include src/constants.asm
include src/rom.asm
include src/macros.asm
			org	program_start
			jp	init
include src/state.asm
include src/resources.asm
include src/routines.asm
init:
			call	cl_all		; clear screen
			ld	a,output_stream	; upper screen
			call	chan_open	; open channel

set_a			ld	a,0

assert_a_is_zero	cp	0		; does A = 0?
			jp	z,test_passes	; pass if so
test_fails		call	inc_fail	; otherwise, fail
			jp	end_test
test_passes		call	inc_pass
			jp	end_test
end_test:

print_summary:
			print_text	banner_txt, banner_txt_end
			print_text	ok_txt, ok_txt_end
			print_value	num_pass	; print number of passing tests		
			print_text	fail_txt, fail_txt_end
			print_value	num_fail	; print number of failing tests		

			ret
		end	program_start
