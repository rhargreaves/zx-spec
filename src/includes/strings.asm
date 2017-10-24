_zxspec_text_banner		db	_nl, '   '
				db	10h, zxspec_config_banner_ink_colour
				db	'ZX Spec: The TDD Framework'
				db	10h, zxspec_config_normal_ink_colour
				db	_nl, _nl
_zxspec_text_banner_end		equ	$
_zxspec_text_pass		db	_nl, 'Pass: '
_zxspec_text_pass_end		equ	$
_zxspec_text_fail		db	', Fail: '
_zxspec_text_fail_end		equ	$
_zxspec_text_total		db	', Total: '
_zxspec_text_total_end		equ	$
_zxspec_text_expected		db	'Expected: ' 
_zxspec_text_expected_end	equ	$
_zxspec_text_actual		db	', Actual: '
_zxspec_text_actual_end		equ	$
_zxspec_text_exit		db	'-- ZX SPEC TEST END --'
_zxspec_text_exit_end		equ	$
_zxspec_text_pass_mark		db	10h,zxspec_config_pass_ink_colour
				db	'.'
				db	10h,zxspec_config_normal_ink_colour
_zxspec_text_pass_mark_end	equ	$
_zxspec_text_fail_mark		db	10h,zxspec_config_fail_ink_colour
				db	'x'
				db	10h,zxspec_config_normal_ink_colour
_zxspec_text_fail_mark_end	equ	$
_zxspec_text_pass_ink		db	10h,zxspec_config_pass_ink_colour
_zxspec_text_pass_ink_end	equ	$
_zxspec_text_fail_ink		db	10h,zxspec_config_fail_ink_colour
_zxspec_text_fail_ink_end	equ	$
_zxspec_text_normal_ink		db	10h,zxspec_config_normal_ink_colour
_zxspec_text_normal_ink_end	equ	$