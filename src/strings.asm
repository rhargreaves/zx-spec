; Resources
banner_txt		db	'   ZX Spec: The TDD Framework', nl, nl
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
pass_indicator_txt	db	10h,04h,'.',10h,00h
pass_indicator_txt_end	equ	$
fail_indicator_txt	db	10h,02h,'x',10h,00h
fail_indicator_txt_end	equ	$