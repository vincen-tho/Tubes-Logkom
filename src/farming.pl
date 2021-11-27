
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
            getFarmingbarang(INDEXED, INV, [NAME, QUANTITY]),
            plantedLetter(NAME, LETTER, TIMETOHARVEST),
            illegalLetter(ILLEGALLETTER),
            LETTER \= ILLEGALLETTER,
            retract(specialTile(X, Y, 'D')),
            assertz(specialTile(X, Y, LETTER)),
            time(TIME),
            assertz(plantTime(X, Y, TIME, TIMETOHARVEST)),
            write('You planted a '), write(NAME), write('.'), 
            /* disini harusnya untuk mengurangi QUANTITY */
            !.
plant :-    playerPos(X, Y),
            specialTile(X, Y, 'D'),
            write('Planting failed!'), !.

harvest :-  playerPos(X, Y),
            specialTile(X, Y, LETTER),
            plantedLetter(PLANTNAME, LETTER),
            plantTime(X, Y, PLANTTIME, TIMETOHARVEST),
            time(CURRENTTIME),
            DIFFERENCE is CURRENTTIME - PLANTTIME,
            DIFFERENCE >= TIMETOHARVEST,
            retract(specialTile(X, Y, LETTER)),
            write('You harvested '), write(PLANTNAME), 
            /* disini push ke inventory */
            !.
harvest :-  playerPos(X, Y),
            specialTile(X, Y, LETTER),
            plantedLetter(_, LETTER),
            plantTime(X, Y, PLANTTIME, TIMETOHARVEST),
            time(CURRENTTIME),
            DIFFERENCE is CURRENTTIME - PLANTTIME,
            DIFFERENCE < TIMETOHARVEST,
            write('This crop can\'t be harvested yet!'),
            !.
harvest :- write('Harvest failed!'), !.