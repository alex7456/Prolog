% Permutations

delete(X, [X|T], T).

delete(X, [H|T], [H|Rest]) :- 
    delete(X, T, Rest).

permutation([], []).

permutation([H|T], Result) :-
    permutation(T, ResultT),
    delete(H, Result, ResultT).

permutation_repeat([H|T], UniqResult) :-
    setof(Template, permutation([H|T], Template), UniqResult).


% Combinations

combination(0, _, []).

combination(K, [H|T], [H|Comb]) :-
    K > 0,
    KNext is K - 1,
    combination(KNext, T, Comb).

combination(K, [_|T], Comb) :-
    K > 0,
    combination(K, T, Comb).

combination_repeat(0, _, []).

combination_repeat(K, [H|T], [H|Comb]) :-
    K > 0,
    KNext is K - 1,
    combination_repeat(KNext, [H|T], Comb).

combination_repeat(K, [_|T], Comb) :-
    K > 0,
    combination_repeat(K, T, Comb).


% Arranegments

pick(_, []) :- false.
pick(H, [H|_]).
pick(X, [_|T]) :- pick(X, T).


arrangement(0, _, []).

arrangement(K, List, [H|T]) :-
    K > 0,
    delete(H, List, Rest),
    KNext is K - 1,
    arrangement(KNext, Rest, T).

arrangement_repeat(0, _, []).
    
arrangement_repeat(K, List, [H|T]) :-
    K > 0,
    pick(H, List),
    KNext is K - 1,
    arrangement_repeat(KNext, List, T).