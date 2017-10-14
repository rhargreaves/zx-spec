; State
num_pass		db	0
num_fail		db	0
shown_names		db	0	; LSB = Group Name, 2nd LSB = Test Name
cur_test_name_addr	db	0,0
cur_test_name_len	db	0,0
cur_group_name_addr	db	0,0
cur_group_name_len	db	0,0