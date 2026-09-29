" Show absolute line number and relative line number
set number relativenumber

" Set GUI font to Iosevka, font size 16
set guifont=Iosevka:h16

" Remove menu bar
set guioptions-=m
" Remove tab bar at top
set guioptions-=T
" Remove right scrollbar
set guioptions-=r
" Remove left scrollbar
set guioptions-=L

" Enable syntax highlighting
syntax on

" Enable filetype detection, plugin and indent rules
filetype plugin indent on

" Number of spaces a <Tab> counts for
set tabstop=4
" Number of spaces for auto indent
set shiftwidth=4
" Convert Tab key to spaces
set expandtab
" Copy indent from current line to next line
set autoindent

" Ignore case in search patterns
set ignorecase
" Override ignorecase if search contains uppercase
set smartcase
" Show search matches as you type
set incsearch

" Disable ESC key special behaviors
set noesckeys
" Enable modeline for file-local settings
set modeline
" Auto change working directory to current file's folder
set autochdir

" C indent option: adjust brace indent style
set cinoptions=>

" Load habamax color scheme
colorscheme habamax

" Do not create backup files
set nobackup
" Do not create write backup files
set nowritebackup
" Disable swapfile
set noswapfile
