; Routines
inc_pass		ld	hl,num_pass
			inc	(hl)
			ret

inc_fail		ld	hl,num_fail
			inc	(hl)
			ret

print_value_at_hl	ld	b,0
			ld	c,(hl)
			call	out_num_1
			ret

print_summary		print_text	banner_txt, banner_txt_end
			print_text	ok_txt, ok_txt_end
			print_value	num_pass	; print number of passing tests		
			print_text	fail_txt, fail_txt_end
			print_value	num_fail	; print number of failing tests
			ret

spec_init		call	cl_all		; clear screen
			ld	a,output_stream	; upper screen
			call	chan_open	; open channel
			ret

spec_end		call	print_summary
			ret