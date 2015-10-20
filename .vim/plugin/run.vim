" depending on the current file type, run the program using different documentation.

function! FnRun()
	let curren_ft = &ft

	if curren_ft == 'python' " call this script using default python interpreter
		execute '!python '.bufname('%')
	elseif curren_ft == 'cpp' || curren_ft == 'c'
		let dir_name = GetCurrentDirName()
		if dir_name == ''
			return
		else
			exec '!./Build/'.dir_name
		endif
	elseif curren_ft == 'matlab' || curren_ft == 'octave'
		execute '!octave '.bufname('%')
	elseif curren_ft == 'd'
		execute '!dub run'
	else
		echo 'Run() Error!~ Unsupported filetype'
	endif
endfunction

function! FnDebug()
	let curren_ft = &ft

	if curren_ft == 'python' " call this script using default python interpreter
		execute '!python -m pdb '.bufname('%')
	elseif curren_ft == 'cpp' || curren_ft == 'c'
		let dir_name = GetCurrentDirName()
		if dir_name == ''
			return
		else
			exec '!cgdb ./Build/'.dir_name
		endif
	elseif curren_ft == 'd'
		let curren_ft = GetCurrentDirName()
		if dir_name == ''
			return
		else
			exec '!cgdb ./' . dir_name
	else
		echo 'Debug() Error!~ Unsupported filetype'
	endif
endfunction

function! FnCompile()
	if &ft == 'cpp' || &ft == 'c'
		:CMakem
	elseif &ft == 'd'
		:!dub build
	else
		echo 'Compile() Error!~ Unsupported filetype'
	endif
endfunction

command! Run :call FnRun()
command! Debug :call FnDebug()
command! Compile :call FnCompile()

nmap <F5> :Run<CR>
nmap <F6> :Debug<CR>
nmap <F8> :Compile<CR>
