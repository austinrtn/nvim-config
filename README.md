# Neovim Configuration

Personal Neovim configuration with a focus on Zig development and efficient navigation.

## Special Features

- **Leader Key**: `,` (comma)
- **Modular Plugin System**: Plugins organized in `lua/plugins/` directory
- **LSP Support**: Zig Language Server (zls) with symbol navigation
- **Code Breadcrumbs**: Real-time function/class context in statusline via nvim-navic
- **Symbol Outline**: Aerial.nvim for tree-view of code structure
- **Fast File Navigation**: Harpoon for marking and jumping between frequently used files

## Plugin List

### Core Functionality
- **lazy.nvim** - Plugin manager
- **nvim-lspconfig** - LSP configuration
- **nvim-cmp** - Autocompletion engine
- **LuaSnip** - Snippet engine
- **nvim-treesitter** - Syntax highlighting and code parsing

### Navigation
- **telescope.nvim** - Fuzzy finder for files, buffers, and symbols
- **harpoon** - Quick file marking and navigation
- **nvim-tree.lua** - File explorer sidebar
- **aerial.nvim** - Code outline and symbol navigation
- **nvim-navic** - LSP-based breadcrumbs showing current code context

### LSP & Language Support
- **mason.nvim** - LSP/tool installer
- **zls** - Zig Language Server configuration
- **conform.nvim** - Code formatting

### Debugging
- **nvim-dap** - Debug Adapter Protocol client
- **nvim-dap-ui** - UI for debugging
- **nvim-dap-virtual-text** - Show variable values inline during debugging

### UI & Editing
- **mini.nvim** - Collection of minimal plugins (statusline, surround, text objects)
- **tokyonight.nvim** - Color scheme
- **which-key.nvim** - Keybinding hints
- **gitsigns.nvim** - Git integration in sign column
- **zen-mode.nvim** - Distraction-free writing mode
- **snacks.nvim** - UI utilities and notifications
- **todo-comments.nvim** - Highlight TODO/FIXME/etc in comments
- **nvim-autopairs** - Auto-close brackets and quotes
- **Comment.nvim** - Easy commenting
- **vim-sleuth** - Auto-detect indentation

## Keybindings

### Leader Key Actions

#### File Operations (`<leader>f`)
| Key | Action |
|-----|--------|
| `,ff` | Find files (Telescope) |
| `,fg` | Live grep (Telescope) |
| `,fb` | Browse buffers (Telescope) |
| `,fh` | Search help tags (Telescope) |
| `,fd` | Show diagnostics (Telescope) |
| `,fs` | LSP document symbols (Telescope) |
| `,f` | Format buffer |

#### File Tree (`<leader>e`)
| Key | Action |
|-----|--------|
| `,e` | Toggle file tree |
| `,ef` | Find current file in tree |

#### Code Actions (`<leader>c`)
| Key | Action |
|-----|--------|
| `,ca` | Code action |

#### Document/Debug (`<leader>d`)
| Key | Action |
|-----|--------|
| `,ds` | Document symbols (Telescope) |
| `,db` | Toggle breakpoint |
| `,dB` | Set conditional breakpoint |
| `,du` | Toggle debug UI |

#### Rename (`<leader>r`)
| Key | Action |
|-----|--------|
| `,rn` | Rename symbol |

#### Search (`<leader>s`)
| Key | Action |
|-----|--------|
| `,sh` | Search help |
| `,sk` | Search keymaps |
| `,sf` | Search files |
| `,ss` | Select Telescope picker |
| `,sw` | Search current word |
| `,sg` | Search by grep |
| `,sd` | Search diagnostics |
| `,sr` | Resume last search |
| `,s.` | Search recent files |
| `,s/` | Search in open files |
| `,sn` | Search Neovim config files |

#### Toggle (`<leader>t`)
| Key | Action |
|-----|--------|
| `,th` | Toggle inlay hints |

#### Workspace (`<leader>w`)
| Key | Action |
|-----|--------|
| `,ws` | Workspace symbols (Telescope) |

#### Other Leader Actions
| Key | Action |
|-----|--------|
| `,a` | Harpoon: Add file to list |
| `,o` | Toggle Aerial outline |
| `,q` | Open diagnostic quickfix list |
| `,D` | Type definition |
| `,/` | Fuzzy search in current buffer |
| `,<leader>` | Find existing buffers |

### LSP Keybindings
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gD` | Go to declaration |

### Harpoon Navigation
| Key | Action |
|-----|--------|
| `<C-e>` | Toggle Harpoon menu |
| `<C-h>` | Jump to Harpoon file 1 |
| `<C-t>` | Jump to Harpoon file 2 |
| `<C-n>` | Jump to Harpoon file 3 |
| `<C-s>` | Jump to Harpoon file 4 |
| `<C-S-P>` | Previous Harpoon file |
| `<C-S-N>` | Next Harpoon file |

### Aerial Navigation (Symbol Outline)
| Key | Action |
|-----|--------|
| `{` | Previous symbol (when aerial is open) |
| `}` | Next symbol (when aerial is open) |
| `o` | Toggle fold in aerial window |
| `q` | Close aerial window |

### Window Navigation
| Key | Action |
|-----|--------|
| `<C-h>` | Move to left window |
| `<C-l>` | Move to right window |
| `<C-j>` | Move to lower window |
| `<C-k>` | Move to upper window |

### Debugging (F-keys)
| Key | Action |
|-----|--------|
| `<F5>` | Continue/Start debugging |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |

### Other
| Key | Action |
|-----|--------|
| `<Esc>` | Clear search highlights |
| `<Esc><Esc>` | Exit terminal mode |

## Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Main entry point
├── kickstart.lua           # Kickstart.nvim base configuration
├── lua/
│   └── plugins/            # Modular plugin configurations
│       ├── aerial.lua      # Symbol outline
│       ├── autopairs.lua   # Auto-close pairs
│       ├── colorscheme.lua # Theme configuration
│       ├── comment.lua     # Commenting plugin
│       ├── completion.lua  # Completion setup
│       ├── dap.lua         # Debugging
│       ├── harpoon.lua     # File navigation
│       ├── lsp.lua         # LSP configuration
│       ├── luasnip-snippets.lua # Snippet definitions
│       ├── navic.lua       # Breadcrumbs
│       ├── nvim-tree.lua   # File tree
│       ├── persistence.lua # Session management
│       ├── snacks.lua      # UI utilities
│       ├── telescope.lua   # Fuzzy finder
│       ├── zen-mode.lua    # Distraction-free mode
│       └── zls.lua         # Zig LSP
└── README.md              # This file
```

## Notes

- Based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- Optimized for Zig development with zls integration
- Uses mini.statusline with nvim-navic for contextual breadcrumbs
- Aerial provides a comprehensive symbol outline sidebar
- Harpoon provides fast navigation between frequently accessed files
