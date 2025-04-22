% Предикат max(+X, +Y, +U, -Z), где U - максимальное из чисел X, Y и Z
max(X, Y, U, Z) :-
    max_list([X, Y, U], Z).

% Факториал с рекурсией вверх (хвостовая рекурсия)
fact_up(N, X) :-
    fact_up_helper(N, 1, X).

fact_up_helper(0, Acc, Acc) :- !.
fact_up_helper(N, Acc, X) :-
    N > 0,
    NewAcc is Acc * N,
    NewN is N - 1,
    fact_up_helper(NewN, NewAcc, X).

% Факториал с рекурсией вниз
fact_down(0, 1) :- !.
fact_down(N, X) :-
    N > 0,
    NewN is N - 1,
    fact_down(NewN, PrevX),
    X is N * PrevX.

% Сумма цифр числа с рекурсией вверх (хвостовая рекурсия)
sum_digits_up(Number, Sum) :-
    sum_digits_up_helper(Number, 0, Sum).

sum_digits_up_helper(0, Acc, Acc) :- !.
sum_digits_up_helper(Number, Acc, Sum) :-
    Number > 0,
    Digit is Number mod 10,
    NewNumber is Number // 10,
    NewAcc is Acc + Digit,
    sum_digits_up_helper(NewNumber, NewAcc, Sum).

% Сумма цифр числа с рекурсией вниз
sum_digits_down(0, 0) :- !.
sum_digits_down(Number, Sum) :-
    Number > 0,
    NewNumber is Number // 10,
    sum_digits_down(NewNumber, PrevSum),
    Digit is Number mod 10,
    Sum is PrevSum + Digit.

% Проверка, что число свободно от квадратов (не делится ни на один квадрат простого числа)
is_square_free(N) :-
    N > 0,
    \+ (between(2, N, X),
        is_prime(X),
        Square is X * X,
        0 is N mod Square).

% Вспомогательный предикат для проверки простоты числа
is_prime(2) :- !.
is_prime(3) :- !.
is_prime(N) :-
    N > 3,
    N mod 2 =\= 0,
    \+ has_factor(N, 3).

has_factor(N, F) :-
    F * F =< N,
    (0 is N mod F -> true; 
     NewF is F + 2,
     has_factor(N, NewF)).

% Предикат чтения списка с клавиатуры
read_list(List) :-
    write('Enter list elements (end with .): '), nl,
    read_list_helper(List).

read_list_helper([]) :-
    peek_code(46), !, % проверка на точку
    skip_line. % пропустить точку и перевод строки
read_list_helper([H|T]) :-
    read(H),
    read_list_helper(T).

% Предикат вывода списка на экран
write_list([]) :-
    nl.
write_list([H|T]) :-
    write(H), write(' '),
    write_list(T).

% Сумма элементов списка с рекурсией вниз
sum_list_down([], 0).
sum_list_down([H|T], Sum) :-
    sum_list_down(T, TailSum),
    Sum is H + TailSum.

% Сумма элементов списка с рекурсией вверх (хвостовая рекурсия)
sum_list_up(List, Sum) :-
    sum_list_up_helper(List, 0, Sum).

sum_list_up_helper([], Acc, Acc).
sum_list_up_helper([H|T], Acc, Sum) :-
    NewAcc is Acc + H,
    sum_list_up_helper(T, NewAcc, Sum).

% Программа: чтение списка, подсчет суммы, вывод результата
process_list :-
    read_list(List),
    sum_list_down(List, Sum),
    write('Sum of list elements: '), write(Sum), nl.

% Предикат, который удаляет все элементы, сумма цифр которых равна заданной
remove_with_sum_digits([], _, []).
remove_with_sum_digits([H|T], TargetSum, Result) :-
    sum_digits_up(H, Sum),
    Sum =:= TargetSum, !,
    remove_with_sum_digits(T, TargetSum, Result).
remove_with_sum_digits([H|T], TargetSum, [H|Result]) :-
    remove_with_sum_digits(T, TargetSum, Result).