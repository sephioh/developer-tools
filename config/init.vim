""""""""" PLUGIN INSTALLATION """"""""""""
set rtp+=~/.vim/bundle/Vundle.vim

call plug#begin()
" Airline (must be on top)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

" Find things!
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'mileszs/ack.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'rbgrouleff/bclose.vim'

" File browser
Plug 'francoiscabrol/ranger.vim'
Plug 'scrooloose/nerdtree'

" Text editor helpers
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-surround'
Plug 'ntpeters/vim-better-whitespace'
Plug 'preservim/nerdcommenter'
Plug 'tmhedberg/SimpylFold'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'

" Syntax helpers
Plug 'dkarter/bullets.vim'
Plug 'chr4/nginx.vim'
Plug 'aserebryakov/vim-todo-lists'

" Tagbar
Plug 'preservim/tagbar'
Plug 'tenfyzhong/tagbar-rust.vim'

" lsp
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'

" Tmux
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-tbone'

" Themes
Plug 'dikiaap/minimalist'
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim'

" Python plugins
Plug 'ycm-core/YouCompleteMe'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'python-rope/ropevim'
Plug 'vim-scripts/indentpython.vim'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'mvanderkamp/vim-pudb-and-jam'
Plug 'wookayin/vim-autoimport'
Plug 'fisadev/vim-isort'

" JS & TS
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'ianks/vim-tsx'

" Test
Plug 'vim-test/vim-test'

" CSS
Plug 'ap/vim-css-color'

" Generic
Plug 'vimwiki/vimwiki'

call plug#end()

""" Lua config
lua << EOF
EOF

autocmd User TelescopePreviewerLoaded setlocal wrap

""""""""" General configuration """"""""""""
"colorscheme minimalist
set path+=**
set encoding=utf-8
colorscheme gruvbox
nnoremap ; :

set cursorline
imap <C-C> <esc>

"change the mapleader from \ to ,
let mapleader=","

"enable syntax
syntax on

"line numbers
set number
set relativenumber
autocmd TermOpen * setlocal nonumber norelativenumber
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" indentation
set autoindent
set copyindent
filetype plugin indent on

set smarttab
set updatetime=100
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

"""search using insensitive case
set nohlsearch
set incsearch
set ignorecase
set smartcase

set nobackup
set noswapfile

au BufNewFile,BufRead * set tabstop=4 softtabstop=4 shiftwidth=4
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix
au BufNewFile,BufRead,BufAdd *.py let b:coc_enabled=0
au BufNewFile,BufRead *.js set tabstop=2 softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.ts set tabstop=2 softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.html set tabstop=2 softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.css set tabstop=2 softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.json set tabstop=2 softtabstop=2 shiftwidth=2
au BufRead,BufNewFile tsconfig.json set filetype=jsonc
au BufRead,BufNewFile *.yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType typescript.tsx setlocal ts=2 sts=2 sw=2
autocmd FileType typescriptreact setlocal ts=2 sts=2 sw=2
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw, match BadWhitespace /\s\+$/

