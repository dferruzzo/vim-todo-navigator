# Installation Guide - Vim Todo Navigator

## Prerequisites

- Vim 7.4 or higher (or Neovim)
- `grep` command available in your system (usually pre-installed on Unix-like systems)

## Installation Methods

### Method 1: Using vim-plug (Recommended)

1. Add this line to your `.vimrc` between the `call plug#begin()` and `call plug#end()` lines:

```vim
Plug 'dferruzzo/vim-todo-navigator'
```

2. Restart Vim and run:

```vim
:PlugInstall
```

### Method 2: Using Vundle

1. Add this line to your `.vimrc` between the `call vundle#begin()` and `call vundle#end()` lines:

```vim
Plugin 'dferruzzo/vim-todo-navigator'
```

2. Restart Vim and run:

```vim
:PluginInstall
```

### Method 3: Using Pathogen

1. Navigate to your bundle directory:

```bash
cd ~/.vim/bundle
```

2. Clone the repository:

```bash
git clone https://github.com/dferruzzo/vim-todo-navigator.git
```

3. Restart Vim.

### Method 4: Manual Installation

1. Create the directory structure:

```bash
mkdir -p ~/.vim/pack/plugins/start
```

2. Clone the repository:

```bash
cd ~/.vim/pack/plugins/start
git clone https://github.com/dferruzzo/vim-todo-navigator.git
```

3. Restart Vim.

### Method 5: Using Vim 8+ Native Package Manager

1. Create directories:

```bash
mkdir -p ~/.vim/pack/todo/start
```

2. Clone the repository:

```bash
cd ~/.vim/pack/todo/start
git clone https://github.com/dferruzzo/vim-todo-navigator.git
```

3. Restart Vim or run `:packloadall`.

## Post-Installation Setup

### Basic Configuration

Add these lines to your `.vimrc` for basic setup:

```vim
" Quick access mapping
nmap <F5> :TODOToggle<CR>

" Optional: Customize keywords (default shown)
let g:todo_navigator_keywords = ['TODO', 'FIXME', 'NOTE', 'HACK', 'BUG', 'CANCELLED', 'XXX']

" Optional: Customize file extensions (default shown)
let g:todo_navigator_file_extensions = ['*.py', '*.js', '*.ts', '*.java', '*.c', '*.cpp', '*.h', '*.html', '*.css', '*.md']

" Optional: Customize excluded directories (default shown)
let g:todo_navigator_exclude_dirs = ['.venv', 'venv', '__pycache__', '.git', 'node_modules']
```

### Verification

Test the installation by opening Vim in a project directory and running:

```vim
:TodoNavigator
```

You should see a split window showing any TODO-style comments found in your project.

## Help Documentation

After installation, access the built-in help with:

```vim
:help todo-navigator
```

## Troubleshooting

### No results found
- Ensure your files contain TODO/FIXME comments
- Check that file extensions match your configuration
- Verify you're running Vim from your project root

### Plugin not loading
- Check that the plugin files are in the correct directory
- For manual installation, ensure directory structure matches above
- Try `:scriptnames` to see if the plugin is loaded

### Permission issues
- Ensure you have write permissions to the Vim configuration directory
- For system-wide installation, you may need sudo privileges

For more help, see the [main README](../README.md) or [documentation](../doc/todo-navigator.txt).
