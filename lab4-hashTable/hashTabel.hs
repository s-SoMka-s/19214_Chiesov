import System.IO
import Data.Bits
import Data.Char
type MaxSize = Int
type Capacity = Int
data HashTable key value = HashTable [[(key, value)]] MaxSize Capacity deriving (Show)

defaultHashTable :: HashTable k v
defaultHashTable = HashTable [] 0 0

hash :: String -> Int -> Int
hash key size = (foldl (\acc x -> acc + ord(x)) 0 key) `mod` size

size :: (Show key) => HashTable key value -> Int
size (HashTable hTable maxSize capacity) = capacity

empty :: (Show key) => HashTable key value -> Bool
empty (HashTable hTable maxSize capacity)
                                        | capacity == 0 = True
                                        | otherwise = False

main :: IO()
main = do
    content <- lines <$> readFile "result.txt"
    let kvList = [(head $ words x, last $ words x) | x <- content]
    print(kvList)

ht = defaultHashTable
