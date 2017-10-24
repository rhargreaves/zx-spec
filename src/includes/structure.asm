spec_init		macro
			ld	a,zxspec_config_normal_paper_colour	; Set border to background colour to avoid last
									; two lines being wrong colour
			call	border_int
			ld 	a,zxspec_config_normal_ink_colour	; Set ink colour
			ld	(attr_p),a
			call	cl_all		; clear screen
			ld	a,output_stream	; upper screen
			call	chan_open	; open channel
			print_text	_zxspec_text_banner, _zxspec_text_banner_end
			endm

describe		macro	group_name
			local	group_name_start, group_name_end
			ld	hl,_zxspec_shown_names
			res	0,(hl)		; Reset shown group name
			jp	group_name_end
group_name_start	db	group_name
group_name_end		ld	hl,group_name_start
			ld	(_zxspec_group_name),hl
			ld	hl,group_name_end - group_name_start
			ld	(_zxspec_group_name_length),hl
			endm

it			macro	test_name
			local	test_name_start, test_name_end
			jp	test_name_end
test_name_start		db	test_name
test_name_end		ld	hl,test_name_start
			ld	(_zxspec_test_name),hl
			ld	hl,test_name_end - test_name_start
			ld	(_zxspec_test_name_length),hl
			endm

spec_end		macro
			update_border
			call	print_summary
			if defined zx_spec_test_mode
				print_zx_spec_test_end
			endif
			endm