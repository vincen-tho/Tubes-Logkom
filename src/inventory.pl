

:- dynamic(inventory/1).






/* change inventory */
changeInv(Inv) :- retractall(inventory(_)),
                assertz(inventory(Inv)).



/* display and initialize */
showInventory([]) :- !.
showInventory(Inv) :- write('Items: '), nl,
                displayInventoryItems(Inv, 1), nl,
                write('Equipments: '), nl,                
                displayInventoryEquipments(Inv), !.


                
displayInventoryItems([], _) :- !.
displayInventoryItems([[Name, Qty]|Tail], Num) :-
    NewNum is Num + 1,
    items(Name, Price, _),
    Qty =\= 0,
    write(Num), write('. '),
    write(Name), write('('), write(Qty), write(')'), write(', Price: '), write(Price), write(' Gold'), nl, 
    displayInventoryItems(Tail, NewNum), !.
displayInventoryItems([[Name, Qty]|Tail], Num) :-
    (\+ items(Name, _, _)),
    displayInventoryItems(Tail, Num), !.
displayInventoryItems([[Name, Qty]|Tail], Num) :-
    (items(Name, _, _)), Qty =:= 0,
    displayInventoryItems(Tail, Num), !.

displayInventoryEquipments([]) :- !.
displayInventoryEquipments([[Name, Level]|Tail]) :-
    equipment(Name, _), Level =\= 0,
    write(Name), write(', Lv.'), write(Level), nl, 
    displayInventoryEquipments(Tail), !.

displayInventoryEquipments([[Name, Level]|Tail]) :-
    equipment(Name, _), Level =:= 0,
    displayInventoryEquipments(Tail), !.

displayInventoryEquipments([[Name, Level]|Tail]) :-
    (\+ equipment(Name, _)),
    displayInventoryEquipments(Tail), !.

/* Debug Only */

initInv :- retractall(inventory(_)),
            assertz(inventory(

                [
                ['TEST', 3],
                ['Dung', 3],
                ['Egg', 0],
                ['Milk', 11],
                ['Water Sprinkler', 1],
                ['Shovel', 1],
                ['Shearer', 0],
                ['Bucket', 0],
                ['Fishing Rod', 0],
                ['Bait', 0],
                ['Rice Seed', 5]
                
                ]
                
                )).


