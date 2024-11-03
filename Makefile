# var
MODULE = $(notdir $(CURDIR))

# dir
CWD = $(CURDIR)

# tool
CURL = curl -L -o
CF   = clang-format -style=file -i

# src
C += $(wildcard src/*.c*)
H += $(wildcard inc/*.h*)
F += $(wildcard lib/*.ini)

CP += tmp/$(MODULE).parser.cpp tmp/$(MODULE).lexer.cpp
HP += tmp/$(MODULE).parser.hpp

# cfg
CFLAGS += -Iinc -Itmp -ggdb -O0 -std=gnu++17
CFLAGS += -Wno-write-strings

# all
.PHONY: all run
all: bin/$(MODULE) $(F)
run: bin/$(MODULE) $(F)
	$^

# format
.PHONY: format
format: tmp/format_cpp
tmp/format_cpp: $(C) $(H)
	$(CF) $? && touch $@

# rule
bin/$(MODULE): $(C) $(H) $(CP) $(HP)
	$(CXX) $(CFLAGS) -o $@ $(C) $(CP) $(L)
tmp/$(MODULE).lexer.cpp: src/$(MODULE).lex
	flex -o $@ $<
tmp/$(MODULE).parser.cpp: src/$(MODULE).yacc
	bison -o $@ $<

# doc
.PHONY: doc
doc:

.PHONY: doxy
doxy: .doxygen
	rm -rf docs ; doxygen $< 1>/dev/null

# install
.PHONY: install update ref gz
install: doc ref gz
	$(MAKE) update
update:
	sudo apt update
	sudo apt install -uy `cat apt.txt`
ref:
gz:

# merge
MERGE += README.md Makefile apt.txt
MERGE += .gitignore .clang-format .doxygen
MERGE += .vscode bin lib inc src tmp
MERGE += $(C) $(H) $(F)

.PHONY: dev
dev:
	git push -v
	git checkout $@
	git pull -v
	git checkout $(USER) -- $(MERGE)
	$(MAKE) doxy ; git add -f docs

.PHONY: $(USER)
$(USER):
	git push -v
	git checkout $(USER)
	git pull -v

.PHONY: release
release:
	git tag $(NOW)-$(REL)
	git push -v --tags
	$(MAKE) $(USER)

ZIP = tmp/$(MODULE)_$(NOW)_$(REL)_$(BRANCH).zip
zip: $(ZIP)
$(ZIP):
	git archive --format zip --output $(ZIP) HEAD
