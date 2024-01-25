" YCM (installed with --clangd-completer)
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_autoclose_preview_window_after_insertion = 1
let mapleader = '\<Space>'
nnoremap <leader>jd :YcmCompleter GoTo<CR>

" FZF
let g:fzf_layout = {'down':'~40%'}
nnoremap <silent> <C-f> :Files<CR>'

" Plugins
call plug#begin()
    Plug 'ycm-core/YouCompleteMe'
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-fugitive'
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
set wildmenu
set wildoptions=pum
set clipboard=unnamedplus
set encoding=utf-8
set mouse=a
set scrolloff=6

" Term
set term=kitty
set splitbelow
nnoremap <C-Enter> :tab term<CR>

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
highlight NameColor ctermbg=239 ctermfg=white
highlight FileTypeColor ctermbg=239 ctermfg=green
highlight ModifiedColor ctermbg=239 ctermfg=green
highlight ErrorsColor ctermbg=239 ctermfg=red
highlight WarningsColor ctermbg=239 ctermfg=yellow
highlight Default ctermbg=239 ctermfg=white

set statusline=
set statusline+=%#NameColor#
set statusline+=\ %<%F
set statusline+=%#FileTypeColor#
set statusline+=\ %y
set statusline+=%#Default#
set statusline+=\ %{FugitiveStatusline()}
set statusline+=%#ModifiedColor#
set statusline+=\ %m
set statusline+=%=
set statusline+=%#ErrorsColor#
set statusline+=\ \ E:\ %{youcompleteme#GetErrorCount()}
set statusline+=%#WarningsColor#
set statusline+=\ \ W:\ %{youcompleteme#GetWarningCount()}
set statusline+=%#Default#
set statusline+=\ \ TotL:\ %L
set statusline+=\ \ Col:\ %c
set statusline+=\ \ %p%%\ 
set laststatus=2
