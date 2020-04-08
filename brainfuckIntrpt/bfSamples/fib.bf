++++++++++++++++++++++++++++++++++++++++++++		c1v44 : ASCII code of comma
>++++++++++++++++++++++++++++++++			c2v32 : ASCII code of space
>++++++++++++++++					c3v11 : quantity of numbers to be calculated
>							c4v0  : zeroth Fibonacci number (will not be printed)
>+							c5v1  : first Fibonacci number
<<							c3    : loop counter
[							block : loop to print (i)th number and calculate next one
>>							c5    : the number to be printed

							block : divide c5 by 10 (preserve c5)
>							c6v0  : service zero
>++++++++++						c7v10 : divisor
<<							c5    : back to dividend
[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]			c5v0  : divmod algo; results in 0 n d_n%d n%d n/d
>[<+>-]							c5    : move dividend back to c5 and clear c6
>[-]							c7v0  : clear c7

>>							block : c9 can have two digits; divide it by ten again
>++++++++++						c10v10: divisor
<							c9    : back to dividend
[->-[>+>>]>[+[-<+>]>+>>]<<<<<]				c9v0  : another divmod algo; results in 0 d_n%d n%d n/d
>[-]							c10v0 : clear c10
>>[++++++++++++++++++++++++++++++++++++++++++++++++.[-]]c12v0 : print nonzero n/d (first digit) and clear c12
<[++++++++++++++++++++++++++++++++++++++++++++++++.[-]] c11v0 : print nonzero n%d (second digit) and clear c11

<<<++++++++++++++++++++++++++++++++++++++++++++++++.[-]	c8v0  : print any n%d (last digit) and clear c8
<<<<<<<.>.                                              c1c2  : print comma and space
							block : actually calculate next Fibonacci in c6
>>[>>+<<-]						c4v0  : move c4 to c6 (don't need to preserve it)
>[>+<<+>-]						c5v0  : move c5 to c6 and c4 (need to preserve it)
>[<+>-]							c6v0  : move c6 with sum to c5
<<<-							c3    : decrement loop counter
]
<<++...							c1    : output three dots
Факториал:
Пример для версий EsCo 0.511 (Brainfuck), Müller's Brainfuck 2.0, weave.rb
В примере используется итеративное определение факториала: последний вычисленный факториал хранится в ячейке-переменной c6 и на каждом шагу умножается на очередное число, хранящееся в c5. Низкоуровневое описание приведено в комментариях к коду, запись “cXvY” означает, что после выволнения команд в строке указатель данных находится в ячейке X, и значение в этой ячейке равно Y.

Классический интерпретатор Brainfuck использует переменные типа byte для хранения значений в ячейках памяти, и уже 6! вызовет ошибку переполнения. Написание длинной арифметики на Brainfuck — задача достаточно трудоемкая, поэтому в примере предполагается, что в ячейках памяти могут храниться числа типа integer.

+++++++++++++++++++++++++++++++++			c1v33 : ASCII code of !
>++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++				c2v61 : ASCII code of =
>++++++++++						c3v10 : ASCII code of EOL
>+++++++						c4v7  : quantity of numbers to be calculated
>							c5v0  : current number (one digit)
>+							c6v1  : current value of factorial (up to three digits)
<<							c4    : loop counter
[							block : loop to print one line and calculate next
>++++++++++++++++++++++++++++++++++++++++++++++++.	c5    : print current number
------------------------------------------------	c5    : back from ASCII to number
<<<<.-.>.<.+						c1    : print !_=_

>>>>>							block : print c6 (preserve it)
>							c7v0  : service zero
>++++++++++						c8v10 : divizor
<<							c6    : back to dividend
[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]			c6v0  : divmod algo borrowed from esolangs; results in 0 n d_n%d n%d n/d
>[<+>-]							c6    : move dividend back to c6 and clear c7
>[-]							c8v0  : clear c8

>>							block : c10 can have two digits; divide it by ten again
>++++++++++						c11v10: divizor
<							c10   : back to dividend
[->-[>+>>]>[+[-<+>]>+>>]<<<<<]				c10v0 : another divmod algo borrowed from esolangs; results in 0 d_n%d n%d n/d
>[-]							c11v0 : clear c11
>>[++++++++++++++++++++++++++++++++++++++++++++++++.[-]]c13v0 : print nonzero n/d (first digit) and clear c13
<[++++++++++++++++++++++++++++++++++++++++++++++++.[-]] c12v0 : print nonzero n%d (second digit) and clear c12
<<<++++++++++++++++++++++++++++++++++++++++++++++++.[-]	c9v0  : print any n%d (last digit) and clear c9

<<<<<<.							c3    : EOL
>>+							c5    : increment current number
							block : multiply c6 by c5 (don't preserve c6)
>[>>+<<-]						c6v0  : move c6 to c8
>>							c8v0  : repeat c8 times
[
<<<[>+>+<<-]						c5v0  : move c5 to c6 and c7
>>[<<+>>-]						c7v0  : move c7 back to c5
>-
]
<<<<-							c4    : decrement loop counter
]