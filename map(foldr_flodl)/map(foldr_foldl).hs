map_left :: (a->b)->[a]->[b]
map_left f xs = foldl (\acc x ->acc ++ [f x]) [] xs

map_right :: (a->b)->[a]->[b]
map_right f xs = foldr (\x acc ->f x: acc) [] xs

{-
    Правая свёртка будет лучше, т.к левая - слишком тяжелая операция.
    Ведь нам вначале нужно развернуть список, а лишь потом его собрать
-}

--Здесь я пытался понять как работают свёртки--

-----------------------------------------------
--f :: a->a->a
--[a1, a2, a3, a4]
--Left fold: f (f (f a1 a2) a3) a4
--Right fold: f a1 (f a2 (f a3 a4))
-----------------------------------------------

my_foldr :: (a->a->a)->[a]->a
my_foldr f [x] = x
my_foldr f (x:xs) = f x (my_foldr f xs)

--my_forldr f [a1, a2, a3, a4]          =>
--f a1 (my_foldr f [a2, a3, a4])        =>
--f a1 (f a2 (my_foldr f [a3, a4]))     =>
--f a1 (f a2 (f a3 (my_foldr f [a4])))  =>
--f a1 (f a2 (f a3 a4))

my_foldl :: (a->b->a)->a->[b]->a
my_foldl f base [] = base
my_foldl f base (x:xs) = my_foldl f (f base x) xs 

--fId = undefined
--f a fId = a
--f fId a = a

--my_foldl f [a1, a2, a3, a4] fId      =>
--my_foldl f (f fId a1) [a2, a3, a4]   =>
--my_foldl f a1 [a2, a3, a4]           =>
--my_foldl f (f a1 a2) [a3, a4]        =>
--my_foldl f (f (f a1 a2) a3) [a4]     => 
--my_foldl f (f (f a1 a2) a3) a4) []   =>
--(f (f (f a1 a2) a3) a4)