" Always use bash
set shell=/bin/bash

" Pathogen
let g:pathogen_disabled = ['pathogen']
call pathogen#infect()

" Helpful defaults
set nocompatible " Disable complete vi compatibility
set backspace=indent,eol,start " Smarter backspacing
set timeoutlen=500 " Lower ESC timeout
set history=1000 " Keep command line history
set ignorecase " Case-insensitive searching
set matchtime=2 " Time between bracket jumping for showmatch
if has("mouse")
    set mouse=a " Enable the mouse
endif
set autoindent
set nobackup " Don't make backup files XXX
set completeopt=longest,menuone,preview " Better completion
set formatoptions=qrn1
set nohlsearch " No search highlighting
set noincsearch " No incremental searching
set shiftround " Indent to multiples of shiftwidth
set showcmd " Don't show incomplete commands
set showmatch " Show matching brackets
set ruler " Show cursor information
set smartcase " Case-sensitive searching for searches with uppercase letters
set splitbelow
set splitright
set textwidth=0 " No hard line wrapping XXX
set title " Set the terminal title
set viminfo=\"50,'20 " Store session info in ~/.viminfo
set wildmode=list:longest " More useful command completion
" Hide annoying files from wildmenu/netrw/fuzzyfinder
set wildignore=*.orig,*~,*.o,*.so,*.py[cdo],*.swp,*.prof
let g:netrw_list_hide='\.orig$,\.~$,\.s?o$,\.py[cdo]$,\.swp$,\.prof$'
fixdel " Try to fix backspace if it's broken
" Enable automatic filetype and ft plugins
filetype on
filetype plugin on
filetype indent on

" Syntax highlighting settings
if has("syntax")
    syntax enable " Automatic syntax highlighting
    syntax sync maxlines=500 " Sync highlighting with previous 500 lines
    " Highlight VCS conflict markers
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
endif

" Auto-commands
if has("autocmd")
    " Tabbing settings
    autocmd FileType c,changelog,cheetah,cpp,cs,csh,css,django,dosini,
                    \haskell,java,javascript,mysql,objc,objcpp,perl,po,pyrex,
                    \python,rl,rst,ruby,sh,sql,tcsh,vim,zsh
                   \ setlocal autoindent expandtab smarttab shiftwidth=4
                            \ softtabstop=4 tabstop=8
    autocmd FileType ant,dtml,genshi,html,htmlcheetah,htmldjango,kid,mako,
                    \php,sgml,smarty,xhtml,xml,xslt
                   \ setlocal autoindent expandtab smarttab shiftwidth=2
                            \ softtabstop=2 tabstop=8
    " Resize splits when the window is resized
    autocmd VimResized * :wincmd =
endif

" Convenience command to map something to every mode
command -nargs=+ AllMap noremap <args>|noremap! <args>|vnoremap <args>

let mapleader = ","
let maplocalleader = "\\"
nnoremap ; :
nnoremap <silent> <Leader>f <Esc>:FufFileWithCurrentBufferDir<Return>
nnoremap <silent> <Leader>b <Esc>:FufBuffer<Return>
nnoremap <silent> <Leader>c <Esc>:bd<Return>
nnoremap <silent> <Leader>q <Esc>:q<Return>
nnoremap <silent> <Leader>Q <Esc>:qa<Return>
nnoremap <Leader>u <Esc>:GundoToggle<Return>
nnoremap <Leader>a <Esc>:Ack!<space>
nnoremap <Leader>v <C-w>v<C-w>l
nnoremap <Leader>s <C-w>s<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

delcommand AllMap

" Sudo to write
cmap w!! w !sudo tee % > /dev/null

" :Man for man pages
runtime ftplugin/man.vim

" Enable colors if available
if &term == "xterm-color"
    set t_Co=16
elseif &term == "xterm-256color"
    set t_Co=256
endif

" Set color scheme
if has("gui")
    set background=dark
    colorscheme billw
else
    set background=dark
endif

" Enable spell checking (vim7 only)
if has("spell")
    set spelllang=en_us " Global spell checking
    highlight clear SpellBad
    highlight SpellBad term=standout ctermfg=Red term=underline
                     \ cterm=underline gui=underline guifg=Red
    highlight clear SpellCap
    highlight SpellCap term=underline cterm=underline gui=underline
    highlight clear SpellRare
    highlight SpellRare term=underline cterm=underline gui=underline
    highlight clear SpellLocal
    highlight SpellLocal term=underline cterm=underline gui=underline
    if has("autocmd")
        " Spell check where it works properly
        autocmd FileType c,changelog,cheetah,cpp,cs,csh,css,java,javascript,
                        \perl,po,python,rst,ruby,sh,tcsh,vim,dtml,genshi,
                        \html,htmlcheetah,htmldjango,kid,mako,php,smarty,
                        \xhtml,xml,xslt
                       \ setlocal spell
    endif
endif

" TextMate-style display of invisible characters
set listchars=tab:⇥\ ,eol:¬,trail:·
set list
highlight clear NonText
highlight NonText ctermfg=DarkGrey guifg=#222222
highlight clear SpecialKey
highlight SpecialKey ctermfg=DarkGrey guifg=#222222
if &t_Co == 256
    highlight NonText ctermfg=232 guifg=#222222
    highlight SpecialKey ctermfg=232 guifg=#222222 guibg=NONE
endif

" Highlight the 80th column
if has("autocmd") && (has("gui") || &t_Co == 256)
    " Only show colorcolumn in the current window.
    setlocal colorcolumn=+1
    augroup ccol
        autocmd!
        autocmd WinLeave * setlocal colorcolumn=0
        autocmd WinEnter * setlocal colorcolumn=+1
    augroup END
    highlight ColorColumn ctermbg=232 guibg=#121212
endif

" MacVim settings
if has("gui_macvim")
    set guifont=Inconsolata:h12
    set linespace=2
    set guioptions-=T " Disable toolbar
    set guioptions-=r " Disable scrollbar
    set guioptions-=L " Disable left-hand scrollbar
    "set transparency=15 " Transparency's broken in 7.3e!
    set columns=80 lines=40 " Set default window size
    set fuoptions+=maxhorz
    map <silent> <Leader>t <Esc>:silent !open -a Terminal<Return>
endif
