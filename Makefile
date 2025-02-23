CCFLAGS=-O2
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
    -Wunreachable-code\
    --std=gnu17

LIBS=*.o
EXENAME=out
.PHONY: all clean

all: out

clean:
	rm -f ./$(EXENAME)
	rm -f ./*.o

$(EXENAME): libs
	cc $(LIBS) $(CCFLAGS) $(WARNFLAGS) ./main.c
libs:
	cc $(CCFLAGS) $(WARNFLAGS) -c *.c
