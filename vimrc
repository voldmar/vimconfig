" .vimrc
" Vladimir Epifanov
" https://github.com/voldmar/vimconfig

set nocompatible " It’s 2012 
filetype off 
set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()

let mapleader=","

" ,T is defined in other 
map <leader>T <Plug>TaskList

Bundle 'gmarik/vundle'

Bundle 'tpope/vim-repeat'
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
Bundle 'vim-scripts/TaskList.vim'
Bundle 'sontek/rope-vim'


filetype plugin indent on

" It should be here because syntax highlight will be off overwise
autocmd!


set autoindent
set autoread
set autowriteall 
set backspace=2
set backup
set backupdir=~/.vim/tmp/backup/
set backupskip=/tmp/*,/private/tmp/*
set cmdheight=2 " For bufexplorer
set cursorline
set directory=~/.vim/tmp/swap/
set expandtab
set exrc
set foldlevel=25
set foldmethod=indent
set grepprg=grep\ -rien\ --exclude-dir=.git\ --exclude=tags\ $*
set hidden
set history=200
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set linebreak
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮
set matchtime=3
set modeline
set mouse=a
set nofoldenable
set noswapfile
set nowrap
set number
set pastetoggle=<leader>p
set path+=templates " django templates
set ruler
set scrolloff=3
set secure
set shiftround
set shiftwidth=4
set showbreak=↪
set showcmd 
set showmatch
set sidescrolloff=5
set smartcase
set softtabstop=4
set splitbelow
set statusline=%{fugitive#statusline()}\ %f%m%r%h%w\ [type=%y]\ %=[ascii=\%03.3b]\ [hex=\%02.2b]\ %l,%v\ %p%%\ of\ %l\ lines
set t_co=256
set tabstop=4
set tags=./tags*,tags
set termencoding=utf-8
set title
set ttyfast
set undodir=~/.vim/tmp/undo/
set vb t_vb=  " Turn off visual bell
set ve=block
set viminfo='100,%,/50,:50,<50,h
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=_generated_media*
set wildmenu 
syn on
colorscheme railscasts

" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Normal navigation in wrap files
nnoremap j gj
nnoremap k gk

runtime ftplugin/man.vim
runtime macros/matchit.vim

nnoremap <leader><space> :set invhlsearch<cr>:set hlsearch?<cr>
nnoremap <leader>n :set number<cr>
nnoremap <leader>N :set relativenumber<cr>
nnoremap <leader>r :source ~/.vimrc<cr>
nnoremap K <nop>
nnoremap <leader>u :!sudo service uwsgi restart<cr>
nnoremap <Left> :cprev<CR>
nnoremap <Right> :cnext<CR>
nnoremap <Up> :colder<CR>
nnoremap <Down> :cnewer<CR>

vnoremap < <gv
vnoremap > >gv

map H ^
map L $

noremap <silent> <leader>t :call PyUnitRunTests()<CR>
nnoremap <silent> <C-B> :BufExplorer<CR>
inoremap <silent> <C-B> <Esc>:BufExplorer<CR>


" Easy buffer navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l
noremap <leader>v <C-w>v

nnoremap <leader>h :help <c-r><c-w><CR>

" Restore position on loading buffer
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" markdown
augroup markdown
    autocmd BufRead *.md  set ai formatoptions=tcroqn2 comments=n:>
    autocmd BufRead,BufNewFile *.md setfiletype 
augroup END

" Show trailing spaces in 
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
augroup END

let python_highlight_all = 1
let html_no_rendering = 1

augroup python
    autocmd FileType python map <buffer> <silent> +m :call ShowDoc("<C-R><C-W>")<CR>
    autocmd FileType python set makeprg=pyflakes\ %
augroup END
autocmd FileType xhtml set filetype=htmldjango.html
autocmd FileType html set filetype=htmldjango.html

function! ShowDoc(name)
  enew
  execute "read !pydoc " . a:name
  setlocal nomodifiable
  setlocal nomodified
  set filetype=man
  normal 1G 
endfunction

let Tlist_Ctags_Cmd = '/opt/local/bin/ctags'
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1

let g:bufExplorerShowDirectories = 1
let g:bufExplorerShowRelativePath = 1
let g:bufExplorerSplitOutPathName = 0

" Expand %% to dir of current file
cabbr <expr> %% expand('%:p:h')

match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$' " Highlight VCS conflict markers

" CtrlP settings
let g:ctrlp_extensions = ['tag', 'quickfix', 'dir']

let g:slimv_repl_syntax = 1

if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

let g:pyflakes_use_quickfix = 0

" -- EOF -- "

