import System.IO
import Data.Bits
import Data.Char

type Capacity = Int
type ECnt = Int
data HashTable k v = HashTable [[(k, v)]] Capacity ECnt deriving (Show)

hash :: (Show k) => k -> Int
hash k = (foldl (\acc x -> acc + ord(x)) 0 (show k))
                                                                               
fromList::(Show k, Eq k) => [(k,v)] -> HashTable k v
fromList list = foldr (\p xs -> insert xs (fst p) (snd p)) (defaultHashTable $ length list * 2 + 1) list

---
getSameList ::(Eq hash) => HashTable k v -> hash -> [(k,v)]
getSameList (HashTable table capacity ecnt) hash = concat $ filter (\(indx, hList) -> indx == hash) (zip [0..] table)
---

----------------------------------- Функционал с pdf-ки -----------------------------------

defaultHashTable :: Int -> HashTable k v
defaultHashTable capacity = HashTable (replicate capacity []) capacity 0

clear :: HashTable k v -> HashTable k v
clear (HashTable table capacity ecnt) = HashTable (replicate capacity []) capacity 0

erase :: (Show k, Eq k) => HashTable k v -> k -> HashTable k v
erase (HashTable table capacity ecnt) k = HashTable(
                                                    map (\(indx, hList) ->  if indx == (hash k) `mod` capacity then
                                                                                [elem | elem <- hList, fst elem /= k]
                                                                            else
                                                                                hList)
                                                        (zip [0..] table)) capacity (ecnt - 1)


insert :: (Show k, Eq k) => HashTable k v -> k -> v -> HashTable k v
insert (HashTable table capacity ecnt) k v = HashTable(
                                                        map (\(indx, hList) ->  if indx == ((hash k) `mod` capacity) then
                                                                                    ([elem | elem <- hList, fst elem /= k] ++ [(k, v)])
                                                                                else
                                                                                    hList)             
                                                            (zip [0..] table)) capacity (ecnt + 1)

----
contains :: (Show k, Eq k) => HashTable k v -> k -> Bool
contains (HashTable table capacity ecnt) k = empty $ getSameList (HashTable table capacity ecnt) ((hash k) `mod` capacity)
---

size :: (Show k) => HashTable k v -> Int
size (HashTable _ capacity _) = capacity

empty :: (Show k) => HashTable k v -> Bool
empty (HashTable _ _ ecnt) = ecnt == 0

-------------------------------------- Чтение из файла --------------------------------------

main :: IO()
main = do
    content <- lines <$> readFile "result.txt"
    let kvList = [(head $ words x, last $ words x) | x <- content]
    print(kvList)

ht = defaultHashTable 3
