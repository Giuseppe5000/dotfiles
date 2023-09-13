-- Plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

require("lazy").setup({
    'vim-airline/vim-airline',
    'preservim/nerdtree',
    'tpope/vim-fugitive',
    'lewis6991/gitsigns.nvim',
    'tpope/vim-commentary',
    'ryanoasis/vim-devicons', -- nerd-fonts required
    'dracula/vim',
    'RRethy/vim-illuminate',
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    'nvim-lua/plenary.nvim', -- telescope dependency

    -- LSP
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip'
})

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
vim.cmd.colorscheme('dracula')
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
vim.g['airline_theme'] = 'dracula'
vim.g['airline_powerline_fonts'] = 1
vim.g['airline_section_c'] = '%t'
vim.cmd('let g:airline_section_z = airline#section#create(["%p%%", " ℅:%v"])')
vim.g['airline#extensions#tabline#enabled'] = 2
vim.g['airline#extensions#tabline#show_close_button'] = 1
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

-- Gitsigns
require('gitsigns').setup()

-- Vim-illuminate default configuration
require('illuminate').configure({
    filetypes_denylist = {
        'dirvish',
        'fugitive',
        'nerdtree'
    }
})

-- change the highlight style
vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})

require('lsp')
