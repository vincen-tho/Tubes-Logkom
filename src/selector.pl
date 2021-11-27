/* get Element from any list */
getElmt(0, [Head|_], Res) :-
    Res = Head, !.
getElmt(Idx, [_|Tail], Res) :-
    NewIdx is (Idx-1),
    getElmt(NewIdx, Tail, Res).

/* get element from inventory (barang only (barang) and Quantity not 0) */
getbarangNoZero(_, [], _) :- !.
getbarangNoZero(0, [[_, Qty]|Tail], Res) :-
    Qty =:= 0,
    getbarangNoZero(0, Tail, Res), !.
getbarangNoZero(0, [[Name, Qty]|_], Res) :-
    Qty =\= 0,
    barang(Name, _, _),
    Res = [Name, Qty], !.
getbarangNoZero(Idx, [[Name, Qty]|Tail], Res) :-
    Idx =\= 0,
    Qty =\= 0,
    barang(Name, _, _),
    NewIdx is (Idx-1),
    getbarangNoZero(NewIdx, Tail, Res), !.
getbarangNoZero(Idx, [[Name, Qty]|Tail], Res) :-
    barang(Name, _, _),
    Qty =:= 0,
    getbarangNoZero(Idx, Tail, Res), !.
getbarangNoZero(Idx, [[Name, _]|Tail], Res) :-
    \+ barang(Name, _, _),
    getbarangNoZero(Idx, Tail, Res), !.

/* get element from inventory (farming barang (barang) only) */
getFarmingbarang(_, [], _) :- !.
getFarmingbarang(0, [[_, Qty]|Tail], Res) :-
    Qty =:= 0,
    getFarmingbarang(0, Tail, Res), !.
getFarmingbarang(0, [[Name, Qty]|_], Res) :-
    Qty =\= 0,
    barang(Name, _, 'F'),
    Res = [Name, Qty], !.
getFarmingbarang(Idx, [[Name, Qty]|Tail], Res) :-
    Idx =\= 0,
    Qty =\= 0,
    barang(Name, _, 'F'),
    NewIdx is (Idx-1),
    getFarmingbarang(NewIdx, Tail, Res), !.
getFarmingbarang(Idx, [[Name, Qty]|Tail], Res) :-
    barang(Name, _, 'F'),
    Qty =:= 0,
    getFarmingbarang(Idx, Tail, Res), !.
getFarmingbarang(Idx, [[Name, _]|Tail], Res) :-
    \+ barang(Name, _, 'F'),
    getFarmingbarang(Idx, Tail, Res), !.

/* get element from inventory (ranching (barang)  barang only) */
getRanchingbarang(_, [], _) :- !.
getRanchingbarang(0, [[_, Qty]|Tail], Res) :-
    Qty =:= 0,
    getRanchingbarang(0, Tail, Res), !.
getRanchingbarang(0, [[Name, Qty]|_], Res) :-
    Qty =\= 0,
    barang(Name, _, 'R'),
    Res = [Name, Qty], !.
getRanchingbarang(Idx, [[Name, Qty]|Tail], Res) :-
    Idx =\= 0,
    Qty =\= 0,
    barang(Name, _, 'R'),
    NewIdx is (Idx-1),
    getRanchingbarang(NewIdx, Tail, Res), !.
getRanchingbarang(Idx, [[Name, Qty]|Tail], Res) :-
    barang(Name, _, 'R'),
    Qty =:= 0,
    getRanchingbarang(Idx, Tail, Res), !.
getRanchingbarang(Idx, [[Name, _]|Tail], Res) :-
    \+ barang(Name, _, 'R'),
    getRanchingbarang(Idx, Tail, Res), !.

/* get element from inventory (fishing barang only) */
getFishingbarang(_, [], _) :- !.
getFishingbarang(0, [[_, Qty]|Tail], Res) :-
    Qty =:= 0,
    getFishingbarang(0, Tail, Res), !.
getFishingbarang(0, [[Name, Qty]|_], Res) :-
    Qty =\= 0,
    barang(Name, _, 'H'),
    Res = [Name, Qty], !.
getFishingbarang(Idx, [[Name, Qty]|Tail], Res) :-
    Idx =\= 0,
    Qty =\= 0,
    barang(Name, _, 'H'),
    NewIdx is (Idx-1),
    getFishingbarang(NewIdx, Tail, Res), !.
getFishingbarang(Idx, [[Name, Qty]|Tail], Res) :-
    barang(Name, _, 'H'),
    Qty =:= 0,
    getFishingbarang(Idx, Tail, Res), !.
getFishingbarang(Idx, [[Name, _]|Tail], Res) :-
    \+ barang(Name, _, 'H'),
    getFishingbarang(Idx, Tail, Res), !.
















