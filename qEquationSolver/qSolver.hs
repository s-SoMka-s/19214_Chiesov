solver :: (Float, Float, Float) -> (Float, Float)
solver (a, b, c)
    | a == 0.0 = (x, x)
    | a /= 0.0 = if d<0 then error "No Solutions" else (x1, x2)
        where
            x = -c / b
            x1 = (-b + sqrt d ) / (2*a)
            x2 = (-b - sqrt d ) / (2*a)
            d = b*b - 4*a*c
