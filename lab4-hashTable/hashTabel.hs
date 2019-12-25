import System.IO
import Data.Char

type Capacity = Int
type ECnt = Int
data HashTable k v = HashTable [[(k, v)]] Capacity ECnt deriving (Show)

------------------------------- Вспомогательный функционал -------------------------------

hash :: (Show k) => k -> Int
hash k = (foldl (\acc x -> acc + ord(x)) 0 (show k))
                                                                               
-- Поиск вложенного списка c парами (k,v)
-- На hashTable навешиваем индексацию
-- Из получившегося списка вытаскиваем такой, где hash(k) == indx
getSameList :: (Show k, Eq k) => HashTable k v -> k -> [(k,v)]
getSameList (HashTable table capacity ecnt) k = snd $ head $ filter (\(indx, hList) -> indx == ((hash k) `mod` capacity)) (zip [0..] table)

checkLF :: (Eq k, Show k) => HashTable k v-> HashTable k v
checkLF (HashTable table capacity ecnt) 
                                        | ((fromIntegral ecnt) / (fromIntegral capacity)) > 0.5 = fromList $ concat table
                                        | otherwise = HashTable table capacity ecnt

----------------------------------- Функционал с pdf-ки -----------------------------------

defaultHashTable :: Int -> HashTable k v
defaultHashTable capacity = HashTable (replicate capacity []) capacity 0

fromList :: (Show k, Eq k) => [(k,v)] -> HashTable k v
fromList list = foldr (\pair xs -> insert xs (fst pair) (snd pair)) (defaultHashTable $ length list * 2 + 1) list

clear :: HashTable k v -> HashTable k v
clear (HashTable table capacity ecnt) = HashTable (replicate capacity []) capacity 0

-- Нужный подсписок в таблице изменям на
-- Такой же, но без элемента, где k = key
erase :: (Show k, Eq k) => HashTable k v -> k -> HashTable k v
erase (HashTable table capacity ecnt) k = checkLF $ HashTable(
                                                                map (\(indx, hList) ->  if indx == (hash k) `mod` capacity then
                                                                                            [elem | elem <- hList, fst elem /= k]
                                                                                        else
                                                                                            hList)
                                                                    (zip [0..] table)) capacity (ecnt - 1)

-- Находим нужный нам подсписок
-- Изменяем его, добавлением нового элемента
-- Следим, чтобы ключи не совпали
insert :: (Show k, Eq k) => HashTable k v -> k -> v -> HashTable k v
insert (HashTable table capacity ecnt) k v = HashTable(
                                                        map (\(indx, hList) ->  if indx == ((hash k) `mod` capacity) then
                                                                                    ([elem | elem <- hList, fst elem /= k] ++ [(k, v)])
                                                                                else
                                                                                    hList)             
                                                            (zip [0..] table)) capacity (ecnt + 1)

-- Посмотрим на вложенный список с парами (k,v)
-- если он пустой, то такого k в таблице нет
contains :: (Show k, Eq k) => HashTable k v -> k -> Bool
contains (HashTable table capacity ecnt) k = not $ null (getSameList (HashTable table capacity ecnt) k)

at :: (Show k, Eq k) => HashTable k v -> k -> Maybe v
at (HashTable table capacity ecnt) k
                                    | null result = Nothing
                                    | otherwise = Just $ snd $ head result
                                                                        where
                                                                            result = getSameList (HashTable table capacity ecnt) k
                                    
size :: (Show k) => HashTable k v -> Int
size (HashTable _ _ ecnt) = ecnt

empty :: (Show k) => HashTable k v -> Bool
empty (HashTable _ _ ecnt) = ecnt == 0

-------------------------------------- Чтение из файла --------------------------------------
{-
main :: IO()
main = do
    content <- lines <$> readFile "some.txt"
    let kvList = [(head $ words x, last $ words x) | x <- content]
    print(kvList)
    let table = fromList kvList
    print(table)
-}

ht = defaultHashTable 3
x = insert ht 1 1
xx = insert x 2 1
