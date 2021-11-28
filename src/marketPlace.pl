

/* static shop */
:- dynamic(shop/1).

shop([]).

createShop :- retractall(shop(_)),
                assertz(shop(
                [
                    ['Tomato Seed', 75],
                    ['Rice Seed', 50],
                    ['Potato', 75],
                    ['Corn', 250],
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
    Name == 'Shovel',
    UpLv is (Level + 1),
    Price is UpLv*100,
    shop(S),
    append(S, [[Name, UpLv, Price]], NewS), !,
    retractall(shop(_)),
    assertz(shop(NewS)),
    addEQtoShop(Tail), !.
addEQtoShop([[Name, Level]|Tail]) :-
    Name == 'Bucket',
    UpLv is (Level + 1),
    Price is UpLv*200,
    shop(S),
    append(S, [[Name, UpLv, Price]], NewS), !,
    retractall(shop(_)),
    assertz(shop(NewS)),
    addEQtoShop(Tail), !.
addEQtoShop([[Name, Level]|Tail]) :-
    Name == 'Fishing Rod',
    UpLv is (Level + 1),
    Price is UpLv*300,
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
    getbarangNoZero(Idx, Inv, [Name, OldQty]),
    (   isNumValid(Qty, 1, OldQty) ->
        addBarang(Name, -Qty),
        write(Name), write(' (x'), write(Qty),
        write(') Have been sold'), nl,
        barang(Name, Price, _),
        isSellRanch(Name, Qty),
        AddGold is Price * Qty,
        addGold(AddGold),
        write(AddGold), write(' Gold has been added');

        write('You don\'t have that many')

    ), !.
        


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
    addBarang(Name, Qty),
    addGold(-MinGold),
    write(Name), write(' (x'), write(Qty),
    write(') have been added to your inventory'), nl,
    write(MinGold), write(' Gold has been deducted'),
    isNewRanch(Name, Qty)
    
    ;

    write('Insufficient gold'), nl
    ), !.    

buyaction(Opt, _) :-
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


isNewRanch(Name, Qty) :-
    Name == 'Sheep',
    newSheep(Qty), !.
isNewRanch(Name, Qty) :-
    Name == 'Cow',
    newCow(Qty), !.
isNewRanch(Name, Qty) :-
    Name == 'Chicken',
    newChicken(Qty), !.
isNewRanch(_, _).

isSellRanch(Name, Qty) :-
    Name == 'Sheep',
    sellSheep(Qty), !.
isSellRanch(Name, Qty) :-
    Name == 'Cow',
    sellCow(Qty), !.
isSellRanch(Name, Qty) :-
    Name == 'Chicken',
    sellChicken(Qty), !.
isSellRanch(_, _).







/* debug only */
