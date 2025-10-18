#!/bin/bash
# Simple one-command test for vim-todo-navigator

echo "Opening Vim with plugin loaded and demo file..."
echo ""
echo "When Vim opens:"
echo "  1. You should see TODO keywords highlighted in COLORS"
echo "  2. Press :TodoNavigator<Enter> to see full TODO list"
echo "  3. Press Enter on any TODO to jump to it"
echo "  4. Press q to close TODO window"
echo "  5. Press :TodoHighlight<Enter> to toggle highlights on/off"
echo "  6. Press :qa<Enter> to exit"
echo ""
echo "Press Enter to continue..."
read

vim -u NONE -N \
    -c "source $(dirname "$0")/plugin/todo_navigator.vim" \
    -c "e $(dirname "$0")/examples/highlight_demo.py" \
    -c "echo 'Plugin loaded! Keywords should be highlighted. Try :TodoNavigator'"
