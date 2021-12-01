import Lexer
import Parser
import Interp

main = do
  txt <- getContents
  print $ interp $ parser $ alexScanTokens txt
