" Colors {{{
colorscheme nord         "set colorscheme to [dracula]
syntax enable            "[enable] syntax processing
set title
"}}}
"Spelling{{{
set spelllang=en
setlocal spell
"}}}
"Spaces & Tabs {{{
set tabstop=4            "number of visual spaces per TAB
set softtabstop=4        "number of spaces in tab when editing
set expandtab            "tabs are spaces
filetype plugin indent on "lines automatically indent to the right level
"}}}
" UI Config {{{
set relativenumber               "show line numbers
set showcmd              "show command in bottom bar
set cursorline           "highlight current line
set wildmenu             "visual autocomplete for command menu
set lazyredraw           "redraw only when needed
set showmatch            "highlight matching [{()}]
set title                "show file name on terminal
"}}}
" Searching{{{
set incsearch            "search as characters are entered
set hlsearch             "highlight matches
" turn off search highlight
nnoremap <leader>h :nohlsearch<CR>
"}}}
"Folding {{{
set foldenable           "enable folding
set foldlevelstart=1    "open most fold by default
set foldnestmax=10       "[10] nested fold max
" space open/closes folds
nnoremap <space> za
set foldmethod=indent    "fold based on indent level
"}}}
"Movement {{{
" move vertically by visual line
nnoremap j gj
nnoremap k gk
"}}}
" Leader Shortcuts{{{
let mapleader=","        "leader is comma
" jk is escape
inoremap jk <esc>
"edit vimrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
"save session
nnoremap <leader>s  :mksession<CR>
"}}}
" Autogroups {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType java setlocal foldmethod=expr
    autocmd FileType java setlocal foldexpr=ImportFolds()
    autocmd FileType rust setlocal foldmethod=expr
    autocmd FileType rust setlocal foldexpr=UseFolds()
augroup END
"}}}
"Backups{{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
"}}}
"Vim-Plug {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
   silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

so ~/.config/nvim/plugins.vim
"}}}
"NerdTree{{{
 map <C-n> :NERDTreeToggle<CR>
"}}}
"Airline{{{
 let g:airline_powerline_fonts = 1
 let g:airline#extensions#tabline#enabled = 1
 let g:airline#extensions#tabline#buffer_nr_show = 1
"}}}
" Import Folding{{{
        function! ImportFolds()
                let thisline = getline(v:lnum)
                if thisline =~? '\v^\s*$'
                        return -1
                endif

                if thisline =~ '^import.*$'
                        return 2
                else
                        return indent(v:lnum) / &shiftwidth
                endif
        endfunction
"}}}
" Use Folding{{{
        function! UseFolds()
                let thisline = getline(v:lnum)
                if thisline =~? '\v^\s*$'
                        return -1
                endif

                if thisline =~ '^use.*$'
                        return 1
                else
                        return indent(v:lnum) / &shiftwidth
                endif
        endfunction
"}}}
set modelines=1
" vim:foldmethod=marker:foldlevel=0
