" YCM (installed with --clangd-completer)
let mapleader = '\<Space>'
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_list_stop_completion = ['<CR>']

" FZF
let g:fzf_layout = {'down':'~40%'}

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

" Mappings
nnoremap <C-enter> :term<cr>
nnoremap <C-t> :Lex<cr>
nnoremap <C-b> :Buffers<cr>
nnoremap <C-f> :Files<cr>'
nnoremap <leader>jd :YcmCompleter GoTo<cr>

" Explorer
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_liststyle = 3
let g:netrw_winsize = 12
let g:netrw_banner = 0

" Term
set term=kitty
set splitbelow

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

" Folding
set foldmethod=indent
set nofoldenable

" C/C++ format
autocmd FileType c,cpp setlocal equalprg=clang-format

" Theme
set background=dark
set termguicolors
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

" Status line
hi NameColor ctermbg=239 ctermfg=white
hi FileTypeColor ctermbg=239 ctermfg=green
hi ModifiedColor ctermbg=239 ctermfg=green
hi ErrorsColor ctermbg=239 ctermfg=red
hi WarningsColor ctermbg=239 ctermfg=yellow
hi DefaultColor ctermbg=239 ctermfg=white

set statusline=
set statusline+=%#NameColor#
set statusline+=\ %<%F
set statusline+=%#FileTypeColor#
set statusline+=\ %y
set statusline+=%#DefaultColor#
set statusline+=\ %{FugitiveStatusline()}
set statusline+=%#ModifiedColor#
set statusline+=\ %m
set statusline+=%=
set statusline+=%#ErrorsColor#
set statusline+=\ \ E:\ %{youcompleteme#GetErrorCount()}
set statusline+=%#WarningsColor#
set statusline+=\ \ W:\ %{youcompleteme#GetWarningCount()}
set statusline+=%#DefaultColor#
set statusline+=\ \ TotL:\ %L
set statusline+=\ \ Col:\ %c
set statusline+=\ \ %p%%\ 
set laststatus=2
