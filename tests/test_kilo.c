#include <errno.h>
#include <setjmp.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <cmocka.h>


static void test_simple(void** state) {
	assert_true(false);
}

int main(int argc, char* argv[]) {

	const struct CMUnitTest tests[] = {
		cmocka_unit_test(test_simple),
	};
	cmocka_run_group_tests(tests, NULL, NULL);
}
