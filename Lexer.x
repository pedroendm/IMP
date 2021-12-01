{
module Lexer where
}

%wrapper "basic"

$white = [\ \t\n\r\b\v\f\a\\\'\"]
$alpha = [_A-Za-z]
$digit = [0-9]

tokens :-

$white+                                                           ;
"+"                                          { \_ -> PLUS         }
"-"                                          { \_ -> MINUS        }
"*"	                                         { \_ -> MULT         }
"<="                                         { \_ -> LESS_EQUAL   }
"="                                          { \_ -> EQUAL        }
"skip"                                       { \_ -> SKIP         }
":="                                         { \_ -> ASSIGN       }
";"                                          { \_ -> SEMICOLON    }
"!"                                          { \_ -> NOT          }
"&&"                                         { \_ -> AND          }
"true"                                       { \_ -> TRUE         }
"false"                                      { \_ -> FALSE        }
if		                                       { \_ -> IF           }
then                                         { \_ -> THEN         }
else                                         { \_ -> ELSE         }
while                                        { \_ -> WHILE        }
do                                           { \_ -> DO           }
$alpha($alpha|$digit)*	                     { \s -> ID s         }
$digit+                                      { \s -> NUM (read s) }

{
data Token = ID String
            | NUM Int
            | LESS_EQUAL
            | EQUAL
            | ASSIGN | SKIP
            | IF | THEN | ELSE
            | WHILE | DO
            | PLUS | MINUS | MULT
            | SEMICOLON
            | NOT    | AND
            | TRUE   | FALSE
           deriving (Eq, Show)
}
