.PHONY: test test-fcat clean

# Default target
all: test

# Run all tests
test: test-fcat

# Run fcat tests
test-fcat:
	@echo "Running fcat tests..."
	@source .zsh/commands.zsh && source .zsh/tests/fcat_test.zsh

# Clean up test artifacts
clean:
	@rm -f test_output.txt
	@rm -rf test_dir

# Help target
help:
	@echo "Available targets:"
	@echo "  test        - Run all tests"
	@echo "  test-fcat   - Run fcat tests"
	@echo "  clean       - Clean up test artifacts"
	@echo "  help        - Show this help message" 