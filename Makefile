.DEFAULT_GOAL := check

ZIRAN ?= ziran
CC ?= cc
BUILD := build

.PHONY: check test clean

# Checks the package, then runs the tests as C and as a portable bundle.
check: test

test:
	$(ZIRAN) check --project
	$(ZIRAN) build --project --target=c --entry syntax_test:main \
		-o $(BUILD)/test-c tests/syntax_test.zi
	$(CC) -std=c99 -pedantic-errors -I$$($(ZIRAN) pkg path ziran)/include \
		-I$(BUILD)/test-c $(BUILD)/test-c/*.c -o $(BUILD)/syntax-test
	$(BUILD)/syntax-test
	$(ZIRAN) bundle --project --entry syntax_test:main \
		-o $(BUILD)/syntax-test.zib tests/syntax_test.zi
	test "$$($(ZIRAN) run $(BUILD)/syntax-test.zib)" = 0

clean:
	rm -rf $(BUILD)
