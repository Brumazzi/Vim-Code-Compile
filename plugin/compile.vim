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
" 			"<F10>" Use MakeFile
"
" Support:	C, C++, Nasm, SH, Java, PHP, Python
"

if v:version < 700
	finish
endif

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
:map <F10> :make<cr>
