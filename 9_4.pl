profession(slesar).   % слесарь
profession(tokar).    % токарь
profession(svarshik). % сварщик

surname(borisov).     % Борисов
surname(ivanov).      % Иванов
surname(semenov).     % Семенов

solve(Slesar, Tokar, Svarshik) :-
    profession(Slesar), profession(Tokar), profession(Svarshik),
    all_different([Slesar, Tokar, Svarshik]),
    
    surname(SlesarSurname), surname(TokarSurname), surname(SvarshikSurname),
    all_different([SlesarSurname, TokarSurname, SvarshikSurname]),
    
    
    SlesarSurname \= borisov,
    
    
    SlesarSurname \= semenov,
    TokarSurname \= semenov,
    SvarshikSurname \= semenov,
    
    
    

    (SlesarSurname = ivanov; SlesarSurname = borisov; SlesarSurname = semenov),
    (TokarSurname = ivanov; TokarSurname = borisov; TokarSurname = semenov),
    (SvarshikSurname = ivanov; SvarshikSurname = borisov; SvarshikSurname = semenov),
    
    
    SlesarSurname \= borisov,   % так как у Борисова есть сестра
    SlesarSurname \= semenov,   % так как Семенов старше токаря
    TokarSurname \= semenov,    % так как Семенов старше токаря
    SvarshikSurname = semenov.  % единственный оставшийся вариант для Семенова

all_different([]).
all_different([H|T]) :- \+ member(H, T), all_different(T).

solution :-
    solve(Slesar, Tokar, Svarshik),
    write('Слесарь: '), write(Slesar), write(', '), write(Slesar), nl,
    write('Токарь: '), write(Tokar), write(', '), write(Tokar), nl,
    write('Сварщик: '), write(Svarshik), write(', '), write(Svarshik), nl.