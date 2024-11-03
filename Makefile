# var
MODULE = $(notdir $(CURDIR))

# dir
CWD = $(CURDIR)

# tool
CURL = curl -L -o
CF   = clang-format -style=file -i

# src
C += $(wildcard src/*.c*)
H += $(wildcard src/*.h*)

CP += tmp/$(MODULE).parser.cpp tmp/$(MODULE).lexer cpp
HP += tmp/$(MODULE).parser.hpp

# cfg
CFLAGS += -Itmp -Iinc -std=gnu++17 -ggdb -O0 -Wno-write-string

# all
.PHONY: all run
all: bin/$(MODULE) lib/$(MODULE).ini
run: bin/$(MODULE) lib/$(MODULE).ini
	$^

# format
.PHONY: format
format: tmp/format_cpp
tmp/format_cpp: $(C) $(H)
	$(CF) $? && touch $@
