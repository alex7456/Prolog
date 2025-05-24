read_line_from_file(Stream, Line) :-
    read_line_to_string(Stream, Line),
    Line \= end_of_file.

read_lines_from_file(File, Lines) :-
    open(File, read, Stream),
    read_lines(Stream, Lines),
    close(Stream).

read_lines(Stream, Lines) :-
    read_line_from_file(Stream, Line),
    (   Line = end_of_file
    ->  Lines = []
    ;   Lines = [Line|Rest],
        read_lines(Stream, Rest)
    ).

write_lines_to_file(File, Lines) :-
    open(File, write, Stream),
    write_lines(Stream, Lines),
    close(Stream).

write_lines(_, []).
write_lines(Stream, [Line|Rest]) :-
    write(Stream, Line), nl(Stream),
    write_lines(Stream, Rest).

print_line(Line) :-
    write(Line), nl.

max_line_length(File, MaxLength) :-
    read_lines_from_file(File, Lines),
    maplist(string_length, Lines, Lengths),
    max_list(Lengths, MaxLength).

lines_with_above_avg_a(File) :-
    read_lines_from_file(File, Lines),
    maplist(count_a, Lines, Counts),
    sum_list(Counts, Total),
    length(Lines, N),
    (   N > 0
    ->  Avg is Total / N,
        include(above_avg_a(Avg), Lines, Filtered),
        maplist(print_line, Filtered)
    ;   true
    ).

count_a(Line, Count) :-
    string_chars(Line, Chars),
    include(=(a), Chars, As),
    length(As, Count).

above_avg_a(Avg, Line) :-
    count_a(Line, Count),
    Count > Avg.

generate_words_6(Alphabet, Words) :-
    findall(Word,
            (   length(Word, 5),
                select_n(2, a, Word, Rest),

                subset(Rest, Alphabet),
                member(a, Alphabet)
            ),
            Words).

select_n(N, X, List, Rest) :-
    length(Prefix, N),
    msort(Prefix, [X|SortedRest]),
    append(Prefix, Rest, List),
    msort(List, [X|SortedRest]).

all_distinct([]).
all_distinct([X|Xs]) :-
    \+ member(X, Xs),
    all_distinct(Xs).

generate_words_9(Alphabet, Words) :-
    findall(Word,
            (   length(Word, 7),
                select_n(2, X, Word, Rest1),
                select_n(3, Y, Rest1, Rest2),
                X \= Y,
                all_distinct(Rest2),
                subset([X,Y|Rest2], Alphabet)
            ),
            Words).


:- initialization(main).

main :-
    write('Задача 1: Длина наибольшей строки'), nl,
    max_line_length('input.txt', Max),
    format('Максимальная длина строки: ~w~n', [Max]),

    write('Задача 3: Строки с числом букв \'a\' выше среднего'), nl,
    lines_with_above_avg_a('input.txt'),

    Alphabet = [a, b, c, d, e],
    write('Задача 6: Слова длины 5 с 2 \'a\', остальные не повторяются'), nl,
    generate_words_6(Alphabet, Words6),
    maplist(print_line, Words6),

    write('Задача 9: Слова длины 7, 1 буква 2 раза, 1 буква 3 раза'), nl,
    generate_words_9(Alphabet, Words9),
    maplist(print_line, Words9).