"""""""""" SHORTCUTS """"""""""""
"F1 -> File Browser
nmap <silent><F1> :RangerCurrentFile<CR>

"F2 -> Next issue
nnoremap <silent><F2> <cr>
autocmd FileType python nnoremap <silent><F2> :ALENext <cr>
autocmd FileType rust,typescript,typescript.tsx nnoremap <silent><F2> :call CocAction('diagnosticNext') <cr>

"F3 -> Git Utils
nmap <silent><F3> :call ToggleGStatus()<CR>

"F4 -> Fix File
autocmd FileType python nnoremap <silent><F4> :Black <cr> :ImportSymbol <cr> :ALEFix <cr> :Isort <cr> :w <cr> b
autocmd FileType rust,typescript,typescript.tsx nnoremap <silent><F4> :call CocAction('format') <cr> :CocFix <cr> b

"F5 -> Tag Bar
nnoremap <silent><F5> :TagbarToggle<cr>

"F10 -> Reload Neovim
nnoremap <silent><F10> :source $MYVIMRC <cr>

"CTRL + f -> Search pattern in dir
nnoremap <C-f> :Ag<CR>

"CTRL + p -> Search file by filename
nmap <silent> <C-p> :Files<CR>

"CTRL + a -> Search commands
nmap <silent> <C-a> :Commands<CR>

"Space bar -> Fold/Unfold code
nnoremap <space> za

"CTRL + y -> NERDTree
map <silent> <C-y> :NERDTreeToggle<CR>

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <silent>q :bd<CR>

" resize splits
nnoremap <silent> ∆ :resize -2 <CR>
nnoremap <silent> ˚ :resize +2 <CR>
nnoremap <silent> ˙ :vertical resize -2 <CR>
nnoremap <silent> ¬ :vertical resize +2 <CR>

"Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

"""""""""" /SHORTCUTS """"""""""""
"Folding config
set foldmethod=indent
set foldlevel=99

"""""""""" PLUGIN CONFIGURATION """"""""""""
""python mode
let g:pymode_options_max_line_length = 88
let g:pymode_options_colorcolumn = 0
let g:pymode_lint = 0

if !empty($VIRTUAL_ENV)
  let g:ycm_server_python_interpreter = $VIRTUAL_ENV . '/bin/python'
  let $PYTHONPATH = finddir('site-packages', $VIRTUAL_ENV . '/lib/*')
endif


""NERDTree config
let g:NERDTreeNodeDelimiter = "\u00a0"
let g:NERDTreeIgnore=['\~$', '__pycache__']
let g:autotagTagsFile=".tags"
let g:NERDTreeWinPos = "right"
let g:NERDTreeHijackNetrw = 0
let g:ranger_replace_netrw = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"GutenTags
let g:gutentags_ctags_tagfile = ".tags"

"""FZF
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
let $FZF_DEFAULT_COMMAND= 'ag -g ""'

""Ack
let g:ack_autoclose = 1
let g:ackpreview=1

""VIMUX
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vc :VimuxCloseRunner<CR>
map <Leader>vz :VimuxZoomRunner<CR>

" coc extensions
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier', 'coc-rls']
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
command! -nargs=0 Prettier :CocCommand prettier.formatFile
autocmd FileType python CocDisable

"" closetag
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.jsx,*.tsx'

" Disables auto-close if not in a "valid" region (based on filetype)
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }

""YCM
let g:ycm_autoclose_preview_window_after_completion=1
autocmd FileType python nmap <silent>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
autocmd FileType python nmap <silent>gr :YcmCompleter GoToReferences<CR>
let g:ycm_confirm_extra_conf = 0
let g:ycm_filetype_whitelist = {'python': 1}
set completeopt-=preview

""vim-better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

""ropevim
source ~/.local/share/nvim/plugged/ropevim/ftplugin/python_ropevim.vim

""vim-fugitive
function! ToggleGStatus()
    if buflisted(bufname('.git/index'))
        bd .git/index
    else
        Git
    endif
endfunction

""vim-pudb-and-jam"
let g:pudb_sign='>☠'
nnoremap <leader>bc :<C-U>PudbClearAll<CR>
nnoremap <leader>be :<C-U>PudbEdit<CR>
nnoremap <leader>bl :<C-U>PudbList<CR>
nnoremap <leader>bq :<C-U>PudbQfList<CR>
nnoremap <leader>bp :<C-U>PudbToggle<CR>
nnoremap <leader>bu :<C-U>PudbUpdate<CR>

""vim-sneak"
let g:sneak#s_next = 1

""vim-autoimport"
let g:vim_isort_map = ''

""ale"
let b:ale_linters = ['pyflakes']
let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {'python': ['autoimport', 'black']}

""vim-airline
let g:airline_theme='tomorrow'
"let g:airline_powerline_fonts = 1
"remove the filetype part
let g:airline_section_x=''
"remove the encoding type section
let g:airline_section_y = ''
" remove separators for empty sections
let g:airline_skip_empty_sections = 1

let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_section_c = '%t'

"au User AirlineAfterInit :let g:airline_section_x = airline#section#create([])
au User AirlineAfterInit :let g:airline_section_z = airline#section#create(["linenr", "maxlinenr"])

let g:webdevicons_enable_airline_statusline_fileformat_symbols = 0

""vim-tbone"
nnoremap <silent> <leader>vb :Twrite {bottom} <cr> :TmuxNavigateDown <cr>

""tagbar"
let g:tagbar_autofocus = 1

""vim-test"
nmap <silent> tt :TestNearest<CR>
nmap <silent> tf :TestFile<CR>
nmap <silent> ts :TestSuite<CR>
nmap <silent> tl :TestLast<CR>
let test#strategy = "vimux"
let test#python#runner = 'pytest'

set t_vb=
