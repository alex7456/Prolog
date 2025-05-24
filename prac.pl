%сумма элементов списка вверх
sum([],0).
sum([H|T],S) :- 
    sum(T,S1),
    S is S1 + H.

%длина списка
len([],0).
len([_|T],N) :-
    len(T,N1),
    N is N1 + 1.


%сумма цифр вверх
sum_up(0,0).
sum_up(N,Sum) :-
    N>0,
    D is N mod 10,
    N1 is N // 10,
    sum_up(N1,sum1),
    sum is D + sum1.


%сумма цифр вниз
sum_down(N,Sum) :- sum_down(N,0,Sum).
sum_down(0,Acc,Acc).
sum_down(N,Acc,Sum) :-
    N>0,
    D is N mod 10,
    N1 is N // 10,
    NewAcc is Acc + D,
    sum_down(N1,NewAcc,Sum).


%факториал вверх
fac_up(0,1).
fac_up(N,F) :-
    N>0,
    N1 is N - 1,
    fac_up(N1,F1),
    F is N * F1.

%факториал вниз
fac_down(N,F) :- fac_down(N,0,F).
fac_down(0,Acc,Acc).
fac_down(N,Acc,F) :- 
    N>0,
    N1 is N-1,
    NewAcc is Acc * N,
    fac_down(N1,NewAcc,F).


%максимум из трех чисел
max(X,Y,Z,Max) :-
    X>=Y,X>=Z,Max = X, !.
max(_,Y,Z,Max) :-
    Y>=Z,Max=Y,!.
max(_,_,Z,Z).


%произведение цифр вниз
prdown(N,pr) :- prdown(N,1,pr).
prdown(0,Acc,Acc).
prdown(N,Acc,pr) :-
    N>0,
    D is N mod 10,
    N1 is N // 10,
    NewAcc is Acc * D,
    prdown(N1,NewAcc,pr).


%количество нечетных цифр больше трех
colnechet3(N,odd) :- colnechet3(N,0,odd).
colnechet3(0,Acc,Acc).
colnechet3(N,Acc,odd) :-
    N>0,
    D is N mod 10,
    N1 is N//10,
    (D mod 2 =:= 1, D > 3
    -> NewAcc is Acc + 1,
    ; NewAcc is Acc),
    colnechet3(N1,NewAcc,odd).

%максимальная цифра числа
maxdigit(N,Max) :- maxdigit(N,0,Max).
maxdigit(0,Acc,Acc).
maxdigit(N,Acc,Max) :- 
    N>0,
    D is N mod 10,
    N1 is N // 10,
    NewAcc is max(D,Acc),
    maxdigit(N1,NewAcc,Max).

%сочетания без повторений
combination(0, _ ,[]) :- !.
combination(K,[X|Xs],[Y|Ys]) :-
    K>0,
    K1 is K-1,
    combination(K1,Xs,Ys).
combination(K,[_|Xs], Ys) :-
    K>0,
    combination(K,Xs,Ys).



%сочетание с повторениями
combination(0,_,[]) :- !.
combination(K,[X|Xs],[X|Ys]) :-
    K>0,
    K1 is K - 1,
    combination(K1,[X|Xs],Ys).
combination(K,[_|Xs],Ys) :-
    K>0
    combination(K,Xs,Ys).

%размещение без повторений
arrangement(0,_,[]) :- !.
arrangement(K,List,[X|Xs]) :-
    K>0,
    select(X,List,Rest),
    K1 is K - 1,
    arrangement(K1,Rest,Xs)

%размещение с повторениями
arrangement(0,_,[]) :- !.
arrangement(K,List,[X|Xs]) :-
    K>0,
    member(X,List),
    K1 is K - 1,
    arrangement(K1,List,Xs).


%перестановки без повторений
permutuation([],[]).
permutuation(List,[X|Xs]) :-
    select(X,List,Rest),
    permutuation(Rest,Xs).

%перестановки с повторениями
permutuation([],[]).
permutuation(List,[X|Xs]) :-
    member(X,List),
    permutuation(List,Xs).

%nth0 получить элемент по индексу 0
nth0(0, [H|_], H).
nth0(N, [_|T], Elem) :-
    N > 0,
    N1 is N - 1,
    nth0(N1, T, Elem).


% реализация подмножеств
subset([], []).
subset([H|T], [H|R]) :- subset(T, R).
subset([_|T], R) :- subset(T, R).


%реализация append
my_append([],L,L).
my_append([H|T], L2, [H|R]) :-
    my_append(T,L2,R).

%реализация reverse
my_reverse([],[]).
my_reverse([H|T],Rev) :-
    my_reverse(T,RevT),
    append(RevT, [H] , Rev).

%реализация member
my_member(X,[X|_]).
my_member(X,[_|T]) :-
    my_member([X|T]).


%реализация length
my_length([], 0).
my_length([_|T], N) :-
    my_length(T, N1),
    N is N1 + 1.

%реализация select
my_select(X, [X|Xs], Xs).  
my_select(X, [Y|Ys], [Y|Rest]) :- 
    my_select(X, Ys, Rest).


