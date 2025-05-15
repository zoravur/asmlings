EXERCISES := $(shell find lessons -name "[0-9][0-9]_*.c" | sort)

.PHONY: all list check diff

all:
	@echo "Usage:"
	@echo "  make list              # show all exercises"
	@echo "  make check EXERCISE=1  # check exercise"
	@echo "  make diff EXERCISE=1   # view diff (reveals answer)"

list:
	@for f in $(EXERCISES); do echo $$f; done

resolve_path = $(shell echo $(EXERCISES) | tr ' ' '\n' | grep "/$(shell printf '%02d' $(EXERCISE))_")

check:
	@if [ -z "$(EXERCISE)" ]; then \
	  echo "Usage: make check EXERCISE=N (e.g. make check EXERCISE=1)"; \
	  exit 1; \
	fi; \
	path=$(call resolve_path); \
	if [ -z "$$path" ]; then \
	  echo "Exercise $(EXERCISE) not found."; \
	  exit 1; \
	fi; \
	expected=$${path%.c}.expect.asm; \
	echo "Checking $$path"; \
	bash scripts/check.sh "$$path" "$$expected" --quiet

diff:
	@if [ -z "$(EXERCISE)" ]; then \
	  echo "Usage: make diff EXERCISE=N"; \
	  exit 1; \
	fi; \
	path=$(call resolve_path); \
	if [ -z "$$path" ]; then \
	  echo "Exercise $(EXERCISE) not found."; \
	  exit 1; \
	fi; \
	expected=$${path%.c}.expect.asm; \
	echo "Diff for $$path:"; \
	bash scripts/check.sh "$$path" "$$expected" --diff

help:
	@echo "asmlings: compiler vision drills"
	@echo
	@echo "Commands:"
	@echo "  make list              # list all exercises"
	@echo "  make check EXERCISE=n  # run test for exercise n (e.g. 1)"
	@echo "  make diff  EXERCISE=n  # view diff for exercise n (reveals answer)"
	@echo
	@echo "Recommended via wrapper:"
	@echo "  asmlings list"
	@echo "  asmlings check 2"
	@echo "  asmlings diff 2"
