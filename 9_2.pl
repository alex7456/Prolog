% Предикат для нахождения произведения цифр числа (рекурсия вверх)
% product_digits_up(+Number, -Product) - Product - произведение цифр Number
product_digits_up(Number, Product) :-
    product_digits_up_helper(Number, 1, Product).

product_digits_up_helper(0, Acc, Acc) :- !.
product_digits_up_helper(Number, Acc, Product) :-
    Number > 0,
    Digit is Number mod 10,
    NewAcc is Acc * Digit,
    NewNumber is Number // 10,
    product_digits_up_helper(NewNumber, NewAcc, Product).

% Предикат для нахождения произведения цифр числа (рекурсия вниз)
% product_digits_down(+Number, -Product) - Product - произведение цифр Number
product_digits_down(0, 1) :- !.
product_digits_down(Number, Product) :-
    Number > 0,
    NewNumber is Number // 10,
    product_digits_down(NewNumber, PartialProduct),
    Digit is Number mod 10,
    Product is PartialProduct * Digit.

% Предикат для нахождения максимальной цифры числа, не делящейся на 3 (рекурсия вверх)
% max_non_div3_up(+Number, -MaxDigit) - MaxDigit - максимальная цифра Number, не делящаяся на 3
max_non_div3_up(Number, MaxDigit) :-
    max_non_div3_up_helper(Number, -1, MaxDigit).

max_non_div3_up_helper(0, CurrentMax, CurrentMax) :- !.
max_non_div3_up_helper(Number, CurrentMax, MaxDigit) :-
    Number > 0,
    Digit is Number mod 10,
    (   (Digit mod 3 =\= 0, Digit > CurrentMax)
    ->  NewCurrentMax = Digit
    ;   NewCurrentMax = CurrentMax
    ),
    NewNumber is Number // 10,
    max_non_div3_up_helper(NewNumber, NewCurrentMax, MaxDigit).

% Предикат для нахождения максимальной цифры числа, не делящейся на 3 (рекурсия вниз)
% max_non_div3_down(+Number, -MaxDigit) - MaxDigit - максимальная цифра Number, не делящаяся на 3
max_non_div3_down(Number, MaxDigit) :-
    max_non_div3_down(Number, -1, MaxDigit).

max_non_div3_down(0, CurrentMax, CurrentMax) :- !.
max_non_div3_down(Number, CurrentMax, MaxDigit) :-
    Number > 0,
    NewNumber is Number // 10,
    max_non_div3_down(NewNumber, CurrentMax, TempMax),
    Digit is Number mod 10,
    (   Digit mod 3 =\= 0,
        Digit > TempMax
    ->  MaxDigit = Digit
    ;   MaxDigit = TempMax
    ).

% Предикат для нахождения количества делителей числа (рекурсия вверх)
% count_divisors_up(+Number, -Count) - Count - количество делителей Number
count_divisors_up(Number, Count) :-
    Number > 0,
    count_divisors_up_helper(Number, 1, 0, Count).

count_divisors_up_helper(Number, Divisor, Acc, Acc) :-
    Divisor * Divisor > Number, !.
count_divisors_up_helper(Number, Divisor, Acc, Count) :-
    Divisor * Divisor =< Number,
    (   0 is Number mod Divisor
    ->  (   DivisorSquared is Divisor * Divisor,
             DivisorSquared =:= Number
         ->  NewAcc is Acc + 1
         ;   NewAcc is Acc + 2
        )
    ;   NewAcc = Acc
    ),
    NewDivisor is Divisor + 1,
    count_divisors_up_helper(Number, NewDivisor, NewAcc, Count).

% Предикат для нахождения количества делителей числа (рекурсия вниз)
% count_divisors_down(+Number, -Count) - Count - количество делителей Number
count_divisors_down(Number, Count) :-
    Number > 0,
    UpperBound is floor(sqrt(Number)),
    count_divisors_down(Number, 1, UpperBound, 0, Count).

count_divisors_down(_, Divisor, UpperBound, Acc, Acc) :-
    Divisor > UpperBound, !.
count_divisors_down(Number, Divisor, UpperBound, Acc, Count) :-
    Divisor =< UpperBound,
    (   0 is Number mod Divisor
    ->  (   DivisorSquared is Divisor * Divisor,
             DivisorSquared =:= Number
         ->  NewAcc is Acc + 1
         ;   NewAcc is Acc + 2
        )
    ;   NewAcc = Acc
    ),
    NewDivisor is Divisor + 1,
    count_divisors_down(Number, NewDivisor, UpperBound, NewAcc, Count).