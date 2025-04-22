read_number(Number) :-
    write('Введите натуральное число: '),
    read(Number),
    integer(Number),
    Number > 0.


main_logic(Number) :-
    max_prime_divisor(Number, MaxPrime),
    product_of_digits(Number, Product),
    max_odd_composite_divisor(Number, MaxOddComposite),
    gcd(MaxOddComposite, Product, GCD),
    print_results(Number, MaxPrime, GCD).

max_prime_divisor(Number, MaxPrime) :-
    findall(D, (divider(Number, D), Divisors),
    include(is_prime, Divisors, PrimeDivisors),
    max_list(PrimeDivisors, MaxPrime).

max_odd_composite_divisor(Number, Div) :-
    findall(D, (divider(Number, D), D mod 2 =\= 0, \+ is_prime(D)), Divisors),
    (   Divisors = [] -> Div = 1 % если нет таких делителей
    ;   max_list(Divisors, Div)
    ).

product_of_digits(Number, Product) :-
    product_of_digits(Number, 1, Product).

product_of_digits(0, Acc, Acc) :- !.
product_of_digits(Number, Acc, Product) :-
    Number > 0,
    Digit is Number mod 10,
    NewAcc is Acc * Digit,
    NewNumber is Number // 10,
    product_of_digits(NewNumber, NewAcc, Product).

print_results(Number, MaxPrime, GCD) :-
    nl,
    write('Для числа '), write(Number), write(':'), nl,
    write('1. Максимальный простой делитель: '), write(MaxPrime), nl,
    write('2. НОД максимального нечетного непростого делителя '), nl,
    write('   и произведения цифр числа: '), write(GCD), nl,
    nl.


is_prime(2) :- !.
is_prime(3) :- !.
is_prime(N) :-
    N > 3,
    N mod 2 =\= 0,
    \+ has_factor(N, 3).

has_factor(N, F) :-
    F * F =< N,
    (N mod F =:= 0 -> true; 
     NewF is F + 2, has_factor(N, NewF)).

divider(N, D) :-
    between(1, N, D),
    N mod D =:= 0.

gcd(A, 0, A) :- !.
gcd(A, B, GCD) :-
    B > 0,
    R is A mod B,
    gcd(B, R, GCD).

start :-
    read_number(Number),
    main_logic(Number).