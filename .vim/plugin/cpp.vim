if !exists("g:cpp_src_directory")
	let g:cpp_src_directory="src"
endif

if !exists("g:cpp_header_ext")
	let g:cpp_header_ext = ".hpp"
endif
if !exists("g:cpp_source_ext")
	let g:cpp_source_ext= ".cpp"
endif

function! NewCppHppFile(filename)
	if !isdirectory(g:cpp_src_directory)
		exec "!mkdir -p " . g:cpp_src_directory
	endif
	exec "!touch " . g:cpp_src_directory . "/" . a:filename . g:cpp_header_ext
	exec "!touch " . g:cpp_src_directory . "/" . a:filename . g:cpp_source_ext
endfunction

function! NewCppFile(filename)
	if !isdirectory(g:cpp_src_directory)
		exec "!mkdir -p " . g:cpp_src_directory
	endif
	exec "!touch " . g:cpp_src_directory . "/" . a:filename . g:cpp_source_ext
endfunction

function! NewHppFile(filename)
	if !isdirectory(g:cpp_src_directory)
		exec "!mkdir -p " . g:cpp_src_directory
	endif
	exec "!touch " . g:cpp_src_directory . "/" . a:filename . g:cpp_header_ext
endfunction

function! InitCppVimrc()
	let l:currdir = GetCurrentDirName()
	let l:vimrc = ['nmap <F5> :CMakem<CR>',
		\'nmap <F6> :execute "!Build/' . l:currdir . '"<CR>',
		\'nmap <F7> <F5> :execute "!Build/' . l:currdir . '"<CR>',
		\'nmap <F8> :execute "!gdb -tui Build/' . l:currdir . '"<CR>']
	call writefile(l:vimrc, ".vimrc", "a")
endfunction
