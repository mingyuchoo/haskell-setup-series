{-# OPTIONS_GHC -fwarn-missing-signatures #-}
{-# OPTIONS_GHC -fwarn-unused-binds #-}
{-# OPTIONS_GHC -fwarn-unused-imports #-}

{-# LANGUAGE ExplicitForAll           #-}
{-# LANGUAGE NoImplicitPrelude        #-}
{-# LANGUAGE OverloadedStrings        #-}
{-# LANGUAGE StandaloneKindSignatures #-}

--------------------------------------------------------------------------------
module Chapter10.FunctionallySolvingProblems
    where

--------------------------------------------------------------------------------
import           Control.Exception (catch)
import           Data.Kind         (Type)
import           Data.List
    ( concat
    , drop
    , foldl
    , head
    , lines
    , map
    , reverse
    , sum
    , take
    , words
    , (++)
    )
import           Prelude
    ( Double (..)
    , IO (..)
    , Int (..)
    , Maybe (..)
    , Show (..)
    , String (..)
    , fst
    , getContents
    , log
    , otherwise
    , print
    , putStrLn
    , read
    , return
    , snd
    , undefined
    , ($)
    , (*)
    , (**)
    , (+)
    , (-)
    , (.)
    , (/)
    , (<=)
    )
import           System.IO.Error   (IOError (..), isEOFError)
--------------------------------------------------------------------------------

main' :: IO ()
main' = do
  contents <- getContents
  let threes     = groupsOf 3 (map read $ lines contents)
      roadSystem = map (\[a,b,c] -> Section a b c) threes
      path       = optimalPath roadSystem
      pathString = concat $ map (show . fst) path
      pathPrice  = sum $ map snd path
  putStrLn $ "The best path to take is: " ++ pathString
  putStrLn $ "The price is: " ++ show pathPrice
--------------------------------------------------------------------------------
-- |
doSolveRPN :: IO()
doSolveRPN = action `catch` handler

-- |
action :: IO ()
action = do
    print $ solveRPN "10 4 3 + 2 * -"
    print $ solveRPN "2 3.5 +"
    print $ solveRPN "90 34 12 33 55 66 + * - +"
    print $ solveRPN "90 34 12 33 55 66 + * - + -"
    print $ solveRPN "90 3.8 -"
    return ()

-- |
solveRPN :: String -> Double
solveRPN = head . foldl foldingFunction [] . words
  where
    foldingFunction (x0:x1:xs) "+" = (x1 +  x0):xs
    foldingFunction (x0:x1:xs) "-" = (x1 -  x0):xs
    foldingFunction (x0:x1:xs) "*" = (x1 *  x0):xs
    foldingFunction (x0:x1:xs) "/" = (x1 /  x0):xs
    foldingFunction (x0:x1:xs) "^" = (x1 ** x0):xs
    foldingFunction (x:xs) "ln"    = log x:xs
    foldingFunction xs "sum"       = [sum xs]
    foldingFunction xs ns          = read ns:xs

-- |
handler :: IOError -> IO ()
handler e | isEOFError e = putStrLn "EOF Error!"
          | otherwise    = putStrLn "Woops, had some trouble!"

--------------------------------------------------------------------------------
type Node :: Type
data Node = Node Road (Maybe Road)

type Road :: Type
data Road = Road Int Node

type Section :: Type
data Section = Section { getA :: Int
                       , getB :: Int
                       , getC :: Int
                       }
     deriving (Show)


type RoadSystem :: Type
type RoadSystem = [Section]

heathrowToLondon :: RoadSystem
heathrowToLondon = [Section 50 10 30, Section 5 90 20, Section 40 2 25, Section 10 8 0]

type Label :: Type
data Label = A | B | C deriving (Show)


type Path :: Type
type Path  = [(Label, Int)]

roadStep :: (Path, Path) -> Section -> (Path, Path)
roadStep (pathA, pathB) (Section a b c) =
  let priceA          = sum $ map snd pathA
      priceB          = sum $ map snd pathB
      forwardPriceToA = priceA + a
      crossPriceToA   = priceB + b + c
      forwardPriceToB = priceB + b
      crossPriceToB   = priceA + a + c
      newPathToA      = if forwardPriceToA <= crossPriceToA
                          then (A,a):pathA
                          else (C,c):(B,b):pathB
      newPathToB      = if forwardPriceToB <= crossPriceToB
                          then (B,b):pathB
                          else (C,c):(A,a):pathA
  in (newPathToA, newPathToB)



optimalPath :: RoadSystem -> Path
optimalPath roadSystem =
  let (bestAPath, bestBPath) = foldl roadStep ([],[]) roadSystem
  in if sum (map snd bestAPath) <= sum (map snd bestBPath)
       then reverse bestAPath
       else reverse bestBPath



groupsOf :: Int -> [a] -> [[a]]
groupsOf 0 _  = undefined
groupsOf _ [] = []
groupsOf n xs = take n xs : groupsOf n (drop n xs)
