# Test Suite for Entelechia

This document describes how to test the Entelechia system.

## Prerequisites

- Nix with flakes enabled
- jq (for JSON processing)

## Basic Tests

### 1. Syntax Validation

Test that all Nix files are syntactically valid:

```bash
# Test library
nix-instantiate --parse lib/entelechia.nix

# Test examples
nix-instantiate --parse examples/epistemology.nix
nix-instantiate --parse examples/phenomenology.nix
nix-instantiate --parse examples/systems.nix
nix-instantiate --parse examples/dialectical.nix

# Test flake
nix flake check
```

### 2. Library Evaluation

Test that the library can be imported and evaluated:

```bash
# Import and evaluate the library
nix-instantiate --eval --expr 'let lib = import ./lib/entelechia.nix {}; in lib.modes.socratic'

# Test creating an agent
nix-instantiate --eval --json --expr '
  let lib = import ./lib/entelechia.nix {};
  in lib.mkAgent { 
    mode = lib.modes.socratic; 
    reasoning = lib.reasoningTypes.deductive; 
  }
' | jq .

# Test creating an inquiry
nix-instantiate --eval --json --expr '
  let lib = import ./lib/entelechia.nix {};
  in lib.mkInquiry {
    question = "What is truth?";
    mode = lib.modes.analytic;
  }
' | jq .
```

### 3. Example Evaluation

Test that all examples evaluate correctly:

```bash
# Evaluate epistemology example
nix-instantiate --eval --json examples/epistemology.nix | jq .

# Evaluate phenomenology example
nix-instantiate --eval --json examples/phenomenology.nix | jq .

# Evaluate systems example
nix-instantiate --eval --json examples/systems.nix | jq .

# Evaluate dialectical example
nix-instantiate --eval --json examples/dialectical.nix | jq .
```

### 4. Build Tests

Test that the package builds:

```bash
# Build with flakes
nix build

# Verify the result
ls -la result/

# Check installed files
tree result/
```

### 5. CLI Tests

Test the CLI functionality:

```bash
# Test help
./result/bin/entelechia help

# Test modes listing
./result/bin/entelechia modes

# Test reasoning types listing
./result/bin/entelechia reasoning

# Test agent creation
./result/bin/entelechia agent socratic

# Test example processing
./result/bin/entelechia example epistemology
```

### 6. Integration Tests

Test the complete workflow:

```bash
# Create a custom inquiry
cat > /tmp/test-inquiry.nix << 'EOF'
let
  lib = import ./lib/entelechia.nix {};
in
let
  agent = lib.mkAgent {
    mode = lib.modes.analytic;
    reasoning = lib.reasoningTypes.deductive;
  };

  inquiry = lib.mkInquiry {
    question = "What is the meaning of declarative programming?";
    mode = lib.modes.analytic;
    assumptions = [ "Programs can be described rather than prescribed" ];
  };

  reflection = lib.reflect agent inquiry;
in reflection
EOF

# Process the custom inquiry
./result/bin/entelechia inquiry /tmp/test-inquiry.nix
```

## Expected Results

All tests should complete without errors. The system should:

1. Parse all Nix expressions successfully
2. Evaluate library functions correctly
3. Build the package without errors
4. Execute CLI commands properly
5. Process inquiries and display results

## Manual Verification

After running tests:

1. Verify that agent configurations are displayed correctly
2. Check that inquiry processing shows proper structure
3. Ensure that example outputs are meaningful
4. Confirm that error messages are helpful

## Continuous Integration

For CI/CD, the minimal test suite is:

```bash
# Syntax check
nix flake check

# Build test
nix build

# Basic functionality test
./result/bin/entelechia modes
./result/bin/entelechia example epistemology
```

## Known Limitations

- Tests require Nix to be installed
- Some features require Nix flakes to be enabled
- Interactive REPL tests must be manual
- CLI output formatting depends on terminal capabilities
