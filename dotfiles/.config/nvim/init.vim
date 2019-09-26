" -------------------------------
"  Neovim Configuration
" -------------------------------

" history
set history=100
set undolevels=100

" column and line numbers
set ruler
set nu

set t_Co=256
set background=dark

" Remaps
:inoremap jk <Esc>`^ " `^ is so cursor doesn't move
:inoremap <C-B> <Home>
:inoremap <C-E> <End>

" Search Settings
set incsearch
set ignorecase
set smartcase

set laststatus=2

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()


"set background=dark
syntax on
colorscheme onedark
set termguicolors
