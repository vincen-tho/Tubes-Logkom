

/* static shop */
:- dynamic(shop/1).

shop([]).

createShop :- retractall(shop(_)),
                assertz(shop(
                [
                    ['Tomato Seed', 200],
                    ['Rice Seed', 200],
                    ['Potato', 200],
                    ['Corn', 200],
                    ['Chicken', 200],
                    ['Sheep', 200],
                    ['Cow', 200]
                ]



                )),
                addEQtoShop.

displayShop :- shop(S), displayShop(S, 1).
displayShop([], _) :- !.
displayShop([[Name, Price]|Tail], Num) :-
    barang(Name, _, _),
    write(Num), write('. '),
    write(Name), write(', Price: '), write(Price), write(' Gold'), nl, 
    NewNum is (1+Num),
    displayShop(Tail, NewNum), !.
displayShop([[Name, UpLv, Price]|Tail], Num) :-
    equipment(Name, _),
    write(Num), write('. '),
    write(Name), write(', lv.'), write(UpLv), write(', Price: '), write(Price), write(' Gold'), nl, 
    NewNum is (1+Num),
    displayShop(Tail, NewNum), !.

displayEQShop([], _) :- !.

displayEQShop([[Name, Level, Price]|Tail], Num) :-
    write(Num), write('. '),
    write(Name), write(', lv.'), write(Level), write(', Price: '), write(Price), write(' Gold'), nl, 
    NewNum is (1+Num),
    displayEQShop(Tail, NewNum), !.



/* add equipment to shop */
addEQtoShop :- inventory(Inv), addEQtoShop(Inv).

addEQtoShop([]) :- !.

addEQtoShop([[Name, Level]|Tail]) :-
    equipment(Name, _),
    UpLv is (Level + 1),
    Price is UpLv*100,
    shop(S),
    append(S, [[Name, UpLv, Price]], NewS), !,
    retractall(shop(_)),
    assertz(shop(NewS)),
    addEQtoShop(Tail), !.

addEQtoShop([[Name, _]|Tail]) :-
    \+ equipment(Name, _),
    addEQtoShop(Tail), !.


/* sell items */
sell :- showInventoryBarang,
        write('What do you want to sell'), nl,
        read(Opt), nl,
        write('How many items do you want to sell'), nl,
        read(Qty), nl.

sellaction(Opt, Qty) :- !.
        


/* buy items */
buy :- createShop, displayShop, !.