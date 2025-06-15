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
set backspace=indent,eol,start
set iskeyword-=_
set ttimeoutlen=0

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

" Mappings
imap <C-c> <Esc>
tnoremap <Esc> <C-\><C-n>
nnoremap <C-x><C-f> :e<space>
nnoremap <C-x>b :b<space>
nnoremap <C-x>k :bd<space>

" Term
autocmd TerminalOpen * setlocal nolist

" Style
set background=dark
set termguicolors
colorscheme habamax
hi MatchParen cterm=NONE ctermbg=green ctermfg=blue
hi TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+$/

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

" ALE
" Installation:
" mkdir -p ~/.vim/pack/git-plugins/start
" git clone --depth 1 https://github.com/dense-analysis/ale.git ~/.vim/pack/git-plugins/start/ale

let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
nnoremap <C-]> :ALEGoToDefinition<CR>
