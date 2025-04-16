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


father(X, Y) :- man(X), parent(X, Y).
father(X) :- parent(Y, X), man(Y), write(Y), nl.
wife(X, Y) :- woman(X), (married(X, Y); married(Y, X)).
wife(X) :- married(X, Y), woman(Y), write(Y), nl.
wife(X) :- married(Y, X), woman(Y), write(Y), nl.
