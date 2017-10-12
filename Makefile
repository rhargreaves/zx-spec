SRC = $(wildcard src/*.asm)
TEST = $(wildcard test/*.asm)
PASMO = docker run -v $(PWD):/work -w="/work" -it charlottegore/pasmo pasmo
BIN = bin

.PHONY: build clean run

build:	bin/zx-spec.tap

clean:
	rm -rf $(BIN)

$(BIN):
	mkdir $(BIN)

$(BIN)/zx-spec-demo.tap: test/test-passes.asm
	$(PASMO) --equ output_stream=2 --tapbas $< $@

$(BIN)/test-passes.tap: test/test-passes.asm
	$(PASMO) --equ output_stream=3 --tapbas $< $@

test:	$(BIN)/test-passes.tap
		./test.py

run:	$(BIN)/zx-spec-demo.tap
	fuse --tape $< --auto-load --no-autosave-settings
