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
                    | (base > 0) && (base < 62) = show $ foldl (\acc x -> base*acc + charToInt x) 0 snumber
                    | otherwise = error "bad input"



fromDecimal :: Int -> String -> String
fromDecimal 1 snumber = replicate (read snumber) '1'
fromDecimal toBase snumber = func (read snumber) toBase snumber
                            where 
                                func 0 toBase snumber = []
                                func number toBase snumber 
                                                        | (toBase > 0) && (toBase < 62) = func (number `div` toBase) toBase snumber ++ (intToChar (number `mod` toBase) : [])
                                                        | otherwise = error "bad input"
            
                                
convertFromTo :: Int -> Int -> String -> String
convertFromTo fromBase toBase snumber = fromDecimal toBase (toDecimal fromBase snumber)
