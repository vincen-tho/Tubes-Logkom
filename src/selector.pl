/* get Element from any list */
getElmt(0, [Head|Tail], Res) :-
    Res = Head, !.
getElmt(Idx, [Head|Tail], Res) :-
    NewIdx is (Idx-1),
    getElmt(NewIdx, Tail, Res).

/* get element from inventory (items only and Quantity not 0) */
getItemNoZero(_, [], _) :- !.
getItemNoZero(0, [[Name, Qty]|Tail], Res) :-
    Qty =:= 0,
    getItemNoZero(0, Tail, Res), !.
getItemNoZero(0, [[Name, Qty]|Tail], Res) :-
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
getItemNoZero(Idx, [[Name, Qty]|Tail], Res) :-
    \+ items(Name, _, _),
    getItemNoZero(Idx, Tail, Res), !.

/* get element from inventory (farming item only) */














