" CMake project management plugin by Relja Ljubobratovic.
" Writen to adopt my CMake development in VIM.

if !exists("g:CMAKE_SAVE_BEFORE_BUILD")
	let g:CMAKE_SAVE_BEFORE_BUILD=1
endif
if !exists("g:CMAKE_BUILD_TYPE")
	let g:CMAKE_BUILD_TYPE="DEBUG" 
endif

if !exists("g:CMAKE_CXX_COMPILER")
	let g:CMAKE_CXX_COMPILER="/usr/bin/g++"
endif

if !exists("g:CMAKE_CXX_FLAGS")
	let g:CMAKE_CXX_FLAGS="-std=c++14 -Wall" 
endif

if !exists("g:CMAKE_ARGS")
	let g:CMAKE_ARGS=""
endif

if !exists("g:MAKE_ARGS")
	let g:MAKE_ARGS="-j6"
endif

if !exists("g:MAKE_BUILD_DIR")
	let g:MAKE_BUILD_DIR="Build"
elseif g:MAKE_BUILD_DIR == ""
	echo "g:MAKE_BUILD_DIR must not be assigned as an empty string: Reassigning to a default value~ \"Build\""
	let g:MAKE_BUILD_DIR="Build"
endif

" Initialze the CMakeLists.txt for the current project.
" ========================================================================================
"
function! CMakeInit()
	let dirNameTokens = split(getcwd(), "/")
	if(len(dirNameTokens) == 0)
		echo "CMake project must be initialized in a sub folder - root directory is not permitted."
		return
	endif
	let dirName = dirNameTokens[-1]
	if filereadable("CMakeLists.txt")
		echo "CMake project is already initialized - CMakeLists.txt exists!"
		return
	endif

	if !isdirectory("src")
		call mkdir("src", "p")
	endif

	let cmakeFile =["project(". dirName . ")"]
	let cmakeFile +=["cmake_minimum_required(VERSION 2.8)"]
	let cmakeFile +=["set(OUT_EXEC \"" . dirName . "\")"]
	let cmakeFile += ["file(GLOB SRC_FILES \"./src/*.cpp\")"]
	let cmakeFile += ["set(CMAKE_CXX_FLAGS \"-std=c++11\")"]
	let cmakeFile += ["set(CMAKE_CXX_FLAGS_DEBUG \"-O0 -g -Wall\")"]
	let cmakeFile += ["set(CMAKE_CXX_FLAGS_RELEASE \"-O3 -DNDEBUG\")"]

	call writefile(cmakeFile, "CMakeLists.txt", "a")
	echo "CMakeLists.txt has been written."
endfunction

" Build the CMakeCache.
" ========================================================================================
"
" Command configures the cmake cache for the current project. Uses global variables defined 
" in this file to run the command !cmake. Configure following variables in the
" .vimrc file:
"
" g:MAKE_BUILD_DIR - name of the directory where the build files will be
" generated.
" g:CMAKE_CXX_COMPILER - path to the c++ compiler which will be used.
" g:CMAKE_CXX_FLAGS - c++ compilation flags.
" g:CMAKE_BUILD_TYPE - compilation type - Debug, Release, etc.
"
function! CMakeBuildCache()
	if !filereadable("CMakeLists.txt")
		echo "CMakeLists.txt not found in current directory."
		return 1
	endif

	if !isdirectory("./".g:MAKE_BUILD_DIR)
		call mkdir("./".g:MAKE_BUILD_DIR, "p")
	endif

	execute "cd ".g:MAKE_BUILD_DIR
	let cmargs = "!cmake " . g:CMAKE_ARGS ." -D CMAKE_CXX_COMPILER=" . g:CMAKE_CXX_COMPILER . " -D CMAKE_BUILD_TYPE=" .g:CMAKE_BUILD_TYPE . "-D CMAKE_CXX_FLAGS= " . g:CMAKE_CXX_FLAGS . " ../"
	execute cmargs
	cd ../
	return 0
endfunction

" Build the CMake project using default CMake configuration
function! CMakeBuild()
	let res =CMakeBuildCache()
	if res == 0
	execute "cd ".g:MAKE_BUILD_DIR
		if g:CMAKE_SAVE_BEFORE_BUILD == 1:
			exec "bufdo w!"
		endif
		execute "!make ".g:MAKE_ARGS
		cd ../
	else
		echo "CMake build not successful."
	endif
endfunction

" Clean the CMake build - delete the ./Build/*
function! CMakeClean()
	if isdirectory("./Build") && filereadable("CMakeLists.txt")
		execute "!rm -rf ./".g:MAKE_BUILD_DIR."/*"
	endif
endfunction

function! CMakeRebuild() 
	call CMakeClean()
	call CMakeBuild()
endfunction

" Commands
command! CMake :call CMakeBuildCache()
command! CMakem :call CMakeBuild()
command! CMakec :call CMakeClean()
command! CMaker :call CMakeRebuild()

