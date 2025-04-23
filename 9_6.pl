% Предикат чтения списка
read_list(List) :-
    write('Введите элементы списка (окончание - точка): '), nl,
    read_list_helper(List).

read_list_helper([]) :-
    peek_code(46), !,
    skip_line.
read_list_helper([H|T]) :-
    read(H),
    read_list_helper(T).

% Предикат логики разделения элементов
split_by_index(List, EvenOddList) :-
    split_by_index(List, 1, [], [], Even, Odd),
    append(Even, Odd, EvenOddList).

split_by_index([], _, EvenAcc, OddAcc, EvenAcc, OddAcc).
split_by_index([H|T], Index, EvenAcc, OddAcc, Even, Odd) :-
    (   0 is Index mod 2
    ->  NewEvenAcc = [H|EvenAcc],
        NewOddAcc = OddAcc
    ;   NewEvenAcc = EvenAcc,
        NewOddAcc = [H|OddAcc]
    ),
    NewIndex is Index + 1,
    split_by_index(T, NewIndex, NewEvenAcc, NewOddAcc, Even, Odd).

% Предикат вывода результата
print_split_result(Original, Result) :-
    write('Исходный список: '), write(Original), nl,
    write('Список с элементами с четными индексами, затем с нечетными: '), nl,
    write(Result), nl.

% Главный предикат
task_1_39 :-
    read_list(List),
    split_by_index(List, Result),
    print_split_result(List, Result).









    % Предикат чтения (используем тот же read_list/1)

% Предикат логики построения списков
build_frequency_lists(List, UniqueList, FrequencyList) :-
    get_unique(List, UniqueList),
    count_frequencies(List, UniqueList, FrequencyList).

get_unique([], []).
get_unique([H|T], Unique) :-
    (   member(H, T)
    ->  get_unique(T, Unique)
    ;   Unique = [H|RestUnique],
        get_unique(T, RestUnique)
    ).

count_frequencies(_, [], []).
count_frequencies(List, [H|UniqueT], [Count|FreqT]) :-
    count_occurrences(List, H, Count),
    count_frequencies(List, UniqueT, FreqT).

count_occurrences([], _, 0).
count_occurrences([H|T], X, Count) :-
    count_occurrences(T, X, TailCount),
    (   H =:= X
    ->  Count is TailCount + 1
    ;   Count = TailCount
    ).

% Предикат вывода результата
print_frequency_result(Original, Unique, Frequencies) :-
    write('Исходный список: '), write(Original), nl,
    write('Список уникальных элементов: '), write(Unique), nl,
    write('Список частот: '), write(Frequencies), nl.

% Главный предикат
task_1_51 :-
    read_list(List),
    build_frequency_lists(List, Unique, Frequencies),
    print_frequency_result(List, Unique, Frequencies).