import Data.Maybe

data Tape a = Tape [a]
                    a
                   [a] deriving(Show)

emptyTape :: Tape Int
emptyTape = Tape zeros 0 zeros
    where zeros = repeat 0

moveRight :: Tape a -> Tape a
moveRight (Tape ls p (r:rs)) = Tape (p:ls) r rs

moveLeft :: Tape a -> Tape a
moveLeft (Tape (l:ls) p rs) = Tape ls l (p:rs)

runBrainfuck :: BrainfuckSource -> IO ()
runBrainfuck = run emptyTape . bfSource2Tape where
    bfSource2Tape (b:bs) = Tape [] b bs

run :: Tape Int
    -> Tape BrainfuckCommand
    -> IO ()

data BrainfuckCommand = GoRight -- >
                      | GoLeft -- <
                      | Increment -- +
                      | Decrement -- -
                      | Print -- .
                      | Read -- ,
                      | LoopL -- [
                      | LoopR -- ]
                          deriving Show

type BrainfuckSource = [BrainfuckCommand]

data BFSource = BFSource [BrainfuckCommand]

instance Show BFSource where
    show (BFSource xs) = show $ concat [convert x | x <- xs] where
        convert x = case x of
            GoRight -> ">"
            GoLeft -> "<"
            Increment -> "+"
            Decrement -> "-"
            Print -> "." 
            Read -> "," 
            LoopL -> "["
            LoopR -> "]"


parseBrainfuck :: String-> BrainfuckSource
parseBrainfuck = map charToBf
    where
        charToBf x = case x of
            '>' -> GoRight
            '<' -> GoLeft
            '+' -> Increment
            '-' -> Decrement
            '.' -> Print
            ',' -> Read
            '[' -> LoopL
            ']' -> LoopR

