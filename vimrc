" Always use bash
set shell=/bin/bash

" Pathogen
let g:pathogen_disabled = ['pathogen']
call pathogen#infect()
call pathogen#helptags()

" Helpful defaults
set nocompatible " Disable complete vi compatibility
set backspace=indent,eol,start " Smarter backspacing
set notimeout
set ttimeout
set ttimeoutlen=10
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
set nonumber
set ruler " Show cursor information
set smartcase " Case-sensitive searching for searches with uppercase letters
"set splitbelow
"set splitright
set textwidth=0 " No hard line wrapping XXX
set title " Set the terminal title
set viminfo=\"50,'20 " Store session info in ~/.viminfo
set wildmode=list:longest " More useful command completion
" Hide annoying files from wildmenu/netrw/fuzzyfinder
set wildignore=*.orig,*~,*.o,*.so,*.py[cdo],*.swp,*.prof,.DS_Store,
              \*/.git/*,*/.hg/*,*/.svn/*,.hgsubstate
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
                            \ softtabstop=4 tabstop=8 textwidth=78
    autocmd FileType ant,dtml,genshi,html,htmlcheetah,htmldjango,kid,mako,
                    \php,sgml,smarty,xhtml,xml,xslt
                   \ setlocal autoindent expandtab smarttab shiftwidth=2
                            \ softtabstop=2 tabstop=8
    autocmd FileType python highlight PyFlakes gui=bold guibg=#aa2222
    " Resize splits when the window is resized
    autocmd VimResized * :wincmd =
endif

" Undo python-mode brain damage
let g:pymode_lint_checker = "pyflakes,mccabe"
let g:pymode_lint_onfly = 1
let g:pymode_lint_cwindow = 0
let g:pymode_utils_whitespaces = 0
let g:pymode_folding = 0
let g:pymode_options_other = 0

" Convenience command to map something to every mode
command -nargs=+ AllMap noremap <args>|noremap! <args>|vnoremap <args>

function! SmartSplit()
    vsplit
    if winwidth(0) <= &columns
        set columns+=80
    endif
endfunction

let mapleader = ","
let maplocalleader = "\\"
nnoremap ; :
let g:ctrlp_map = '<Leader>f'
nnoremap <silent> <Leader>b <Esc>:CtrlPMRU<Return>
nnoremap <silent> <Leader>c <Esc>:bd<Return>
nnoremap <silent> <Leader>q <Esc>:q<Return>
nnoremap <silent> <Leader>Q <Esc>:qa<Return>
nnoremap <silent> <Leader>0 <Esc>:q<Return>
nnoremap <silent> <Leader>1 <C-w>o<Esc>:set columns=80<Return>
nnoremap <Leader>w <C-w>w
nnoremap <Leader>u <Esc>:GundoToggle<Return>
nnoremap <Leader>a <Esc>:Ack!<space>
nnoremap <Leader>s <C-w>s
nnoremap <Leader>v <Esc>:call SmartSplit()<Return>
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
    colorscheme molokai
else
    set background=dark
endif

" Enable spell checking (vim7 only)
if has("spell")
    set spelllang=en_us " Global spell checking
    highlight clear SpellBad
    highlight SpellBad term=standout ctermfg=Red term=underline
                     \ cterm=underline gui=underline guisp=#883300
    highlight clear SpellCap
    highlight SpellCap term=underline cterm=underline gui=underline
                     \ guisp=#7070f0
    highlight clear SpellLocal
    highlight SpellLocal term=underline cterm=underline gui=underline
                       \ guisp=#70f0f0
    highlight clear SpellRare
    highlight SpellRare term=underline cterm=underline gui=underline
                      \ guisp=#ffffff
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
highlight NonText ctermfg=DarkGrey guifg=#404040
highlight clear SpecialKey
highlight SpecialKey ctermfg=DarkGrey guifg=#505050
if &t_Co == 256
    highlight NonText ctermfg=232 guifg=#404040
    highlight SpecialKey ctermfg=232 guifg=#505050 guibg=NONE
    highlight ColorColumn ctermbg=232
endif

let g:vimroom_guibackground='#1B1E1F'
let g:vimroom_width=79

function! SmartColorColumn()
    if winwidth(0) <= &textwidth + 2
        setlocal colorcolumn=0
    else
        setlocal colorcolumn=+1
    endif
endfunction

" Highlight the 80th column
if has("autocmd") && (has("gui") || &t_Co == 256)
    " Only show colorcolumn in the current window.
    call SmartColorColumn()
    augroup ccol
        autocmd!
        "autocmd WinLeave * setlocal colorcolumn=0
        "autocmd WinEnter * setlocal colorcolumn=+1
        autocmd WinLeave * setlocal colorcolumn=0
        autocmd WinEnter * call SmartColorColumn()
        autocmd VimEnter * call SmartColorColumn()
        autocmd VimResized * call SmartColorColumn()
    augroup END
endif

" MacVim settings
if has("gui_macvim")
    "set guifont=Inconsolata:h12
    set guifont=DejaVu\ Sans\ Mono:h14
    set linespace=2
    set guioptions-=T " Disable toolbar
    set guioptions-=r " Disable scrollbar
    set guioptions-=L " Disable left-hand scrollbar
    "set transparency=15 " Transparency's broken in 7.3e!
    map <silent> <Leader>t <Esc>:silent !open -a Terminal<Return>

    set columns=80 lines=40 " Set default window size
    if str2nr(split(system('osascript -e ''tell application "Finder" to get bounds of window of desktop'''), '\W\+')[3]) > 900
        set lines=60
    endif
endif
