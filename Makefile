.PHONY: all clean debug
.SUFFIXES: .o .c

WARNS=\
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

CFLAGS+=-O2 --std=c17

OUTDIR=bin
EXE=$(OUTDIR)/out

# BSD Make, GNU Make
SRCS:=${:!find . -name '*.c'!}
SRCS?=$(wildcard *.c)

ASMSRCS:=${:!find . -name '*.s'!}
ASMSRCS?=$(wildcard *.s)

# BSD Make, GNU Make
OBJ=${SRCS:S/.c/.o/g}
OBJ?=$(patsubst %.c,%.o,$(SRCS))

OBJ+=${ASMSRCS:S/.s/.o/g}
OBJ+=$(patsubst %.s,%.o,$(ASMSRCS))

DBGFLAGS=$(CFLAGS) $(WARNS) -g -fsanitize=address,undefined

all: $(EXE)

clean:
	rm -rf $(OUTDIR)/*
	rm -f $(OBJ)

$(EXE): $(OBJ)
	cc $(OBJ) $(CFLAGS) $(WARNS) -o $(EXE)
debug:
	cc $(OBJ) $(DBGFLAGS) -o $(EXE).dbg

.c.o:
	cc $(CFLAGS) $(WARNS) -c $< -o $@
.s.o:
	cc -c $< -o $@
