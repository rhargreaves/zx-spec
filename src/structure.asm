; Macros
describe		macro	group_name
local			group_name_start, group_name_end
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
local			start_test_name, end_test_name
			jp	end_test_name
start_test_name		db	test_name
end_test_name		ld	hl,start_test_name
			ld	(cur_test_name_addr),hl
			ld	hl,end_test_name - start_test_name
			ld	(cur_test_name_len),hl
			endm

spec_init		macro
			call	cl_all		; clear screen
			ld	a,output_stream	; upper screen
			call	chan_open	; open channel
			print_text	banner_txt, banner_txt_end
			endm

spec_end		macro
			update_border
			call	print_summary
			endm