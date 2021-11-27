

:- dynamic(inventory/1).

inventory :- showInventory.






/* change inventory */
changeInv(Inv) :- retractall(inventory(_)),
                assertz(inventory(Inv)).



/* show inventory to user */
/* show all inventory */
showInventory :- inventory(Inv), showInventoryFunction(Inv), !.
showInventoryFunction([]) :- !.
showInventoryFunction(Inv) :- write('barang: '), nl,
                displayInventorybarang(Inv, 1), nl,
                write('Equipments: '), nl,                
                displayInventoryEquipments(Inv, 1), !.
% barang
displayInventorybarang([], _) :- !.
displayInventorybarang([[Name, Qty]|Tail], Num) :-
    NewNum is Num + 1,
    barang(Name, Price, _),
    Qty =\= 0,
    write(Num), write('. '),
    write(Name), write('('), write(Qty), write(')'), write(', Price: '), write(Price), write(' Gold'), nl, 
    displayInventorybarang(Tail, NewNum), !.
displayInventorybarang([[Name, _]|Tail], Num) :-
    (\+ barang(Name, _, _)),
    displayInventorybarang(Tail, Num), !.
displayInventorybarang([[Name, Qty]|Tail], Num) :-
    (barang(Name, _, _)), Qty =:= 0,
    displayInventorybarang(Tail, Num), !.

% EQUIPMENTS
displayInventoryEquipments([], _) :- !.
displayInventoryEquipments([[Name, Level]|Tail], Num) :-
    NewNum is Num + 1,
    equipment(Name, _), Level =\= 0,
    write(Num), write('. '),
    write(Name), write(', Lv.'), write(Level), nl, 
    displayInventoryEquipments(Tail, NewNum), !.

displayInventoryEquipments([[Name, Level]|Tail], Num) :-
    equipment(Name, _), Level =:= 0,
    displayInventoryEquipments(Tail, Num), !.

displayInventoryEquipments([[Name, _]|Tail], Num) :-
    (\+ equipment(Name, _)),
    displayInventoryEquipments(Tail, Num), !.

/* show barang only */
showbarang :- inventory(Inv), showbarangFunction(Inv), !.
showbarangFunction([]) :- !.
showbarangFunction(Inv) :- write('barang: '), nl,
                displayInventorybarang(Inv, 1), nl, !.

/* show equipment only */
showEquipments :- inventory(Inv), showEquipmentsFunction(Inv), !.
showEquipmentsFunction([]) :- !.
showEquipmentsFunction(Inv) :- write('Equipments: '), nl,
                displayInventoryEquipments(Inv, 1), nl, !.

/* show farming inventory */
showFarmingInventory :- inventory(Inv), showFarmingInventoryFunction(Inv), !.
showFarmingInventoryFunction([]) :- !.
showFarmingInventoryFunction(Inv) :- write('Farming barang: '), nl,
                displayFarmingbarang(Inv, 1), nl. 
                /*
                write('Farming Equipments: '), nl,                
                displayInventoryEquipments(Inv), !.
                */
                

/* display farming item and equipments */
displayFarmingbarang([], _) :- !.
displayFarmingbarang([[Name, Qty]|Tail], Num) :-
    NewNum is Num + 1,
    barang(Name, Price, 'F'),
    Qty =\= 0,
    write(Num), write('. '),
    write(Name), write('('), write(Qty), write(')'), write(', Price: '), write(Price), write(' Gold'), nl, 
    displayFarmingbarang(Tail, NewNum), !.
displayFarmingbarang([[Name, _]|Tail], Num) :-
    (\+ barang(Name, _, 'F')),
    displayFarmingbarang(Tail, Num), !.
displayInventorybarang([[Name, Qty]|Tail], Num) :-
    (barang(Name, _, 'F')), Qty =:= 0,
    displayFarmingbarang(Tail, Num), !.



/* Debug Only */

initInv :- retractall(inventory(_)),
            assertz(inventory(

                [
                ['Dung', 3],
                ['Egg', 0],
                ['Milk', 11],
                ['Water Sprinkler', 1],
                ['Shovel', 1],
                ['Shearer', 0],
                ['Bucket', 0],
                ['Fishing Rod', 0],
                ['Bait', 0],
                ['Rice Seed', 5],
                ['Potato', 15]
                
                ]
                
                )).


