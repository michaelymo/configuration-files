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

" unite.vimの設定
noremap <C-U><C-F> :Unite -buffer-name=file file<CR> " ファイル一覧
noremap <C-U><C-R> :Unite file_mru<CR> " 最近使ったファイル一覧

au FileType unite nnoremap <silent> <buffer> <expr> <C-i> unite#do_action('split') " ウィンドウを分割して開く
au FileType unite inoremap <silent> <buffer> <expr> <C-i> unite#do_action('split')

" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

""" airline系 """
" Powerline系フォントを利用する
let g:airline_powerline_fonts = 1

" タブバーのカスタマイズを有効にする
let g:airline#extensions#tabline#enabled = 1

" タブバーの右領域を非表示にする
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0

" j/kによる移動を速くする
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

" 検索モードを開く
nmap <Leader>f :CtrlP<CR>
