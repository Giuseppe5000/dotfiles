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

" Mappings
imap <C-c> <Esc>
cnoremap <C-g> <C-c>
nnoremap <C-t> :Lex<cr>
nnoremap <C-x><C-f> :e<Space>
nnoremap <C-x><C-s> :w<CR>
nnoremap <C-x>b :b!<Space>
nnoremap <C-x>k :bd<Space>
nnoremap <C-x><C-b> :buffers<CR>
nnoremap <C-x><C-l> :below terminal<CR>
tnoremap <Esc> <C-\><C-n>
exec "map \e! <M-!>"
nnoremap <M-!> :Compile<CR>
exec "map \ex <M-x>"
nnoremap <M-x> :

" Git mappings (feat. Magit)
nnoremap <C-x>gs :!git status<CR>
nnoremap <C-x>ga :!git add<Space>
nnoremap <C-x>gx :!git restore<Space>
nnoremap <C-x>gcc :!git commit -m "
nnoremap <C-x>gp :!git push<Space>
nnoremap <C-x>gf :!git pull<CR>
nnoremap <C-x>gd :!git diff<CR>
nnoremap <C-x>gD :!git diff --staged<CR>
nnoremap <C-x>gbb :!git checkout<Space>
nnoremap <C-x>gbc :!git checkout -b<Space>
nnoremap <C-x>gm :!git merge<Space>
nnoremap <C-x>gr :!git rebase<Space>
nnoremap <C-x>gz :!git stash<Space>
nnoremap <C-x>gll :!git log<CR>

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
let g:netrw_keepdir = 0

function! NetrwMapping()
    nm <buffer> h -
    nm <buffer> l gn
    nm <buffer> <Tab> <CR>
    nm <buffer> + d
    nm <buffer> C :!cp <cfile><Space>
    nm <buffer> u mF
    nm <buffer> z mz
endfunction
aug netrw_mapping
    au!
    au filetype netrw call NetrwMapping()
aug END

" Compilation mode like Emacs
command! Compile call SetMakePrgAndExec()
function! SetMakePrgAndExec()
    let l:make_command = input('Enter makeprg: ')
    execute 'setlocal makeprg=' . l:make_command
    make
endfunction

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
