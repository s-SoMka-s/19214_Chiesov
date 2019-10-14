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

myZip :: [a]->[b]->[(a,b)]
myZip [] [] = error "Empty list"
myZip [x] [y] = [(x,y)]
myZip (x:xs) (y:ys) = (x,y) : myZip xs ys 