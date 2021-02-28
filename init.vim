""""""""" PLUGIN INSTALLATION """"""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin()
Plug 'benmills/vimux'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/indentpython.vim'
Plug 'morhetz/gruvbox'
Plug 'myusuf3/numbers.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'preservim/nerdcommenter'
" Plug 'vim-syntastic/syntastic'
" Plug 'nvie/vim-flake8'
" Plug 'mileszs/ack.vim'
" Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/indentpython.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'ludovicchabant/vim-gutentags'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'dikiaap/minimalist'
" Plug 'chr4/nginx.vim'
Plug 'ycm-core/YouCompleteMe'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

""""""""" General configuration """"""""""""
colo solarized8
nnoremap ; :
let mapleader="," " change the mapleader from \ to ,
"set timeoutlen=1000 ttimeoutlen=200 "dont wait for normal mode

syntax on  "enable syntax
set number  "display line numbers
"set laststatus=2
set encoding=utf-8
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set smarttab
set updatetime=100
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
"set visualbell           " don't beep
set noerrorbells         " don't beep

"""search using insensitive case
"set hlsearch
set nohlsearch
set incsearch
set ignorecase
set smartcase

set nobackup
set noswapfile

"filetype off
filetype plugin indent on

au BufNewFile,BufRead * set tabstop=4 softtabstop=4 shiftwidth=4
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix
au BufNewFile,BufRead,BufAdd *.py let b:coc_enabled=0
au BufNewFile,BufRead *.js set tabstop=2 softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.ts set tabstop=2 softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.tsx set tabstop=2 softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
au BufNewFile,BufRead *.html set tabstop=2 softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.css set tabstop=2 softtabstop=2 shiftwidth=2
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw, match BadWhitespace /\s\+$/

"""""""""" SHORTCUTS """"""""""""
""split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

""Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>


"""""""""" PLUGIN CONFIGURATION """"""""""""
""python mode
"let g:pymode_python = 'python3'
"
"""Folding config
set foldmethod=indent
set foldlevel=99
nnoremap <space> za 

"""NERDTree config
let g:NERDTreeNodeDelimiter = "\u00a0"
let g:NERDTreeIgnore=['\~$', '__pycache__']
let g:autotagTagsFile=".tags"
let g:NERDTreeWinPos = "right"
nnoremap <leader>. :CtrlPTag<cr>
map <C-y> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""CTRLP config
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
  let g:ackprg = 'ag --vimgrep'
endif

"" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|node_modules\|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }

""VIMUX
" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>


""YCM
let g:ycm_autoclose_preview_window_after_completion=1
" map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
map <leader>b :YcmCompleter GoToReferences<CR>
let g:ycm_confirm_extra_conf = 0
let g:ycm_filetype_whitelist = {'python': 1}
set completeopt-=preview


" coc extensions
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier']
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

autocmd FileType python let b:coc_enabled=0 "disable coc for python files
autocmd FileType python CocDisable

command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)


"" closetag
let g:closetag_regions =  {
\ 'typescript.tsx': 'jsxRegion,tsxRegion',
\ 'javascript.jsx': 'jsxRegion',
\ }

set t_vb=
