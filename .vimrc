filetype off

" set shell to bash for Vundle
set shell=/bin/bash

" Vundle setup
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

function! IsCurrChar(c)
    let v = matchstr(getline('.'), '\%' . col('.') . 'c.')
    return a:c == v
endfunction

function! IsCurrEmpty()
    return IsCurrChar('') || IsCurrChar(' ') || IsCurrChar('\t') || IsCurrChar('\n')
endfunction

function! IsNextChar(c)
    let v = matchstr(getline('.'), '\%' . (col('.')+1) . 'c.')
    return a:c == v
endfunction

function! IsClosing()
    let v = matchstr(getline('.'), '\%' . col('.') . 'c.')
    if v == "\""
        return 1
    elseif v == "}"
        return 1
    elseif v == ")"
        return 1
    elseif v == "]"
        return 1
    endif

    return 0
endfunction

command! Closing :call IsClosing()

let mapleader = " "

" Mappings
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nmap <S-j> :m+<CR>
nmap <S-k> :m-2<CR>
map <Leader><Leader>d :Bclose<CR>
nmap < :tabprev<CR>
nmap > :tabnext<CR>
nmap <TAB> :A<CR>
inoremap <C-c> <CR><Esc>O
nnoremap <silent> <F5> :!clear;python %<CR>
map <C-e>E :e ~/.vimrc<CR>
nmap <C-o> o<Esc>

inoremap {<CR> <CR>{<CR>}<Esc>O
inoremap <expr> " IsCurrChar("\"") ? "<Right>" : "\"\"<Esc>i"
inoremap <expr> ' IsCurrChar("\'") ? "<Right>" : "\'\'<Esc>i" 
inoremap <expr> [ IsCurrEmpty() ? "[]<Left>" : "["
inoremap <expr> ( IsCurrEmpty() ? "()<Left>" : "("

inoremap <expr> ] IsCurrChar("]") ? "<Right>" : "]"
inoremap <expr> ) IsCurrChar(")") ? "<Right>" : ")"
inoremap <expr> } IsCurrChar("}") ? "<Right>" : "}"

vnoremap " s"<C-r>*"<Esc>
vnoremap ' s'<C-r>*'<Esc>
vnoremap [ s[<C-r>*]<Esc>
vnoremap ( s(<C-r>*)<Esc>
vnoremap { s{<CR><C-r>*<CR>}<Esc>

inoremap <C-e> <Esc>A
inoremap <C-n> <Esc>jo
inoremap <expr> <Tab> :Closing ? "<Left>" : "<Tab>"

nmap <leader>l :set list!<CR>
nmap <leader>vs :vsp<CR>
nmap <leader>s :split<CR>
nmap <leader>ts :tab split<CR>
nmap <leader>as :exec "%!astyle --style=google --indent=spaces"<CR>
"nmap <leader>as :exec "%!astyle --style=allman"<CR>
vnoremap <leader>r y :%sno/<c-r>0//g <left><left><left>
vnoremap <leader><leader>r y :bufdo %sno/<c-r>0//g <left><left><left>
nnoremap ; :

" Octave syntax
augroup filetypedetect
  au! BufRead,BufNewFile *.m,*.oct set filetype=octave
augroup END 

Bundle 'Vundle/Vundle.vim'

Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'vim-scripts/taglist.vim'
Bundle 'vim-scripts/TaskList.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'rbgrouleff/bclose.vim'

Bundle 'altercation/vim-colors-solarized'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'jansenm/vim-cmake'
Bundle 'tikhomirov/vim-glsl'
Bundle 'vim-scripts/Conque-GDB'
Bundle 'idanarye/vim-dutyl'
Bundle 'zah/nim.vim'
Bundle 'Wutzara/vim-materialtheme'
Bundle 'jscappini/material.vim'
Bundle 'NLKNguyen/papercolor-theme'
Bundle 'xero/sourcerer.vim'
Bundle 'tomasr/molokai'
Bundle 'joshdick/onedark.vim'
Bundle 'lifepillar/vim-wwdc16-theme'
Bundle 'tyrannicaltoucan/vim-deep-space'
Bundle 'mtglsk/wikipedia.vim'
Bundle 'lifepillar/vim-solarized8'
Bundle 'vim-scripts/Visual-Studio'
Bundle 'MvanDiemen/ghostbuster'
Bundle 'cseelus/vim-colors-lucid'
Bundle 'YorickPeterse/happy_hacking.vim'
Bundle 'marciomazza/vim-brogrammer-theme'
Bundle 'AlessandroYorba/Sierra'

" Setup NERDTree

let g:NERDTreeWinPos = "left"
let NERDTreeQuitOnOpen = 1
let NERDTreeIgnore=['\.DS_Store$','\.pyc$', '\.xls$','\.zip$','\.pdf$','\.nav$','\.snm$','.\toc$','\.vrb$','\.aux$' , '\.git$', '\.db$', '\.ropeproject', '\.so$', '\.un\~$', '\.lein-plugins$', '\.beam$']
let NERDTreeHighlightCursorline=1
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=0
let NERDTreeDirArrows = 1

" NerdTree and TagList toggles
nmap <silent> <TAB> :NERDTreeToggle<CR>
nmap <silent> <F3> :TlistToggle<CR>
let Tlist_Use_Right_Window = 1

" Tags
let g:vim_tags_auto_generate = 1
if has("autocmd")
    autocmd Filetype nerdtree setlocal nolist
endif

" Setup UltiSnips

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
let g:UltiSnipsListSnippets="<c-l>"
" this mapping Enter key to <C-y> to chose the current highlight item 
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

autocmd Filetype python :UltiSnipsAddFiletypes python
autocmd Filetype html :UltiSnipsAddFiletypes html
autocmd Filetype d :UltiSnipsAddFiletypes d
autocmd Filetype c :UltiSnipsAddFiletypes c
autocmd Filetype cpp :UltiSnipsAddFiletypes cpp

" Setup YouCompleteMe

let g:ycm_path_to_python_interpreter = '/usr/local/bin/python2'
let g:ycm_register_as_syntastic_checker = 1

"YCM will put icons in Vim's gutter on lines that have a diagnostic set.
"Turning this off will also turn off the YcmErrorLine and YcmWarningLine
"highlighting
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 0

let g:ycm_complete_in_strings = 1 "default 1
let g:ycm_collect_identifiers_from_tags_files = 1 "default 0
let g:ycm_path_to_python_interpreter = 'python' "default ''

let g:ycm_server_use_vim_stdout = 0 "default 0 (logging to console)
let g:ycm_server_log_level = 'info' "default info
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 1

let g:ycm_goto_buffer_command = 'same-buffer' "[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab' ]
let g:ycm_filetype_whitelist = { '*': 1 }
let g:ycm_autoclose_preview_window_after_insertion = 1

" Setup dutyl
call dutyl#register#tool('dcd-client','/home/relja/Packages/DCD/bin/dcd-client')
call dutyl#register#tool('dcd-server','/home/relja/Packages/DCD/bin/dcd-server')
call dutyl#register#tool('dscanner','/home/relja/Packages/dscanner/bin/dscanner')
call dutyl#register#tool('dfix','/home/relja/Packages/dfix/bin/dfix')
call dutyl#register#tool('dfmt','/home/relja/Packages/dfmt/bin/dfmt')

function! LoadDMDIncludes()
    let g:dutyl_stdImportPaths=['/usr/include/dmd/phobos', '/usr/include/dmd/druntime/import/']
endfunction

function! LoadLDCIncludes()
    let g:dutyl_stdImportPaths=['/usr/local/include/d']
endfunction

call LoadLDCIncludes()

nmap <Leader>dcd :DUDCDstartServer<CR>
nmap <Leader>ndc :DUDCDstopServer<CR>

autocmd Filetype python nnoremap <C-]> :YcmCompleter GoTo<CR>
autocmd Filetype c nnoremap <C-]> :YcmCompleter GoTo<CR>
autocmd Filetype cpp nnoremap <C-]> :YcmCompleter GoTo<CR>
autocmd Filetype d nnoremap <C-]> :DUjump<CR>

