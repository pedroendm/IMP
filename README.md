# Interpreter for the IMP (or WHILE) language

Implementation of the operational semantics for a small imperative language, called IMP (or WHILE), in the literature, with a non-deterministic operator: the operator 'or'.

The implementation is fully written in Haskell and with the tools Alex and Happy, for the lexer and parser, respectively.

Some design choices:
- The operators '+', '-' and '*' are left-associative.
- The operator '*' has an higher precedence than '+' and '-'  

- The operators ';' and 'or' are right associative.
- The operator 'or' has an higher precedence than ';'.

- '=', '<=', 'and', 'not', and 'else' are all non-associative.

# Source files
- Lexer.x: the description of the lexer
- Parser.y: the description of the parser
- Main.hs
- State.hs: definition of a state
- Interp.hs: implementation of the operational semantics for the language

## Compilation process
Within the root folder (IMP/):
```bash
alex Lexer.x
happy Parser.y
ghc -o interp Main.hs
```

## Usage
To use the interpreter, just do:
```bash
./interp < tests/file.imp
```
, where *file.imp* is a program written in the IMP language. 

## Tests
In the test folder, there are 4 testes:
- factorial.imp -> Computes the factorial of the number n. The answer is in the variable acc.
- gcd.imp -> Computes the gcd of the numbers a and b. The answer is in the variable a.
- is_prime.imp -> Checks if the number n is prime or not. If the number is prime, then variable is_prime = 1, otherwise, is_prime = 0.
- factorial_or_is_prime.imp -> Either computes the factorial of the number n or checks if it's a prime number. The answer is given exactly as in the programs factorial.imp and is_prime.imp, respectively.
