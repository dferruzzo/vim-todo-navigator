# Changelog

All notable changes to vim-todo-navigator will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2025-10-18

### Added
- **Auto-highlighting feature**: Automatically highlights TODO keywords in all opened files
- New command `:TodoHighlight` - Toggle keyword highlighting for current buffer
- New command `:TodoHighlightEnable` - Enable auto-highlighting globally
- New command `:TodoHighlightDisable` - Disable auto-highlighting globally
- New configuration variable `g:todo_navigator_auto_highlight` (default: 1)
- Autocommands for automatic keyword highlighting on buffer/window enter
- Per-buffer state tracking for highlight status
- Dynamic syntax matching for all configured keywords
- Color-coded highlighting that works alongside existing syntax highlighting

### Changed
- Updated documentation with auto-highlighting instructions
- Enhanced color definitions with GUI color codes for better gVim/NeoVim support
- Improved syntax patterns to use word boundaries for more accurate matching

### Documentation
- Added `AUTO_HIGHLIGHTING.md` - Comprehensive guide for the new feature
- Added `TESTING.md` - Test cases and verification procedures
- Updated `README.md` with auto-highlighting feature description
- Added recommended F6 key mapping for quick highlight toggle
- Created `examples/highlight_demo.py` - Demo file showing all keyword types

## [1.0.0] - 2025-10-17

### Added
- Initial release of vim-todo-navigator
- Core navigation window with TODO/FIXME/NOTE/HACK/BUG/CANCELLED/XXX support
- Command `:TodoNavigator` - Opens TODO navigation window
- Command `:ShowTodos` - Alias for TodoNavigator
- Command `:TODOToggle` - Toggle TODO window on/off
- Configuration variable `g:todo_navigator_keywords`
- Configuration variable `g:todo_navigator_file_extensions`
- Configuration variable `g:todo_navigator_exclude_dirs`
- Recursive grep-based search through project files
- Color-coded keyword display in navigation window
- Quick jump to TODO location with Enter key
- Syntax highlighting in TODO navigation buffer
- Directory exclusion support (.git, node_modules, etc.)
- File extension filtering
- Status line with current position
- Keyboard shortcuts (q/Esc to close, Enter to jump)
- MIT License
- Basic documentation and examples

### Technical
- Uses grep for fast recursive search
- Creates temporary nofile buffers for display
- Implements custom syntax highlighting
- Supports both terminal and GUI vim
- Compatible with Vim 8.0+

---

## Version History Summary

- **v1.1.0** (2025-10-18): Added auto-highlighting feature
- **v1.0.0** (2025-10-17): Initial release with core navigation features

---

## Upgrade Notes

### From 1.0.0 to 1.1.0

The upgrade is fully backward compatible. The new auto-highlighting feature is:
- Enabled by default (`g:todo_navigator_auto_highlight = 1`)
- Can be disabled by setting `let g:todo_navigator_auto_highlight = 0` in your `.vimrc`
- Adds no new dependencies
- Does not modify existing functionality

No changes to your configuration are required unless you want to customize the new feature.

---

## Future Roadmap

### Planned Features
- [ ] Refresh command to update TODO list without reopening
- [ ] Sort options (by file, by keyword type, by date)
- [ ] Filter options in navigation window
- [ ] Context preview (show surrounding lines)
- [ ] Integration with quickfix list
- [ ] Support for custom keyword colors
- [ ] Async search for better performance on large projects
- [ ] Cache mechanism for faster repeated searches
- [ ] Statistics view (count by type, by file, etc.)
- [ ] Export TODO list to markdown/text file

### Under Consideration
- Windows support (PowerShell/CMD compatibility)
- Integration with task management tools
- Git blame integration for TODOs
- Age tracking (when was TODO added)
- Priority levels in comments
- Due dates support
