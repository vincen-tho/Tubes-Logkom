
/* equipmentShop(X, Y, Z), X adalah nama eq, Y adalah level upgrade, Z adalah harga */
:- dynamic(eqShop/1). 

/* baranghop(X, Y), X adalah nama barang, Y adalah Price */
baranghop([['Rice Seed', 200], ['Tomato Seed', 150], ['Potato', 350]]).
eqShop([]).


% displaybaranghop([['Rice Seed', 200], ['Tomato Seed', 150], ['Potato', 350]]).


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


/* sell barang */


sellbarang(Opt, Qty) :- 
    inventory(I),
    Idx is Opt-1,
    getbarangNoZero(Idx, I, [ResN, ResQ]),
   member([ResN, ResQ], I),
            NewQ is (ResQ - Qty),
            delete(I, [ResN, ResQ], TempI),
            append(TempI, [[ResN, NewQ]], NewI),
            changeInv(NewI).

/* buy barang */
buy :- initShop, baranghop(IS), write('barang: '), nl, displaybaranghop(IS, 1), nl, write('Equipments: '), nl, eqShop(EQS), displayEQShop(EQS, 1),
    nl, write('What do you want to buy (0 to cancel)? '),
    read(X),
    nl, write('How many barang do you want to buy? '),
    read(Q),
    buybarang(X, Q).

buybarang(X, Q) :- 
    baranghop(IS),
    inventory(I),
    Idx is X-1,
    getElmt(Idx, IS, [ResN, _]),

    (member([ResN, ResQ], I) ->
            NewQ is (ResQ + Q),
            delete(I, [ResN, ResQ], TempI),
            append(TempI, [[ResN, NewQ]], NewI),
            changeInv(NewI),
            (ResN == 'Cow') -> newCow(Q);
            (ResN == 'Sheep') -> newSheep(Q);
            (ResN == 'Chicken') -> newChicken(Q);
            
        ;
            append(I, [[ResN, Q]], NewI),
            changeInv(NewI)
    ).
    

            

/* FUNCTION */






/* debug only */
% eqShop([['Shovel', 10, 15], ['Bucket', 11, 16]]).
initShop :- retractall(eqShop(_)), assertz(eqShop([])), inventory(Inv), createEQShop(Inv), !.





displaybaranghop([], _) :- !.

displaybaranghop([[Name, Price]|Tail], Num) :-
    write(Num), write('. '),
    write(Name), write(', Price: '), write(Price), write(' Gold'), nl, 
    NewNum is (1+Num),
    displaybaranghop(Tail, NewNum), !.

displayEQShop([], _) :- !.

displayEQShop([[Name, Level, Price]|Tail], Num) :-
    write(Num), write('. '),
    write(Name), write(', lv.'), write(Level), write(', Price: '), write(Price), write(' Gold'), nl, 
    NewNum is (1+Num),
    displayEQShop(Tail, NewNum), !.

