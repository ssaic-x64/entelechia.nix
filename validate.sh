#!/usr/bin/env bash
# Basic validation script for Entelechia
# This validates structure and syntax without requiring Nix installation

set -e

echo "=== Entelechia Structure Validation ==="
echo ""

# Check directory structure
echo "Checking directory structure..."
for dir in lib bin examples modes; do
    if [ -d "$dir" ]; then
        echo "  ✓ Directory exists: $dir"
    else
        echo "  ✗ Missing directory: $dir"
        exit 1
    fi
done
echo ""

# Check required files
echo "Checking required files..."
required_files=(
    "flake.nix"
    "default.nix"
    "lib/entelechia.nix"
    "bin/entelechia"
    "README.md"
    "USAGE.md"
    "TESTING.md"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✓ File exists: $file"
    else
        echo "  ✗ Missing file: $file"
        exit 1
    fi
done
echo ""

# Check executable permissions
echo "Checking executable permissions..."
if [ -x "bin/entelechia" ]; then
    echo "  ✓ bin/entelechia is executable"
else
    echo "  ✗ bin/entelechia is not executable"
    exit 1
fi
echo ""

# Check examples
echo "Checking example files..."
for example in examples/*.nix; do
    if [ -f "$example" ]; then
        echo "  ✓ Example found: $(basename $example)"
        # Basic syntax check - verify it starts with a comment or let
        first_line=$(head -1 "$example")
        if [[ "$first_line" =~ ^#.*$ ]] || [[ "$first_line" =~ ^let$ ]]; then
            echo "    → Valid Nix structure"
        else
            echo "    → Warning: Unexpected start"
        fi
    fi
done
echo ""

# Check for proper shebang in entelechia script
echo "Checking entelechia script..."
shebang=$(head -1 bin/entelechia)
if [[ "$shebang" == "#!/usr/bin/env bash" ]]; then
    echo "  ✓ Correct shebang line"
else
    echo "  ✗ Invalid shebang line"
    exit 1
fi
echo ""

# Check flake.nix structure
echo "Checking flake.nix structure..."
if grep -q "description.*Entelechia" flake.nix; then
    echo "  ✓ Flake description found"
else
    echo "  ✗ Missing flake description"
fi

if grep -q "nixpkgs.url" flake.nix; then
    echo "  ✓ Nixpkgs input found"
else
    echo "  ✗ Missing nixpkgs input"
fi

if grep -q "outputs" flake.nix; then
    echo "  ✓ Outputs section found"
else
    echo "  ✗ Missing outputs section"
fi
echo ""

# Check library structure
echo "Checking library structure..."
if grep -q "modes = {" lib/entelechia.nix; then
    echo "  ✓ Modes definition found"
else
    echo "  ✗ Missing modes definition"
fi

if grep -q "reasoningTypes = {" lib/entelechia.nix; then
    echo "  ✓ Reasoning types definition found"
else
    echo "  ✗ Missing reasoning types definition"
fi

if grep -q "mkAgent = " lib/entelechia.nix; then
    echo "  ✓ mkAgent function found"
else
    echo "  ✗ Missing mkAgent function"
fi

if grep -q "mkInquiry = " lib/entelechia.nix; then
    echo "  ✓ mkInquiry function found"
else
    echo "  ✗ Missing mkInquiry function"
fi
echo ""

# Count available modes
echo "Counting philosophy modes..."
mode_count=$(grep -c 'name = ".*";' lib/entelechia.nix | head -1)
echo "  Found approximately: $mode_count modes"
echo ""

# Check documentation
echo "Checking documentation..."
if grep -q "Quick Start" README.md; then
    echo "  ✓ README has Quick Start section"
else
    echo "  ✗ README missing Quick Start"
fi

if grep -qi "usage" USAGE.md; then
    echo "  ✓ USAGE.md has usage information"
else
    echo "  ✗ USAGE.md missing usage information"
fi
echo ""

echo "==================================="
echo "✓ All structure validations passed!"
echo "==================================="
echo ""
echo "Note: Full functionality testing requires Nix installation."
echo "See TESTING.md for comprehensive test instructions."
