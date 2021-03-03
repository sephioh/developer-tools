""""""""" PLUGIN INSTALLATION """"""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin()
Plug 'benmills/vimux'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'myusuf3/numbers.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'preservim/nerdcommenter'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-fugitive'
Plug 'lifepillar/vim-solarized8'
Plug 'ludovicchabant/vim-gutentags'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'dikiaap/minimalist'
Plug 'chr4/nginx.vim'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'christoomey/vim-tmux-navigator'
Plug 'ntpeters/vim-better-whitespace'
" Python plugins
Plug 'ycm-core/YouCompleteMe'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'python-rope/ropevim'
Plug 'vim-scripts/indentpython.vim'
Plug 'psf/black', { 'branch': 'stable' }
call plug#end()

""""""""" General configuration """"""""""""
colorscheme gruvbox
nnoremap ; :
let mapleader="," " change the mapleader from \ to ,
"set timeoutlen=1000 ttimeoutlen=200 "dont wait for normal mode

syntax on  "enable syntax
set number  "display line numbers
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

"""search using insensitive case
"set hlsearch
set nohlsearch
set incsearch
set ignorecase
set smartcase

set nobackup
set noswapfile

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

"""Folding config
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

"""""""""" PLUGIN CONFIGURATION """"""""""""
""python mode
let g:pymode_options_max_line_length = 88
let g:pymode_options_colorcolumn = 0

"""NERDTree config
let g:NERDTreeNodeDelimiter = "\u00a0"
let g:NERDTreeIgnore=['\~$', '__pycache__']
let g:autotagTagsFile=".tags"
let g:NERDTreeWinPos = "right"
nnoremap <leader>. :CtrlPTag<cr>
map <C-y> :NERDTreeToggle<CR>
nmap <silent>¡ :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""CTRLP config
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
  let g:ackprg = 'ag --vimgrep'
endif

""Ack
nmap ƒ :Ack!
let g:ack_autoclose = 1
let g:ackpreview=1

"" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|node_modules\|log\|tmp$',
  \ 'file': 'tags\|\.so$\|\.dat$|\.DS_Store$'
  \ }

""VIMUX
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vc :VimuxCloseRunner<CR>

" coc extensions
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier']
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
command! -nargs=0 Prettier :CocCommand prettier.formatFile
autocmd FileType python CocDisable

"" closetag
let g:closetag_regions =  {
\ 'typescript.tsx': 'jsxRegion,tsxRegion',
\ 'javascript.jsx': 'jsxRegion',
\ }

""YCM
let g:ycm_autoclose_preview_window_after_completion=1
autocmd FileType python nmap <silent>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
autocmd FileType python nmap <silent>gr :YcmCompleter GoToReferences<CR>
let g:ycm_confirm_extra_conf = 0
let g:ycm_filetype_whitelist = {'python': 1}
set completeopt-=preview

""Black
autocmd FileType python nmap <Leader>gl :Black<CR>

""vim-better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

""ropevim
source ~/.config/nvim/plugged/ropevim/ftplugin/python_ropevim.vim

""vim-fugitive
function! ToggleGStatus()
    if buflisted(bufname('.git/index'))
        bd .git/index
    else
        Gstatus
    endif
endfunction
command ToggleGStatus :call ToggleGStatus()
nmap <silent>£ :ToggleGStatus<CR>

set t_vb=
