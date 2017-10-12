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