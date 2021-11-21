
/* FAKTA */

/* DINAMIS */

/* RULES */
dig :-  playerPos(X, Y),
        NEWY is Y+1,
        (\+ (specialTile(X, NEWY, 'W')),
        NEWY =\= 1,
        \+ (specialTile(X, Y, _)) ->
        (assertz(specialTile(X, Y, 'D')),
        retract(playerPos(X, Y)),
        assertz(playerPos(X, NEWY))); 
        write('You can\'t dig here!')), !.
/* plant :-    playerPos(X, Y),
            plantY() */