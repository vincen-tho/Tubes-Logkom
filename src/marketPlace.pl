
/* equipmentShop(X, Y, Z), X adalah nama eq, Y adalah level upgrade, Z adalah harga */
:- dynamic(eqShop/1). 

/* itemShop(X, Y), X adalah nama item, Y adalah Price */
itemShop([['Rice Seed', 200], ['Potato', 350], ['Tomato Seed', 150]]).
eqShop([]).


% displayItemShop([['Rice Seed', 200], ['Potato', 350], ['Tomato Seed', 150]]).


/* Create EQ Shop based on equipments in inventory */
createEQShop([]) :- !.

/* need to be set manually each EQ */
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









/*
buy :- !.
sell :- !.
*/


sell :- inventory(Inv), displayInventoryItems(Inv, 1),
    write('What item do you want to sell? '),
    read(Opt), nl,
    write('How many items do you want to sell'), nl,
    read(Qty), nl,
    sellAction(Opt, Qty).

sellAction(Opt, Qty) :- 
    inventory(I),
    Idx is Opt-1,
    getElmtNoZero(Idx, I, Res),
    getElmt(0, Res, ResN),
    (member([ResN, ResQ], I)),
            NewQ is (ResQ - Qty),
            delete(I, [ResN, ResQ], TempI),
            append(TempI, [[ResN, NewQ]], NewI),
            retractall(inventory(_)),
            assertz(inventory(NewI)).
            

/* FUNCTION */
getElmt(0, [Head|Tail], Res) :-
    Res = Head, !.
getElmt(Idx, [Head|Tail], Res) :-
    NewIdx is (Idx-1),
    getElmt(NewIdx, Tail, Res).

getElmtNoZero(0, [[Name, Qty]|Tail], Res) :-
    Qty =\= 0,
    items(Name, _),
    Res = [Name, Qty], !.
getElmtNoZero(Idx, [[Name, Qty]|Tail], Res) :-
    Qty =\= 0,
    items(Name, _),
    NewIdx is (Idx-1),
    getElmtNoZero(NewIdx, Tail, Res).

getElmtNoZero(Idx, [[Name, Qty]|Tail], Res) :-
    Qty =:= 0,
    getElmtNoZero(Idx, Tail, Res).
getElmtNoZero(Idx, [[Name, Qty]|Tail], Res) :-
    \+ items(Name, _),
    getElmtNoZero(Idx, Tail, Res).

    % inventory(X), getElmt(0, X, Res), write(Res).

/* debug only */
% eqShop([['Shovel', 10, 15], ['Bucket', 11, 16]]).
initShop :- retractall(eqShop(_)), assertz(eqShop([])), inventory(Inv), createEQShop(Inv), !.


buyAction(X, Q) :- 
    itemShop(IS),
    inventory(I),
    Idx is X-1,
    getElmt(Idx, IS, Res),
    getElmt(0, Res, ResN),

    (member([ResN, ResQ], I)) ->
            NewQ is (ResQ + Q),
            delete(I, [ResN, ResQ], TempI),
            append(TempI, [[ResN, NewQ]], NewI),
            retractall(inventory(_)),
            assertz(inventory(NewI))
        ;
            append(I, [[ResN, Q]], NewI),
            retractall(inventory(_)),
            assertz(inventory(NewI)).




buy :- initShop, itemShop(IS), write('Items: '), nl, displayItemShop(IS, 1), nl, write('Equipments: '), nl, eqShop(EQS), displayEQShop(EQS, 1),
    nl, write('What do you want to buy (0 to cancel)? '),
    read(X),
    nl, write('How many items do you want to buy? '),
    read(Q),
    buyAction(X, Q).

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