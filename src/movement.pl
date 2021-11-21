
resetPlayerPos :- retractall(playerPos(_, _)),
                    assertz(playerPos(2, 9)).

newPos(X, Y) :- retractall(playerPos(_, _)),
                assertz(playerPos(X, Y)), !.






hitWater :- nl, write('You can\'t step on water'), nl, nl, !.
hitBorder :- nl, write('You can\'t escape until you get 20000 gold'), nl, nl.


/* move up */
% allowed
w :- playerPos(X, Y), map_size(_, _),
    NewY is Y-1,
    NewY =\= 1,
    \+ specialTile(X, NewY, 'W'),
    newPos(X, NewY), !,
    createMap, !.
% disallowed
w :- playerPos(X, Y), map_size(_, _),
    NewY is Y-1,
    NewY =\= 1,
    specialTile(X, NewY, 'W'),
    hitWater,
    createMap, !.
w :- playerPos(_, Y), map_size(_, _),
    NewY is Y-1,
    NewY =:= 1,
    hitBorder,
    createMap, !.


/* move down */
% allowed
s :- playerPos(X, Y), map_size(_, H),
    NewY is Y+1,
    NewY =\= H,
    \+ specialTile(X, NewY, 'W'),
    newPos(X, NewY), !,
    createMap.

% disallowed
s :- playerPos(X, Y), map_size(_, _),
    NewY is Y+1,
    specialTile(X, NewY, 'W'),
    hitWater,
    createMap, !.

s :- playerPos(_, Y), map_size(_, H),
    NewY is Y+1,
    NewY =:= H,
    hitBorder,
    createMap, !.


/* move left */
% allowed
a :- playerPos(X, Y), map_size(_, _),
    NewX is X-1,
    NewX =\= 1,
    \+ specialTile(NewX, Y, 'W'),
    newPos(NewX, Y), !,
    createMap.

% disallowed
a :- playerPos(X, Y), map_size(_, _),
    NewX is X-1,
    specialTile(NewX, Y, 'W'),
    hitWater,
    createMap.
a :- playerPos(X, _), map_size(_, _),
    NewX is X-1,
    NewX =:= 1,
    hitBorder,
    createMap.

/* move right */

% allowed
d :- playerPos(X, Y), map_size(W, _),
    NewX is X+1,
    NewX =\= W,
    \+ specialTile(NewX, Y, 'W'),
    newPos(NewX, Y), !,
    createMap.

% disallowed
d :- playerPos(X, Y), map_size(_, _),
    NewX is X+1,
    specialTile(NewX, Y, 'W'),
    hitWater,
    createMap.
d :- playerPos(X, _), map_size(W, _),
    NewX is X+1,
    NewX =:= W,
    hitBorder,
    createMap.
