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
let mapleader = "\<C-x>"
imap <C-c> <Esc>
cnoremap <C-g> <C-c>
nnoremap <leader><leader> :qa<CR>
nnoremap <C-t> :Lex<cr>
nnoremap <leader><C-f> :e *
nnoremap <leader><C-s> :w<CR>
nnoremap <leader>b :b!<Space>
nnoremap <leader>k :bd<Space>
nnoremap <leader><C-b> :buffers<CR>
nnoremap <leader><C-l> :below term<CR>
tnoremap <Esc> <C-\><C-n>
exec "map \e! <M-!>"
exec "map \e& <M-&>"
exec "map \ex <M-x>"
nnoremap <M-!> :Compile<CR>
nnoremap <M-&> :tab term<Space>
nnoremap <M-x> :

" Git mappings (feat. Magit)
nnoremap <leader>g<Space> :call UpdateGitStatus()<CR>
nnoremap <leader>gs :!git add<Space>
nnoremap <leader>gu :!git restore --staged<Space>
nnoremap <leader>gx :!git restore<Space>
nnoremap <leader>gcc :!git commit<CR>
nnoremap <leader>gp :!git push<Space>
nnoremap <leader>gF :!git pull<CR>
nnoremap <leader>gfa :!git fetch --all<CR>
nnoremap <leader>gd :tab term git diff<CR>
nnoremap <leader>gbb :!git checkout<Space>
nnoremap <leader>gbc :!git checkout -b<Space>
nnoremap <leader>gm :!git merge<Space>
nnoremap <leader>gr :!git rebase<Space>
nnoremap <leader>gz :!git stash<Space>
nnoremap <leader>gll :!git log<CR>

" Explorer
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_liststyle = 3
let g:netrw_winsize = 12
let g:netrw_banner = 0
let g:netrw_keepdir = 0
autocmd filetype netrw call NetrwMapping()

" Compilation mode like Emacs
command! Compile call SetMakePrgAndExec()

" Term
autocmd TerminalOpen * setlocal nolist

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

" Custom functions
function! UpdateGitStatus()
    let l:buffer_name = expand('%:t')
    if &buftype == 'terminal' && l:buffer_name == '!git status -v --show-stash'
        bd!
    endif
    tab term git status -v --show-stash
endfunction

function! NetrwMapping()
    nm <buffer> h -
        nm <buffer> l <CR>
    nm <buffer> <Tab> gn
    nm <buffer> + d
    nm <buffer> C :!cp <cfile><Space>
    nm <buffer> u mF
    nm <buffer> z mz
    nm <buffer> . gh
endfunction

function! SetMakePrgAndExec()
    let l:compile_command = input('Compile command: ')
    execute 'setlocal makeprg=' . l:compile_command
    make
endfunction
