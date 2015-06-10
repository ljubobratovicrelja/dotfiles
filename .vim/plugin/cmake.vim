
if !exists("g:CMAKE_BUILD_TYPE")
	let g:CMAKE_BUILD_TYPE="DEBUG" 
endif

if !exists("g:CMAKE_CXX_COMPILER")
	let g:CMAKE_CXX_COMPILER="/usr/bin/clang++-3.6" 
endif

if !exists("g:CMAKE_CXX_FLAGS")
	let g:CMAKE_CXX_FLAGS="-std=c++11 -Wall" 
endif

if !exists("g:MAKE_ARGS")
	let g:MAKE_ARGS="-j6"
endif

" Initialze the CMakeLists.txt for the current project.
function! CMakeInit()
	let dirName = split(expand("%"), "/")[-2]
	if filereadable("CMakeLists.txt")
		echo "CMake project is already initialized - CMakeLists.txt exists!"
		return
	endif

	if !isdirectory("src")
		call mkdir("src", "p")
	endif

	let cmakeFile =["project(ProjectName)"]
	let cmakeFile +=["set(OUT_EXEC \"Raytrace\")"]
	let cmakeFile += ["file(GLOB SRC_FILES \"./src/*.cpp\")"]
	let cmakeFile += ["set(CMAKE_CXX_FLAGS \"-std=c++11\")"]
	let cmakeFile += ["set(CMAKE_CXX_FLAGS_DEBUG \"-O0 -g -Wall\")"]
	let cmakeFile += ["set(CMAKE_CXX_FLAGS_RELEASE \"-O3 -DNDEBUG\")"]

	call writefile(cmakeFile, "CMakeLists.txt", "a")
endfunction

" Build the CMakeCache.
function! CMakeBuildCache()
	if !filereadable("CMakeLists.txt")
		echo "CMakeLists.txt not found in current directory."
		return 1
	endif

	if !isdirectory("./Build")
		call mkdir("./Build", "p")
	endif

	cd Build
	let cmargs = "!cmake -D CMAKE_CXX_COMPILER=" . g:CMAKE_CXX_COMPILER . " -D CMAKE_BUILD_TYPE=" .g:CMAKE_BUILD_TYPE . "-D CMAKE_CXX_FLAGS= " . g:CMAKE_CXX_FLAGS . " ../"
	execute cmargs
	cd ../
	return 0
endfunction

" Build the CMake project using default CMake configuration
function! CMakeBuild()
	let res =CMakeBuildCache()
	if res == 0
		cd Build
		execute "!make ".g:MAKE_ARGS
		cd ../
	else
		echo "CMake build not successful."
	endif
endfunction

" Clean the CMake build - delete the ./Build/*
function! CMakeClean()
	if isdirectory("./Build") && filereadable("CMakeLists.txt")
		execute "!rm -rf ./Build/*"
	endif
endfunction
