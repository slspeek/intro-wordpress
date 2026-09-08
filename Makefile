PANDOC_IMAGE ?= pandoc/latex:3.11-debian
INPUT ?= intro-wordpress.md
OUTPUT ?= intro-wordpress.pdf

.PHONY: all pdf clean

all: pdf

pdf: $(OUTPUT)

$(OUTPUT): $(INPUT)
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
