include src/constants.asm
include src/rom.asm
include src/macros.asm
			org	program_start
			jp	init
include src/state.asm
include src/resources.asm
include src/routines.asm
include src/asserts.asm
init:

			spec_init

test_1			ld	a,0
			call	assert_a_is_zero

			spec_end
			ret

			end	program_start
