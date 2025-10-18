# Auto-Highlighting Feature

## Overview

The vim-todo-navigator plugin now supports **automatic keyword highlighting** in all opened files! This means that whenever you open any file in Vim, all TODO, FIXME, NOTE, and other configured keywords will be automatically highlighted with different colors.

## How It Works

### Automatic Mode (Default)

By default, the plugin automatically highlights keywords when you:
- Open a new file (`:edit`, `:open`)
- Switch between buffers (`:bnext`, `:bprev`)
- Enter a window (`<C-w>w`)

Keywords are highlighted using syntax matching, which means they won't interfere with your existing syntax highlighting and will work alongside it.

## Color Scheme

Each keyword type has its own distinct color:

| Keyword    | Color   | Purpose                        |
|------------|---------|--------------------------------|
| TODO       | Green   | Tasks to be completed          |
| FIXME      | Red     | Code that needs fixing         |
| NOTE       | Cyan    | Important notes or reminders   |
| HACK       | Orange  | Temporary workarounds          |
| BUG        | Red     | Known bugs or issues           |
| CANCELLED  | Gray    | Cancelled or deprecated items  |
| XXX        | Red     | Critical attention needed      |

## Commands

### Toggle Highlighting

- `:TodoHighlight` - Toggle highlighting on/off for the **current buffer only**
  - First press: disables highlighting in current buffer
  - Second press: enables highlighting in current buffer

### Global Control

- `:TodoHighlightEnable` - Enable auto-highlighting for **all buffers**
  - Sets `g:todo_navigator_auto_highlight = 1`
  - Highlights current buffer immediately
  
- `:TodoHighlightDisable` - Disable auto-highlighting for **all buffers**
  - Sets `g:todo_navigator_auto_highlight = 0`
  - Clears highlighting in current buffer

## Configuration

### Disable Auto-Highlighting by Default

Add to your `.vimrc`:

```vim
let g:todo_navigator_auto_highlight = 0
```

Then you can manually enable it with `:TodoHighlight` when needed.

### Custom Key Mappings

```vim
" Quick toggle for current buffer
nmap <F6> :TodoHighlight<CR>

" Or use <leader> mappings
nmap <leader>th :TodoHighlight<CR>
nmap <leader>te :TodoHighlightEnable<CR>
nmap <leader>td :TodoHighlightDisable<CR>
```

### Customize Keywords

The highlighting uses the same keywords as the navigator:

```vim
let g:todo_navigator_keywords = ['TODO', 'FIXME', 'NOTE', 'HACK', 'BUG', 'IDEA', 'OPTIMIZE']
```

All keywords will be automatically highlighted with colors (though custom keywords will use default highlighting unless you add custom highlight groups).

## Use Cases

### 1. Code Review
When reviewing code, the auto-highlighting makes it easy to spot all comments that need attention without having to manually search.

### 2. Project Onboarding
New team members can quickly identify areas that need work or have known issues.

### 3. Refactoring
During refactoring sessions, highlighted TODOs and FIXMEs serve as visual reminders of pending tasks.

### 4. Focus Mode
If highlighting becomes distracting, use `:TodoHighlight` to toggle it off for the current file while keeping it on for others.

## Technical Details

### Syntax Matching

The plugin uses Vim's syntax matching with word boundaries:

```vim
syntax match TodoKeyword_TODO /\<TODO\>/
```

This matches the keyword as a complete word, so:
- ✅ Matches: `# TODO: fix this`, `// TODO`, `/* TODO */`
- ❌ Doesn't match: `TODOLIST`, `MyTODOClass`

### Buffer-Local State

Each buffer maintains its own state (`b:todo_navigator_highlight_enabled`), so you can have highlighting enabled in some files and disabled in others.

### Autocommands

The plugin registers autocommands that trigger on:
- `BufEnter` - When entering a buffer
- `BufWinEnter` - When showing a buffer in a window
- `WinEnter` - When entering a window

These ensure highlighting is applied consistently across all file operations.

## Troubleshooting

### Highlighting Not Working

1. Check if auto-highlight is enabled:
   ```vim
   :echo g:todo_navigator_auto_highlight
   ```
   Should return `1`

2. Check buffer state:
   ```vim
   :echo b:todo_navigator_highlight_enabled
   ```
   Should return `1`

3. Manually trigger highlighting:
   ```vim
   :call todo_navigator#HighlightKeywords()
   ```

### Conflicts with Other Plugins

If you have other plugins that also highlight TODO comments (like vim-commentary, etc.), they might conflict. You can:

1. Disable auto-highlighting: `let g:todo_navigator_auto_highlight = 0`
2. Use it selectively with `:TodoHighlight` only when needed
3. Adjust the order of plugin loading in your plugin manager

### Performance with Large Files

The syntax highlighting is lightweight and shouldn't impact performance. However, if you experience issues:

1. Disable auto-highlighting for large files
2. Use `:TodoHighlight` to toggle off when not needed
3. Consider reducing the number of keywords in `g:todo_navigator_keywords`

## Examples

### Example 1: Working on a Python Project

```python
def process_data(data):
    # TODO: Add error handling
    # FIXME: This is slow with large datasets
    result = []
    for item in data:
        # NOTE: Handles None values
        if item:
            result.append(item * 2)
    return result
```

When you open this file, all three keywords will be immediately visible with their respective colors!

### Example 2: Toggle While Presenting

When sharing your screen during a presentation:

```vim
" Hide TODOs temporarily
:TodoHighlight

" Present your code...

" Show TODOs again
:TodoHighlight
```

### Example 3: Different Settings Per Project

In project A's `.vimrc`:
```vim
let g:todo_navigator_auto_highlight = 1
```

In project B's `.vimrc`:
```vim
let g:todo_navigator_auto_highlight = 0
```

## Integration with Navigation Feature

The auto-highlighting feature works seamlessly with the TODO Navigator window:

1. Use `:TODOToggle` (F5) to see all TODOs across your project
2. Keywords are already highlighted in the files you're viewing
3. When you jump to a TODO from the navigator window, the line is both highlighted by the temporary flash AND the keyword itself is color-coded

This creates a comprehensive workflow for managing TODOs!
