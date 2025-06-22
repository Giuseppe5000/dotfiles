" General
set nocompatible
filetype plugin indent on
syntax on
set autoread
set number relativenumber
set noswapfile
set wildmenu
set wildmode=full
set wildoptions=pum
set wildignore=*/node_modules/**
set clipboard=unnamedplus
set encoding=utf-8
set sj=-50
set belloff=all
set history=200
set complete=.,w,b,t
set backspace=indent,eol,start
set iskeyword-=_
set hidden
set mouse=a
set autochdir
set tags=tags;

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
let g:markdown_folding = 1

" Mappings
imap <C-c> <Esc>
tnoremap <Esc> <C-\><C-n>
nnoremap <C-x>b :b<Space>
nnoremap <C-x>f :call FZF(1)<CR>
nnoremap <C-x><C-f> :call FZF()<CR>
" Kills a buffer without closing the window
nnoremap <C-x>k :bp<bar>sp<bar>bn<bar>bd

" Custom functions
function! FZF(root = 0)
    let _ = system('which fzf')
    if v:shell_error != 0
        echo "Error: fzf is not installed."
        return
    end

    " Using temp buffer for reading fzf output
    " and then jump to the selected file
    enew | setlocal buftype=nofile nobuflisted nospell nonu nornu | file fzf_output

    if a:root
        let l:cmd = printf('find %s -type f 2>/dev/null | grep -vE "(/node_modules/|\.git/)" | fzf', g:vim_initial_cwd)
        silent execute 'read !' . l:cmd
    else
        silent read !fzf
    end

    let l:file = getline('.')
    if !empty(l:file)
        normal gf
    end

    silent execute 'bwipeout fzf_output'
endfunction

" Useful constants
let g:vim_initial_cwd = expand('%:p:h')

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
set statusline +=%5*\ %{&ff}%*
set statusline +=%3*%y%*
set statusline +=%4*\ %<%F%*
set statusline +=%2*%m%*
set statusline +=%4*%=(\%l,\%c)
set statusline +=%1*%5l%*
set statusline +=%2*/%L\ %*
set laststatus=2

" Plugins

" Make the plugin dir with: 'mkdir -p ~/.vim/pack/git-plugins/start'
" ALE: 'git clone --depth 1 https://github.com/dense-analysis/ale.git ~/.vim/pack/git-plugins/start/ale'

" ALE
if isdirectory(expand('~/.vim/pack/git-plugins/start/ale'))
    let g:ale_enabled = 0
    let g:ale_completion_enabled = 0
    let g:ale_completion_autoimport = 1
    set omnifunc=ale#completion#OmniFunc
    nnoremap <C-]> :ALEGoToDefinition<CR>
end
