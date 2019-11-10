myGet ::[a] -> Integer -> a
myGet [] _ = error "Empty list"
myGet (x:xs) 0 = x
myGet (x:xs) n = myGet xs (n-1) 

myHead :: [a] -> a
myHead [] = error "Empty list"
myHead (x:xs) = x

myLast :: [a] -> a
myLast [] = error "Empty list"
myLast [x] = x
myLast (x:xs) = myLast xs

myTail :: [a] -> [a]
myTail [] = error "Empty list"
myTail [x] = []
myTail (x:xs) = xs

myInit :: [a]->[a]
myInit [] = error "Empty list"
myInit [x] = []
myInit (x:xs) = x : myInit xs

myReverse:: [a] -> [a]
myReverse xs = helper [] xs
    where
        helper acc [] = acc
        helper acc (x:xs) = helper (x:acc) xs

myLenght :: [a] -> Integer
myLenght [] = 0
myLenght xs = helper 0 xs where
        helper acc [] = acc
        helper acc (x:xs) = 1 + helper acc xs

myAppend :: [a] -> a -> [a]
myAppend [] elem = [elem]
myAppend (x:xs) elem = x : myAppend xs elem

myConcat :: [a] -> [a] -> [a]
myConcat [] ys = ys
myConcat (x:xs) ys = x : myConcat xs ys

myDrop :: Integer -> [a] -> [a]
myDrop 0 xs = xs;
myDrop n (x:xs) = myDrop (n-1) xs

myTake :: Integer -> [a] -> [a]
myTake _ [] = []
myTake 0 xs = []
myTake n (x:xs) = x : ( myTake (n-1) xs)

mySplitAt :: Integer -> [a] -> ([a],[a])
mySplitAt n xs = (myTake n xs, myDrop n xs)

myElem :: Eq a => [a] -> a -> Bool
myElem [] _ = False
myElem (x:xs) elem  = if elem == x then True else myElem xs elem

myNull :: [a] -> Bool
myNull [] = True
myNull xs = False

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter _ [] = []
myFilter cond (x:xs) = if cond x then x : myFilter cond xs else myFilter cond xs

myMap :: (a->b)->[a]->[b]
myMap _ [] = []
myMap f (x:xs) = (f x) : myMap f xs 

myZip :: [a]->[b]->[(a,b)]
myZip xs [] = []
myZip [] xy = []
myZip (x:xs) (y:ys) = (x,y) : myZip xs ys
