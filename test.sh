#!/bin/bash
# Test script for vim-todo-navigator plugin
# This script performs basic validation tests

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_FILE="$SCRIPT_DIR/plugin/todo_navigator.vim"
EXAMPLES_DIR="$SCRIPT_DIR/examples"

echo "🧪 vim-todo-navigator Test Suite"
echo "=================================="
echo ""

# Test 1: Check if plugin file exists
echo "✓ Test 1: Plugin file exists"
if [ ! -f "$PLUGIN_FILE" ]; then
    echo "❌ FAILED: Plugin file not found at $PLUGIN_FILE"
    exit 1
fi
echo "  ✅ PASSED: $PLUGIN_FILE found"
echo ""

# Test 2: Check for syntax errors in plugin
echo "✓ Test 2: VimL syntax check"
if command -v vim &> /dev/null; then
    # Try to source the plugin and check for errors
    if vim -u NONE -N -c "source $PLUGIN_FILE" -c "qa!" 2>&1 | grep -i "error" > /dev/null; then
        echo "  ❌ FAILED: Syntax errors detected"
        vim -u NONE -N -c "source $PLUGIN_FILE" -c "qa!" 2>&1
        exit 1
    else
        echo "  ✅ PASSED: No syntax errors"
    fi
else
    echo "  ⚠️  SKIPPED: vim not found in PATH"
fi
echo ""

# Test 3: Check if grep is available
echo "✓ Test 3: Required dependencies"
if ! command -v grep &> /dev/null; then
    echo "  ❌ FAILED: grep not found (required for TODO search)"
    exit 1
fi
echo "  ✅ PASSED: grep is available"
echo ""

# Test 4: Check example files
echo "✓ Test 4: Example files exist"
if [ ! -d "$EXAMPLES_DIR" ]; then
    echo "  ❌ FAILED: Examples directory not found"
    exit 1
fi

if [ ! -f "$EXAMPLES_DIR/highlight_demo.py" ]; then
    echo "  ⚠️  WARNING: highlight_demo.py not found"
else
    echo "  ✅ PASSED: highlight_demo.py found"
fi
echo ""

# Test 5: Search for TODOs in example files
echo "✓ Test 5: Grep can find TODOs in examples"
TODO_COUNT=$(grep -r "TODO\|FIXME\|NOTE\|HACK\|BUG" "$EXAMPLES_DIR" 2>/dev/null | wc -l)
if [ "$TODO_COUNT" -eq 0 ]; then
    echo "  ⚠️  WARNING: No TODO comments found in examples"
else
    echo "  ✅ PASSED: Found $TODO_COUNT TODO-style comments"
fi
echo ""

# Test 6: Check documentation files
echo "✓ Test 6: Documentation exists"
DOC_FILES=("README.md" "CHANGELOG.md" "QUICK_TEST.md" "doc/AUTO_HIGHLIGHTING.md")
for doc in "${DOC_FILES[@]}"; do
    if [ -f "$SCRIPT_DIR/$doc" ]; then
        echo "  ✅ $doc"
    else
        echo "  ⚠️  Missing: $doc"
    fi
done
echo ""

# Test 7: Validate plugin version
echo "✓ Test 7: Plugin version check"
VERSION=$(grep "Version:" "$PLUGIN_FILE" | head -1 | awk '{print $3}')
if [ -z "$VERSION" ]; then
    echo "  ❌ FAILED: No version found in plugin"
    exit 1
fi
echo "  ✅ PASSED: Version $VERSION detected"
echo ""

# Test 8: Check for required functions
echo "✓ Test 8: Required functions defined"
FUNCTIONS=(
    "todo_navigator#ShowTodos"
    "todo_navigator#OpenTodoItem"
    "todo_navigator#TODOToggle"
    "todo_navigator#HighlightKeywords"
    "todo_navigator#ClearKeywordHighlights"
    "todo_navigator#ToggleKeywordHighlight"
    "todo_navigator#AutoHighlightKeywords"
)

MISSING_FUNCTIONS=0
for func in "${FUNCTIONS[@]}"; do
    if grep -q "function! $func()" "$PLUGIN_FILE"; then
        echo "  ✅ $func"
    else
        echo "  ❌ Missing: $func"
        MISSING_FUNCTIONS=$((MISSING_FUNCTIONS + 1))
    fi
done

if [ $MISSING_FUNCTIONS -gt 0 ]; then
    echo "  ❌ FAILED: $MISSING_FUNCTIONS function(s) missing"
    exit 1
fi
echo ""

# Test 9: Check for commands
echo "✓ Test 9: User commands defined"
COMMANDS=(
    "TodoNavigator"
    "ShowTodos"
    "TODOToggle"
    "TodoHighlight"
    "TodoHighlightEnable"
    "TodoHighlightDisable"
)

MISSING_COMMANDS=0
for cmd in "${COMMANDS[@]}"; do
    if grep -q "command! $cmd" "$PLUGIN_FILE"; then
        echo "  ✅ :$cmd"
    else
        echo "  ❌ Missing: :$cmd"
        MISSING_COMMANDS=$((MISSING_COMMANDS + 1))
    fi
done

if [ $MISSING_COMMANDS -gt 0 ]; then
    echo "  ❌ FAILED: $MISSING_COMMANDS command(s) missing"
    exit 1
fi
echo ""

# Test 10: Interactive Vim test (optional)
echo "✓ Test 10: Interactive test (optional)"
echo "  Run this to test interactively:"
echo "  $ vim -u NONE -N -c 'source $PLUGIN_FILE' -c 'e $EXAMPLES_DIR/highlight_demo.py'"
echo ""

# Summary
echo "=================================="
echo "✅ All automated tests passed!"
echo ""
echo "📝 Next steps:"
echo "   1. Open Vim: vim"
echo "   2. Source plugin: :source $PLUGIN_FILE"
echo "   3. Open demo: :e $EXAMPLES_DIR/highlight_demo.py"
echo "   4. Test navigation: :TodoNavigator"
echo "   5. Toggle highlight: :TodoHighlight"
echo ""
echo "📚 See QUICK_TEST.md for detailed manual testing guide"
echo "=================================="