"autocmd Filetype d nmap <leader>as :exec "%!dfmt -i --brace_style=stroustrup --max_line_length=120 --soft_max_line_length=80"<CR>
autocmd Filetype d nmap <leader>as :exec "%!dfmt -i --space_after_cast=false --max_line_length=120 --soft_max_line_length=100"<CR>
autocmd Filetype cpp nmap <leader>as :exec "%!astyle --style=google --indent=spaces"<CR>
autocmd Filetype c nmap <leader>as :exec "%!astyle --style=google --indent=spaces"<CR>

"set omnifunc=syntaxComplete#complete
"set omnifunc=syntaxcomplete#Complete

filetype plugin indent on

" Options
set exrc
set laststatus=2

set secure
set nobackup
set noswapfile
set nowritebackup
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set colorcolumn=120
set encoding=utf-8
set showcmd            " Show (partial) command in status line.
set nowrap
set showmatch          " Show matching brackets.
set hidden             " Hide buffers when they are abandoned
set mouse=v
set cindent
set cinoptions=g-1,N-s
set list  
set listchars=tab:▸-,eol:¬,trail:๐
set clipboard=unnamed
set wildignore+=*.git,*.jpg,*.tif,*.png
set nowrap
set number
set relativenumber
set t_Co=256
set nospell
set pastetoggle=<F2>
set backspace=2 " make backspace work like most other apps
set cursorline!
set spell spelllang=en_us

"vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_powerline_fonts=1
let g:airline_enable_branch=1
let g:airline_theme="PaperColor"
let g:airline_enable_syntastic=1
let g:airline_detect_paste=1

"Setup run plugin
let g:compile_args='--compiler=ldc2'
let g:run_args='--compiler=ldc2 --build=release'

let g:release_args='--compiler=ldc2 --build=release'
let g:debug_args='--compiler=ldc2 --build=debug'

nmap <leader><leader>dd let g:compile_args=g:debug_args
nmap <leader><leader>dr let g:compile_args=g:release_args

if has("gui_running")
	colorscheme onedark
else
	colorscheme molokai
    "colorscheme deep-space
    "colorscheme materialtheme
endif

set guifont=Meslo\ 13
set guioptions-=m
set guioptions-=T

hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

syntax on

hi Normal ctermbg=NONE
