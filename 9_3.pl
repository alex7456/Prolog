/* Предикат чтения */
read_input(List, Index) :-
    write('Enter list elements (end with .): '), nl,
    read_list(List),
    write('Enter index: '),
    read(Index),
    integer(Index),
    Index >= ,
    length(List, Length),
    Index < Length.

/* Предикат логики */
is_global_max(List, Index) :-
    nth(Index, List, Element),
    max_list(List, Max),
    Element =:= Max.

/* Предикат вывода */
print_global_max_result(List, Index) :-
    (   is_global_max(List, Index)
    ->  write('Element at index '), write(Index), write(' is global maximum')
    ;   write('Element at index '), write(Index), write(' is NOT global maximum')
    ),
    nl.

/* Главный предикат */
check_global_max :-
    read_input(List, Index),
    print_global_max_result(List, Index).


    /* Предикат чтения (используем тот же, что и в первой задаче) */

/* Предикат логики */
is_local_min(List, Index) :-
    nth(Index, List, Element),
    (   Index =:= 
    ->  Right is Index + 1,
        nth(Right, List, RightElem),
        Element < RightElem
    ;   length(List, Length),
        Index =:= Length - 1
    ->  Left is Index - 1,
        nth(Left, List, LeftElem),
        Element < LeftElem
    ;   Left is Index - 1,
        Right is Index + 1,
        nth(Left, List, LeftElem),
        nth(Right, List, RightElem),
        Element < LeftElem,
        Element < RightElem
    ).

/* Предикат вывода */
print_local_min_result(List, Index) :-
    (   is_local_min(List, Index)
    ->  write('Element at index '), write(Index), write(' is local minimum')
    ;   write('Element at index '), write(Index), write(' is NOT local minimum')
    ),
    nl.

/* Главный предикат */
check_local_min :-
    read_input(List, Index),
    print_local_min_result(List, Index).



    /* Предикат чтения списка */
read_list(List) :-
    write('Enter list elements (end with .): '), nl,
    read_list_helper(List).

read_list_helper([]) :-
    peek_code(46), !,
    skip_line.
read_list_helper([H|T]) :-
    read(H),
    read_list_helper(T).

/* Предикат логики */
shift_left([], []).
shift_left([First|Rest], Shifted) :-
    append(Rest, [First], Shifted).

/* Предикат вывода */
print_shifted_list(Original, Shifted) :-
    write('Original list: '), write(Original), nl,
    write('Shifted list: '), write(Shifted), nl.

/* Главный предикат */
perform_shift_left :-
    read_list(List),
    shift_left(List, Shifted),
    print_shifted_list(List, Shifted).