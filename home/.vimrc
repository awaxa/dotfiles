set nocompatible              " be iMproved, required
filetype off                  " required

" Setting up Vundle - the vim plugin bundler
let firstinstall=0
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim
    let firstinstall=1
endif


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" plugin not on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

Plugin 'Shougo/neocomplcache.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'edkolev/tmuxline.vim'
Plugin 'godlygeek/tabular'
Plugin 'jnurmine/Zenburn'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'osyo-manga/vim-over'
Plugin 'rodjek/vim-puppet'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'vim-ruby/vim-ruby'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins

if firstinstall== 1
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :PluginInstall
endif
" Setting up Vundle - the vim plugin bundler end
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax on
color zenburn
set bg=dark

if !isdirectory(expand('~/.vim/swap'))
    silent !mkdir ~/.vim/swap
endif
set directory=~/.vim/swap//

set splitbelow
set splitright

set cursorline

set hlsearch

set number

set mouse=a

let g:syntastic_check_on_wq = 0
let g:syntastic_ignore_files = ['\m\.pp$']

inoremap jk <Esc>

" Change cursor style when entering INSERT mode (works in tmux!)
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Open URLs with <Leader>w
function! HandleURI()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:)]*')
  echo s:uri
  if s:uri != ""
          exec "!open \"" . s:uri . "\""
  else
          echo "No URI found in line."
  endif
endfunction
map <Leader>w :call HandleURI()<CR>

" let &colorcolumn=join(range(81,999),",")

cmap w!! % ! sudo tee 2> /dev/null %

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

highlight LiteralTabs ctermbg=darkgreen guibg=darkgreen
match LiteralTabs /\s\	/
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

map <C-n> :NERDTreeToggle<CR>

let g:neocomplcache_enable_at_startup = 1
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

let g:airline#extensions#tabline#enabled = 1

let g:tmuxline_preset = {
    \ 'a': '#S',
    \ 'b': ['%a %b %d', '%R'],
    \ 'win': ['#I', '#W'],
    \ 'cwin': ['#I', '#W'],
    \ 'y': '#(battinfo.rb)',
    \ 'z': '#h',
    \}

map <Leader>b :CtrlPBuffer<CR>
map <Leader>m :CtrlPMRUFiles<CR>

autocmd FileType puppet setlocal commentstring=#\ %s
autocmd FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType java setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType sh setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

set expandtab

nnoremap S "_diwP

" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
