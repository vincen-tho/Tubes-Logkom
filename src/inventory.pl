

:- dynamic(inventory/1).

inventory :- showInventory, !.






/* change inventory */
changeInv(Inv) :- retractall(inventory(_)),
                assertz(inventory(Inv)).



/* show inventory to user */
/* show all inventory */
showInventory :- inventory(Inv), showInventoryFunction(Inv), !.
showInventoryFunction([]) :- !.
showInventoryFunction(Inv) :- write('Your inventory: '), nl,
                displayInventory(Inv, 1), nl.

displayInventory([], _) :- !.
displayInventory([[Name, Qty]|Tail], Num) :-
    barang(Name, Price, _),
    NewNum is Num + 1,
    Qty =\= 0,
    write(Num), write('. '),
    write(Name), write('('), write(Qty), write(')'), write(', Price: '), write(Price), write(' Gold'), nl, 
    displayInventory(Tail, NewNum), !.
displayInventory([[Name, Lvl]|Tail], Num) :-
    equipment(Name, _), Lvl =\= 0,
    NewNum is Num + 1,
    write(Num), write('. '),
    write(Name), write(', Lv.'), write(Lvl), nl, 
    displayInventory(Tail, NewNum), !.
displayInventory([[Name, QtyLvl]|Tail], Num) :-
    QtyLvl =:= 0,
    displayInventory(Tail, Num), !.



/* barang dan equipment */

showInventoryBarang :- inventory(X), displayInventorybarang(X, 1), !.

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
                ['Rice Seed', 5],
                ['Potato', 15],

                ['Shearer', 0],
                ['Bucket', 0],
                ['Fishing Rod', 0],
                ['Bait', 0]    
                ]
                
                )).




test :- initInv, assertz(gold(500)), showInventory.




/* mengganti quantity barang */
changeBarang(Name, NewQty) :-
    inventory(I),
   member([Name, Qty], I),
            delete(I, [Name, Qty], TempI),
            append(TempI, [[Name, NewQty]], NewI),
            changeInv(NewI), !.


/* menambahkan barang, negatif untuk mengurangkan */
addBarang(Name, AddQty) :- 
inventory(I),
    (member([Name, Qty], I) ->
        NewQty is AddQty + Qty,
        changeBarang(Name, NewQty)
        ;
    append(I, [[Name, AddQty]], NewI),
    changeInv(NewI)
    ).

/* remove barang sepenuhnya */
removeBarang(Name) :-
    changeBarang(Name, 0).

/* mengganti level equipment */
changeEquipment(Name, NewLvl) :-
    inventory(I),
   member([Name, Lvl], I),
            delete(I, [Name, Lvl], TempI),
            append(TempI, [[Name, NewLvl]], NewI),
            changeInv(NewI), !.

/* upgrade level equipment */
upgradeEquipment(Name) :-
    inventory(I),
    member([Name, Lvl], I),
    NewLvl is (Lvl + 1),
    changeEquipment(Name, NewLvl), !.

/* remove equipment (set to lv.0) */
removeEquipment(Name) :-
    changeEquipment(Name, 0), !.






