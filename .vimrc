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
     " NERDTreeでタブ間のディレクトリを同期する
     NeoBundle 'jistr/vim-nerdtree-tabs'

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

nnoremap <C-g> 1<C-g>

" ファイルを移動した時にファイルの絶対パスを表示する
augroup EchoFilePath
    autocmd WinEnter * execute
augroup END

" 最後にNERDTreeが残ったらvimを閉じる
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ファイルオープン後にNERDTreeを閉じない
let g:NERDTreeQuitOnOpen=0

" <C-n>でファイル間の移動を行う
nnoremap <C-n> <C-w>w

" <C-a>でNERDTreeウィンドウにフォーカスする
nnoremap <silent><C-a> :NERDTreeFocus<CR>

" 起動時にNERDTreeTabsを使ってNERDTreeを開く
let g:nerdtree_tabs_open_on_console_startup = 1
