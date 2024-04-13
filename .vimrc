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

" Mappings
nn <C-t> :Lex<cr>
im <C-c> <Esc>

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

" C/C++ format
au FileType c,cpp setlocal equalprg=clang-format

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

" No arrows
nm <Up> <Nop>
nm <Down> <Nop>
nm <Left> <Nop>
nm <Right> <Nop>

" Theme
set background=dark
set termguicolors
colorscheme habamax
hi Normal guibg=NONE ctermbg=NONE
hi MatchParen cterm=NONE ctermbg=green ctermfg=blue

" Status line
hi White ctermbg=239 ctermfg=white
hi Green ctermbg=239 ctermfg=green

set statusline=
set statusline+=%#White#
set statusline+=\ %<%F
set statusline+=%#Green#
set statusline+=\ %y
set statusline+=\ %m
set statusline+=%=
set statusline+=%#White#
set statusline+=\ \ (\%l,\%c)
set statusline+=\ \ %p%%\ 
set laststatus=2

" GPG encrypted files
aug encrypted
    au!
    au BufReadPre,FileReadPre *.gpg set viminfo=
    au BufReadPre,FileReadPre *.gpg set noswapfile
    au BufReadPre,FileReadPre *.gpg set bin
    au BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
    au BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt 2> /dev/null
    au BufReadPost,FileReadPost *.gpg set nobin
    au BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
    au BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")
    au BufWritePre,FileWritePre *.gpg '[,']!gpg --default-recipient-self -ae 2>/dev/null
    au BufWritePost,FileWritePost *.gpg u
aug END
