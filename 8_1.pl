% Пол
man(ivan).
man(petr).
man(sergey).
man(dmitry).

woman(anna).
woman(olga).
woman(maria).
woman(natasha).

% Брак
married(ivan, anna).
married(petr, olga).
married(sergey, maria).

% Родители
parent(ivan, dmitry).
parent(anna, dmitry).
parent(petr, natasha).
parent(olga, natasha).
parent(sergey, anna).
parent(maria, anna).

men :- man(X), write(X), nl, fail.
men.

women :- woman(X), write(X), nl, fail.
women.


children(X, Y) :- parent(X, Y).


children(X) :- parent(X, Y), write(Y), nl, fail.
children(_).



mother(X, Y) :- woman(X), parent(X, Y).

mother(Y) :- parent(X, Y), woman(X), write(X), nl.


brother(X, Y) :-
    man(X),
    parent(Z, X),
    parent(Z, Y),
    X \= Y.

brothers(X) :-
    brother(Y, X),
    write(Y), nl, fail.
brothers(_).



b_s(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    X \= Y.

b_s(X) :-
    b_s(X, Y),
    write(Y), nl, fail.
b_s(_).



