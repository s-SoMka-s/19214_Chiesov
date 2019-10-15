myGet ::(Eq b, Num b) => [a] -> b -> a
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

myReverse :: [a] -> [a]
myReverse [] = error "Empty list"
myReverse [x] = [x]
myReverse (xs) = myLast(xs) : myReverse(myInit(xs))

myLenght :: Num b => [a] -> b
myLenght [] = 0
myLenght (x:xs) = 1 + myLenght xs

myAppend :: [a] -> a -> [a]
myAppend [] elem = [elem]
myAppend (x:xs) elem = x : myAppend xs elem

myTake :: (Num b, Eq b) => b -> [a] -> [a]
myTake _ [] = []
myTake 0 xs = []
myTake n (x:xs) = x :( myTake (n-1) xs)

myElem :: Eq a => [a] -> a -> Bool
myElem [] _ = False
myElem (x:xs) elem  = if elem == x then True else myElem xs elem

myNull :: [a] -> Bool
myNull [] = True
myNull xs = False

myZip :: [a]->[b]->[(a,b)]
myZip [] [] = error "Empty list"
myZip [x] [y] = [(x,y)]
myZip (x:xs) (y:ys) = (x,y) : myZip xs ys 