" General
set nocompatible
filetype plugin indent on
syntax on
set autoread
set number relativenumber
set cursorline
set autochdir
set noswapfile
set splitbelow
set list
set wildmenu
set wildoptions=pum
set clipboard=unnamedplus
set encoding=utf-8
set mouse=a
set sj=-50
set updatetime=1000
set belloff=all
set lcs=space:·

" Mappings
nn <C-enter> :term<cr>
nn <C-t> :Lex<cr>
im <C-c> <Esc>

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

" Theme
set background=dark
set termguicolors
colorscheme habamax
hi Normal guibg=NONE ctermbg=NONE

" Status line
hi NameColor ctermbg=239 ctermfg=white
hi FileTypeColor ctermbg=239 ctermfg=green
hi ModifiedColor ctermbg=239 ctermfg=green
hi DefaultColor ctermbg=239 ctermfg=white

set statusline=
set statusline+=%#NameColor#
set statusline+=\ %<%F
set statusline+=%#FileTypeColor#
set statusline+=\ %y
set statusline+=%#ModifiedColor#
set statusline+=\ %m
set statusline+=%=
set statusline+=%#DefaultColor#
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
