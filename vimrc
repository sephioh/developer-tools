""""""""" PLUGIN INSTALLATION """"""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'airblade/vim-gitgutter'
Plugin 'benmills/vimux'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'mileszs/ack.vim'
Plugin 'morhetz/gruvbox'
Plugin 'myusuf3/numbers.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tmhedberg/SimpylFold'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'lifepillar/vim-solarized8'
Plugin 'ludovicchabant/vim-gutentags.git'
Plugin 'leafgarland/typescript-vim.git'
Plugin 'chr4/nginx.vim'
call vundle#end()

""""""""" General configuration """"""""""""
colo solarized8
nnoremap ; :
let mapleader="," " change the mapleader from \ to ,
set timeoutlen=1000 ttimeoutlen=200 "dont wait for normal mode

if has("gui_running")
    " C-Space seems to work under gVim on both Linux and win32
    inoremap <C-Space> <C-n>
else " no gui
  if has("unix")
    inoremap <Nul> <C-n>
  else
  " I have no idea of the name of Ctrl-Space elsewhere
  endif
endif

syntax on  "enable syntax
set number  "display line numbers
set nocompatible
set laststatus=2
set encoding=utf-8
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set smarttab

set updatetime=100
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

""search using insensitive case
set hlsearch
set incsearch
set ignorecase
set smartcase

" <Ctrl-x> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-x> :nohl<CR><C-x>

set nobackup
set noswapfile

filetype off
filetype plugin indent on

au BufNewFile,BufRead * set tabstop=4 softtabstop=4 shiftwidth=4
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix
au BufNewFile,BufRead *.js set tabstop=2 softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.ts set tabstop=2 softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.tsx set tabstop=2 softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.html set tabstop=2 softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.css set tabstop=2 softtabstop=2 shiftwidth=2
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw, match BadWhitespace /\s\+$/

""""""""" SHORTCUTS """"""""""""
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>


""""""""" PLUGIN CONFIGURATION """"""""""""
"python mode
let g:pymode_python = 'python3'

""Folding config
set foldmethod=indent
set foldlevel=99
nnoremap <space> za 

""NERDTree config
let g:NERDTreeNodeDelimiter = "\u00a0"
let g:NERDTreeIgnore=['\~$', '__pycache__']
let g:autotagTagsFile=".tags"
let g:NERDTreeWinPos = "right"
nnoremap <leader>. :CtrlPTag<cr>
map <C-y> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

""CTRLP config
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
  let g:ackprg = 'ag --vimgrep'
endif

" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|node_modules\|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }

""GitGutter
if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

"VIMUX
" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>

set t_ut=
