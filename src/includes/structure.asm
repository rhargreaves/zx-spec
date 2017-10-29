spec_init		macro
			ld	a,zxspec_config_normal_paper_colour	; Set border to background colour to avoid last
									; two lines being wrong colour
			call	_zxspec_rom_border_int
			ld 	a,zxspec_config_normal_ink_colour	; Set ink colour
			ld	(_zxspec_attr_p),a
			call	_zxspec_rom_cl_all	; clear screen
			ld	a,_zxspec_output_stream	; upper screen
			call	_zxspec_rom_chan_open	; open channel
			_print_text	_zxspec_text_banner, _zxspec_text_banner_end
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
			_update_border
			call	_print_summary
			if defined zxspec_test_mode
				_print_zxspec_test_end
			endif
			endm