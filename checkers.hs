 {-# LANGUAGE UnicodeSyntax #-}

import Control.Arrow ((***))
import Control.Monad (foldM, join, liftM2)
import Data.Array (range)
import Data.Map (Map, elems, fromListWith)
import Data.Maybe (isJust)

-- Red (R), Black (B), Empty (E)
data Cell = R | B | E deriving Show

type Board = [[Cell]]

enumerate ∷ [a] → [Int]
enumerate = curry range 0 . pred . length

cartesian ∷ Board → [(Int, Int)]
cartesian = (liftM2 . liftM2) (,) enumerate (enumerate . head)

diagonal ∷ [(Int, Int)] → [[Int]]
diagonal = elems . fromListWith (++) . map withRowNum . withIndices
  where
    withIndices = zip <*> enumerate
    withRowNum  = uncurry (+) *** pure

project ∷ [Cell] → [Int] → [Cell]
project = map . (!!)

split ∷ Board → Board
split = liftM2 (map . project) join (diagonal . cartesian)

bothDirections ∷ Board → Board
bothDirections = liftM2 (++) split (split . map reverse)

neighborCheck ∷ Cell → Cell → Maybe Cell
neighborCheck B R = Nothing
neighborCheck _ ω = Just ω

safe ∷ Board → Bool
safe = isJust . traverse (foldM neighborCheck E) . bothDirections

-- Example boards
unsafe1 ∷ Board
unsafe1 =
  [[E, R, E, E],
   [E, E, B, E],
   [E, R, E, E],
   [E, E, B, E]]

unsafe2 ∷ Board
unsafe2 =
  [[E, R, E, E],
   [B, E, E, E],
   [E, R, E, E],
   [B, E, E, E]]

safe1 ∷ Board
safe1 =
  [[E, B, E, E],
   [E, E, R, E],
   [E, E, E, R],
   [E, E, E, B]]

safe2 ∷ Board
safe2 =
  [[E, B, E, E],
   [R, E, R, E],
   [E, E, B, E],
   [B, R, B, B]]
