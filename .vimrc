" options
set nocompatible

" display options
set number
set title
set ruler
set cursorline cursorcolumn " 現在カーソルが存在する行、列をハイライトする
set laststatus=2 " status行を常に表示する
set cmdheight=2 " status行の下の行を常に2行表示する
set showmatch " 対応する括弧を強調表示
set helpheight=999
set list listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮ " 不可視文字を別の文字で表示する

"cursor movement options
set backspace=indent,eol,start " backspace押下時に行を跨いで削除する
set whichwrap=b,s,h,l,<,>,[,] " リストにある移動キー押下時に、行を跨いで移動する
set scrolloff=8 sidescrolloff=16 " カーソル移動時の視界確保
set sidescroll=1

" file handling options
set hidden
set confirm
set autoread
set nobackup
set noswapfile

" search replace options
set hlsearch
set incsearch
set ignorecase smartcase " 検索時、基本大文字小文字区別しない。大文字小文字が混在している場合のみ区別する
set wrapscan
set gdefault " 置換時、デフォルトでgオプションをつける（s/aaa/bbb/g ←このg

" tab indent options
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent

" insert options
set textwidth=0 " 特定の文字数に達すると自動改行する挙動を無効化

" environment options
set clipboard=unnamed,unnamedplus
set mouse=a
set shellslash " Windows環境でディレクトリ区切りのバックスラッシュをスラッシュで表示する
set encoding=utf-8

" cmdline options
set wildmenu wildmode=list:longest,full " cmdモードでファイル名補完を有効にする
set history=10000

" bell options
" ビープ音をすべて無効にする
set visualbell t_vb=
set noerrorbells " エラーメッセージの表示時にビープを鳴らさない

" other options
set updatetime=1000 " for GoInfo. カーソルを移動してからGoInfoを実行するまでの時間。値が小さすぎるとカーソル移動時の表示挙動が不安定になる





""" dein settings
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  " User defined plugins
  " Color scheme
  call dein#add('tomasr/molokai')

  " golang
  call dein#add('fatih/vim-go')
  call dein#add('AndrewRadev/splitjoin.vim') " structを複数行展開にする
  call dein#add('SirVer/ultisnips')
  call dein#add('ctrlpvim/ctrlp.vim')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable




""" original keybindings
" open vimrc
nnoremap <Space>. :<C-u>edit $MYVIMRC<CR>
" reload vimrc
nnoremap <Space>s. :<C-u>source $MYVIMRC<CR>

" option change shortcuts
nnoremap <Space>on
\  :<C-u>setlocal number!
\ \|     setlocal number?<CR>

" marks, registeの確認を楽にする
nnoremap <C-o>m :<C-u>marks
nnoremap <C-o>r :<C-u>registers

" tab-pages shortcuts
"nnoremap <C-t> <Nop>
nnoremap <C-t>n :<C-u>tabnew<CR>
nnoremap <C-t>c :<C-u>tabclose<CR>
nnoremap <C-t>o :<C-u>tabonly<CR>
nnoremap <C-t>j :<C-u>execute 'tabnext' 1 + (tabpagenr() + v:count1 - 1) % tabpagenr('$')<CR>
nnoremap <C-t>k gT

" help shortcut
nnoremap <C-h> :<C-u>help<Space>

" quickfix shortcuts
nnoremap <C-q>n :cnext<CR>
nnoremap <C-q>p :cprevious<CR>
nnoremap <C-q>c :cclose<CR>


"** vim-go settings **"
" 動かない場合：:GoUpdateBinariesを実行
"
" [Usages]
" 'Search and jump'
"   :GoDef (alternatives: Ctl-t, ]])
"   back to jump元: Ctl-o
"   :GoDecls
"   :GoDeclsDir
set autowrite
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
augroup vim_go
    autocmd!
    autocmd FileType go nnoremap <Space>r :GoRun<CR>
    autocmd FileType go nnoremap <Space>b :<C-u>call <SID>build_go_files()<CR>
    autocmd FileType go nnoremap <Space>t :GoTest<CR>
    autocmd FileType go nnoremap <Space>f :GoTestFunc<CR>
    autocmd FileType go nnoremap <Space>c :GoCoverageToggle<CR>
    "autocmd FileType go nnoremap <Space>l :GoMetaLinterCR> " go_metalinter_auto_saveで自動実行されるのでコメント
    " _testと通常ファイルのトグル
    autocmd FileType go nnoremap <Space>alt :GoAlternate<CR>
    autocmd FileType go nnoremap <Space>i :GoInfo<CR>

    autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

    " :GoPlay無効化（事故る危険排除 うまい方法見つからないので対応延期
    " delcommand GoPlay

augroup END
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports" " file save時にgoimportsとgofmtを自動実行
let g:go_fmt_fail_silently = 0 " errorが発生した場合にquickfixに表示する
let g:go_addtags_transform = "snake_case"
let g:go_textobj_include_function_doc = 1 " [dv]af 選択時にコメントも選択対象に含める
" beauty
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
" linter
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1 " save時に自動実行
let g:go_metalinter_deadline = "5s" " deadline
" go-info
let g:go_auto_type_info = 1 " カーソル移動時に自動表示
" sameid highlight
let g:go_auto_sameids = 1
" :GoPlayでタブを開かなくする設定（開かないだけでuploadはする
"let g:go_play_open_browser = 0

" molokai
colorscheme molokai
syntax on
let g:molokai_original = 1
let g:rehash256 = 1
set background=dark
