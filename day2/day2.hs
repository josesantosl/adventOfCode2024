module Day2 where

readInput :: IO [[Int]]
readInput = do
  file <- readFile "input.txt"
  return $ map (map read . words) (lines file)

safetyWrapper :: [Int] -> Bool
safetyWrapper (x1:x2:xs)
  | x1 == x2 = False
  | x1 > x2 = safety (x1:x2:xs) 0
  | x1 < x2 = safety (x1:x2:xs) 1
safetyWrapper _ = True

safety :: [Int] -> Int -> Bool
safety [_] _ = True
safety (x1:x2:xs) s
  | x1 == x2 = False
  | x1 > x2 && s == 0 && abs (x1 - x2) <= 3 = safety (x2:xs) s
  | x1 > x2 && s == 1 = False
  | x1 < x2 && s == 0 = False
  | x1 < x2 && s == 1 && abs (x1 - x2) <= 3 = safety (x2:xs) s
  | otherwise = False

part1 :: IO ()
part1 = do
  input <- readInput
  let counter = length (filter safetyWrapper input)
  putStrLn (show counter)

{- Problem Dampener: Checks if a sequence is safe by either being originally
safe or becoming safe after removing exactly one element.
-}
dampener :: [Int] -> Bool
dampener xs = safetyWrapper xs || any safetyWrapper (removeOneElement xs)

{-|
Generates all possible subsequences removing one element.
For [1,2,3] returns [[2,3], [1,3], [1,2]]
-}
removeOneElement :: [Int] -> [[Int]]
removeOneElement [] =  []
removeOneElement (x:xs) = xs : map (x:) (removeOneElement xs)

part2 :: IO ()
part2 = do
  input <- readInput
  let counter = length (filter dampener input)
  putStrLn (show counter)
