" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support"
    Plug 'sheerun/vim-polyglot'
    " File Explorer"
    Plug 'scrooloose/NERDTree'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Barber Tabline
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'romgrk/barbar.nvim'
    " Discord Presence"
    Plug 'andweeb/presence.nvim'
    "Airline"
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'    
    "Color Picker"
    Plug 'KabbAmine/vCoolor.vim'
    "Colorizer
    Plug 'norcalli/nvim-colorizer.lua'
    "fzf"
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    "Auto-complete"
    Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
    "Themes"
    Plug 'tiagovla/tokyodark.nvim'
    Plug 'navarasu/onedark.nvim'
    "Copilot"
    Plug 'github/copilot.vim'    
    "Dracula theme"
    Plug 'dracula/vim'
    "icons"
    Plug 'ryanoasis/vim-devicons'
    Plug 'tpope/vim-fugitive'
    "HTML"
    Plug 'mattn/emmet-vim'
    " startup screen
    Plug 'mhinz/vim-startify'
call plug#end()

"Config Section

if (has("termguicolors"))
    set termguicolors
endif
syntax enable
let g:dracula_colorterm = 0
colorscheme dracula
