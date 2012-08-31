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
map <leader><leader> <Plug>Vm_goto_next_sign

Bundle 'gmarik/vundle'

Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-git'

Bundle 'django.vim'
Bundle 'scratch.vim'
Bundle 'python.vim'
Bundle 'othree/html5.vim'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'groenewege/vim-less'
Bundle 'bufexplorer.zip'
Bundle 'mileszs/ack.vim'
Bundle 'ctrlp.vim'
"Bundle 'ervandew/supertab'
Bundle 'mitechie/pyflakes-pathogen'
Bundle 'sjl/gundo.vim'
Bundle 'fs111/pydoc.vim'
Bundle 'vim-scripts/TaskList.vim'
Bundle 'nvie/vim-flake8'
Bundle 'majutsushi/tagbar'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neocomplcache-snippets-complete'
Bundle 'voldmar/Visual-Mark'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'AndrewRadev/linediff.vim'
Bundle 'ameade/qtpy-vim'
Bundle 'chilicuil/conque'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'vim-scripts/applescript.vim'
Bundle 'emezeske/paredit.vim'
Bundle 'vim-scripts/VimClojure'

" Color schemes
if $TERM == "xterm-256color"
    Bundle 'altercation/vim-colors-solarized'
    Bundle 'vim-scripts/Railscasts-Theme-GUIand256color.git'
    let g:Powerline_symbols = 'fancy'
    let g:Powerline_cache_enabled = 1
    let g:Powerline_colorscheme = 'skwp'
    Bundle 'Lokaltog/vim-powerline'
endif
Bundle 'vim-scripts/xterm16.vim'

filetype plugin indent on

" It should be here because syntax highlight will be off overwise
autocmd!


set autoindent
set autoread
set autowriteall 
set backspace=2
set nobackup
set nowritebackup
set noswapfile
set clipboard=unnamed
set cmdheight=2 " For bufexplorer
set cursorline
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
set nowrap
set number
set pastetoggle=<leader>p
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
set statusline=(%{fugitive#head()})\ %f%q%m%r%h%w:%l%{tagbar#currenttag(':%s','','f')}\ %=\ %l,%v\ %p%%\ of\ %L\ lines
set tabstop=4
set tags=./tags*,tags
set termencoding=utf-8
set title
set ttyfast
set undofile
set undodir=~/temp/vim-undo/
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
set wildignore+=.env
set wildmenu 
syn on
set background=dark
hi PyFlakes ctermbg=52 ctermfg=white

" Must be after :syn on
if $TERM == "xterm-256color"
    set t_Co=256
    let g:solarized_termcolors=&t_Co
    colorscheme solarized
elseif $TERM == "xterm-color" || $TERM == "xterm"
    colorscheme xterm16
endif

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
nnoremap <leader>R :source ~/.vimrc<cr>
nnoremap K <nop>
nnoremap <leader>u :!sudo service uwsgi restart<cr>
nnoremap <Left> :colder<CR>
nnoremap <Right> :cnewer<CR>
nnoremap <Up> :cprev<CR>
nnoremap <Down> :cnext<CR>
nnoremap <leader>8 :call Flake8()<CR>
nnoremap <leader>a :Ack <C-R><C-W><cr>
nnoremap <leader>A :Ack -w <C-R><C-W><cr>
nnoremap <leader>t :TagbarToggle<CR>
" Ack for the last search.
nnoremap <silent> <leader>/ :execute "Ack! '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>
nnoremap <leader>g :GundoToggle<CR>
nnoremap <leader>l :Linediff<CR>
nnoremap <leader>L :LinediffReset<CR>
nnoremap <leader>r :silent redraw!<CR>
nnoremap <leader><Tab> :NERDTreeToggle .<CR>


vnoremap < <gv
vnoremap > >gv

map H ^
map L $

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
    autocmd BufRead,BufNewFile *.md set filetype=markdown
augroup END

" shower
augroup shower
    autocmd BufRead *.shower  set ai formatoptions=tcroqn2 comments=n:>
    autocmd BufRead,BufNewFile *.shower set filetype=markdown 
    autocmd BufWritePost  *.shower :silent !convert.sh % &
augroup END

" Show trailing spaces in 
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
augroup END

let python_highlight_all = 1
let html_no_rendering = 1

augroup vimconfig
    function! GotoBundle()
        let l:currentline = getline(".")
        if l:currentline =~ '^\s*Bundle'
            let l:path = matchstr(l:currentline, "'.*'")
            if l:path != ""
                let l:bundle = vundle#config#init_bundle(l:path, [])
                echo "Opening " . l:bundle.uri
                exec ":! open " . l:bundle.uri
            endif
        else
            normal! gf
        endif
    endfunction
    if has("mac")
        autocmd FileType vim nnoremap <buffer> <silent> gf :call GotoBundle()<CR>
    endif
augroup END

augroup python
    autocmd FileType python map <buffer> <silent> +m :call ShowDoc("<C-R><C-W>")<CR>
    autocmd FileType python set makeprg=pyflakes\ %
    autocmd FileType python setlocal colorcolumn=80
    autocmd FileType python let g:qtpy_shell_command = "./manage.py test"
    autocmd FileType python nnoremap <leader>m :QTPY method<CR>
    autocmd FileType python nnoremap <leader>M :QTPY method verbose<CR>
    autocmd FileType python nnoremap <silent> <leader>P :let @* = expand("%") . ":" .  tagbar#currenttag("%s", "", "f") <CR>
    autocmd FileType python set path+=templates " django templates
augroup END
autocmd FileType xhtml set filetype=htmldjango.html
autocmd FileType html set filetype=htmldjango.html

augroup clojure
    autocmd FileType clojure set shiftwidth=2
    autocmd FileType clojure set tabstop=2
    autocmd FileType clojure set softtabstop=2
    autocmd FileType clojure set path+=src
    autocmd BufRead,BufNewFile *.cljs set filetype=clojure
augroup END

augroup applescript
    autocmd BufRead,BufNewFile *.applescript set filetype=applescript
augroup END

function! ShowDoc(name)
  enew
  execute "read !pydoc " . a:name
  setlocal nomodifiable
  setlocal nomodified
  set filetype=man
  normal 1G 
endfunction

let g:bufExplorerShowDirectories = 1
let g:bufExplorerShowRelativePath = 1
let g:bufExplorerSplitOutPathName = 0

" Expand %% to dir of current file
cabbr <expr> %% expand('%:p:h')

match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$' " Highlight VCS conflict markers

" CtrlP settings
let g:ctrlp_extensions = ['tag', 'quickfix', 'dir', 'line']
let g:ctrlp_working_path_mode = 2
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files | grep -v -e /migrations/ -e /static/img']
noremap <C-T> :<C-U>CtrlPTag<CR>

if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

let g:pyflakes_use_quickfix = 0
let g:ropevim_guess_project = 1

let g:neocomplcache_enable_at_startup = 1
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ?  "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
highlight SignColor ctermfg=white ctermbg=67
sign define SignSymbol linehl=SignColor texthl=SignColor text=»

let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:tagbar_autofocus = 1

if exists("g:Powerline_loaded")
    call Pl#Theme#ReplaceSegment('tagbar:currenttag', 'tagbar:fullcurrenttag')
    call Pl#Theme#RemoveSegment('fileformat')
    call Pl#Theme#RemoveSegment('fileencoding')
    call Pl#Theme#RemoveSegment('filetype')
    call Pl#Theme#RemoveSegment('lineinfo')
endif

let g:NERDTreeQuitOnOpen = 1

" -- EOF -- "

