-- module Chapter09.InputAndOutput
-- (
-- 
-- ) where

-- main = putStrLn "Hello, World!"


-- main = do
--     putStrLn "Hello, what's your name?"
--     name <- getLine
--     putStrLn ("Hey " ++ name ++ ", you rock!")


-- import Data.Char
-- 
-- main = do
--     putStrLn "What's your first name?"
--     firstName <- getLine
--     putStrLn "What's your last name?"
--     lastName <- getLine
--     let bigFirstName = map toUpper firstName
--         bigLastName = map toUpper lastName
--     putStrLn $ "hey " ++ bigFirstName ++ " " ++ bigLastName ++ ", how are you?"




-- main = do
--     line <- getLine
--     if null line
--         then return ()
--         else do
--             putStrLn $ reverseWords line
--             main
-- 
-- 
-- reverseWords :: String -> String
-- reverseWords = unwords . map reverse . words



-- main = do
--     return ()
--     return "HAHAHA"
--     line <- getLine
--     return "BLAH BLAH BLAH BLAH"
--     return 4
--     putStrLn line



-- main = do
--     a <- return "hell"
--     b <- return "yeah!"
--     putStrLn $ a ++ " " ++ b


-- main = do
--     let a = "hell"
--         b = "yeah"
--     putStrLn $ a ++ " " ++ b



-- main = do   putStr "Hey, "
--             putStr "I'm "
--             putStrLn "Andy!"



-- main = do putChar 't'
--           putChar 'e'
--           putChar 'h'



-- main = do print True
--           print 2
--           print "haha"
--           print 3.2
--           print [3,4,3]




-- main = do
--     c <- getChar
--     if c /= ' '
--         then do
--             putChar c
--             main
--         else 
--             return ()



-- import Control.Monad
-- 
-- main = do
--     c <- getChar
--     when (c /= ' ') $ do
--         putChar c
--         main




-- main = do
--     a <- getLine
--     b <- getLine
--     c <- getLine
--     print [a,b,c]




-- main = do
--     rs <- sequence [getLine, getLine, getLine]
--     print rs



-- import Control.Monad
-- import Data.Char
-- 
-- main = forever $ do
--     putStr "Give me some input: "
--     l <- getLine
--     putStrLn $ map toUpper l



-- import Control.Monad
-- 
-- main = do
--     colors <- forM [1,2,3,4] (\a -> do
--         putStrLn $ "Which color do you associate with the number " ++ show a ++ "?"
--         color <- getLine
--         return color)
--     putStrLn "The colors that you associate with 1,2,3 and 4 are: "
--     mapM putStrLn colors




-- import Control.Monad
-- import Data.Char
-- 
-- main = forever $ do
--     putStr "Give me some input: "
--     l <- getLine
--     putStrLn $ map toUpper l



-- import Data.Char
-- 
-- main = do
--     contents <- getContents
--     putStr (map toUpper contents)



-- main = do
--     contents <- getContents
--     putStr (shortLinesOnly contents)
-- 
-- shortLinesOnly :: String -> String
-- shortLinesOnly input =
--     let allLines   = lines input
--         shortLines = filter (\line -> length line < 10) allLines
--         result     = unlines shortLines
--     in  result



-- main = interact shortLinesOnly
-- 
-- shortLinesOnly :: String -> String
-- shortLinesOnly input =
--     let allLines   = lines input
--         shortLines = filter (\line -> length line < 10) allLines
--         result     = unlines shortLines
--     in  result





-- main = interact $ unlines . filter ((<10) . length) . lines





-- main = interact respondPalindromes
-- 
-- respondPalindromes contents = unlines (map (\xs -> if isPalindrome xs then "palindrome" else "not a palindrome") (lines contents))
--     where isPalindrome xs = xs == reverse xs




-- main = interact respondPalindromes
-- 
-- respondPalindromes = unlines . map (\xs -> if isPalindrome xs then "palindrome" else "not a palindrome") . lines
--     where isPalindrome xs = xs == reverse xs




{-- // girlfriend.txt

Hey! Hey! You! You!
I don't like your girlfriend!
No way! No way!
I think you need a new one!

--}

import System.IO

main = do
    handle <- openFile "girlfriend.txt" ReadMode
    contents <- hGetContents handle
    putStr contents
    hClose handle











