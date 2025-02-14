" General
set nocompatible
filetype plugin indent on
syntax on
set autoread
set number relativenumber
set cursorline
set noswapfile
set wildmenu
set wildmode=full
set wildoptions=pum
set path+=**
set clipboard=unnamedplus
set encoding=utf-8
set mouse=a
set sj=-50
set updatetime=1000
set belloff=all
set list
set lcs=space:·
set history=200
set complete=.,w,b,t
set autochdir

" Mappings
imap <C-c> <Esc>
nnoremap <C-t> :Lex<cr>
nnoremap <C-x><C-f> :e<Space>
nnoremap <C-x><C-s> :w<CR>
nnoremap <C-x>b :b<Space>
nnoremap <C-x>k :bd<CR>
nnoremap <C-x><C-b> :buffers<CR>
nnoremap <C-x><C-l> :below terminal<CR>
nnoremap <C-x>g :!git<Space>
tnoremap <Esc> <C-\><C-n>

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase

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

" Explorer
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_liststyle = 3
let g:netrw_winsize = 12
let g:netrw_banner = 0

fu! NetrwMapping()
    nm <buffer> h -
    nm <buffer> l <CR>
    nm <buffer> C gn
endf
aug netrw_mapping
    au!
    au filetype netrw call NetrwMapping()
aug END

" Theme
set background=dark
set termguicolors
colorscheme habamax
hi MatchParen cterm=NONE ctermbg=green ctermfg=blue

" Status line (feat. antirez)
hi User1 ctermfg=green ctermbg=black
hi User2 ctermfg=yellow ctermbg=black
hi User3 ctermfg=red ctermbg=black
hi User4 ctermfg=blue ctermbg=black
hi User5 ctermfg=white ctermbg=black

set statusline=
set statusline +=%1*\ %n\ %*
set statusline +=%5*%{&ff}%*
set statusline +=%3*%y%*
set statusline +=%4*\ %<%F%*
set statusline +=%2*%m%*
set statusline +=%4*%=(\%l,\%c)
set statusline +=%1*%5l%*
set statusline +=%2*/%L\ %*
set laststatus=2
