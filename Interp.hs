module Interp where

import Parser

type State = [(String, Int)]

updateState :: (String, Int) -> State -> State
updateState (x, y) [] = [(x,y)]
updateState (x, y) ((x',y'):xs) = if x == x' then (x,y) : xs else (x',y') : updateState (x,y) xs

lookupState :: String -> State -> Int
lookupState id s = case lookup id s of
                      Just v -> v
                      Nothing -> error "variable doesn't exist"

interp com = interpCom com []

interpCom :: Com -> State -> State
interpCom Skip s = s
interpCom (Assign id aexp) s    = let n = interpAExp aexp s
                                  in updateState (id, n) s
interpCom (Seq com1 com2) s     = let s' = interpCom com1 s
                                  in interpCom com2 s'
interpCom (If bexp com1 com2) s = case interpBExp bexp s of
                                    True -> interpCom com1 s
                                    False -> interpCom com2 s
interpCom (While bexp com) s    = interpCom (If bexp (Seq com (While bexp com)) Skip) s

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
