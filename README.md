# Vim Todo Navigator

A simple plugin to help you manage and navigate TODO comments in your code using Vim.

## Features

- Quickly find and jump between TODO, and FIXME comments.
- Customizable keywords.
- Lightweight and easy to use.

## Installation

Use your preferred plugin manager. For example, with [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'dferruzzo/vim_todo_navigator'
```

Then run:

```
:PlugInstall
```

## Usage

- Run `:TodoNavigator` to open the list of TODOs.
- Run `:TODOToggle` to toggle the buffer ON/OFF
- Use the provided mappings to jump between comments.

## TODO: Configuration

Add to your `.vimrc` to customize keywords:

```vim
let g:todo_navigator_keywords = ['TODO', 'FIXME', 'NOTE']
```

## Contributing

Pull requests and issues are welcome!

## License

MIT License