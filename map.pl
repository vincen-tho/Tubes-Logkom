

/* membuat map size 20 * 15 WIDTH * HEIGHT */ 
map_size(20, 15).

/* special tile */
    % water tile
    special_tile(2, 2, 'W').
    special_tile(2, 3, 'W').
    special_tile(2, 4, 'W').
    special_tile(2, 5, 'W').
    special_tile(3, 2, 'W').
    special_tile(3, 3, 'W').
    special_tile(3, 4, 'W').
    special_tile(4, 2, 'W').
    special_tile(4, 3, 'W').
    special_tile(5, 2, 'W').

    special_tile(13, 10, 'W').

    % house tile
    special_tile(7, 7, 'H').

    % ranch tile
    special_tile(8, 8, 'H').

    % quest tile
    special_tile(9, 9, 'Q').

    % marketplace tile
    special_tile(10, 10, 'M').

    % digged tile DYNAMIC


/* render left */
write_tile(X, Y) :- map_size(_, H),
                    X =:= 1,
                    Y =< H,
                    write('# '),
					NewX is X+1,
					write_tile(NewX, Y).

/* render right */
write_tile(X, Y) :- map_size(W, H),
                    X =:= W, Y =< H,
                    write('# '), nl,
                    NewY is Y+1,
                    write_tile(1, NewY).

/* render top */
write_tile(X, Y) :- map_size(W, _),
                    X > 1, X < W, Y =:= 1,
                    write('# '),
                    NewX is X+1,
                    write_tile(NewX, Y).

/* render bottom */
write_tile(X, Y) :- map_size(W, H),
                    X > 1, X < W, Y =:= H,
                    write('# '),
                    NewX is X+1,
                    write_tile(NewX, Y).

/* render regular tile */
write_tile(X, Y) :- map_size(W, H),
                    X > 1, X < W, Y > 1, Y < H,
                    \+ special_tile(X, Y, _),
                    write('- '),
                    NewX is X+1,
                    write_tile(NewX, Y).

/* render water tile */
write_tile(X, Y) :- map_size(W, H),
                    X > 1, X < W, Y > 1, Y < H,
                    special_tile(X, Y, 'W'),
                    write('o '),
                    NewX is X+1,
                    write_tile(NewX, Y).

/* render house tile */
write_tile(X, Y) :- map_size(W, H),
                    X > 1, X < W, Y > 1, Y < H,
                    special_tile(X, Y, 'H'),
                    write('H '),
                    NewX is X+1,
                    write_tile(NewX, Y).

/* render ranch tile */
write_tile(X, Y) :- map_size(W, H),
                    X > 1, X < W, Y > 1, Y < H,
                    special_tile(X, Y, 'R'),
                    write('R '),
                    NewX is X+1,
                    write_tile(NewX, Y).

/* render quest tile */
write_tile(X, Y) :- map_size(W, H),
                    X > 1, X < W, Y > 1, Y < H,
                    special_tile(X, Y, 'Q'),
                    write('Q '),
                    NewX is X+1,
                    write_tile(NewX, Y).

/* render marketplace tile */
write_tile(X, Y) :- map_size(W, H),
                    X > 1, X < W, Y > 1, Y < H,
                    special_tile(X, Y, 'M'),
                    write('M '),
                    NewX is X+1,
                    write_tile(NewX, Y).

/* render digged tile */
write_tile(X, Y) :- map_size(W, H),
                    X > 1, X < W, Y > 1, Y < H,
                    special_tile(X, Y, 'D'),
                    write('= '),
                    NewX is X+1,
                    write_tile(NewX, Y).


create_map :- write_tile(1, 1).