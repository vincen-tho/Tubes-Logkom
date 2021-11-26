/* get Element from any list */
getElmt(0, [Head|_], Res) :-
    Res = Head, !.
getElmt(Idx, [_|Tail], Res) :-
    NewIdx is (Idx-1),
    getElmt(NewIdx, Tail, Res).

/* get element from inventory (items only and Quantity not 0) */
getItemNoZero(_, [], _) :- !.
getItemNoZero(0, [[_, Qty]|Tail], Res) :-
    Qty =:= 0,
    getItemNoZero(0, Tail, Res), !.
getItemNoZero(0, [[Name, Qty]|_], Res) :-
    Qty =\= 0,
    items(Name, _, _),
    Res = [Name, Qty], !.
getItemNoZero(Idx, [[Name, Qty]|Tail], Res) :-
    Idx =\= 0,
    Qty =\= 0,
    items(Name, _, _),
    NewIdx is (Idx-1),
    getItemNoZero(NewIdx, Tail, Res), !.
getItemNoZero(Idx, [[Name, Qty]|Tail], Res) :-
    items(Name, _, _),
    Qty =:= 0,
    getItemNoZero(Idx, Tail, Res), !.
getItemNoZero(Idx, [[Name, _]|Tail], Res) :-
    \+ items(Name, _, _),
    getItemNoZero(Idx, Tail, Res), !.

/* get element from inventory (farming item only) */
getFarmingItem(_, [], _) :- !.
getFarmingItem(0, [[_, Qty]|Tail], Res) :-
    Qty =:= 0,
    getFarmingItem(0, Tail, Res), !.
getFarmingItem(0, [[Name, Qty]|_], Res) :-
    Qty =\= 0,
    items(Name, _, 'F'),
    Res = [Name, Qty], !.
getFarmingItem(Idx, [[Name, Qty]|Tail], Res) :-
    Idx =\= 0,
    Qty =\= 0,
    items(Name, _, 'F'),
    NewIdx is (Idx-1),
    getFarmingItem(NewIdx, Tail, Res), !.
getFarmingItem(Idx, [[Name, Qty]|Tail], Res) :-
    items(Name, _, 'F'),
    Qty =:= 0,
    getFarmingItem(Idx, Tail, Res), !.
getFarmingItem(Idx, [[Name, _]|Tail], Res) :-
    \+ items(Name, _, 'F'),
    getFarmingItem(Idx, Tail, Res), !.

/* get element from inventory (ranching item only) */
getRanchingItem(_, [], _) :- !.
getRanchingItem(0, [[_, Qty]|Tail], Res) :-
    Qty =:= 0,
    getRanchingItem(0, Tail, Res), !.
getRanchingItem(0, [[Name, Qty]|_], Res) :-
    Qty =\= 0,
    items(Name, _, 'R'),
    Res = [Name, Qty], !.
getRanchingItem(Idx, [[Name, Qty]|Tail], Res) :-
    Idx =\= 0,
    Qty =\= 0,
    items(Name, _, 'R'),
    NewIdx is (Idx-1),
    getRanchingItem(NewIdx, Tail, Res), !.
getRanchingItem(Idx, [[Name, Qty]|Tail], Res) :-
    items(Name, _, 'R'),
    Qty =:= 0,
    getRanchingItem(Idx, Tail, Res), !.
getRanchingItem(Idx, [[Name, _]|Tail], Res) :-
    \+ items(Name, _, 'R'),
    getRanchingItem(Idx, Tail, Res), !.

/* get element from inventory (fishing item only) */
getFishingItem(_, [], _) :- !.
getFishingItem(0, [[_, Qty]|Tail], Res) :-
    Qty =:= 0,
    getFishingItem(0, Tail, Res), !.
getFishingItem(0, [[Name, Qty]|_], Res) :-
    Qty =\= 0,
    items(Name, _, 'H'),
    Res = [Name, Qty], !.
getFishingItem(Idx, [[Name, Qty]|Tail], Res) :-
    Idx =\= 0,
    Qty =\= 0,
    items(Name, _, 'H'),
    NewIdx is (Idx-1),
    getFishingItem(NewIdx, Tail, Res), !.
getFishingItem(Idx, [[Name, Qty]|Tail], Res) :-
    items(Name, _, 'H'),
    Qty =:= 0,
    getFishingItem(Idx, Tail, Res), !.
getFishingItem(Idx, [[Name, _]|Tail], Res) :-
    \+ items(Name, _, 'H'),
    getFishingItem(Idx, Tail, Res), !.
















