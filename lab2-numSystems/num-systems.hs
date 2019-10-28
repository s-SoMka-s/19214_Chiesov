import Data.Char
import Data.List

--ASCII

--48..57: 1, 2 ... 8, 9
--65..90: A, B, ... Y, Z
--97..122: a, b, ... y, z

-- a - 87 = 10


charToInt :: Char -> Int
charToInt x
            | ord x >= 48 && ord x <= 57 = ord x - 48
            | ord x >= 65 && ord x <= 90 = ord x - 29
            | ord x >= 97 && ord x <= 122 = ord x - 87
            | otherwise = error "bad input"

intToChar :: Int -> Char  
intToChar x 
            | x >= 0 && x <= 9 = chr (x + 48)
            | x >= 10 && x <= 35 = chr (x + 87)
            | x >= 36 && x <= 61 = chr (x + 29)
            | otherwise = error "bad input"

toDecimal :: Int -> String -> String
toDecimal base snumber
                    | base > 61 || base < 1 = error "bad input"
                    | otherwise = show $ func ((length snumber)-1) (map charToInt snumber) base
                        where
                            func n [] base = 0
                            func n (x:xs) base = x * base^n + func (n-1) xs base


fromDecimal :: Int -> String -> String
fromDecimal toBase snumber
                        | toBase > 61 || toBase < 1 = error "bad input"
                        | otherwise = reverse (func (read snumber) toBase)
                            where
                                func 0 toBase = []
                                func number 1 = intToChar (1) : (func (number-1) toBase)
                                func number toBase =  intToChar (number `mod` toBase) : (func (number `div` toBase) toBase)
                                
convertFromTo :: Int -> Int -> String -> String
convertFromTo fromBase toBase snumber = fromDecimal toBase (toDecimal fromBase snumber)