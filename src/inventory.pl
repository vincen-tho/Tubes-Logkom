

:- dynamic(inventory/1).

showInventory(Inv) :- write('Items: '), nl,
                displayInventoryItems(Inv), nl,
                write('Equipments: '), nl,                
                displayInventoryEquipments(Inv), !.


                
displayInventoryItems([]) :- !.
displayInventoryItems([[Name, Qty]|Tail]) :-
    items(Name, Price),
    Qty =\= 0,
    write(Name), write('('), write(Qty), write(')'), write(', Price: '), write(Price), write(' Gold'), nl, 
    displayInventoryItems(Tail).
displayInventoryItems([[Name, Qty]|Tail]) :-
    ((\+ items(Name, _)); (Qty =:= 0)),
    displayInventoryItems(Tail).

displayInventoryEquipments([[Name, Level]|Tail]) :-
    equipment(Name),
    write(Name), write(', Lv.'), write(Level), nl, 
    displayInventoryEquipments(Tail).
displayInventoryEquipments([[Name, _]|Tail]) :-
    \+ equipment(Name), 
    displayInventoryEquipments(Tail).





/* change inventory */
changeInv(Inv) :- retractall(inventory(_)),
                assertz(inventory(Inv)).




/* Debug Only */

initInv :- retractall(inventory(_)),
            assertz(inventory([['Dung', 3], ['Egg', 0], ['Shovel', 3], ['Milk', 11], ['Water Sprinkler', 1]])).

test :- initInv, inventory(X), showInventory(X).
