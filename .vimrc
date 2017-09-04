set number
set title
set autoindent
set encoding=utf-8
set tabstop=5
set shiftwidth=4
set nocompatible

if has('vim_starting')
     set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle/'))
     NeoBundleFetch 'Shougo/neobundle.vim'
     " ファイルオープンを便利に
     NeoBundle 'Shougo/unite.vim'
     " Unite.vimで最近使ったファイルを表示できるようにする
     NeoBundle 'Shougo/neomru.vim'
     " 非同期linter
     NeoBundle 'osyo-manga/vim-watchdogs'
     "NeoBundle 'scrooloose/syntastic'
     " vimの画面内にディレクトリツリーを表示
     NeoBundle 'scrooloose/nerdtree'
     " 補完機能
     NeoBundle 'Shougo/neosnippet.vim'
     " カラースキーマをmolokaiにする
     NeoBundle 'tomasr/molokai'
     " ペースト時にインデント崩れをなくす
     NeoBundle 'ConradIrwin/vim-bracketed-paste'

call neobundle#end()
filetype plugin indent on

colorscheme molokai
syntax enable

if &term == "xterm-256color"
    colorscheme molokai
    hi Comment ctermfg=102
    hi Visual  ctermbg=236
endif

let NERDTreeShowHidden = 1

nnoremap <silent><C-e> :NERDTreeToggle<CR>
