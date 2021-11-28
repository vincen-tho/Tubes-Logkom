
:- dynamic(playerPos/2).
:- dynamic(specialTile/3).

/* membuat map size 20 * 15 WIDTH * HEIGHT */ 
map_size(20, 15).

/* special tile */
    % water tile
    specialTile(2, 2, 'W').
    specialTile(2, 3, 'W').
    specialTile(2, 4, 'W').
    specialTile(2, 5, 'W').
    specialTile(3, 2, 'W').
    specialTile(3, 3, 'W').
    specialTile(3, 4, 'W').
    specialTile(4, 2, 'W').
    specialTile(4, 3, 'W').
    specialTile(5, 2, 'W').

    specialTile(13, 10, 'W').

    % house tile
    specialTile(7, 7, 'H').

    % ranch tile
    specialTile(8, 8, 'R').

    % quest tile
    specialTile(9, 9, 'Q').

    % marketplace tile
    specialTile(10, 10, 'M').

    % digged tile DYNAMIC


/* render left */
writeTile(X, Y) :- map_size(_, H),
                    X =:= 1,
                    Y =< H,
                    write('# '),
					NewX is X+1,
					writeTile(NewX, Y), !.

/* render right */
writeTile(X, Y) :- map_size(W, H),
                    X =:= W, Y =< H,
                    write('# '), nl,
                    NewY is Y+1,
                    writeTile(1, NewY), !.

/* render top */
writeTile(X, Y) :- map_size(W, _),
                    X > 1, X < W, Y =:= 1,
                    write('# '),
                    NewX is X+1,
                    writeTile(NewX, Y), !.

/* render bottom */
writeTile(X, Y) :- map_size(W, H),
                    X > 1, X < W, Y =:= H,
                    write('# '),
                    NewX is X+1,
                    writeTile(NewX, Y), !.

/* render regular tile */
writeTile(X, Y) :- map_size(W, H),
                    X > 1, X < W, Y > 1, Y < H,
                    \+ specialTile(X, Y, _),
                    \+ playerPos(X, Y),
                    write('- '),
                    NewX is X+1,
                    writeTile(NewX, Y), !.

/* render water tile */
writeTile(X, Y) :- map_size(W, H),
                    X > 1, X < W, Y > 1, Y < H,
                    specialTile(X, Y, 'W'),
                    write('o '),
                    NewX is X+1,
                    writeTile(NewX, Y), !.

/* render house tile */
writeTile(X, Y) :- map_size(W, H),
                    X > 1, X < W, Y > 1, Y < H,
                    specialTile(X, Y, 'H'),
                    \+ playerPos(X, Y),
                    write('H '),
                    NewX is X+1,
                    writeTile(NewX, Y), !.

/* render ranch tile */
writeTile(X, Y) :- map_size(W, H),
                    X > 1, X < W, Y > 1, Y < H,
                    specialTile(X, Y, 'R'),
                    \+ playerPos(X, Y),
                    write('R '),
                    NewX is X+1,
                    writeTile(NewX, Y), !.

/* render quest tile */
writeTile(X, Y) :- map_size(W, H),
                    X > 1, X < W, Y > 1, Y < H,
                    specialTile(X, Y, 'Q'),
                    \+ playerPos(X, Y),
                    write('Q '),
                    NewX is X+1,
                    writeTile(NewX, Y), !.

/* render marketplace tile */
writeTile(X, Y) :- map_size(W, H),
                    X > 1, X < W, Y > 1, Y < H,
                    specialTile(X, Y, 'M'),
                    \+ playerPos(X, Y),
                    write('M '),
                    NewX is X+1,
                    writeTile(NewX, Y), !.

/* render digged tile */
writeTile(X, Y) :- map_size(W, H),
                    X > 1, X < W, Y > 1, Y < H,
                    specialTile(X, Y, 'D'),
                    \+ playerPos(X, Y),
                    write('= '),
                    NewX is X+1,
                    writeTile(NewX, Y), !.

/* render planted tile */
writeTile(X, Y) :- map_size(W, H),
                    X > 1, X < W, Y > 1, Y < H,
                    specialTile(X, Y, P),
                    plantedLetter(_, P, _),
                    \+ playerPos(X, Y),
                    write(P),
                    NewX is X+1,
                    writeTile(NewX, Y), !.

/* render player tile */
writeTile(X, Y) :- map_size(W, H),
                    X > 1, X < W, Y > 1, Y < H,
                    playerPos(X, Y),
                    write('P '),
                    NewX is X+1,
                    writeTile(NewX, Y), !.


createMap :- writeTile(1, 1), !.

/* debug only */
startD :- resetPlayerPos,
        createMap.
