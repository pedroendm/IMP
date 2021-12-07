module State where

import qualified Data.Map as Map

type State = Map.Map String Int

emptyState :: State
emptyState = Map.empty

updateState :: (String, Int) -> State -> State
updateState (id, v) s = Map.insert id v s

lookupState :: String -> State -> Int
lookupState id s = case Map.lookup id s of
                      Just v ->  v
                      Nothing ->  0

printState :: State -> [(String, Int)]
printState s = Map.toList s
