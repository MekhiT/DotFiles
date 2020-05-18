call plug#begin('~/.vim/plugged')
Plug 'shapeoflambda/dark-purple.vim'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'lervag/vimtex'
Plug 'joshdick/onedark.vim'
Plug 'whatyouhide/vim-gotham'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'rust-lang/rust.vim'
Plug 'dracula/vim',{'as':'dracula'}
Plug 'arcticicestudio/nord-vim'
Plug 'psliwka/vim-smoothie'
Plug 'Yggdroot/indentLine'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
" g:tex_conceal='abdmg'
Plug 'sirver/ultisnips'
let g:UltiSnipsSnippetDirectories = ['/home/mekhi/.vim/UltiSnips']
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
call plug#end()
