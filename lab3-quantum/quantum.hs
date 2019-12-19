data Complex a = Complex a a
data QState a = QState a String
type Qubit a = [QState a]

-------------------------------------------------------------------

--  r real part
--  i image part
--  c complex number

instance (Eq a) => Eq (Complex a) where
    (Complex r1 i1) == (Complex r2 i2) = (r1 == r2) && (i1 == i2)

instance (Eq a) => Eq (QState a) where
    (QState c1 s1) == (QState c2 s2) = (c1 == c2) && (s1 == s2)

instance (Show a) => Show (Complex a) where
    show (Complex r i) = show r ++ "+" ++ show i ++ "i"

instance (Show a) => Show (QState a) where
    show (QState complex state) = show complex ++ " " ++ state 

instance (Num a, Floating a) => Num (Complex a) where
        (Complex r1 i1) + (Complex r2 i2) = Complex (r1 + r2) (i1 + i2)
        (Complex r1 i1) * (Complex r2 i2) = Complex (r1*r2 - i1 * i2) (r1*r2 + i1 * i2)
        abs (Complex r i) = Complex (sqrt $ r * r + i * i) 0
        negate (Complex r i) = Complex r (negate i)
        fromInteger int  = Complex  (fromInteger int) 0
        signum (Complex r i) = Complex (signum r) 0 

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

scalarProduct:: (Num a, Floating a) => Qubit (Complex a) -> Qubit (Complex a) -> (Complex a)
scalarProduct [] [] = Complex 0 0
--scalarProduct ((QState c1 _):xs) ((QState c2 _):ys) = (c1 * c2) + (scalarProduct xs ys) 
scalarProduct xs ys = foldl (+) 0 [c1*c2 | ((QState c1 s1), (QState c2 s2)) <- (zip xs ys)]

entagle :: (Num a,  Floating a ) => Qubit (Complex a) -> Qubit (Complex a) -> Qubit (Complex a)
entagle q1 q2 = [ QState (c1 * c1) (state1 ++ state2) | (QState c1 state1) <- q1 , (QState c2 state2) <- q1]

-------------------------------------------------------------------

c1 = (Complex 3.0 6.0)
c2 = (Complex 5.0 2.0)
c3 = (Complex 1.0 3.0)

pairs = [(c1, "ttt"), (c2, "rrr"), (c3, "jjj")]

qs1 = QState c1 "uuu"
qs2 = QState c2 "ggg"
qs3 = QState (Complex 8.0 56.0) "kkkk"


qb = [qs1, qs2, qs3]
