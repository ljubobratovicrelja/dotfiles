
function! GetCurrentDirName()
	let dirNameTokens = split(getcwd(), "/")
	if(len(dirNameTokens) == 0)
		return ""
	endif
	let dirName = dirNameTokens[-1]
	return dirName
endfunction
