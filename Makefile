EXERCISES := $(shell find lessons -name "*.c" | sort)

.PHONY: all list check

all:
	@echo "Usage:"
	@echo "  make list             # show all exercises"
	@echo "  make check path=...   # check one exercise"

list:
	@echo "Available exercises:"
	@for f in $(EXERCISES); do \
	  echo " - $$f"; \
	done

check:
	@if [ -z "$(path)" ]; then \
	  echo "Please provide the path to an exercise using: make check path=lessons/level0/01_add.c"; \
	  exit 1; \
	fi; \
	expected=$${path%.c}.expect.asm; \
	echo "Checking $$path"; \
	bash scripts/check.sh $$path $$expected
