% Читает строку символов с ввода до символа новой строки (код 10) и возвращает её как список кодов.
read_str(A) :- get0(X), r_str(X, A, []).

% Вспомогательный предикат для read_str/2, собирает символы в список.
r_str(10, A, A) :- !. % Символ новой строки завершает ввод
r_str(X, A, B) :- append(B, [X], B1), get0(X1), r_str(X1, A, B1).

% Удаляет первый элемент из списка, возвращая остаток.
del_1st([H|T], T).

% Проверяет, принадлежит ли элемент списку, и возвращает элементы по одному при бэктрекинге.
in_list([El|_], El).
in_list([_|T], El) :- in_list(T, El).

% Аналог in_list/2, но с использованием среза для остановки после первого совпадения.
in_list1([El|_], El) :- !.
in_list1([_|T], El) :- in_list1(T, El).

% Конкатенация двух списков, аналог стандартного append/3.
append1([], X, X) :- !.
append1([H|T], X, [H|Z]) :- append1(T, X, Z).


% Проверяет, есть ли вершина в списке вершин.
check_vertex([V1|_], V1) :- !.
check_vertex([_|T], V1) :- check_vertex(T, V1).


% Выбирает элемент из списка и возвращает список без этого элемента.
in_list_exlude([El|T], El, T).
in_list_exlude([H|T], El, [H|Tail]) :- in_list_exlude(T, El, Tail).


% Считывает граф: вершины и рёбра, возвращает списки вершин V и рёбер E.
get_graph_edges(V, E) :-
    get_V(V),
    write(V), nl,
    write("Edges"), nl,
    get_edges(V, E),
    write(E).


% Считывает количество вершин и вызывает get_V/2 для их чтения.
get_V(V) :-
    read(N),
    write("Vertexes"), nl,
    N1 is N + 1,
    get_V(V1, N1),
    del_1st(V1, V).


% Считывает вершины графа, преобразуя строки в атомы.
get_V([], 0) :- !.
get_V([H|T], N) :- 
    read_str(X),
    name(H, X),
    N1 is N - 1,
    get_V(T, N1).


% Считывает рёбра графа, проверяя, что вершины принадлежат списку V.
get_edges(V, E) :-
    read(M),
    get0(X),
    get_edges(V, E, [], M, 0).


% Вспомогательный предикат для get_edges/2, собирает M рёбер.
get_edges(V, E, E, M, M) :- !.
get_edges(V, E, Edges, M, Count) :-
    get_edge(V, Edge),
    append1(Edges, [Edge], E1),
    Count1 is Count + 1,
    get_edges(V, E, E1, M, Count1).


% Считывает одно ребро [V1, V2], проверяя, что V1 и V2 — вершины графа.
get_edge(V, [V1, V2]) :-
    write("Edge"), nl,
    read_str(X), name(V1, X), check_vertex(V, V1),
    read_str(Y), name(V2, Y), check_vertex(V, V2).


% Находит гамильтонов цикл в графе, если он существует.
gamilton :- get_graph_edges(V, E), gamilton(V, E).


% Проверяет существование гамильтонова цикла, используя перестановки вершин.
gamilton(V, E) :- b_a_r(V, W, Way), way_check(Way, E), write(Way).


% Проверяет, является ли путь гамильтоновым циклом (все рёбра существуют).
way_check([H|T], E) :- append1([H|T], [H], Way), w_c(Way, E).


% Проверяет, что последовательные вершины в пути соединены рёбрами.
w_c([_], _) :- !.
w_c([V1,V2|T], E) :- in_list1(E, [V1,V2]), w_c([V2|T], E).


% Находит эйлеров цикл в графе, если он существует.
euler :- get_graph_edges(V, E), euler(V, E).


% Проверяет существование эйлерова цикла, используя перестановки рёбер.
euler(V, E) :- b_a_r(E, W, Way), way_edge_check(Way), write(Way).


% Проверяет, что последовательность рёбер образует цикл.
way_edge_check([H|T]) :- append1([H|T], [H], Way), w_e_c(Way).


% Проверяет, что рёбра в пути соединены (конец одного ребра совпадает с началом следующего).
w_e_c([_]) :- !.
w_e_c([[_,X]|[[X|Y]|Tail]]) :- w_e_c([[X|Y]|Tail]).


