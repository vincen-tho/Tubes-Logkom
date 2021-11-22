
/* equipmentShop(X, Y, Z), X adalah nama eq, Y adalah level upgrade, Z adalah harga */
:- dynamic(eqShop/1). 

/* itemShop(X, Y), X adalah nama item, Y adalah Price */
itemShop([['Rice Seed', 200], ['Tomato Seed', 150], ['Potato', 350]]).
eqShop([]).


% displayItemShop([['Rice Seed', 200], ['Tomato Seed', 150], ['Potato', 350]]).


/* Create EQ Shop based on equipments in inventory */
createEQShop([]) :- !.

/* need to be set manually each EQ */
createEQShop([[Name, Level]|Tail]) :-
    equipment(Name, _),
    UpLv is (Level + 1),
    Price is UpLv*100,
    eqShop(EQS),
    append(EQS, [[Name, UpLv, Price]], NewEQS), !,
    retractall(eqShop(_)),
    assertz(eqShop(NewEQS)),
    createEQShop(Tail), !.

createEQShop([[Name, _]|Tail]) :-
    \+ equipment(Name, _),
    createEQShop(Tail), !.









/*
buy :- !.
sell :- !.
*/


/* sell item */
sell :- inventory(Inv), displayInventoryItems(Inv, 1),
    write('What item do you want to sell? '),
    read(Opt), nl,
    write('How many items do you want to sell'), nl,
    read(Qty), nl,
    sellItem(Opt, Qty).

sellItem(Opt, Qty) :- 
    inventory(I),
    Idx is Opt-1,
    getItemNoZero(Idx, I, [ResN, ResQ]),
   member([ResN, ResQ], I),
            NewQ is (ResQ - Qty),
            delete(I, [ResN, ResQ], TempI),
            append(TempI, [[ResN, NewQ]], NewI),
            changeInv(NewI).

/* buy item */
buy :- initShop, itemShop(IS), write('Items: '), nl, displayItemShop(IS, 1), nl, write('Equipments: '), nl, eqShop(EQS), displayEQShop(EQS, 1),
    nl, write('What do you want to buy (0 to cancel)? '),
    read(X),
    nl, write('How many items do you want to buy? '),
    read(Q),
    buyItem(X, Q).

buyItem(X, Q) :- 
    itemShop(IS),
    inventory(I),
    Idx is X-1,
    getElmt(Idx, IS, [ResN, ResP]),

    (member([ResN, ResQ], I) ->
            NewQ is (ResQ + Q),
            delete(I, [ResN, ResQ], TempI),
            append(TempI, [[ResN, NewQ]], NewI),
            changeInv(NewI)
        ;
            append(I, [[ResN, Q]], NewI),
            changeInv(NewI)
    ).
    

            

/* FUNCTION */






/* debug only */
% eqShop([['Shovel', 10, 15], ['Bucket', 11, 16]]).
initShop :- retractall(eqShop(_)), assertz(eqShop([])), inventory(Inv), createEQShop(Inv), !.





displayItemShop([], _) :- !.

displayItemShop([[Name, Price]|Tail], Num) :-
    write(Num), write('. '),
    write(Name), write(', Price: '), write(Price), write(' Gold'), nl, 
    NewNum is (1+Num),
    displayItemShop(Tail, NewNum), !.

displayEQShop([], _) :- !.

displayEQShop([[Name, Level, Price]|Tail], Num) :-
    write(Num), write('. '),
    write(Name), write(', lv.'), write(Level), write(', Price: '), write(Price), write(' Gold'), nl, 
    NewNum is (1+Num),
    displayEQShop(Tail, NewNum), !.

test :- initInv, inventory(X), showInventory(X), initShop.

disInv :- inventory(X), showInventory(X).