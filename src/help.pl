help :- 
    playerPos(X, Y),
    \+ (specialTile(X, Y, _)),
    write(' ################################################################################'),nl,
    write(' #                                 ~MAIN MENU~                                  #'),nl,
    write(' # 1. map       : Show map                                                      #'),nl,
    write(' # 2. status    : Show your current status                                      #'),nl,
    write(' # 3. printTime : Show current time                                             #'),nl,
    write(' # 4. w         : Move up 1 step                                                #'),nl,   
    write(' # 5. s         : Move down 1 step                                              #'),nl,
    write(' # 6. d         : Move right 1 step                                             #'),nl,
    write(' # 7. a         : Move left 1 step                                              #'),nl,
    write(' # 8. help      : Show command list                                             #'),nl,
    write(' # 9. quit      : Quit the game                                                 #'),nl,
    write(' ################################################################################'), !.

help :- 
    playerPos(X, Y),
    specialTile(X, Y, 'Q'),
    write(' ################################################################################'),nl,
    write(' #                                   ~QUEST~                                    #'),nl,
    write(' # 1. getQuest       : Get your quest                                           #'),nl,
    write(' # 2. printQuest     : Show quest details                                       #'),nl,
    write(' # 3. printProgress  : Show your quest progress                                 #'),nl,
    write(' # 4. questFinished  : Claim your rewards                                       #'),nl,   
    write(' ################################################################################'), !.

help :- 
    playerPos(X, Y),
    specialTile(X, Y, 'H'),
    write(' ################################################################################'),nl,
    write(' #                                   ~HOUSE~                                    #'),nl,
    write(' # 1.        : Get your quest                                           #'),nl,
    write(' # 2.      : Show quest details                                       #'),nl,
    write(' # 3.   : Show your quest progress                                 #'),nl,
    write(' # 4.   : Claim your rewards                                       #'),nl,   
    write(' ################################################################################'), !.