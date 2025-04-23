faculty(math).    
faculty(physics). 
faculty(chem).   

solution :-
    faculty(Peter), faculty(Roman), faculty(Sergey),
    all_different([Peter, Roman, Sergey]),
    
    (Peter == math -> Sergey \= physics ; true),
    
    (Roman \= physics -> Peter == math ; true),
    
    (Sergey \= math -> Roman == chem ; true),
    
    
    format('Петр учится на ~w факультете~n', [Peter]),
    format('Роман учится на ~w факультете~n', [Roman]),
    format('Сергей учится на ~w факультете~n', [Sergey]),
    
    format('~nОтвет: Роман учится на ~w факультете~n', [Roman]).

all_different([]).
all_different([H|T]) :- \+ member(H, T), all_different(T).

:- solution.