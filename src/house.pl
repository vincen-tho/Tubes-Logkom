


sleep :- 
    (playerPos(X, Y),
    specialTile(X, Y, 'H')),
    addTime(24),
    write("You went to sleep.").