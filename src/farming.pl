
/* FAKTA */

/* DINAMIS */

/* RULES */
dig :-  playerPos(X, Y),
        \+ (specialTile(X, Y, _)),
        haveShovel,
        playerRole(ROLE),
        roleName(IDX, ROLE),
        IDX =:= 2,
        ADDEDEXP is 10,
        addFarmingEXP(ADDEDEXP),
        assertz(specialTile(X, Y, 'D')), 
        write('you digged a tile and got 20 EXP!'), !.
dig :-  playerPos(X, Y),
        \+ (specialTile(X, Y, _)),
        haveShovel,
        playerRole(ROLE),
        roleName(IDX, ROLE),
        IDX \== 2,
        ADDEDEXP is 10,
        addFarmingEXP(ADDEDEXP),
        assertz(specialTile(X, Y, 'D')), 
        write('you digged a tile and got 10 EXP!'), !.
dig :-  playerPos(X, Y),
        \+ (specialTile(X, Y, _)),
        \+ haveShovel,
        write('You don\'t have shovel!'), !.
dig :-  playerPos(X, Y),
        specialTile(X, Y, _),
        write('You can\'t dig here!'), !.

plant :-    playerPos(X, Y),
            \+ (specialTile(X, Y, 'D')),
            write('You can\'t plant here!'), !.
plant :-    playerPos(X, Y),
            specialTile(X, Y, 'D'),
            inventory(INV),
            countFarmingBarang(INV, COUNT),
            COUNT > 0,
            showFarmingInventory,
            write('What do you want to plant?'), nl,
            write('> '),
            read(NUM),
            NUM =< COUNT,
            NUM > 0,
            INDEXED is NUM - 1,
            getFarmingbarang(INDEXED, INV, [NAME, _]),
            plantedLetter(NAME, LETTER, TIMETOHARVEST),
            illegalLetter(ILLEGALLETTER),
            LETTER \= ILLEGALLETTER,
            retract(specialTile(X, Y, 'D')),
            assertz(specialTile(X, Y, LETTER)),
            time(TIME),
            assertz(plantTime(X, Y, TIME, TIMETOHARVEST)),
            addBarang(NAME, -1),
            write('You planted a '), write(NAME), write('.'), 
            !.
plant :-    playerPos(X, Y),
            specialTile(X, Y, 'D'),
            inventory(INV),
            countFarmingBarang(INV, COUNT),
            COUNT =< 0, 
            write('You don\'t have anything to plant!'), !.

plant :-    playerPos(X, Y),
            specialTile(X, Y, 'D'),
            write('Planting failed!'), !.

harvest :-  playerPos(X, Y),
            specialTile(X, Y, LETTER),
            harvestResult(LETTER, PLANTNAME, QUANTITY),
            plantTime(X, Y, PLANTTIME, TIMETOHARVEST),
            time(CURRENTTIME),
            DIFFERENCE is CURRENTTIME - PLANTTIME,
            DIFFERENCE >= TIMETOHARVEST,
            retract(specialTile(X, Y, LETTER)),
            addBarang(PLANTNAME, QUANTITY),
            addCountFarm(QUANTITY),
            write('You harvested '), write(QUANTITY),write(' '), write(PLANTNAME),write('.'), 
            /* disini push ke inventory */
            !.
harvest :-  playerPos(X, Y),
            specialTile(X, Y, LETTER),
            harvestResult(LETTER, _, _),
            plantTime(X, Y, PLANTTIME, TIMETOHARVEST),
            time(CURRENTTIME),
            DIFFERENCE is CURRENTTIME - PLANTTIME,
            DIFFERENCE < TIMETOHARVEST,
            write('This crop can\'t be harvested yet!'),
            !.
harvest :- write('Harvest failed!'), !.