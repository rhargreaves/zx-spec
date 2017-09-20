SRC = $(wildcard src/*.asm)
BASIC_SRC = $(wildcard src/*.bas)
TAPES = $(patsubst src/%.asm,$(TAPDIR)/%.tap,$(SRC))
BASIC_TAPES = $(patsubst src/%.bas,$(TAPDIR)/%.tap,$(BASIC_SRC))
PASMO = docker run -v $(PWD):/work -w="/work" -it charlottegore/pasmo pasmo
TAPDIR = bin

.PHONY: all clean test

all: $(TAPES) $(BASIC_TAPES)

clean:
	rm -rf $(TAPDIR)

$(TAPDIR):
	mkdir $(TAPDIR)

$(TAPDIR)/%.tap: src/%.asm $(TAPDIR)
	$(PASMO) --tapbas $< $@

$(TAPDIR)/%.tap: src/%.bas $(TAPDIR)
	bas2tap/bas2tap $< $@
