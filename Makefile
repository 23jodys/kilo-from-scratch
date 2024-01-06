UNAME_S := $(shell uname -s)
HEADERS := $(wildcard *.h)
VPATH := src:include:tests

ifeq ($(UNAME_S),Darwin)
GCOV := xcrun llvm-cov gcov
else
GCOV := llvm-cov gcov
endif

CC   := clang

CFLAGS += $(if $(COVERAGE), -fprofile-arcs -ftest-coverage )
CFLAGS += $(if $(DEBUG), -DDEBUG=1 )
CFLAGS += -Werror -Iinclude -g

LDLIBS += $(if $(or $(COVERAGE),$(DEBUG)), -g )
LDLIBS += $(if $(COVERAGE), --coverage )

test_kilo: LDLIBS += -lcmocka
test_kilo: kilo.o test_kilo.o

.PHONY: test
test: test_kilo
	./test_kilo 

# kilo.o: kilo.h

valgrind_%: %
	valgrind --leak-check=full --error-exitcode=1 ./$* 

coverage: COVERAGE=1
coverage: test
	$(GCOV) $(SRCS)

TAGS: $(SRCS) kilo.h test_*.[ch]
	etags $^

docs: $(HEADERS)
	doxygen

.PHONY: clean
clean:
	rm -rf *.o *.gcda *.gcno test_kilo *.dSYM html/ latex/
