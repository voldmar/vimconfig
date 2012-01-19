" Мой конфигурационный файл для VIM 6.x
" voldmar

set nocompatible        " Несовместимость с vi --- так удобнее
filetype off 
set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/Railscasts-Theme-GUIand256color.git'

Bundle 'django.vim'
Bundle 'scratch.vim'
Bundle 'python.vim'
Bundle 'UltiSnips'
Bundle 'othree/html5.vim'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'groenewege/vim-less'
Bundle 'bufexplorer.zip'
Bundle 'mileszs/ack.vim'
Bundle 'VimClojure'
Bundle 'ctrlp.vim'


filetype plugin indent on

autocmd!

set viminfo='100,%,/50,:50,<50,h

set statusline=%{fugitive#statusline()}\ %f%m%r%h%w\ [TYPE=%Y]\ %=[ASCII=\%03.3b]\ [HEX=\%02.2B]\ %l,%v\ %p%%\ of\ %L\ lines
set path+=templates " Django templates

let mapleader=","

nnoremap j gj
nnoremap k gk

" Плагин для просмотра манов
runtime ftplugin/man.vim

" Улучшенный %
runtime macros/matchit.vim

" Настройки истории
set history=200

" Настройки буферов
set autowriteall        " Записывать перед изменениями
set hidden              

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Редактирование 
" Поиск
set hlsearch
set incsearch
set ignorecase
set smartcase
set grepprg=grep\ -RIEn\ --exclude-dir=.git\ --exclude=tags\ $*

nnoremap <leader><space> :set invhlsearch<cr>:set hlsearch?<cr>
nnoremap <leader>n :set number<cr>
nnoremap <leader>N :set relativenumber<cr>
nnoremap <leader>r :source ~/.vimrc<cr>

set matchtime=3

" Поведение строк
set autoindent          " Отступы
set scrolloff=3         " Количество строк вокруг курсора внизу/вверху
set sidescrolloff=5     " Количество символов вокруг курсора справа
set number              " Номера строк
set nowrap              " Не разрывать строки
set linebreak           " Не разрывавать посреди слова при переносах

" Настройки табуляторов
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab

" Настройка свертки
set nofoldenable
set foldmethod=indent
set foldlevel=25

" Показывать выделение после сдвига
vnoremap < <gv
vnoremap > >gv

set showmatch           " Показывать совпадающую скобку
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Интерфейс
set backspace=2         " Поведение клавиш
set termencoding=utf-8  " Кодировка терминала
syn on                  " Подсветка синтаксиса
set ruler               " Строка статуса
set modeline            " Поддержка модлайнов
set ve=block            " Вольный курсор при блочном выделении
set mouse=a             " Скролл мышкой
set ttyfast

" Цвет комментариев
set t_Co=256
let g:zenburn_high_Contrast = 1
colorscheme railscasts
" highlight Comment ctermfg=Blue


set laststatus=2        " Всегда показыать строку статуса
set wildmenu            " Более удобное дополнение
set showcmd             " Показывать введенные команды и размер выделенной области

set vb t_vb=            " Отключить пищалку
set splitbelow          " Новое окно появляется внизу


set list
set listchars=tab:▸\ ,extends:❯,precedes:❮


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Горячие клавиши 

" Передвижение
map H ^
map L $

nnoremap <silent> <F2> :TRegisters<CR>
inoremap <silent> <F2> <Esc>:TRegisters<CR>
nnoremap <silent> <F3> :TlistToggle<CR>
inoremap <silent> <F3> <Esc>:TlistToggle<CR>
nnoremap <silent> <F4> :MarksBrowser<CR>
inoremap <silent> <F4> <Esc>:MarksBrowser<CR>
nnoremap <silent> <C-B> :BufExplorer<CR>
inoremap <silent> <C-B> <Esc>:VSBufExplorer<CR>

" Use CTRL-A to move to start of the command line
cnoremap <silent> <C-A> <C-B>

" Переключение режима вставки
set pastetoggle=<D-F11>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Настройки разных типов файлов
autocmd BufReadPost *.[ch] call On_C_Load()
autocmd BufReadPost *.{[Hh][Tt][Mm]?},*.tpl call On_HTML_Load()
autocmd BufReadPost *.phtml set filetype=php
au! BufRead,BufNewFile *.json setfiletype json 
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" Настройки для markdown
augroup mkd
    autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>
    autocmd BufRead,BufNewFile *.mkd setfiletype mkd
augroup END

function! On_C_Load()
    set cindent
    set formatoptions=cqr
endfunction

function! On_HTML_Load()
    runtime! syntax/html.vim
endfunction

let python_highlight_all = 1
let html_no_rendering = 1
autocmd FileType python map <buffer> <silent> +m :call ShowDoc("<C-R><C-W>")<CR>
autocmd FileType python set makeprg=pyflakes\ %
"autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType xhtml set filetype=htmldjango.html
autocmd FileType html set filetype=htmldjango.html

"autocmd FileType python compiler pychecker
"autocmd BufReadPost quickfix map <buffer> <silent> <CR> :.cc <CR> :ccl

function! ShowDoc(name)
  enew
  execute "read !pydoc " . a:name
  setlocal nomodifiable
  setlocal nomodified
  set filetype=man
  normal 1G 

  " По D-F10 не выйти, но закрыть справку
  nnoremap <silent> <buffer> <D-F10> <Esc>:bdel<CR>
endfunction

" Файлы с тэгами
let Tlist_Ctags_Cmd = '/opt/local/bin/ctags'
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
set tags=./tags*,tags

" BufExplorer
let g:bufExplorerShowDirectories = 1
let g:bufExplorerShowRelativePath = 1
let g:bufExplorerSplitOutPathName = 0

" Expand %% to dir of current file
cabbr <expr> %% expand('%:p:h')

" Settings for VimClojure
let vimclojure#HighlightBuiltins = 1
let vimclojure#ParenRainbow = 1
let vimclojure#WantNailgun   = 1
let vimclojure#NailgunClient ="ng"

set autoread
set title
set shiftround
set backupskip=/tmp/*,/private/tmp/*

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.pyc                            " Python byte code

set undodir=~/.vim/tmp/undo/     " undo files
set backupdir=~/.vim/tmp/backup/ " backups
set directory=~/.vim/tmp/swap/   " swap files
set backup                        " enable backups
set noswapfile                    " It's 2012, Vim.

match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$' " Highlight VCS conflict markers

" CtrlP settings
let g:ctrlp_extensions = ['tag', 'quickfix', 'dir']

" -- EOF -- "

