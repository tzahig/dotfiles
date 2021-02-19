" ========================================================================
" 1. Set-up plugins
" ========================================================================
autocmd! bufwritepost .vimrc source %
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'drewtempelmeyer/palenight.vim'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-sensible'
call plug#end()

" ========================================================================
" 2. VIM basic settings (A)
" ========================================================================
set shell=/bin/bash 
autocmd! bufwritepost .vimrc source %
let mapleader = ","
let g:mapleader = ","

function! IsCursorAtEndOfNonEmptyLine()
    return col('.') == col('$') && col('.') != 1
endfunction

" escape behavior, this breaks the pastetoggle
" inoremap <expr><ESC> IsCursorAtEndOfNonEmptyLine() ? "\<ESC>" : "\<ESC>l"

" noremap <leader>c gc
set pastetoggle=<F2>
" ========================================================================
" https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
" make the default clipboard the system clipboard
set clipboard=unnamedplus
" like -X
set clipboard=exclude:.*

set noswapfile
set notimeout          " don't timeout on mappings
set ttimeout           " do timeout on terminal key codes
set timeoutlen=100     " timeout after 100 msec"

let g:netrw_liststyle=3
set cc=80
set autoindent
set smartindent
set cindent
set number
set history=700
set undolevels=700
set hlsearch
set incsearch
set ignorecase
set smartcase
set mouse=a
" ========================================================================
" 2. VIM basic settings (B)
" ========================================================================
"  http://amix.dk/vim/vimrc.txt
filetype off
filetype plugin indent on
filetype plugin on
filetype indent on
set wildmenu
set wildignore=*.o,*~,*.pyc
set ruler
set cmdheight=2
set hid
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" don't redraw while executing macros (good performance config)
set lazyredraw
" show matching brackets when text indicator is over them
set showmatch
" how many tenths of a second to blink when matching brackets
set mat=2
" no annoying sound on errors
set noerrorbells
set novisualbell
set noeb vb t_vb=
syntax enable
set ffs=unix,dos,mac
" => text, tab and indent related
set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
" linebreak on 500 characters
set lbr
" fold indent group with 'za'
set foldmethod=indent
set foldlevel=99
" => moving around, tabs, windows and buffers

" ========================================================================
" 3. HAX / IDE
" ========================================================================
" specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" return to last edit position when opening files (you want this!)
autocmd bufreadpost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
" remember info about open buffers on close
set viminfo^=%
" ========================================================================
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

noremap tws :call TrimWhitespace()<CR>
autocmd BufWrite *.py :call TrimWhitespace()
autocmd BufWrite *.coffee :call TrimWhitespace()
"autocmd BufWrite *.vimrc :call TrimWhitespace()
autocmd BufWrite *.c :call TrimWhitespace()
autocmd BufWrite *.h :call TrimWhitespace()
" ========================================================================
" Move current tab into the specified direction.
" @param direction -1 for left, 1 for right.
function! TabMove(direction)
    " get number of tab pages.
    let ntp=tabpagenr("$")
    " move tab, if necessary.
    if ntp > 1
        " get number of current tab page.
        let ctpn=tabpagenr()
        " move left.
        if a:direction < 0
            let index=((ctpn-1+ntp-1)%ntp)
        else
            let index=(ctpn%ntp)
        endif

        " move tab page.
        execute "tabmove ".index
    endif
endfunction

" ========================================================================
" 4. Apperance
" ========================================================================
" Palenight
set background=dark
colorscheme palenight

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif
let g:lightline = { 'colorscheme': 'palenight' }
let g:airline_theme = "palenight"
" ========================================================================
" Add left margin
set foldcolumn=12
highlight FoldColumn guibg=gray14 guifg=white

" ========================================================================
" 5. Mappings
" ========================================================================

" Map to commentary plugin
"
map E $
map B ^
nnoremap <F3> :w!<CR>
nnoremap J j
nnoremap <leader>j J
nnoremap <c-j> 5j
nnoremap <c-k> 5k
nmap <leader>w :w!<cr>
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
noremap <leader>e :quit<CR>
noremap <leader>E :qa!<CR>
map <leader>1 :tabnew \| e ~/.buffer/b1<cr>
map <leader>2 :tabnew \| e ~/.buffer/b2<cr>
map <leader>3 :tabnew \| e ~/.buffer/b3<cr>
map <leader>4 :tabnew \| e ~/.buffer/b4<cr>
map <leader>5 :tabnew \| e ~/.buffer/b5<cr>
map <leader>6 :tabnew \| e ~/.buffer/b6<cr>
map <leader>7 :tabnew \| e ~/.buffer/b7<cr>
map <leader>8 :tabnew \| e ~/.buffer/b8<cr>
map <leader>9 :tabnew \| e ~/.buffer/b9<cr>

" disable Ex mode
map Q <Nop>

nnoremap <F1> :tabnew<cr>:e ~/.vimrc<cr>
nnoremap <F7> :! cat %<CR>
nmap <F5> :exec '!'.getline('.')

" arrow keys
" nnoremap <down> :! <Right>
" " imap <up> <esc>
" nmap <up> <nop>
nmap <left> :w<cr>
nmap <right> :q
nnoremap <left> :! <Right>
imap <Right> <esc>
nmap <right> <nop>
" nmap <up> :! <Right>
" nmap <down> :w<cr>

" Disable these
noremap <Del> <ESC>
imap <C-c> <ESC>

map <leader>k :Explore

" easier moving between tabs
nnoremap <leader>n <esc>:tabprevious<CR>
nnoremap <leader>m <esc>:tabnext<CR>
nnoremap <leader>t <esc>:tabnew<CR>:e 
nnoremap <leader>r :! <Right>

" treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

map <space> /

" better indentation in visual mode
vnoremap < <gv
vnoremap > >gv

" search and replace word under cursor
:nnoremap <leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
:vnoremap <leader>s "ay :%s/<c-r>a//g<left><left>
:vnoremap <leader>x "ay :%s/\(<c-r>a\)/\1/g<left><left>
:nnoremap <F4> :%s///g<Left><Left><Left>
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
map <leader>cd :cd %:p:h<cr>:pwd<cr>

map <F9> :call TabMove(-1)<CR>
map <F10> :call TabMove(1)<CR>

