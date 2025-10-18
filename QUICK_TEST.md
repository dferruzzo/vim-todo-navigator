# Quick Test Guide - vim-todo-navigator

## 🚀 Fast 5-Minute Test

### Step 1: Open Vim in the Project Directory

```bash
cd ~/vim-todo-navigator
vim
```

### Step 2: Source the Plugin

Inside Vim, run:
```vim
:source plugin/todo_navigator.vim
```

You should see no errors. If successful, the plugin is loaded! ✅

### Step 3: Test Auto-Highlighting

Open the demo file:
```vim
:e examples/highlight_demo.py
```

**What to expect:**
- All TODO, FIXME, NOTE, HACK, BUG keywords should be **highlighted in colors**
- TODO = Green
- FIXME/BUG = Red  
- NOTE = Cyan
- HACK = Orange

If you see colors, the auto-highlighting works! 🎉

### Step 4: Test Toggle

Toggle highlighting off:
```vim
:TodoHighlight
```

**What to expect:**
- All keyword colors disappear
- Message: "TODO keyword highlighting disabled for this buffer"

Toggle it back on:
```vim
:TodoHighlight
```

**What to expect:**
- Keywords are colored again
- Message: "TODO keyword highlighting enabled for this buffer"

### Step 5: Test Navigation Window

Open the TODO navigator:
```vim
:TodoNavigator
```

**What to expect:**
- Split window opens at the top
- Shows header: "=== TODO Navigator ==="
- Lists all TODOs from the project with colors
- Shows file:line:content format

Navigate in the TODO window:
- Press `j/k` to move up/down
- Press `Enter` on any TODO line
- File should open at that exact line
- Line briefly flashes yellow

Press `q` to close the TODO window.

### Step 6: Test Toggle Window

```vim
:TODOToggle
```
Opens the window.

```vim
:TODOToggle
```
Closes the window.

---

## 🎯 Quick Visual Test

Create a new test file:
```vim
:enew
:set filetype=python
```

Type this:
```python
# TODO: first task
# FIXME: broken code
# NOTE: important info
# BUG: known issue
# HACK: temporary fix
```

**Expected Result:** Each keyword should be highlighted in different colors instantly! 🌈

---

## 🔧 If Something Doesn't Work

### Auto-highlighting not showing?

Check if it's enabled:
```vim
:echo g:todo_navigator_auto_highlight
```
Should return: `1`

If it returns `0`, enable it:
```vim
:TodoHighlightEnable
```

### Navigation window empty?

Make sure you have TODO comments in your files:
```bash
# From terminal
cd ~/vim-todo-navigator/examples
grep -r "TODO\|FIXME" .
```

If empty, the demo files might not have TODOs. Use `highlight_demo.py` which has many.

### No colors at all?

Your terminal might not support colors. Check:
```vim
:echo &t_Co
```
Should return: `256` or higher

Try in gVim/NeoVim for better color support.

---

## ✅ Success Checklist

- [ ] Plugin loads without errors (`:source plugin/todo_navigator.vim`)
- [ ] Keywords are auto-highlighted when opening files
- [ ] `:TodoHighlight` toggles highlighting on/off
- [ ] `:TodoNavigator` opens navigation window
- [ ] Navigation window lists TODOs from project
- [ ] Pressing Enter jumps to correct file and line
- [ ] `:TODOToggle` opens/closes window
- [ ] Colors are visible (green, red, cyan, orange)
- [ ] No error messages in `:messages`

If all items are checked, the plugin is working perfectly! ✨

---

## 🎮 Advanced Tests

### Test with Multiple Files

```vim
:e examples/test.py
:vsplit examples/highlight_demo.py
:wincmd w
```

Both windows should show highlighted keywords.

### Test Disable Globally

```vim
:TodoHighlightDisable
:e examples/test.c
```

No keywords should be highlighted in the new file.

```vim
:TodoHighlightEnable
```

Keywords appear again.

### Test Custom Keywords

Add to a file:
```python
# IDEA: new feature idea
# OPTIMIZE: performance improvement needed
```

These won't be highlighted by default (not in keyword list).

Add them to the keyword list:
```vim
:let g:todo_navigator_keywords = ['TODO', 'FIXME', 'NOTE', 'IDEA', 'OPTIMIZE']
:call todo_navigator#HighlightKeywords()
```

Now IDEA and OPTIMIZE should be highlighted too!

---

## 🐛 Troubleshooting

### Error: "command not found"

The plugin isn't loaded. Run:
```vim
:source plugin/todo_navigator.vim
```

### Error: "grep: command not found"

Install grep:
```bash
# Ubuntu/Debian
sudo apt install grep

# macOS (should be pre-installed)
which grep
```

### Highlights disappeared after switching buffers

This is normal if auto-highlight is disabled. Re-enable:
```vim
:let g:todo_navigator_auto_highlight = 1
```

### Colors look weird

Some color schemes override the plugin colors. Try:
```vim
:colorscheme desert
" or
:colorscheme industry
```

---

## 📝 Make it Permanent

Once tested and working, add to your `~/.vimrc`:

```vim
" Load vim-todo-navigator (if not using a plugin manager)
source ~/vim-todo-navigator/plugin/todo_navigator.vim

" Optional: Key mappings
nmap <F5> :TODOToggle<CR>
nmap <F6> :TodoHighlight<CR>

" Optional: Customize keywords
let g:todo_navigator_keywords = ['TODO', 'FIXME', 'NOTE', 'HACK', 'BUG']

" Optional: Disable auto-highlight (if you prefer manual)
" let g:todo_navigator_auto_highlight = 0
```

Restart Vim and the plugin will work automatically! 🎊