% Находит эйлеров путь (не обязательно цикл) в графе.
euler_N :- get_graph_edges(V, E), euler_N(V, E).


% Проверяет существование эйлерова пути, используя перестановки рёбер.
euler_N(V, E) :- b_a_r(E, W, Way), way_edge_check_N(Way), write(Way).


% Проверяет, что последовательность рёбер образует путь.
way_edge_check_N([H|T]) :- append1([H|T], [H], Way), w_e_c_N(Way).


% Проверяет, что рёбра в пути соединены, учитывая возможную смену направления.
w_e_c_N([_]) :- !.
w_e_c_N([[_,X]|[[X,Y]|Tail]]) :- w_e_c_N([[X,Y]|Tail]).
w_e_c_N([[_,X]|[[Y,X]|Tail]]) :- w_e_c_N([[X,Y]|Tail]).


% Раскрашивает граф в K цветов, если это возможно.
raskras(K) :- get_graph_edges(V, E), make_ar(K, C), raskras(V, E, C, [], Itog), write(Itog).


% Создаёт список цветов от K до 1.
make_ar(0, []) :- !.
make_ar(K, [K|Tail]) :- K1 is K - 1, make_ar(K1, Tail).


% Раскрашивает вершины графа, проверяя допустимость цветов.
raskras([], _, C, Itog, Itog) :- !.
raskras([V|Vtail], E, C, Ras, Itog) :-
    in_list(C, Color), check_color(V, E, Color, Ras), append1(Ras, [[V,Color]], Ras1),
    raskras(Vtail, E, C, Ras1, Itog).


% Проверяет, что цвет вершины не конфликтует с цветами соседей.
check_color(_, _, _, []) :- !.
check_color(V, E, C1, [[_,C2]|Tail]) :- C1 \= C2, check_color(V, E, C1, Tail), !.
check_color(V, E, Col, [[Ver,Col]|Tail]) :-
    not(in_list1(E, [V,Ver])), not(in_list1(E, [Ver,V])),
    check_color(V, E, Col, Tail).


% Находит путь между двумя заданными вершинами графа.
make_way :-
    get_graph_edges(V, E),
    write("Otkuda"), nl, read_str(X), name(I, X),
    write("Kuda"), nl, read_str(Y), name(S, Y),
    make_way(V, E, I, S, Way),
    write_way(Way).


% Строит путь от вершины I до вершины S.
make_way(V, E, I, S, Way) :- in_list_exlude(V, I, Tail), make_way(Tail, E, I, S, [I], Way).
make_way(_, _, S, S, Way, Way) :- !.
make_way(V, E, I, S, Cur_Way, Way) :-
    in_list_exlude(V, X, Tail), in_list1(E, [I,X]),
    append1(Cur_Way, [X], C_W), make_way(Tail, E, X, S, C_W, Way).


% Выводит путь в читаемом виде.
write_way([V]) :- write(" "), write(V), write("."), !.
write_way([V|Tail]) :- write(" "), write(V), write(" -"), write_way(Tail).


% Вычисляет длину списка.
list_len([], 0) :- !.
list_len([_|T], L) :- list_len(T, L1), L is L1 + 1.


% Находит кратчайший путь между двумя вершинами графа.
short_way :-
    get_graph_edges(V, E),
    write("Otkuda"), nl, read_str(X), name(I, X),
    write("Kuda"), nl, read_str(Y), name(S, Y),
    list_len(V, Len),
    short_way(V, E, I, S, Way, Len + 1),
    write_way(Way).


% Вспомогательный предикат для short_way/0, ищет путь минимальной длины.
short_way(V, E, I, S, Way, Len) :-
    short_way(V, E, I, S, Way, _, Len).


% Ищет путь короче заданной длины Len.
short_way(V, E, I, S, Way, _, Len) :-
    make_way(V, E, I, S, Cur_Way1),
    list_len(Cur_Way1, L),
    L < Len,
    !,
    short_way(V, E, I, S, Way, Cur_Way1, L).
short_way(_, _, _, _, Way, Way, _).


% Генерирует перестановки списка (аналог permutation).
b_a_r([], Perm1, Perm1) :- !.
b_a_r(A, Perm, Perm1) :- in_list_exlude(A, El, A1), b_a_r(A1, [El|Perm], Perm1).