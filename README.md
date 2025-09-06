# Vim Todo Navigator

A Vim plugin that helps you quickly find and navigate TODO and FIXME comments in your codebase.

## Features

- 🔍 **Smart Search**: Recursively searches for TODO and FIXME comments in your project
- 📁 **Directory Exclusion**: Automatically excludes common directories like `.venv`, `node_modules`, `.git`, etc.
- 🎯 **File Type Filtering**: Configurable file extensions to search (defaults to Python files)
- 🎨 **Syntax Highlighting**: Color-coded TODO entries in the navigation buffer
- ⚡ **Quick Navigation**: Press Enter to jump directly to any TODO item
- 🔄 **Toggle Interface**: Easy toggle between TODO list and your code

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

### Navigation

In the TODO window:
- `<Enter>` - Jump to the selected TODO item
- `q` - Close the TODO window
- `<Esc>` - Close the TODO window

### Recommended Mapping

Add this to your `.vimrc` for quick access:

```vim
nmap <F5> :TODOToggle<CR>
```

## Configuration

### File Extensions

Customize which file types to search (default: `['*.py']`):

```vim
let g:todo_navigator_file_extensions = ['*.py', '*.js', '*.vim', '*.md', '*.txt']
```

### Excluded Directories

Customize which directories to exclude (default: `['.venv', 'venv', '__pycache__', '.git', 'node_modules']`):

```vim
let g:todo_navigator_exclude_dirs = ['.venv', 'venv', '__pycache__', '.git', 'node_modules', 'dist', 'build']
```

## Example Output

```
=== TODO/FIXME Navigator ===
Base directory: /home/user/my-project
Press <Enter> to open file, <q> to close

src/main.py:42:    # TODO: Implement error handling
lib/utils.py:15:   # FIXME: This function needs optimization
tests/test_main.py:8:  # TODO: Add more test cases
```

## Contributing

Contributions are welcome! Please feel free to:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

MIT License
