WARNFLAGS=\
    -Wall\
    -Wextra\
    -Wpedantic\
    -Wunused\
    -Wunused\
    -Wfloat-equal\
    -Wundef\
    -Wshadow\
    -Wpointer-arith\
    -Wcast-align\
    -Wstrict-prototypes\
    -Wstrict-overflow=5\
    -Wwrite-strings\
    -Wcast-qual\
    -Wswitch-default\
    -Wswitch-enum\
    -Wconversion\
    -Wvla\
    -Wunreachable-code
CCFLAGS=-O2 --std=c17

EXENAME = out
MAIN = main.c

# BSD Make, GNU Make
LIBS := ${:!ls libs/*.c!}
LIBS += $(shell libs/*.c)

# BSD Make, GNU Make
OBJ := ${LIBS:S/.c/.o/g}
OBJ += $(patsubst %.c,%.o,$(wildcard libs/*.c))

# Separate debug c-compiler, fuzzing assumes clang
DBGCC=clang
DBGFLAGS=$(CCFLAGS) $(WARNFLAGS) -g -fsanitize=fuzzer,undefined
DBGDIR=debug
DBGLIB=$(DBGDIR)/debug.c

.SUFFIXES: .o .c
.PHONY: all clean debug

all: $(EXENAME)

clean:
	rm -f $(EXENAME)
	rm -f $(OBJ)
	rm -f $(DBGDIR)/*.o
	rm -f $(DBGDIR)/*.dbg

$(EXENAME): $(OBJ)
	cc $(OBJ) $(MAIN) $(CCFLAGS) $(WARNFLAGS) -o $(EXENAME)

.c.o:
	cc $(CCFLAGS) $(WARNFLAGS) -c $< -o $@

debug:
	$(DBGCC) $(OBJ) $(DBGFLAGS) -o $(DBGDIR)/$(EXENAME).dbg
