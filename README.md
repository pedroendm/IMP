# Interpreter for the IMP (or WHILE) language
Fully written in Haskell and with the tools Alex and Happy, for the lexer and parser, respectively.

## Compilation process
```bash
alex Lexer.x
happy Parser.y
ghc -o interp Main.hs
```

## Usage
You can test it with your own files or the ones in the test directory.

To do so, just do:
```bash
./interp < file.imp
```
