set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/vim-dutyl
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
	source /etc/vim/vimrc.local
endif

" register Vundle
call vundle#rc()

set laststatus=2
set secure
set number
set nobackup
set noswapfile
set nowritebackup
set tabstop=4
set softtabstop=4
set shiftwidth=4
set colorcolumn=120
set encoding=utf-8
set showcmd            " Show (partial) command in status line.
set nowrap
set showmatch          " Show matching brackets.
set ignorecase         " Do case insensitive matching
set smartcase          " Do smart case matching
set incsearch          " Incremental search
set autowrite          " Automatically save before commands like :next and
set hidden             " Hide buffers when they are abandoned
set mouse=a            " Enable mouse usage (all modes)
set cindent
set cinoptions=g-1
set list
set listchars=tab:▸\ ,eol:¬

syntax on
filetype indent on
filetype plugin on
set t_Co=256
set background=light
colorscheme seoul256

highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

map <j> <k>
map <k> <j>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <Leader>d :bd<CR>
nmap , :bp<CR>
nmap . :bn<CR>
map <F4> :A<CR>
nmap <z> :undo
nmap <Z> :redo
nnoremap <b> <C-u>
nnoremap <n> <C-e>
nmap <silent> <Tab> :NERDTreeToggle<CR>
inoremap <C-c> <CR><Esc>O
nnoremap <silent> <F5> :!clear;python %<CR>
map <C-e>E :e ~/.vimrc<CR>
nmap <C-o> o<Esc>
nmap <C-O> O<Esc>
" brackets new line
inoremap {<CR> {<CR>}<Esc>O
" got o end of line in insert, for jump out of brackets
inoremap <C-e> <C-o>A
nmap <leader>l :set list!<CR>

Bundle 'gmarik/Vundle.vim'
Bundle 'Raimondi/delimitMate'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/nerdtree'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'Hackerpilot/DCD', {'rtp': 'editors/vim'}
Bundle 'altercation/vim-colors-solarized'
Bundle 'SirVer/ultisnips'
"Bundle 'honza/vim-snippets'

function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-e>"
" this mapping Enter key to <C-y> to chose the current highlight item 
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"



" YouCompleteMe options
"
let g:ycm_register_as_syntastic_checker = 1

"YCM will put icons in Vim's gutter on lines that have a diagnostic set.
"Turning this off will also turn off the YcmErrorLine and YcmWarningLine
"highlighting
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_always_populate_location_list = 1 "default 0
let g:ycm_open_loclist_on_ycm_diags = 1 "default 1

let g:ycm_complete_in_strings = 1 "default 1
let g:ycm_collect_identifiers_from_tags_files = 1 "default 0
let g:ycm_path_to_python_interpreter = 'python' "default ''

let g:ycm_server_use_vim_stdout = 0 "default 0 (logging to console)
let g:ycm_server_log_level = 'info' "default info
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 1

let g:ycm_goto_buffer_command = 'same-buffer' "[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab' ]
let g:ycm_filetype_whitelist = { '*': 1 }

" Setup DCD
let g:dcd_path = '/home/relja/DCD/bin/'
let g:dcd_importPath=['/usr/include/d']

set omnifunc=syntaxComplete#complete
