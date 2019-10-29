set history=1000

filetype plugin on
filetype indent on

set autoread

set number

command W w !sudo tee % > /dev/null

set ruler
set cmdheight=2

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

map <C-a> <ESC>^
imap <C-a> <ESC>I
map <C-e> <ESC>$
imap <C-e> <ESC>A

set ignorecase
set smartcase
set hlsearch
set incsearch

set showmatch
set mat=2

set noerrorbells
set novisualbell

set foldcolumn=1

syntax enable

try
    colorscheme slate 
catch
endtry

set background=dark

set encoding=utf8

set smarttab

set shiftwidth=4
set tabstop=4

set ai
set si
set wrap

set laststatus=2
set statusline=\ F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
