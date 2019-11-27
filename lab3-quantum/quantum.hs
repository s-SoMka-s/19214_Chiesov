data Complex a = Complex a a
data QState a = QState a String
type Qubit a = [QState a]

-------------------------------------------------------------------

instance (Eq a) => Eq (Complex a) where
    (Complex r1 i1) == (Complex r2 i2) = (r1 == r2) && (i1 == i2)

instance (Eq a) => Eq (QState a) where
    (QState c1 s1) == (QState c2 s2) = (c1 == c2) && (s1 == s2)

instance (Show a) => Show (Complex a) where
    show (Complex r i) = show r ++ "+" ++ show i ++ "i"

instance (Show a) => Show (QState a) where
    show (QState complex state) = show complex ++ " " ++ state 

instance Functor QState where
    fmap f (QState complex label) = QState (f complex) label

-------------------------------------------------------------------

toList :: Qubit (Complex a) -> [Complex a]
toList [] = []
toList q = [complex | (QState complex _ ) <- q]

toLableList :: Qubit (Complex a) -> [String]
toLableList [] = []
toLableList q = [state | (QState _ state) <- q]

fromList :: [Complex a] -> [String] -> Qubit (Complex a)
fromList [] [] = [] 
fromList complexes states = [QState complex state | complex <- complexes, state <- states]

toPairList :: Qubit a -> [(a, String)]
toPairList [] = []
toPairList q = [(complex, state) | (QState complex state) <- q]

fromPairList :: [(a, String)] -> Qubit a
fromPairList [] = []
fromPairList pairList = [(QState complex state) | (complex, state) <- pairList]

scalarProduct:: (Num a) => Qubit (Complex a) -> Qubit (Complex a) -> (Complex a)
scalarProduct [] [] = Complex 0 0
scalarProduct ((QState c1 _):xs) ((QState c2 _):ys) = mSum (scalar c1 c2) (scalarProduct xs ys) 
        where
            scalar (Complex r1 i1) (Complex r2 i2) = Complex (r1*r2 - i1*i2) (r1*r2 + i1*i2)
            mSum (Complex r1 i1) (Complex r2 i2) = Complex (r1 + r2) (i1 + i2)

-------------------------------------------------------------------

c1 = (Complex 3 6)
c2 = (Complex 5 2)
c3 = (Complex 1 3)

pairs = [(c1, "ttt"), (c2, "rrr"), (c3, "jjj")]

qs1 = QState c1 "uuu"
qs2 = QState c2 "ggg"
qs3 = QState (Complex 8 56) "kkkk"

qubit = [qs1, qs2, qs3]
qustatelist = [qs2, qs3]