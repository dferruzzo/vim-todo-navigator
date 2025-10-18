# Vim Todo Navigator

A Vim plugin that helps you quickly find and navigate TODO, FIXME, NOTE, and other custom comment tags in your codebase.

## Features

- 🔍 **Smart Search**: Recursively searches for customizable keywords in your project
- 🏷️ **Custom Keywords**: Configurable tags (TODO, FIXME, NOTE, HACK, BUG, CANCELLED, XXX, etc.)
- 📁 **Directory Exclusion**: Automatically excludes common directories like `.venv`, `node_modules`, `.git`, etc.
- 🎯 **File Type Filtering**: Configurable file extensions to search across multiple languages
- 🎨 **Color-Coded Tags**: Different colors for different tag types with syntax highlighting
- ⚡ **Quick Navigation**: Press Enter to jump directly to any tagged item
- 🔄 **Toggle Interface**: Easy toggle between tag list and your code
- ✨ **Auto-Highlighting**: Automatically highlights TODO keywords in all opened files
- 🎯 **Per-Buffer Control**: Toggle highlighting on/off for individual files

## Installation

### Using vim-plug

```vim
Plug 'dferruzzo/vim-todo-navigator'
```

### Using Vundle

```vim
Plugin 'dferruzzo/vim-todo-navigator'
```

### Manual Installation

1. Clone this repository to your Vim plugins directory:
```bash
git clone https://github.com/dferruzzo/vim-todo-navigator.git ~/.vim/pack/plugins/start/vim-todo-navigator
```

## Usage

### Commands

- `:TodoNavigator` - Opens the TODO navigation window
- `:ShowTodos` - Alias for `:TodoNavigator`
- `:TODOToggle` - Toggles the TODO window on/off
- `:TodoHighlight` - Toggles keyword highlighting in current buffer
- `:TodoHighlightEnable` - Enables auto-highlighting globally
- `:TodoHighlightDisable` - Disables auto-highlighting globally

### Navigation

In the TODO window:
- `<Enter>` - Jump to the selected TODO item
- `q` - Close the TODO window
- `<Esc>` - Close the TODO window

### Recommended Mapping

Add this to your `.vimrc` for quick access:

```vim
" Toggle TODO navigation window
nmap <F5> :TODOToggle<CR>

" Toggle keyword highlighting in current buffer
nmap <F6> :TodoHighlight<CR>
```

## Configuration

### Keywords/Tags

Customize which keywords to search for (default: `['TODO', 'FIXME', 'NOTE', 'HACK', 'BUG', 'CANCELLED', 'XXX']`):

```vim
let g:todo_navigator_keywords = ['TODO', 'FIXME', 'NOTE', 'REVIEW', 'OPTIMIZE', 'HACK']
```

### File Extensions

Customize which file types to search (default: `['*.py', '*.js', '*.ts', '*.java', '*.c', '*.cpp', '*.h', '*.html', '*.css', '*.md']`):

```vim
let g:todo_navigator_file_extensions = ['*.py', '*.js', '*.vim', '*.md', '*.txt']
```

### Excluded Directories

Customize which directories to exclude (default: `['.venv', 'venv', '__pycache__', '.git', 'node_modules']`):

```vim
let g:todo_navigator_exclude_dirs = ['.venv', 'venv', '__pycache__', '.git', 'node_modules', 'dist', 'build']
```

### Auto-Highlighting

By default, the plugin automatically highlights TODO keywords in all opened files. You can disable this:

```vim
" Disable automatic highlighting
let g:todo_navigator_auto_highlight = 0
```

Or toggle it on-demand with:
- `:TodoHighlight` - Toggle for current buffer
- `:TodoHighlightEnable` - Enable globally
- `:TodoHighlightDisable` - Disable globally

## Color Coding

Different tag types are highlighted with different colors:

- **TODO** - Green (tasks to be done)
- **FIXME** - Red (things that need fixing)
- **NOTE** - Cyan (important notes)
- **HACK** - Orange (temporary workarounds)
- **BUG** - Red (known issues)
- **CANCELLED** - Gray with strikethrough (cancelled items)
- **XXX** - Red (urgent attention needed)

## Example Output

```
=== TODO Navigator ===
Base directory: /home/user/my-project
Keywords: TODO, FIXME, NOTE, HACK, BUG, CANCELLED, XXX
Press <Enter> to open file, <q> to close

src/main.py:42:    # TODO: Implement error handling
lib/utils.py:15:   # FIXME: This function needs optimization
tests/test_main.py:8:  # NOTE: Add more test cases
config/settings.py:23: # HACK: Temporary fix for API issue
src/parser.py:67:  # BUG: Edge case not handled properly
old/deprecated.py:12:  # CANCELLED: Feature no longer needed
```

## Contributing

Contributions are welcome! Please feel free to:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

MIT License
