.PHONY: all clean debug
.SUFFIXES: .o .c .S .s 

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
OBJ=${SRCS:S/.c/.o/g}
OBJ+=${ASMSRCS:S/.S/.o/g}
ASMSRCS:=${:!find . -name '*.S'!}


SRCS?=$(wildcard *.c)
ASMSRCS?=$(wildcard *.S)
OBJ?=$(patsubst %.c,%.o,$(SRCS))
OBJ+=$(patsubst %.S,%.o,$(ASMSRCS))

DBGFLAGS=$(CFLAGS) $(WARNS) -g -fsanitize=address,undefined

all: $(EXE)

clean:
	rm -rf $(OUTDIR)/*
	rm -f $(OBJ)

$(EXE): $(OBJ)
	cc $(OBJ) $(CFLAGS) $(WARNS) -o $(EXE)

debug: $(OBJ)
	cc $(OBJ) $(DBGFLAGS) $(WARNS) -o $(EXE).dbg

.c.o:
	cc $(CFLAGS) $(WARNS) -c $< -o $@
.s.o:
	cc -c $< -o $@
