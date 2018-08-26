# Code Compile

## Instalar
Copie o arquivo compile.vim para a pasta `~/.vim/plugin/`

## Manual
O plugin utiliza as teclas <F9> e <F10>, sendo respectivamente para compilar códigos em C, C++, Nasm, SH, Java, PHP, Python e pelo Makefile.

### Usando Makefile
Para gerar o make file, é necessário o uso de um arquivo de configuração `make.vim`, que possui as configuração para gerar o Makefila via cmake.

#### make.vim `cmake`
`
		let g:make = "cmake"					" gera arquivos para o cmake
		let g:make_version = "3.10"				" versão minima para o cmake
		let g:project = "MyProject"				" nome do projeto
		let g:libs = "m z GL"					" bibliotacas dinámicas sem o -l
		let g:path = ["/usr/include/lib/inc/","headers"]	" path dos arquivos de cabeçalho
		let g:src = ["a.c b.c c.c","z.c y.c x.c"]		" vetor de códigos fonte, sendo cada posição para todos os arquivos de cada projeto
		let g:out = ["out1","out2"]				" vetor das saidas, corespondem das posições dos códigos fonte
`

## Autor
`Daniel B. Brumazzi`

`vim Utility`
