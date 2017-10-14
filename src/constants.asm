; Streams
screen_stream		equ	2
printer_stream		equ	3
if not defined output_stream
	output_stream	equ	screen_stream	; Definable via Pasmo command line
endif

; Characters
space			equ	' '
nl			equ	13		; New line character
cross			equ	'x'
period			equ	'.'

; Border
border_port		equ	0feh
red_border		equ	2
green_border		equ	4
yellow_border		equ	6