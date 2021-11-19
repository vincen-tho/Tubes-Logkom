:- include('map.pl').

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
    create_map, !.
% disallowed
w :- playerPos(X, Y), map_size(_, _),
    NewY is Y-1,
    NewY =\= 1,
    specialTile(X, NewY, 'W'),
    hitWater,
    create_map, !.
w :- playerPos(_, Y), map_size(_, _),
    NewY is Y-1,
    NewY =:= 1,
    hitBorder,
    create_map, !.


/* move down */
% allowed
s :- playerPos(X, Y), map_size(_, H),
    NewY is Y+1,
    NewY =\= H,
    \+ specialTile(X, NewY, 'W'),
    newPos(X, NewY), !,
    create_map.

% disallowed
s :- playerPos(X, Y), map_size(_, _),
    NewY is Y+1,
    specialTile(X, NewY, 'W'),
    hitWater,
    create_map, !.

s :- playerPos(_, Y), map_size(_, H),
    NewY is Y+1,
    NewY =:= H,
    hitBorder,
    create_map, !.


/* move left */
% allowed
a :- playerPos(X, Y), map_size(_, _),
    NewX is X-1,
    NewX =\= 1,
    \+ specialTile(NewX, Y, 'W'),
    newPos(NewX, Y), !,
    create_map.

% disallowed
a :- playerPos(X, Y), map_size(_, _),
    NewX is X-1,
    specialTile(NewX, Y, 'W'),
    hitWater,
    create_map.
a :- playerPos(X, _), map_size(_, _),
    NewX is X-1,
    NewX =:= 1,
    hitBorder,
    create_map.

/* move right */

% allowed
d :- playerPos(X, Y), map_size(W, _),
    NewX is X+1,
    NewX =\= W,
    \+ specialTile(NewX, Y, 'W'),
    newPos(NewX, Y), !,
    create_map.

% disallowed
d :- playerPos(X, Y), map_size(_, _),
    NewX is X+1,
    specialTile(NewX, Y, 'W'),
    hitWater,
    create_map.
d :- playerPos(X, _), map_size(W, _),
    NewX is X+1,
    NewX =:= W,
    hitBorder,
    create_map.




    




/* Disallowed move */