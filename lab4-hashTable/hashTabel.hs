import System.IO
type Size = Int
data HashTable key value = HashTable [[(key, value)]] Size deriving (Show)

defaultHashTable :: HashTable k v
defaultHashTable = HashTable [] 0

main :: IO()
main = do
    content <- lines <$> readFile "result.txt"
    let kvList = [(head $ words x, last $ words x) | x <- content]
    print(kvList)