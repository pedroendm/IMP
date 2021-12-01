{
module Parser where
import Lexer
}

%name parser
%tokentype { Token }
%error { parseError }

%token

num         { NUM $$     }
id          { ID $$      }
'+'         { PLUS       }
'-'         { MINUS      }
'*'         { MULT       }
';'         { SEMICOLON  }
':='        { ASSIGN     }
skip        { SKIP       }
'<='        { LESS_EQUAL }
'='         { EQUAL      }
'!'         { NOT        }
'&&'        { AND        }
true        { TRUE       }
false       { FALSE      }
if          { IF         }
then        { THEN       }
else        { ELSE       }
while       { WHILE      }
do          { DO         }

%%

-- Commands
Com : skip                                                   { Skip         }
    | id ':=' AExp                                           { Assign $1 $3 }
    | Com ';' Com                                            { Comp $1 $3   }
    | if BExp then Com else Com                              { If $2 $4 $6  }
    | while BExp do Com                                      { While $2 $4  }

-- Arithmetic Expressions
AExp : num                                                   { Num $1       }
     | id                                                    { Var $1       }
     | AExp '+' AExp                                         { Plus $1 $3   }
     | AExp '-' AExp                                         { Minus $1 $3  }
     | AExp '*' AExp                                         { Times $1 $3  }

-- Boolean Expressions
BExp : true                                                  { T True       }
     | false                                                 { T False      }
     | AExp '=' AExp                                         { Eq $1 $3     }
     | AExp '<=' AExp                                        { Leq $1 $3    }
     | '!' BExp                                              { Not $2       }
     | BExp '&&' BExp                                        { And $1 $3    }

{
-- Arithmetic Expressions
data AExp = Num Int
         | Var String
         | Plus AExp AExp
         | Minus AExp AExp
         | Times AExp AExp
	 deriving (Eq, Show)

-- Boolean Expressions
data BExp = T Bool
        | Eq AExp AExp
        | Leq AExp AExp
        | Not BExp
        | And BExp BExp
   deriving (Eq, Show)

-- Commands
data Com = Skip
        | Assign String AExp
        | Comp Com Com
        | If BExp Com Com
        | While BExp Com
   deriving (Eq, Show)

parseError :: [Token] -> a
parseError toks = error "parse error"
}