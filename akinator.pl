% Questions
question1(X1):- write("Is the club from England? (1 - Yes, 0 - No)"), nl, read(X1).
question2(X2):- write("Has the club won the UEFA Champions League? (1 - Yes, 0 - No)"), nl, read(X2).
question3(X3):- write("Does the club have balondor players right now? (1 - Yes, 0 - No)"), nl, read(X3).
question4(X4):- write("Is the main color red? (1 - Yes, 0 - No)"), nl, read(X4).
question5(X5):- write("Was the club founded before 1900? (1 - Yes, 0 - No)"), nl, read(X5).
question6(X6):- write("Is the club known for a big derby? (1 - Yes, 0 - No)"), nl, read(X6).

% Knowledge base
club(manchester_united, 1, 1, 0, 1, 1, 1).
club(chelsea, 1, 1, 0, 0, 0, 1).
club(liverpool, 1, 1, 0, 1, 1, 0).
club(arsenal, 1, 0, 0, 1, 1, 1).
club(tottenham, 1, 0, 0, 1, 1, 1).
club(manchester_city, 1, 1, 1, 0, 0, 1).
club(real_madrid, 0, 1, 1, 0, 1, 1).
club(barcelona, 0, 1, 0, 0, 1, 1).
club(atletico_madrid, 0, 0, 0, 1, 1, 1).
club(bayern_munich, 0, 1, 0, 1, 1, 1).
club(borussia_dortmund, 0, 1, 0, 1, 1, 1).
club(psg, 0, 0, 0, 0, 0, 1).
club(ac_milan, 0, 1, 0, 1, 1, 1).
club(inter_milan, 0, 1, 0, 0, 1, 1).
club(juventus, 0, 1, 0, 0, 1, 1).
club(napoli, 0, 0, 0, 1, 1, 1).
club(ajax, 0, 1, 0, 0, 1, 0).
club(benfica, 0, 1, 0, 1, 1, 0).
club(porto, 0, 1, 0, 0, 1, 0).
club(celtic, 0, 1, 0, 1, 1, 1).
club(rangers, 0, 0, 0, 0, 1, 1).
club(zenit, 0, 0, 0, 0, 0, 0).
club(shakhtar_donetsk, 0, 0, 0, 1, 0, 0).
club(krasnodar, 0, 0, 0, 0, 0, 0).
club(galatasaray, 0, 1, 0, 1, 1, 1).
club(fenerbahce, 0, 0, 0, 1, 1, 1).
club(besiktas, 0, 0, 0, 1, 1, 1).
club(anderlecht, 0, 0, 0, 1, 1, 0).
club(olympiakos, 0, 0, 0, 1, 1, 0).
club(sevilla, 0, 1, 0, 1, 1, 1).

% Main predicate
guess_club :-
    question1(X1), question2(X2), question3(X3),
    question4(X4), question5(X5), question6(X6),
    club(Name, X1, X2, X3, X4, X5, X6),
    nl, write("Your club is: "), write(Name), nl.