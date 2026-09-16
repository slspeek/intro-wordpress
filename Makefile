SPELLCHECK_CMD=aspell check --mode=markdown -p $(PWD)/aspell.ignore.list -l nl 
SPELLCHECK_NON_INTERACTIVE_CMD=aspell list --mode=markdown -p $(PWD)/aspell.ignore.list -l nl

PANDOC_IMAGE = pandoc/latex:3.11-debian
DOCKER_USER = $(shell id -u):$(shell id -g)
INPUT = intro-wordpress.md
BUILD_DIR = build
PDF_OUTPUT = $(BUILD_DIR)/intro-wordpress.pdf
REVEALJS_DIR = $(BUILD_DIR)/revealjs
REVEALJS_OUTPUT = $(REVEALJS_DIR)/index.html

.PHONY: all pdf revealjs clean spellcheck install_deps

all: pdf revealjs

install_deps:
	sudo apt update
	sudo apt install -y aspell aspell-nl


pdf: $(PDF_OUTPUT)

$(PDF_OUTPUT): $(INPUT) spellcheck-non-interactive
	docker run --rm \
		--user "$(DOCKER_USER)" \
		-v "$(CURDIR):/data" \
		-w /data \
		$(PANDOC_IMAGE) \
		$(INPUT) \
		-t beamer \
		-V theme=Madrid \
		-V date="\\today" \
		-V lang=nl \
		-V header-includes="\AtBeginDocument{\renewcommand{\sectionname}{Sectie}}" \
		-o $(PDF_OUTPUT)

revealjs: $(REVEALJS_OUTPUT)

$(REVEALJS_OUTPUT): $(INPUT) spellcheck-non-interactive
	mkdir -p $(REVEALJS_DIR)
	cp -r images $(REVEALJS_DIR)
	docker run --rm \
		--user "$(DOCKER_USER)" \
		-v "$(CURDIR):/data" \
		-w /data \
		$(PANDOC_IMAGE) \
		$(INPUT) \
		--slide-level=2 \
		-V revealjs-url=https://cdn.jsdelivr.net/npm/reveal.js@5 \
		-t revealjs \
		-s \
		-o $(REVEALJS_OUTPUT)

clean:
	rm -rf $(BUILD_DIR)

openpdf: $(PDF_OUTPUT)
	xdg-open $(PDF_OUTPUT)

openhtml: $(REVEALJS_OUTPUT)
	xdg-open $(REVEALJS_OUTPUT)

spellcheck:
	$(SPELLCHECK_CMD) $(INPUT)

spellcheck-non-interactive:
	! $(SPELLCHECK_NON_INTERACTIVE_CMD) < $(INPUT) |grep -q '.' || exit 1