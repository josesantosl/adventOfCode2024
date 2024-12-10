module Day2 where
{-
# day 2 : Red-Noses Reports
## part 1
Fortunately, the first location The Historians want to search isn't a long walk from the Chief Historian's office.

While the Red-Nosed Reindeer nuclear fusion/fission plant appears to contain no sign of the Chief Historian, the engineers there run up to you as soon as they see you. Apparently, they still talk about the time Rudolph was saved through molecular synthesis from a single electron.

They're quick to add that - since you're already here - they'd really appreciate your help analyzing some unusual data from the Red-Nosed reactor. You turn to check if The Historians are waiting for you, but they seem to have already divided into groups that are currently searching every corner of the facility. You offer to help with the unusual data.

The unusual data (your puzzle input) consists of many reports, one report per line. Each report is a list of numbers called levels that are separated by spaces. For example:

```
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
```
-}

-- Read input from input.txt
readInput :: IO [[Int]]
readInput = do
  file <- readFile "input.txt"
  let numbers = map (map read . words) (lines file)
  return numbers

{-
This example data contains six reports each containing five levels.

The engineers are trying to figure out which reports are safe. The Red-Nosed reactor safety systems can only tolerate levels that are either gradually increasing or gradually decreasing. So, a report only counts as safe if both of the following are true:

- The levels are either all increasing or all decreasing.
- Any two adjacent levels differ by at least one and at most three.
-}
-- confirm the safety of the report
safetyWrapper :: [Int] -> Bool
safetyWrapper (x1 : x2 : xs) | x1 == x2 = False
                             | x1 > x2  = safety (x1:x2:xs) 0
                             | x1 < x2  = safety (x1:x2:xs) 1

safety :: [Int] -> Int -> Bool
safety [_]              _ = True
safety (x1 : x2 : xs) s | x1 == x2 = False
                          | x1 > x2 && s == 0 && (abs(x1 - x2) <= 3) = safety (x2:xs) s
                          | x1 > x2 && s == 1 || (abs(x1 - x2) > 3) = False
                          | x1 < x2 && s == 0 || (abs(x1 - x2) > 3) = False
                          | x1 < x2 && s == 1 && (abs(x1 - x2) <= 3) = safety (x2:xs) s


{-
In the example above, the reports can be found safe or unsafe by checking those rules:

- `7 6 4 2 1`: **Safe** because the levels are all decreasing by 1 or 2.
- `1 2 7 8 9`: **Unsafe** because `2 7` is an increase of 5.
- `9 7 6 2 1`: **Unsafe** because `6 2` is a decrease of 4.
- `1 3 2 4 5`: **Unsafe** because `1 3` is increasing but 3 2 is decreasing.
- `8 6 4 4 1`: **Unsafe** because `4 4` is neither an increase or a decrease.
- `1 3 6 7 9`: **Safe** because the levels are all increasing by 1, 2, or 3.

So, in this example, `2` reports are **safe**.

**Analyze the unusual data from the engineers. How many reports are safe?**
-}

main :: IO ()
main = do
  input <- readInput
  let counter = length (filter safetyWrapper input)
  putStrLn (show counter)


{-
> Answer: 220
-}
