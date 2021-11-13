-- |
-- Module      : BigNumber
-- Description : Implementação de uma biblioteca de big-numbers em Haskell
--               para representar estruturas para big-numbers
-- Copyright   : (c) PFL G6_07, 2021
-- License     : GPL-3
-- Stability   : experimental
-- Portability : POSIX.
module BigNumber where
import Utils

type BigNumber = [Int]

-- applying (:"") to the string we convert each Char of the string (string is just a list of Chars) into a single-element list.
-- next the function read convert the individual strings (Char) into integers.
-- the map applys that to every char of the string, producing our BigNumber (just a list of Ints)

scanner :: String -> BigNumber
scanner str
    | isNegativeNumber = head bigNumber  * (-1) : tail bigNumber
    | otherwise  = bigNumber
    where
        truncatedStr = truncateString str 
        isNegativeNumber = head str == '-'
        numberStr = if isNegativeNumber then tail truncatedStr else truncatedStr 
        bigNumber = map (read . (:"")) numberStr :: BigNumber


output :: BigNumber -> String
output bn = [head (show str) | str <- bn]

somaBN' :: Integral t => [t] -> [t] -> t -> [t]
somaBN' [] x carry
    | carry /= 0 = somaBN' [carry] x 0 --add the carry as a digit and add to the value x
    | carry == 0 = x

somaBN' x [] carry
    | carry /= 0 = somaBN' [carry] x 0
    | carry == 0 = x

somaBN' (x:xs) (y:ys) carry =  val : somaBN' xs ys res
    where
        val = (x + y + carry) `rem` 10
        res = (x + y + carry) `quot` 10

-- TODO acrescentar condições para fazer soma de numeros negativos usando a função subBN
somaBN :: BigNumber -> BigNumber  -> BigNumber
somaBN bn1 bn2 = reverse( somaBN' (reverse bn1) (reverse bn2) 0)

