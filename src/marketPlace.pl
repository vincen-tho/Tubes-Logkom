
/* equipmentShop(X, Y, Z), X adalah nama eq, Y adalah level upgrade, Z adalah harga */
:- dynamic(eqShop/1). 

/* itemShop(X, Y), X adalah nama item, Y adalah Price */
itemShop([['Rice Seed', 200], ['Potato', 350], ['Tomato Seed', 150]]).
eqShop([]).


% displayItemShop([['Rice Seed', 200], ['Potato', 350], ['Tomato Seed', 150]]).


createEQShop([[Name, Level]|Tail]) :-
    equipment(Name),
    UpLv is (Level + 1),
    Price is UpLv*100,
    eqShop(EQS),
    append(EQS, [[Name, UpLv, Price]], NewEQS), !,
    retractall(eqShop(_)),
    assertz(eqShop(NewEQS)),
    createEQShop(Tail), !.

createEQShop([[Name, _]|Tail]) :-
    \+ equipment(Name),
    createEQShop(Tail), !.










buy :- !.
sell :- !.

/* debug only */
% eqShop([['Shovel', 10, 15], ['Bucket', 11, 16]]).
initShop :- inventory(Inv), createEQShop(Inv), !.

displayShop :- itemShop(IS), displayItemShop(IS), nl, eqShop(EQS), displayEQShop(EQS).

displayItemShop([]) :- !.

displayItemShop([[Name, Price]|Tail]) :-
    write(Name), write(', Price: '), write(Price), write(' Gold'), nl, 
    displayItemShop(Tail), !.

displayEQShop([]) :- !.

displayEQShop([[Name, Level, Price]|Tail]) :-
    write(Name), write(', lv.'), write(Level), write(', Price: '), write(Price), write(' Gold'), nl, 
    displayEQShop(Tail), !.

test :- initInv, inventory(X), showInventory(X), initShop.