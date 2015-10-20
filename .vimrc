filetype off

" set shell to bash for Vundle
set shell=/bin/bash

" Powerline setup
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim

" Vundle setup
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

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
inoremap {<CR> {<CR>}<Esc>O
inoremap <C-e> <Esc>A
inoremap <C-n> <Esc>jo
nmap <leader>l :set list!<CR>
nmap <leader>vs :vsp<CR>
nmap <leader>s :split<CR>
nmap <leader>ts :tab split<CR>
"nmap <leader>as :exec "%!astyle --style=google --indent=tab"<CR>
nmap <leader>as :exec "%!astyle --style=allman"<CR>
vnoremap <leader>r y :%sno/<c-r>0//g <left><left><left>
vnoremap <leader><leader>r y :bufdo %sno/<c-r>0//g <left><left><left>
nnoremap ; :
nnoremap <C-]> :YcmCompleter GoTo<CR>
nnoremap <C-LeftMouse> :YcmCompleter GoTo<CR>

" Octave syntax
augroup filetypedetect
  au! BufRead,BufNewFile *.m,*.oct set filetype=octave
augroup END 


Bundle 'gmarik/Vundle.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/nerdtree'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'Hackerpilot/DCD', {'rtp': 'editors/vim'}
Bundle 'altercation/vim-colors-solarized'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'szw/vim-tags'
Bundle 'scrooloose/nerdcommenter'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'vim-scripts/taglist.vim'
Bundle 'Wutzara/vim-materialtheme'
Bundle 'vim-scripts/TaskList.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'rbgrouleff/bclose.vim'
Bundle 'jscappini/material.vim'
Bundle 'xero/sourcerer.vim'
Bundle 'jansenm/vim-cmake'
Bundle 'tikhomirov/vim-glsl'

" Setup NERDTree

let g:NERDTreeWinPos = "left"
let NERDTreeQuitOnOpen = 1
let NERDTreeIgnore=['\.DS_Store$','\.pyc$', '\.xls$','\.zip$','\.pdf$','\.nav$','\.snm$','.\toc$','\.vrb$','\.aux$' , '\.git$', '\.db$', '\.ropeproject', '\.so$', '\.un\~$', '\.lein-plugins$', '\.beam$']
let NERDTreeHighlightCursorline=1
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=0
let NERDTreeDirArrows = 1

" NerdTree and TagList toggles
nmap <silent> <F4> :NERDTreeToggle<CR>
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

" Setup DCD
let g:dcd_path = '/home/relja/DCD/bin/'
let g:dcd_importPath=['/usr/include/d']

nmap <Leader>dcd :DCDstartServer<CR>
nmap <Leader>ndc :DCDstopServer<CR>
map  <F12> :DCDsymbolLocation<CR>

"set omnifunc=syntaxComplete#complete
set omnifunc=syntaxcomplete#Complete

filetype plugin indent on

" Options
set exrc
set laststatus=2
set secure
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
set hidden             " Hide buffers when they are abandoned
set mouse=a            " Enable mouse usage (all modes)
set cindent
set cinoptions=g-1,N-s
set nolist
" set listchars=tab:▸\ ,eol:¬
set clipboard=unnamedplus
set wildignore+=*.git,*.jpg,*.tif,*.png
set nowrap
set number
set norelativenumber
set t_Co=256
set nospell
set pastetoggle=<F2>

colorscheme material
set background=dark

set guioptions-=T
set guioptions-=m

hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

syntax on
