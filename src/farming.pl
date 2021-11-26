
/* FAKTA */

/* DINAMIS */

/* RULES */
dig :-  playerPos(X, Y),
        \+ (specialTile(X, Y, _)),
        assertz(specialTile(X, Y, 'D')), !.
dig :-  playerPos(X, Y),
        specialTile(X, Y, _),
        write('You can\'t dig here!'), !.

plant :-    playerPos(X, Y),
            \+ (specialTile(X, Y, 'D')),
            write('You can\'t plant here!'), !.
plant :-    playerPos(X, Y),
            specialTile(X, Y, 'D'),
            showFarmingInventory,
            inventory(INV),
            write('What do you want to plant?'), nl,
            write('> '),
            read(NUM),
            INDEXED is NUM - 1,
            getFarmingItem(INDEXED, INV, [NAME, QUANTITY]),
            plantedLetter(NAME, LETTER),
            retract(specialTile(X, Y, 'D')),
            assertz(specialTile(X, Y, LETTER)),
            time(TIME),
            assertz(plantTime(X, Y, TIME)),
            write('You planted a '), write(NAME), write('.'), 
            /* disini harusnya untuk mengurangi QUANTITY */
            !.
plant :-    playerPos(X, Y),
            specialTile(X, Y, 'D'),
            write('Planting failed!'), !.