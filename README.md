# 🚀 Modern Neovim Config

## Neovim Setup Preview
![preview](./assets/preview.png)
![floating terminal](./assets/floating-terminal.png)


## Features
- 🌈 Gruvbox colorscheme
- 🔍 Telescope fuzzy search
- 💡 LSP & autocompletion
- 🧠 Treesitter syntax
- 🗂️ File explorer (nvim-tree)
- 🖥️ Floating terminal



## 🔑⌨️ Key Mappings Guide

### Leader Key
- **Leader key:** `<Space>`

### Window Navigation
- `<Alt-j>` — Move to window below 
- `<Alt-k>` — Move to window above 
- `<Alt-h>` — Move to window left  
- `<Alt-l>` — Move to window right 

### Window Splitting
- `<leader>sv` — Vertical split  
- `<leader>sh` — Horizontal split  

### Floating Terminal
- `<leader>t` — Toggle floating terminal (in normal mode)
- `<ESC>`     — To normal mode
- `<i>`       — Insert mode

### File Finder
<leader>ff — Fuzzy find files (Telescope)


## 🛠️ Installation Guide

### Prerequisit:
##### (PowerShell)

winget install Neovim.Neovim  # Neovim
winget install Git.Git         # Git
winget install OpenJS.NodeJS   # Node.js (for LSP)
winget install python

### install:
git clone https://github.com/Daniel-Aridi/nvim-config.git "$env:LOCALAPPDATA\nvim"


