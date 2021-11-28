
house :- help.



sleep :- 
    (playerPos(X, Y),
    specialTile(X, Y, 'H')),
    addTime(24),
    updateRanch,
    write('You went to sleep.'), !.