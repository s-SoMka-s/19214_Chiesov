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

--make faster - possible O(n) solution
myReverse :: [a] -> [a]
myReverse [] = error "Empty list"
myReverse [x] = [x]
myReverse xs = myLast(xs) : myReverse(myInit(xs))

--length not optimal // made faster
myLenght :: [a] -> Integer
myLenght [] = 0
myLenght xs = helper 0 xs where
        helper acc [] = acc
        helper acc (x:xs) = 1 + helper acc xs

myAppend :: [a] -> a -> [a]
myAppend [] elem = [elem]
myAppend (x:xs) elem = x : myAppend xs elem

myDrop :: Integer -> [a] -> [a]
myDrop 0 xs = xs;
myDrop n (x:xs) = myDrop (n-1) xs

myTake :: Integer -> [a] -> [a]
myTake _ [] = []
myTake 0 xs = []
myTake n (x:xs) = x : ( myTake (n-1) xs)

myElem :: Eq a => [a] -> a -> Bool
myElem [] _ = False
myElem (x:xs) elem  = if elem == x then True else myElem xs elem

myNull :: [a] -> Bool
myNull [] = True
myNull xs = False

myMap :: (a->b)->[a]->[b]
myMap _ [] = []
myMap f (x:xs) = (f x) : myMap f xs 

--added checks for empty lists
myZip :: [a]->[b]->[(a,b)]
myZip xs [] = []
myZip [] xy = []
myZip (x:xs) (y:ys) = (x,y) : myZip xs ys 
