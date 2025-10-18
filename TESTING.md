# Testing the Auto-Highlighting Feature

## Quick Start Test

1. **Reload Vim or source the plugin:**
   ```vim
   :source ~/.vim/pack/plugins/start/vim-todo-navigator/plugin/todo_navigator.vim
   " Or just restart Vim
   ```

2. **Open the demo file:**
   ```vim
   :e examples/highlight_demo.py
   ```
   
   You should see all TODO, FIXME, NOTE, HACK, BUG, CANCELLED, and XXX keywords automatically highlighted in different colors!

3. **Toggle highlighting on/off:**
   ```vim
   :TodoHighlight
   ```
   Keywords should disappear. Press again:
   ```vim
   :TodoHighlight
   ```
   Keywords should reappear.

4. **Test the navigator integration:**
   ```vim
   :TodoNavigator
   ```
   Press Enter on any item to jump to it. The keyword in the file should be highlighted.

## Test Cases

### Test 1: Automatic Highlighting on File Open

```vim
:e examples/test.py
```
**Expected:** The TODO keyword on line 11 should be highlighted in green.

### Test 2: Switching Between Buffers

```vim
:e examples/test.py
:e examples/highlight_demo.py
:bprev
:bnext
```
**Expected:** Keywords remain highlighted as you switch buffers.

### Test 3: Toggle in Current Buffer

```vim
:e examples/highlight_demo.py
:TodoHighlight
```
**Expected:** Highlights disappear, message says "disabled for this buffer"

```vim
:TodoHighlight
```
**Expected:** Highlights reappear, message says "enabled for this buffer"

### Test 4: Global Disable

```vim
:e examples/highlight_demo.py
:TodoHighlightDisable
```
**Expected:** Highlights disappear, message says "disabled globally"

```vim
:e examples/test.py
```
**Expected:** No highlights in the new file either.

```vim
:TodoHighlightEnable
```
**Expected:** Highlights appear in current buffer, message says "enabled globally"

### Test 5: Multiple Windows

```vim
:e examples/test.py
:vsplit examples/highlight_demo.py
```
**Expected:** Both windows show highlighted keywords.

```vim
:wincmd w
:TodoHighlight
```
**Expected:** Highlights disappear in active window only.

### Test 6: Custom Keywords

Add to `.vimrc`:
```vim
let g:todo_navigator_keywords = ['TODO', 'FIXME', 'IDEA', 'OPTIMIZE']
```

Restart Vim and create a test file:
```vim
:enew
```

Type:
```python
# TODO: test
# IDEA: new feature
# OPTIMIZE: improve performance
```

**Expected:** All three keywords are highlighted.

### Test 7: With TODO Navigator Window

```vim
:e examples/highlight_demo.py
:TodoNavigator
```

Press Enter on a TODO item.

**Expected:** 
- File opens at correct line
- Line flashes briefly (Search highlight)
- Keyword remains highlighted with its color

### Test 8: Disable by Default

Add to `.vimrc`:
```vim
let g:todo_navigator_auto_highlight = 0
```

Restart Vim and open a file:
```vim
:e examples/test.py
```

**Expected:** No keywords highlighted automatically.

```vim
:TodoHighlight
```

**Expected:** Keywords now appear.

## Verification Checklist

- [ ] Keywords highlight automatically when opening files
- [ ] `:TodoHighlight` toggles on/off correctly
- [ ] `:TodoHighlightEnable` works globally
- [ ] `:TodoHighlightDisable` works globally
- [ ] Colors are correct (TODO=green, FIXME=red, etc.)
- [ ] Works with split windows
- [ ] Works when switching buffers
- [ ] Doesn't interfere with existing syntax highlighting
- [ ] Works alongside TodoNavigator window
- [ ] `g:todo_navigator_auto_highlight = 0` disables auto-highlight
- [ ] No error messages in `:messages`
- [ ] Custom keywords work

## Common Issues and Solutions

### Issue: No Highlighting Appears

**Solution:**
```vim
:echo g:todo_navigator_auto_highlight
" Should be 1

:echo b:todo_navigator_highlight_enabled
" Should be 1

:call todo_navigator#HighlightKeywords()
" Manually trigger
```

### Issue: Colors Look Wrong

**Check your colorscheme:** Some colorschemes override syntax highlighting.

**Try:**
```vim
:highlight TodoKeyword_TODO
" Should show green color definition
```

### Issue: Highlights Persist After Disable

**Solution:**
```vim
:call todo_navigator#ClearKeywordHighlights()
:let b:todo_navigator_highlight_enabled = 0
```

## Performance Test

Open a large file with many TODOs:

```bash
# Generate test file with 1000 TODOs
for i in {1..1000}; do echo "# TODO: item $i"; done > /tmp/many_todos.py
```

```vim
:e /tmp/many_todos.py
```

**Expected:** File opens quickly, no lag when scrolling.

## Success Criteria

✅ All test cases pass  
✅ No error messages  
✅ Performance is acceptable  
✅ Features work as documented  
✅ Integration with existing features works smoothly
