banner_txt		db	nl,'   ',10h,banner_ink_colour,'ZX Spec: The TDD Framework',10h,normal_ink_colour,nl,nl
banner_txt_end		equ	$
ok_txt			db	nl, 'Pass: '
ok_txt_end		equ	$
fail_txt		db	', Fail: '
fail_txt_end		equ	$
total_txt		db	', Total: '
total_txt_end		equ	$
expected_txt		db	'Expected: ' 
expected_txt_end	equ	$
actual_txt		db	', Actual: '
actual_txt_end		equ	$
exit_txt		db	'-- ZX SPEC TEST END --'
exit_txt_end		equ	$
pass_indicator_txt	db	10h,pass_ink_colour,'.',10h,normal_ink_colour
pass_indicator_txt_end	equ	$
fail_indicator_txt	db	10h,fail_ink_colour,'x',10h,normal_ink_colour
fail_indicator_txt_end	equ	$
pass_colour_txt		db	10h,pass_ink_colour
pass_colour_txt_end	equ	$
fail_colour_txt		db	10h,fail_ink_colour
fail_colour_txt_end	equ	$
normal_colour_txt	db	10h,normal_ink_colour
normal_colour_txt_end	equ	$