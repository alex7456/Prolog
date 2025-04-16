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

grand_da(X, Y) :-
    woman(X),
    parent(Y, Z),
    parent(Z, X).


grand_dats(X) :-
    grand_da(Y, X),
    write(Y), nl,
    fail.
grand_dats(_).


grand_pa_and_da(X, Y) :-
    man(X), grand_da(Y, X).

grand_pa_and_da(X, Y) :-
    man(Y), grand_da(X, Y).

aunt(X, Y) :-
    woman(X),
    parent(GP, X),
    parent(GP, P),
    parent(P, Y),
    X \= P.

aunts(X) :-
    aunt(Y, X),
    write(Y), nl,
    fail.
aunts(_).
