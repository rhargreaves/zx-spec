spec_init		macro
			ld	a,normal_paper_colour	; Set border to background colour to avoid last
							; two lines being wrong colour
			call	border_int
			ld 	a,normal_ink_colour	; Set ink colour
			ld	(attr_p),a
			call	cl_all		; clear screen
			ld	a,output_stream	; upper screen
			call	chan_open	; open channel
			print_text	banner_txt, banner_txt_end
			endm

describe		macro	group_name
			local	group_name_start, group_name_end
			ld	hl,shown_names
			res	0,(hl)		; Reset shown group name
			jp	group_name_end
group_name_start	db	group_name
group_name_end		ld	hl,group_name_start
			ld	(cur_group_name_addr),hl
			ld	hl,group_name_end - group_name_start
			ld	(cur_group_name_len),hl
			endm

it			macro	test_name
			local	test_name_start, test_name_end
			jp	test_name_end
test_name_start		db	test_name
test_name_end		ld	hl,test_name_start
			ld	(cur_test_name_addr),hl
			ld	hl,test_name_end - test_name_start
			ld	(cur_test_name_len),hl
			endm

spec_end		macro
			update_border
			call	print_summary
			if defined zx_spec_test_mode
				print_zx_spec_test_end
			endif
			endm