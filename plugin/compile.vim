"========================================================
" File:		compile.vim
" Author:	Brumazzi <brumazzi_daniel@yahoo.com.br>
" Last Change:	2016-02-06 22:52:48
" Version:	1.0
"
" Install:	1. Put compile.vim in plugin folder
"
" Usage:
" 		hotkey:
" 			"<F9>" Key to compile and run
" 			"<F10>" Build auto make
"
" Support:	C, C++, Nasm, SH, Java, PHP, Python
"

if v:version < 700
	finish
endif

" make file args
"
" if use cmake build
" let g:make = "cmake"
" let g:make_version = "3.10"
" let g:project = "MyProject"
" let g:libs = "m z GL"
" let g:path = ["/usr/include/lib/inc/","headers"]
" let g:src = ["a.c b.c c.c","z.c y.c x.c"]
" let g:out = ["out1","out2"]
"
" if use makefile
" let g:make = "make"
" let g:libs = "-lm -lX11"
" let g:path = "/usr/include/lib/inc/ headers/"
" let g:cflags = "-O3 -Wall"
" let g:src = ["a.c", "b.c", "c.c", "z.c", "y.c", "x.c"]
" let g:out = ["out"]

function MakeFileBuild()
	source ./make.vim
	let lines = []
	if g:make == "cmake"
		call add(lines, "CMAKE_MINIMUM_REQUIRED(VERSION ".g:make_version.")")
		call add(lines, "PROJECT(".g:project.")")
		call add(lines, "")
		let _c = 0
		while _c < len(g:src)
			call add(lines, "SET(".toupper(g:out[_c])." ".g:src[_c].")")
			let _c += 1
		endwhile
		call add(lines, "")
		call add(lines, "LINK_LIBRARIES(".g:libs.")")
		call add(lines, "")
		for _path in g:path
			call add(lines, "INCLUDE_DIRECTORIES(\""._path."\")")
		endfor
		call add(lines, "")
		let _c = 0
		while _c < len(g:src)
			call add(lines, "ADD_EXECUTABLE(".g:out[_c]." ${".toupper(g:out[_c])."})")
		endwhile
"	elseif g:make == "make"
	endif
	call writefile(lines, "CMakeLists.txt")
endfunction

" Define Indent Lang: {{{1
function Runner()
	w
	let ext = &filetype
	if ext == "c"
		call CCompile()
	elseif ext == "cpp"
		call CPPCompile()
	elseif ext == "asm"
		call NasmCompile()
	elseif ext == "java"
		call JavaCompile()
	elseif ext == "python"
		call PythonRun()
	elseif ext == "php"
		call PHPRun()
	elseif ext == "sh"
		call ShRun()
	else
		echo &filetype." no suported!"
	endif
endfunction

function CCompile()
	echo "c file compiling..."
	let $_cc = "cc ".expand("%:p")." -o ".expand("%:p:r")
	! $_cc; time %:p:r
endfunction

function CPPCompile()
	echo "c++ file compiling..."
	let $_cpp = "c++ ".expand("%:p")." -o ".expand("%:p:r")
	! $_cpp; time %:p:r
endfunction

function NasmCompile()
	echo "Nasm compiling..."
	let $_asm = "nasm -f elf ".expand("%:p")
	let $_ld = "ld ".expand("%:p:h")."/*.o -o ".expand("%:p:r")
	! $_asm; $_ld; time %:p:r
endfunction

function JavaCompile()
	echo "Java compiling"
	let $_java = "javac ".expand("%:p")
	! $_java; time java %:r
endfunction

function PythonRun()
	echo "Python Running..."
	let $_py = "python ".expand("%:p")
	! time $_py
endfunction

function PHPRun()
	echo "PHP Running..."
	let $_php = "php ".expand("%:p")
	! time $_php
endfunction

function ShRun()
	echo "Shell Script Running..."
	let $_sh = "sh ".expand("%:p")
	! time $_sh
endfunction

:map <F9> :call Runner()<cr>
:map <F10> :call MakeFileBuild()<cr>
