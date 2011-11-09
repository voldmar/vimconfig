" Мой конфигурационный файл для VIM 6.x
" voldmar

" Pathogen
filetype off 
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

autocmd!

set viminfo='100,%,/50,:50,<50,h

set statusline=%{fugitive#statusline()}\ %f%m%r%h%w\ [TYPE=%Y]\ %=[ASCII=\%03.3b]\ [HEX=\%02.2B]\ %l,%v\ %p%%\ of\ %L\ lines
set path+=templates " Django templates

" Плагин для просмотра манов
runtime ftplugin/man.vim

" Улучшенный %
runtime macros/matchit.vim

" Настройки истории
set history=200

" Настройки буферов
set autowriteall        " Записывать перед изменениями
set hidden              

filetype on
filetype indent on      " Включить отступы
filetype plugin on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Редактирование 
" Поиск
set nohlsearch
set incsearch
set ignorecase
set smartcase
set grepprg=grep\ -RIEn\ --exclude-dir=.git\ --exclude=tags\ $*

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
set nocompatible        " Несовместимость с vi --- так удобнее
set backspace=2         " Поведение клавиш
set termencoding=utf-8  " Кодировка терминала
syn on                  " Подсветка синтаксиса
set ruler               " Строка статуса
set modeline            " Поддержка модлайнов
set ve=block            " Вольный курсор при блочном выделении
set mouse=a             " Скролл мышкой

" Цвет комментариев
set t_Co=256
let g:zenburn_high_Contrast = 1
colorscheme zenburn
" highlight Comment ctermfg=Blue


"set list                " Отображение непечатных символов
"set listchars=trail:~   " Отображать тильду вместо замыкающих пробелов

set laststatus=2        " Всегда показыать строку статуса
set wildmenu            " Более удобное дополнение
set showcmd             " Показывать введенные команды и размер выделенной области

set vb t_vb=            " Отключить пищалку
set splitbelow          " Новое окно появляется внизу

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



nnoremap <silent> <D-r> :e %<CR>

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
autocmd FileType python map <buffer> <silent> +m :call ShowDoc("<C-R><C-W>")<CR>
autocmd FileType python set makeprg=pyflakes\ %
"autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType xhtml set filetype=htmldjango

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

" -- EOF -- "

