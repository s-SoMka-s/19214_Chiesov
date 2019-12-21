import System.IO
data HashTable key value = HashTable [[(key, value)]] deriving (Show)

main :: IO()
main = do
    content <- lines <$> readFile "result.txt"
    let kvList = [(head $ words x, last $ words x) | x <- content]
    print(kvList)