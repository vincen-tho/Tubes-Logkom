

:- dynamic(inventory/1).






/* change inventory */
changeInv(Inv) :- retractall(inventory(_)),
                assertz(inventory(Inv)).



/* show inventory to user */
/* show all inventory */
showInventory :- inventory(Inv), showInventoryFunction(Inv), !.
showInventoryFunction([]) :- !.
showInventoryFunction(Inv) :- write('Items: '), nl,
                displayInventoryItems(Inv, 1), nl,
                write('Equipments: '), nl,                
                displayInventoryEquipments(Inv, 1), !.
% ITEMS
displayInventoryItems([], _) :- !.
displayInventoryItems([[Name, Qty]|Tail], Num) :-
    NewNum is Num + 1,
    items(Name, Price, _),
    Qty =\= 0,
    write(Num), write('. '),
    write(Name), write('('), write(Qty), write(')'), write(', Price: '), write(Price), write(' Gold'), nl, 
    displayInventoryItems(Tail, NewNum), !.
displayInventoryItems([[Name, _]|Tail], Num) :-
    (\+ items(Name, _, _)),
    displayInventoryItems(Tail, Num), !.
displayInventoryItems([[Name, Qty]|Tail], Num) :-
    (items(Name, _, _)), Qty =:= 0,
    displayInventoryItems(Tail, Num), !.

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

/* show items only */
showItems :- inventory(Inv), showItemsFunction(Inv), !.
showItemsFunction([]) :- !.
showItemsFunction(Inv) :- write('Items: '), nl,
                displayInventoryItems(Inv, 1), nl, !.

/* show equipment only */
showEquipments :- inventory(Inv), showEquipmentsFunction(Inv), !.
showEquipmentsFunction([]) :- !.
showEquipmentsFunction(Inv) :- write('Equipments: '), nl,
                displayInventoryEquipments(Inv, 1), nl, !.

/* show farming inventory */
showFarmingInventory :- inventory(Inv), showFarmingInventoryFunction(Inv), !.
showFarmingInventoryFunction([]) :- !.
showFarmingInventoryFunction(Inv) :- write('Farming Items: '), nl,
                displayFarmingItems(Inv, 1), nl. 
                /*
                write('Farming Equipments: '), nl,                
                displayInventoryEquipments(Inv), !.
                */
                

/* display farming item and equipments */
displayFarmingItems([], _) :- !.
displayFarmingItems([[Name, Qty]|Tail], Num) :-
    NewNum is Num + 1,
    items(Name, Price, 'F'),
    Qty =\= 0,
    write(Num), write('. '),
    write(Name), write('('), write(Qty), write(')'), write(', Price: '), write(Price), write(' Gold'), nl, 
    displayFarmingItems(Tail, NewNum), !.
displayFarmingItems([[Name, _]|Tail], Num) :-
    (\+ items(Name, _, 'F')),
    displayFarmingItems(Tail, Num), !.
displayInventoryItems([[Name, Qty]|Tail], Num) :-
    (items(Name, _, 'F')), Qty =:= 0,
    displayFarmingItems(Tail, Num), !.



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


