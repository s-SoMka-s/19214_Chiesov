import Data.Maybe
import Data.List
import System.IO
import Data.Char
import Data.Either
import System.Environment

data Tape a = Tape [a]
                    a
                   [a] deriving(Show)


-- -> [0, .., 0] 0 [0, .., 0]
emptyTape :: Tape Int
emptyTape = Tape zeros 0 zeros
    where zeros = repeat 0

-- [2, 2, 1] 0 [1, 0, 0] -> [0, 2, 2, 1] 1 [0, 0]
moveRight :: Tape a -> Tape a
moveRight (Tape ls p (r:rs)) = Tape (p:ls) r rs

-- [2, 2, 1] 0 [1, 0, 0] -> [2, 1] 2 [0, 1, 0, 0]
moveLeft :: Tape a -> Tape a
moveLeft (Tape (l:ls) p rs) = Tape ls l (p:rs)

--                          bfSource2Tape
-- [GoLeft, GoRight, Increment] -> [] GoLeft [GoRight, Increment]
-- runBrainFuck запускает BrainfuckSource на пустой ленте
runBrainfuck :: BrainfuckSource -> IO ()
runBrainfuck = run emptyTape . bfSource2Tape where
    bfSource2Tape (b:bs) = Tape [] b bs

run :: Tape Int -> Tape BrainfuckCommand -> IO ()
run dataTape source@(Tape _ GoRight _) =
    advance (moveRight dataTape) source

run dataTape source@(Tape _ GoLeft _) =
    advance (moveLeft dataTape) source

run (Tape l p r) source@(Tape _ Increment  _) =
    advance (Tape l (p+1) r) source

run (Tape l p r) source@(Tape _ Decrement  _) =
    advance (Tape l (p-1) r) source

run dataTape@(Tape _ p _) source@(Tape _ Print  _) = do
    putChar (chr p)
    hFlush stdout
    advance dataTape source

run dataTape@(Tape l _ r) source@(Tape _ Read  _) = do
    p <- getChar
    advance (Tape l (ord p) r) source

run dataTape@(Tape _ p _) source@(Tape _ LoopL  _)
    | p == 0 = seekLoopR 0 dataTape source
    | otherwise = advance dataTape source

run dataTape@(Tape _ p _) source@(Tape _ LoopR  _)
    | p /= 0 = seekLoopL 0 dataTape source
    | otherwise = advance dataTape source


-- двигает фокус на sourceTape. Чтобы можно было перейти к исполнению другой операции
advance :: Tape Int -> Tape BrainfuckCommand -> IO ()
advance dataTape (Tape _ _ []) = return ()
advance dataTape source = run dataTape (moveRight source)


seekLoopR :: Int -> Tape Int -> Tape BrainfuckCommand -> IO ()
seekLoopR 1 dataTape source@(Tape _ LoopR _) = advance dataTape source
seekLoopR b dataTape source@(Tape _ LoopR _) =
    seekLoopR (b-1) dataTape (moveRight source)
seekLoopR b dataTape source@(Tape _ LoopL _) =
    seekLoopR (b+1) dataTape (moveRight source)
seekLoopR b dataTape source =
    seekLoopR b dataTape (moveRight source)

seekLoopL :: Int -> Tape Int -> Tape BrainfuckCommand -> IO ()
seekLoopL 1 dataTape source@(Tape _ LoopL _) = advance dataTape source
seekLoopL b dataTape source@(Tape _ LoopL _) =
    seekLoopL (b-1) dataTape (moveLeft source)
seekLoopL b dataTape source@(Tape _ LoopR _) =
    seekLoopL (b+1) dataTape (moveLeft source)
seekLoopL b dataTape source =
    seekLoopL b dataTape (moveLeft source)

data BrainfuckCommand = GoRight -- >
                      | GoLeft -- <
                      | Increment -- +
                      | Decrement -- -
                      | Print -- .
                      | Read -- ,
                      | LoopL -- [
                      | LoopR -- ]
                      | Comment
                          deriving Show

type BrainfuckSource = [BrainfuckCommand]

checkSyntax :: BrainfuckSource -> Maybe BrainfuckSource
checkSyntax code = if (sum $ map isValid code) == 0 then Just code else Nothing
    where
        isValid x = case x of
            LoopL -> (1)
            LoopR -> (-1)
            otherwise -> (0)


parseBrainfuck :: String -> Either String BrainfuckSource
parseBrainfuck str = case parsed of
    Just (code) -> Right code
    Nothing -> Left "mismatched opening parenthesis"
    where
        parsed = checkSyntax $ mapMaybe charToBf str
        charToBf x = case x of
            '>' -> Just GoRight
            '<' -> Just GoLeft
            '+' -> Just Increment
            '-' -> Just Decrement
            '.' -> Just Print
            ',' -> Just Read
            '[' -> Just LoopL
            ']' -> Just LoopR
            c -> Nothing

main = do
    args <- getArgs
    text <- readFile (head args)
    let smt = parseBrainfuck text
    case smt of
        Left str -> putStrLn str
        Right code -> runBrainfuck code
