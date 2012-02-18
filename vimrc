set encoding=utf8
set fileencodings=utf8,euc-jp,iso-2022-jp,sjis
set fileencoding=utf8

colorscheme DarkDefault

syntax on
filetype on
filetype indent on
filetype plugin on
au FileType ruby set ts=2 sw=2 expandtab

set shiftwidth=4
set number
set nowrap
set sidescroll=1
set autoread
set hidden
set hlsearch
set incsearch
set cursorline
set expandtab

set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']
    \['.&ff.']'}%=%l,%c%V%8P
