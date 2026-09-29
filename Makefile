INPUT = public/slides.md
SPELLCHECK_CMD=aspell check --mode=markdown -p $(PWD)/aspell.ignore.list -l nl 
SPELLCHECK_NON_INTERACTIVE_CMD=aspell list --mode=markdown -p $(PWD)/aspell.ignore.list -l nl

all: spellcheck-non-interactive

install_deps:
	sudo apt update
	sudo apt install -y aspell aspell-nl

spellcheck:
	$(SPELLCHECK_CMD) $(INPUT)

spellcheck-non-interactive:
	! $(SPELLCHECK_NON_INTERACTIVE_CMD) < $(INPUT) |grep -q '.' || exit 1