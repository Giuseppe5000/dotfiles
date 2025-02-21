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
nnoremap <leader><C-f> :Hex<CR>
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
nnoremap <leader>g :call GitStatus()<CR>
autocmd TerminalOpen * if expand('%:t') =~ '^!git status -v --show-stash' | call GitTermMapping()
function! GitTermMapping()
    nn <buffer> s :call GitFileOp("git add")<CR>
    nn <buffer> u :call GitFileOp("git restore --staged")<CR>
    nn <buffer> x :call GitFileOp("git restore")<CR>
    nn <buffer> cc :call GitOp("!git commit")<CR>
    nn <buffer> p :call GitInputOp("git push", "Push to: ")<CR>
    nn <buffer> Fu :call GitOp("!git pull")<CR>
    nn <buffer> fa :call GitOp("!git fetch --all")<CR>
    nn <buffer> d :tab term git diff<CR>
    nn <buffer> bb :call GitInputOp("git checkout", "Checkout: ")<CR>
    nn <buffer> bc :call GitInputOp("git checkout -b", "Name for new branch: ")<CR>
    nn <buffer> m :call GitInputOp("git merge", "Merge: ")<CR>
    nn <buffer> r :call GitInputOp("git rebase", "Rebase: ")<CR>
    nn <buffer> z :!git stash<Space>
    nn <buffer> ll :!git log<CR>
    nn <buffer> q :bd<CR>
endfunction

" Netrw mappings
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_keepdir = 0
autocmd filetype netrw call NetrwMapping()
function! NetrwMapping()
    nm <buffer> h -:call NetrwCollapse()<CR>
    nm <buffer> l <CR>gn
    nm <buffer> + d
    nm <buffer> C :!cp <cfile><Space>
    nm <buffer> u mF
    nm <buffer> z mz
    nm <buffer> . gh
    nm <buffer> q :bd!<CR>
endfunction

" Compilation mode like Emacs
command! Compile call SetMakePrgAndExec()
autocmd filetype qf nm <buffer> q :bd!<CR>

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

" Custom functions
function! GitStatus()
    let l:buffer_name = expand('%:t')
    rightb vert term git status -v --show-stash
    if l:buffer_name =~ '^!git status -v --show-stash'
        bd #
    endif
    sleep 50ms
    goto 1
endfunction

function! GitFileOp(gitCommand)
    let l:current_line = getline(line('.'))
    let l:file = trim(split(l:current_line, ":")[1])
    if a:gitCommand == 'git restore' && confirm("Delete " . shellescape(l:file) . " changes?", "&No\n&Yes") == 1
        return
    endif
    call system(a:gitCommand . ' ' . shellescape(l:file))
    call GitStatus()
endfunction

function! GitInputOp(gitCommand, gitCommandArg)
    call system(a:gitCommand . ' ' . input(a:gitCommandArg))
    call GitStatus()
endfunction

function! GitOp(gitCommand)
    execute a:gitCommand
    call GitStatus()
    redraw!
endfunction

function! SetMakePrgAndExec()
    let l:compile_command = input('Compile command: ')
    if len(l:compile_command) > 0
        let &makeprg = l:compile_command
        silent make
        rightb vert copen 100
        redraw!
    endif
endfunction

function! NetrwCollapse()
    redir => cnt
        silent .s/|//gn
    redir END
    let lvl = substitute(cnt, '\n', '', '')[0:0] - 1
    exec '?^\(| \)\{' . lvl . '\}\w'
    exec "normal \<CR>"
endfunction
