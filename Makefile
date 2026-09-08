SPELLCHECK_CMD=aspell check -t -p $(PWD)/aspell.ignore.list -l nl 
SPELLCHECK_NON_INTERACTIVE_CMD=aspell list -t -p $(PWD)/aspell.ignore.list -l nl

PANDOC_IMAGE ?= pandoc/latex:3.11-debian
INPUT ?= intro-wordpress.md
OUTPUT ?= intro-wordpress.pdf

.PHONY: all pdf clean spellcheck

all: pdf

pdf: $(OUTPUT)

$(OUTPUT): $(INPUT) spellcheck-non-interactive
	docker run --rm \
		-v "$(CURDIR):/data" \
		-w /data \
		$(PANDOC_IMAGE) \
		$(INPUT) \
		-t beamer \
		-o $(OUTPUT)

clean:
	rm -f $(OUTPUT)

open: $(OUTPUT)
	xdg-open $(OUTPUT)

spellcheck:
	$(SPELLCHECK_CMD) $(INPUT)

spellcheck-non-interactive:
	! $(SPELLCHECK_NON_INTERACTIVE_CMD) < $(INPUT) |grep -q '.' || exit 1