-- Plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'ryanoasis/vim-devicons' -- nerd-fonts required
Plug 'joshdick/onedark.vim'
Plug 'mhinz/vim-startify'

-- LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

vim.call('plug#end')

-- Generic
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.mouse = 'a'
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.autoread = true
vim.opt.title = true
vim.opt.clipboard = 'unnamedplus' -- wl-clipboard or xclip required
vim.cmd([[
    filetype plugin indent on
    aunmenu PopUp.How-to\ disable\ mouse
    aunmenu PopUp.-1-
]])

-- Colorscheme
vim.cmd.syntax('on')
vim.cmd.colorscheme('onedark')
vim.opt.termguicolors = true

-- Font
vim.opt.encoding = 'UTF-8'
vim.opt.guifont = 'DejaVu Sans Mono:h10'

-- Tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Working dir
vim.opt.autochdir = true

-- Terminal
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
vim.api.nvim_create_autocmd('TermOpen', {
    pattern = '*',
    command = 'setlocal nonumber norelativenumber'
})

-- Airline
vim.g['airline_theme'] = 'onedark'
vim.g['airline_powerline_fonts'] = 1
vim.g['airline_section_c'] = '%t'
vim.cmd('let g:airline_section_z = airline#section#create(["%p%%", " ℅:%v"])')
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#show_close_button'] = 0
vim.g['airline#extensions#tabline#tabs_label'] = ''
vim.g['airline#extensions#tabline#buffers_label'] = ''
vim.g['airline#extensions#tabline#fnamemod'] = ':t'
vim.g['airline#extensions#tabline#show_tab_count'] = 0
vim.g['airline#extensions#tabline#show_buffers'] = 0
vim.g['airline#extensions#tabline#tab_min_count'] = 2
vim.g['airline#extensions#tabline#show_splits'] = 0
vim.g['airline#extensions#tabline#show_tab_nr'] = 0
vim.g['airline#extensions#tabline#show_tab_type'] = 0

-- NERDTree
vim.keymap.set('n', '<C-t>', ':NERDTreeToggle<CR>')
vim.g['NERDTreeMinimalUI'] = 1

-- Startify
vim.cmd([[
    let s:startify_ascii_header = [
    \ '                                       ██           ',
    \ '                                                    ',
    \ ' ███▄    █  ▓█████ ▒█████   ██▒   █▓  ██▓ ███▄ ▄███▓',
    \ ' ██ ▀█   █  ▓█   ▀▒██▒  ██▒▓██░   █▒▒▓██▒▓██▒▀█▀ ██▒',
    \ '▓██  ▀█ ██▒ ▒███  ▒██░  ██▒ ▓██  █▒░▒▒██▒▓██    ▓██░',
    \ '▓██▒  ▐▌██▒ ▒▓█  ▄▒██   ██░  ▒██ █░░░░██░▒██    ▒██ ',
    \ '▒██░   ▓██░▒░▒████░ ████▓▒░   ▒▀█░  ░░██░▒██▒   ░██▒',
    \ '░ ▒░   ▒ ▒ ░░░ ▒░ ░ ▒░▒░▒░    ░ ▐░   ░▓  ░ ▒░   ░  ░',
    \ '░ ░░   ░ ▒░░ ░ ░    ░ ▒ ▒░    ░ ░░  ░ ▒ ░░  ░      ░',
    \ '   ░   ░ ░     ░  ░ ░ ░ ▒       ░░  ░ ▒ ░░      ░ ',
    \ '         ░ ░   ░      ░ ░        ░    ░         ░ ',
    \ '',
    \]
    let g:startify_custom_header = map(s:startify_ascii_header + startify#fortune#quote(), '"   ".v:val')
    let g:startify_lists = [{'type': 'files', 'header': ['   Recently used']}]
]])

require('lsp')
