all: pexam3a.exe

pexam3a.exe: pexam3a.obj decode.obj huida.obj
	tcc -v -ml -Lc:\compila\tc\lib pexam3a.obj decode.obj huida.obj

pexam3a.obj: pexam3A.c
	tcc -c -v -ml -Ic:\compila\tc\include pexam3A.c

decode.obj: decode.asm
	tasm /zi /ml decode,,decode

huida.obj: huida.asm
	tasm /zi /ml huida,,huida

clean:
	del *.obj
	del *.lst
	del *.exe
