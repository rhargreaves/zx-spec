ifeq ($(CI),true)
TTY_ARG :=
else
TTY_ARG := -t
endif

PASMO := docker run -v $(PWD):/work -w="/work" -i $(TTY_ARG) ghcr.io/rhargreaves/pasmo:v0.5.5 pasmo -I src
BIN := bin
FUSE ?= fuse

.PHONY: test clean run

clean:
	rm -rf $(BIN)

$(BIN):
	mkdir $(BIN)

$(BIN)/zx-spec-green.tap: test/test-passes.asm $(BIN)
	$(PASMO) --tapbas $< $@

$(BIN)/zx-spec-red.tap: test/test-failures.asm $(BIN)
	$(PASMO) --tapbas $< $@

$(BIN)/zx-spec-mixture.tap: test/test-verbose-mix.asm $(BIN)
	$(PASMO) --tapbas $< $@

$(BIN)/zx-spec-hex.tap: test/test-hex.asm $(BIN)
	$(PASMO) --tapbas $< $@

$(BIN)/checkout-kata.tap: examples/checkout-kata.asm $(BIN)
	$(PASMO) --tapbas $< $@

$(BIN)/test-passes.tap: test/test-passes.asm $(BIN)
	$(PASMO) --equ zxspec_test_mode --tapbas $< $@

$(BIN)/test-failures.tap: test/test-failures.asm $(BIN)
	$(PASMO) --equ zxspec_test_mode --tapbas $< $@

$(BIN)/test-hex.tap: test/test-hex.asm $(BIN)
	$(PASMO) --equ zxspec_test_mode --tapbas $< $@

$(BIN)/test-verbose-mix.tap: test/test-verbose-mix.asm $(BIN)
	$(PASMO) --equ zxspec_test_mode --tapbas $< $@

test:	$(BIN)/test-passes.tap $(BIN)/test-failures.tap $(BIN)/test-hex.tap $(BIN)/test-verbose-mix.tap
	./test.py

demo-mix:	$(BIN)/zx-spec-mixture.tap
	$(FUSE) --tape $< --auto-load --no-autosave-settings

demo-green:	$(BIN)/zx-spec-green.tap
	$(FUSE) --tape $< --auto-load --no-autosave-settings

demo-red:	$(BIN)/zx-spec-red.tap
	$(FUSE) --tape $< --auto-load --no-autosave-settings

demo-hex:	$(BIN)/zx-spec-hex.tap
	$(FUSE) --tape $< --auto-load --no-autosave-settings

checkout-kata:	$(BIN)/checkout-kata.tap
	$(FUSE) --tape $< --auto-load --no-autosave-settings
