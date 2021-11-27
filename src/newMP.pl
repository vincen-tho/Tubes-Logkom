

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
sellMarket :- showInventoryBarang,
        write('What do you want to sell'), nl,
        read(Opt), nl,
        write('How many items do you want to sell'), nl,
        read(Qty), nl,
        sellaction(Opt, Qty).

sellaction(Opt, Qty) :-
    Idx is Opt - 1,
    inventory(Inv),
    getbarangNoZero(Idx, Inv, [Name, _]),
    addBarang(Name, -Qty),
    write(Name), write(' (x'), write(Qty),
    write(') Have been sold'), nl,
    barang(Name, Price, _),
    AddGold is Price * Qty,
    addGold(AddGold),
    write(AddGold), write(' Gold has been added').
        


/* buy items */
market :- 
    write('Welcome to the marketplace!!'), nl,
    write('What do you want to do?'), nl,
    write('1. buy'), nl,
    write('2. sell'), nl,
    write('3. leave'), nl,
    read(Command),
    ((Command == 'buy') -> buyMarket, fail;
    (Command == 'sell') -> sellMarket, fail;
    (Command == 'leave') -> !, fail;
    write('Wrong command')).

buyMarket :- createShop, displayShop,
        write('What do you want to buy'), nl,
        read(Opt), nl,
        Idx is Opt - 1,
        shop(S),
        getElmt(Idx, S, [Name | _]),
        (barang(Name, _, _) ->
        write('How many items do you want to buy'), nl,
        read(Qty);
        !
        ),
        buyaction(Opt, Qty).
        

buyaction(Opt, Qty) :-
    Idx is Opt -1,
    shop(S),
    getElmt(Idx, S, [Name, Price]),
    barang(Name, _, _),
    MinGold is Price*Qty,
    gold(G),
    ((G >= MinGold) -> 
    addGold(-MinGold),
    addBarang(Name, Qty),
    write(Name), write(' (x'), write(Qty),
    write(') have been added to your inventory'), nl,
    write(MinGold), write(' Gold has been deducted');

    write('Insufficient gold'), nl
    ), !.
    

buyaction(Opt, Qty) :-
    Idx is Opt -1,
    shop(S),
    getElmt(Idx, S, [Name, UpLvl, Price]),
    equipment(Name, _),
    MinGold is Price,

    gold(G),
    ((G >= MinGold) ->
    upgradeEquipment(Name),
    addGold(-MinGold),
    write(Name), write(' lv.'), write(UpLvl),
    write(' has been upgraded'), nl,
    write(MinGold), write(' Gold has been deducted');

    write('Insufficient gold'), nl
    ), !.








/* debug only */
