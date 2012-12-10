" colorscheme evening

" Found this on dotfiles.org
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=utf-8,latin1
   endif

set bs=2                " allow backspacing over everything in insert mode
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set history=50          " keep 50 lines of command line history
" set number		" show line number
set showmode            " show mode that VIM is in
" set t_Co=256
syntax enable
" set background=dark
" let g:solarized_termcolors=16
" let g:solarized_visibility="high"
" let g:solarized_contrast = "high"
" colorscheme solarized

cmap w!! % ! sudo tee 2> /dev/null %

set hidden " to move hidden buffers easyly

" spelling
" toggle spellchecking on and off with `,s`
let mapleader = ","
nmap <silent> <leader>s :set spell!<CR>
" set region for dict
set spelllang=en_us


" stolen from vimgolf.com
set nocompatible        " use vim defaults
set scrolloff=3         " keep 3 lines when scrolling
" set ai                  " set auto-indenting on for programming

set showcmd             " display incomplete commands
set nobackup            " do not keep a backup file
set ruler               " show the current row and column

set hlsearch            " highlight searches
set incsearch           " do incremental searching
set showmatch           " jump to matches when entering regexp
set ignorecase          " ignore case when searching
set smartcase           " no ignorecase if Uppercase char present

set visualbell t_vb=    " turn off error beep/flash
set novisualbell        " turn off visual bell

set backspace=indent,eol,start  " make that backspace key work the way it should

syntax on               " turn syntax highlighting on by default
filetype on             " detect type of file
" filetype indent on      " load indent file for specific file type

set t_RV=               " http://bugs.debian.org/608242, http://groups.google.com/group/vim_dev/browse_thread/thread/9770ea844cec3282
