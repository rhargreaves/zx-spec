SRC = $(wildcard src/*.asm)
TAPES = $(patsubst src/%.asm,$(TAPDIR)/%.tap,$(SRC))
PASMO = docker run -v $(PWD):/work -w="/work" -it charlottegore/pasmo pasmo
TAPDIR = bin

.PHONY: build clean run

build: $(TAPES)

clean:
	rm -rf $(TAPDIR)

$(TAPDIR):
	mkdir $(TAPDIR)

$(TAPDIR)/%.tap: src/%.asm $(TAPDIR)
	$(PASMO) --tapbas $< $@

run:	bin/zx-spec.tap
	fuse --tape bin/zx-spec.tap --auto-load --no-autosave-settings
