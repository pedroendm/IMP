import Lexer
import Parser
import Interp
import State

main = do
  source <- getContents
  let tokens = alexScanTokens source
  let ast = parser tokens
  print ast
  state <- interp ast
  print $ State.toList state
  --state <- fmap State.toList (interp $ parser $ alexScanTokens source)
  --print state
  --print $ parser $ alexScanTokens source
