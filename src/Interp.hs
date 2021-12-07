module Interp where

import Parser
import State
import System.Random(randomRIO)

interp :: Com -> IO State
interp com = interpCom com emptyState

interpCom :: Com -> State -> IO State
interpCom Skip s = return s
interpCom (Assign id aexp) s = do
  let n = interpAExp aexp s
  return $ updateState (id, n) s
interpCom (Seq com1 com2) s = do
  s' <- interpCom com1 s
  interpCom com2 s'
interpCom (If bexp com1 com2) s = do
  case interpBExp bexp s of
    True -> interpCom com1 s
    False -> interpCom com2 s
interpCom (While bexp com) s = interpCom (If bexp (Seq com (While bexp com)) Skip) s
interpCom (Or com1 com2) s = do
  r <- randomRIO (0, 1) :: IO Int
  if r == 0 then
    interpCom com1 s
  else
    interpCom com2 s

interpAExp :: AExp -> State -> Int
interpAExp (Num n)       s = n
interpAExp (Var id)      s = lookupState id s
interpAExp (Plus a1 a2)  s = let a1' = interpAExp a1 s
                                 a2' = interpAExp a2 s
                             in  a1' + a2'
interpAExp (Minus a1 a2) s = let a1' = interpAExp a1 s
                                 a2' = interpAExp a2 s
                             in  a1' - a2'
interpAExp (Times a1 a2) s = let a1' = interpAExp a1 s
                                 a2' = interpAExp a2 s
                             in a1' * a2'

interpBExp :: BExp -> State -> Bool
interpBExp (T t) s = t
interpBExp (Eq a1 a2) s  = let a1' = interpAExp a1 s
                               a2' = interpAExp a2 s
                           in  a1' == a2'
interpBExp (Leq a1 a2) s = let a1' = interpAExp a1 s
                               a2' = interpAExp a2 s
                           in  a1' <= a2'
interpBExp (Not b) s     = let b' = interpBExp b s
                           in not b'
interpBExp (And b1 b2) s = let b1' = interpBExp b1 s
                               b2' = interpBExp b2 s
                           in  b1' && b2'
