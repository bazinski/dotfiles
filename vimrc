" SETTINGS {{{

set ff=unix

" Switch syntax highlighting on, when the terminal has colors
syntax on

" no annoying bell at end of line etc.
set noerrorbells

" Use vim, not vi api
set nocompatible

" No write backup
set nowritebackup

" " No swap file
set noswapfile

" Command history
set history=100

" Always show cursor
set ruler

" Show incomplete commands
set showcmd

" Incremental searching (search as you type)
set incsearch

" Highlight search matches
set hlsearch
"
" " Ignore case in search
set smartcase
"
" " Make sure any searches /searchPhrase doesn't need the \c escape character
set ignorecase

" Allow backspace to delete end of line, indent and start of line characters
set backspace=indent,eol,start

" Convert tabs to spaces
set expandtab
"
" " Set tab size in spaces (this is for manual indenting)
set tabstop=4
"
" " The number of spaces inserted for a tab (used for auto indenting)
set shiftwidth=4
"
" " Turn on line numbers
set nu

" setup undo
set undodir=~/.vim/undodir
set undofile
"
" " Highlight tailing whitespace
set list listchars=tab:\ \ ,trail:·

" Get rid of the delay when pressing O (for example)
" "
" http://stackoverflow.com/questions/2158516/vim-delay-before-o-opens-a-new-line
set timeout timeoutlen=1000 ttimeoutlen=100

" " Always show status bar
set laststatus=2

" " Set the status line to something useful
set statusline=%f\ %=L:%l/%L\ %c\ (%p%%)

" " UTF encoding
set encoding=utf-8

" " Autoload files that have changed outside of vim
set autoread

" " Don't show intro
set shortmess+=I

" " Better splits (new windows appear below and to the right)
set splitbelow
set splitright

" Highlight the current line
set cursorline

" " Visual autocomplete for command menu (e.g. :e ~/path/to/file)
set wildmenu

