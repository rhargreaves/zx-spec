PASMO = docker run -v $(PWD):/work -w="/work" -it charlottegore/pasmo pasmo
BIN = bin

.PHONY: test clean run

clean:
	rm -rf $(BIN)

$(BIN):
	mkdir $(BIN)

$(BIN)/zx-spec-green.tap: test/test-passes.asm
	$(PASMO) --equ output_stream=2 --tapbas $< $@

$(BIN)/zx-spec-red.tap: test/test-failures.asm
	$(PASMO) --equ output_stream=2 --tapbas $< $@

$(BIN)/test-passes.tap: test/test-passes.asm
	$(PASMO) --equ output_stream=3 --tapbas $< $@

$(BIN)/test-failures.tap: test/test-failures.asm
	$(PASMO) --equ output_stream=3 --tapbas $< $@

test:	$(BIN)/test-passes.tap $(BIN)/test-failures.tap
	./test.py

demo-green:	$(BIN)/zx-spec-green.tap
	fuse --tape $< --auto-load --no-autosave-settings

demo-red:	$(BIN)/zx-spec-red.tap
	fuse --tape $< --auto-load --no-autosave-settings
