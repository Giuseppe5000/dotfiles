" Plugin settings
let NERDTreeMinimalUI = 1
nnoremap <C-t> :NERDTreeToggle<CR>

" Plugins
call plug#begin()
    Plug 'preservim/nerdtree'
    Plug 'tpope/vim-commentary'
    Plug 'morhetz/gruvbox'
call plug#end()

" General
filetype plugin indent on
syntax on
set nocompatible
set autoread
set number
set cursorline
set autochdir
set clipboard=unnamedplus
set encoding=utf-8
set mouse=a
set scrolloff=6

" Term
set splitbelow
set termwinsize=10x0

" Search
set incsearch
set hlsearch
set ignorecase

" Indent
set autoindent
set smartindent
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" Format
autocmd FileType c,cpp setlocal equalprg=clang-format

" Theme
set background=dark
set termguicolors
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

" Status line
set statusline=
set statusline +=\ %<%F              "full path
set statusline +=\ %y                "file type
set statusline +=%m                  "modified flag
set statusline +=%=
set statusline +=\ \ Column:\ %c     "column
set statusline +=\ \ %p%%\ \ \       "percentage
set laststatus=2
