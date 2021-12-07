import Lexer
import Parser
import Interp
import State

main = do
  source <- getContents
  state <- fmap printState (interp $ parser $ alexScanTokens source)
  print state
