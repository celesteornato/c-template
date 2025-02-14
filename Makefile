CCFLAGS=-Wall -Wextra -Wpedantic -Werror -Wunused --std=c17
.PHONY: all clean libs out

all: out

out: libs
	cc $(CCFLAGS) *.o -o out

libs:
	cc -c $(CCFLAGS) *.c

clean:
	rm *.o ./out
