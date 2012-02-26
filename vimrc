" Мой конфигурационный файл для VIM 6.x
" voldmar

set nocompatible        " Несовместимость с vi --- так удобнее
filetype off 
set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()

map <leader>T <Plug>TaskList

Bundle 'gmarik/vundle'

Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-git'
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
Bundle 'ctrlp.vim'
Bundle 'slimv.vim'
Bundle 'ervandew/supertab'
Bundle 'mitechie/pyflakes-pathogen'
Bundle 'sjl/gundo.vim'
Bundle 'fs111/pydoc.vim'
Bundle 'reinh/vim-makegreen'
Bundle 'vim-scripts/TaskList.vim'
Bundle 'sontek/rope-vim'


filetype plugin indent on


set autoindent          " Отступы
set autoread
set autowriteall        " Записывать перед изменениями
set backspace=2         " Поведение клавиш
set backup                        " enable backups
set backupdir=~/.vim/tmp/backup/ " backups
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim/tmp/swap/   " swap files
set expandtab
set foldlevel=25
set foldmethod=indent
set grepprg=grep\ -RIEn\ --exclude-dir=.git\ --exclude=tags\ $*
set hidden              
set history=200
set hlsearch
set ignorecase
set incsearch
set laststatus=2        " Всегда показыать строку статуса
set linebreak           " Не разрывавать посреди слова при переносах
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮
set matchtime=3
set modeline            " Поддержка модлайнов
set mouse=a             " Скролл мышкой
set nofoldenable
set noswapfile                    " It's 2012, Vim.
set nowrap              " Не разрывать строки
set number              " Номера строк
set pastetoggle=<Leader>p
set path+=templates " Django templates
set ruler               " Строка статуса
set scrolloff=3         " Количество строк вокруг курсора внизу/вверху
set shiftround
set shiftwidth=4
set showcmd             " Показывать введенные команды и размер выделенной области
set showmatch           " Показывать совпадающую скобку
set sidescrolloff=5     " Количество символов вокруг курсора справа
set smartcase
set softtabstop=4
set splitbelow          " Новое окно появляется внизу
set statusline=%{fugitive#statusline()}\ %f%m%r%h%w\ [TYPE=%Y]\ %=[ASCII=\%03.3b]\ [HEX=\%02.2B]\ %l,%v\ %p%%\ of\ %L\ lines
set t_Co=256
set tabstop=4
set tags=./tags*,tags
set termencoding=utf-8  " Кодировка терминала
set title
set ttyfast
set undodir=~/.vim/tmp/undo/     " undo files
set vb t_vb=            " Отключить пищалку
set ve=block            " Вольный курсор при блочном выделении
set viminfo='100,%,/50,:50,<50,h
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=.hg,.git,.svn                    " Version control
set wildmenu            " Более удобное дополнение
syn on                  " Подсветка синтаксиса
colorscheme railscasts


let mapleader=","

nnoremap j gj
nnoremap k gk

" Плагин для просмотра манов
runtime ftplugin/man.vim

" Улучшенный %
runtime macros/matchit.vim

nnoremap <leader><space> :set invhlsearch<cr>:set hlsearch?<cr>
nnoremap <leader>n :set number<cr>
nnoremap <leader>N :set relativenumber<cr>
nnoremap <leader>r :source ~/.vimrc<cr>

vnoremap < <gv
vnoremap > >gv

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

autocmd!
autocmd FileType python map <buffer> <silent> +m :call ShowDoc("<C-R><C-W>")<CR>
autocmd FileType python set makeprg=pyflakes\ %
autocmd FileType xhtml set filetype=htmldjango.html
autocmd FileType html set filetype=htmldjango.html

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

" BufExplorer
let g:bufExplorerShowDirectories = 1
let g:bufExplorerShowRelativePath = 1
let g:bufExplorerSplitOutPathName = 0

" Expand %% to dir of current file
cabbr <expr> %% expand('%:p:h')

match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$' " Highlight VCS conflict markers

" CtrlP settings
let g:ctrlp_extensions = ['tag', 'quickfix', 'dir']

let g:slimv_repl_syntax = 1

" -- EOF -- "