" " redraw only when we need to (i.e. don't redraw when executing a macro)
set lazyredraw

" " highlight a matching [{()}] when cursor is placed on start/end character
set showmatch

" " Set built-in file system explorer to use layout similar to the NERDTree
" plugin
let g:netrw_liststyle=3

" }}}

" PLUGINS {{{

filetype plugin on

" Vundle settings
" required to use with Vundle - begin
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'       " required by vundle

Plugin 'morhetz/gruvbox'
Plugin 'jremmen/vim-ripgrep'
Plugin 'tpope/vim-fugitive'
Plugin 'leafgarland/typescript-vim'
Plugin 'vim-utils/vim-man'
Plugin 'lyuts/vim-rtags'
Plugin 'git@github.com:kien/ctrlp.vim.git'
"Plugin 'git@github.com:Valloric/YouCompleteMe.git'
Plugin 'zxqfl/tabnine-vim'
Plugin 'mbbill/undotree'
Plugin 'rhysd/vim-clang-format'
Plugin 'flazz/vim-colorschemes'  " diff color schemes
"Plugin 'tomtom/tcomment-vim'
"Plugin 'junegunn/goyo.vim',{ 'on','Goyo'}
"Plugin 'junegunn/limelight.vim', {'on': 'LimeLight'}
Plugin 'tpope/vim-vinegar'
Plugin 'djoshea/vim-autoread'
Plugin 'mileszs/ack.vim' " search inside files using ack. Same as command line ack utility, but use :Ack
Plugin 'majutsushi/tagbar' " class outliner viewer
Plugin 'chrisbra/vim-zsh'
Plugin 'Raimondi/delimitMate'
Plugin 'jlanzarotta/bufexplorer' " <leader>be,bs,bt,bv
Plugin 'Konfekt/FastFold'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-scripts/c.vim'
"language-specific plugins
Plugin 'cakebaker/scss-syntax.vim', { 'for': 'scss' } " sass scss syntax support
Plugin 'wavded/vim-stylus', { 'for': ['stylus', 'markdown'] } " markdown support
Plugin 'groenewege/vim-less', { 'for': 'less' } " less support
Plugin 'ap/vim-css-color', { 'for': ['css','stylus','scss'] } " set the background of hex color values to the color
Plugin 'hail2u/vim-css3-syntax', { 'for': 'css' } " CSS3 syntax support
Plugin 'fatih/vim-go', { 'for': 'go' } " go support
Plugin 'nickhutchinson/vim-cmake-syntax'
Plugin 'tmhedberg/SimpylFold' " python folding
" Writing experience
Plugin 'plasticboy/vim-markdown', { 'for': 'markdown' } " markdown support
Plugin 'shime/vim-livedown'

" tmux integration
Plugin 'benmills/vimux' " interact with tmux from vim
Plugin 'christoomey/vim-tmux-runner'
Plugin 'tmux-plugins/vim-tmux' " syntax highlighting for .tmux.conf
Plugin 'christoomey/vim-tmux-navigator' " vim tmux seamless navigation between vim splits and tmux panes
Plugin 'tpope/vim-obsession' " continuously updated session files
 
call vundle#end()
filetype plugin indent on
" required by vundle - end

" Syntastic 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_config_file = '~/.syntastic_cpp_config_file'


" CtrlP
"map <leader>t <C-p>
"map <leader>y :CtrlPBuffer<cr>
"let g:ctrlp_show_hidden=1
"let g:ctrlp_working_path_mode=0
"let g:ctrlp_max_height=30
" CtrlP -> override <C-o> to provide options for how to open files
"let g:ctrlp_arg_map = 1

" CtrlP -> files matched are ignored when expanding wildcards
"set wildignore+=*/.git/*,*/.hg/*,*/.svn/*.,*/.DS_Store

" CtrlP -> use Ag for searching instead of VimScript
" (might not work with ctrlp_show_hidden and ctrlp_custom_ignore)
"let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" CtrlP -> directories to ignore when fuzzy finding
"let g:ctrlp_custom_ignore = '\v[\/]((node_modules)|\.(git|svn|grunt|sass-cache))$'

" Git gutter
set signcolumn=yes
"highlight SignColumn ctermbg=230
"highlight GitGutterChange ctermfg=blue
let g:gitgutter_enabled = 1
let g:gitgutter_eager = 0
let g:gitgutter_sign_column_always = 1
highlight clear SignColumn

" Searching the file system
map <leader>' :NERDTreeToggle<cr>

" NERDTree special characters are not used
let g:NERDTreeDirArrows=0


" BINDINGS {{{

" Map <F9> to make command
" for single-file projects only
:function! C_MAKE()
:make %:r | :cwindow
:endfunction

:nmap <F9> <Esc> :w<CR> :let rowm=line('.')<CR> :let colm=col('.')<CR> :execute C_MAKE()<CR> :source $HOME/.vimrc<CR> :call cursor(rowm, colm)<CR>
:imap <F9> <Esc> :w<CR> :let rowm=line('.')<CR> :let colm=col('.')<CR> :execute C_MAKE()<CR> :source $HOME/.vimrc<CR> :call cursor(rowm, colm)<CR>

" Map <F5> to run
" for sinle-file projects only
:nmap <F5> <Esc> :!./%:r<CR>
:imap <F5> <Esc> :!./%:r<CR>

" Map <F4> to open NERDTree
:nmap <F4> <Esc> :NERDTree<CR>
:imap <F4> <Esc> :NERDTree<CR>

" }}}

" COMMANDS {{{

" " When *.cpp file created, load it from template
autocmd BufNewFile *.cpp r ~/.vim/template.cpp
autocmd BufNewFile *.h r ~/.vim/template.h

" " Automatically close the folds when the file is open
autocmd BufRead * setlocal foldmethod=marker
autocmd BufRead * normal zM

" " file formats
autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd Filetype markdown setlocal wrap linebreak nolist textwidth=0
" wrapmargin=0 " http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
autocmd FileType sh,cucumber,ruby,yaml,zsh,vim setlocal shiftwidth=2
" tabstop=2 expandtab

" "specify syntax highlighting for specific files
autocmd Bufread,BufNewFile *.md set filetype=markdown

" Highlight words to avoid in tech writing
" " http://css-tricks.com/words-avoid-educational-writing/
highlight TechWordsToAvoid ctermbg=red ctermfg=white
match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however\|so,\|easy/
autocmd BufWinEnter * match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however,\|so,\|easy/
autocmd InsertEnter * match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however,\|so,\|easy/
autocmd InsertLeave * match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however,\|so,\|easy/
autocmd BufWinLeave * call clearmatches()

" Rainbow parenthesis always on!
if exists(':RainbowParenthesesToggle')
    autocmd VimEnter * RainbowParenthesesToggle
    autocmd Syntax * RainbowParenthesesLoadRound
    autocmd Syntax * RainbowParenthesesLoadSquare
    autocmd Syntax * RainbowParenthesesLoadBraces
endif

" Reset spelling colours when reading a new buffer
" " This works around an issue where the colorscheme is changed by
" .local.vimrc
fun! SetSpellingColors()
    highlight SpellBad cterm=bold ctermfg=white ctermbg=red
    highlight SpellCap cterm=bold ctermfg=red ctermbg=white
endfun
autocmd BufWinEnter * call SetSpellingColors()
autocmd BufNewFile * call SetSpellingColors()
autocmd BufRead * call SetSpellingColors()
autocmd InsertEnter * call SetSpellingColors()
autocmd InsertLeave * call SetSpellingColors()

" Change colourscheme when diffing
fun! SetDiffColors()
    highlight DiffAdd    cterm=bold ctermfg=white ctermbg=DarkGreen
    highlight DiffDelete cterm=bold ctermfg=white ctermbg=DarkGrey
    highlight DiffChange cterm=bold ctermfg=white ctermbg=DarkBlue
    highlight DiffText   cterm=bold ctermfg=white ctermbg=DarkRed
endfun
autocmd FilterWritePre * call SetDiffColors()

" Mark the 100th column of text that gets there.
:au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)" }}}

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" " if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
 " Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>
