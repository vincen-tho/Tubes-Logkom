help :- 
    playerPos(X, Y),
    \+ (specialTile(X, Y, _)),
    X1 is X+1, X2 is X-1, Y1 is Y+1, Y2 is Y-1,
    (specialTile(X1,Y,'W'); specialTile(X2,Y,'W'); specialTile(X,Y1,'W'); specialTile(X,Y2,'W');
    specialTile(X1,Y1,'W'); specialTile(X1,Y2,'W'); specialTile(X2,Y1,'W'); specialTile(X2,Y2,'W')),
    write(' ################################################################################'),nl,
    write(' #                                 ~MAIN MENU~                                  #'),nl,
    write(' # 1. map       : Show map                                                      #'),nl,
    write(' # 2. status    : Show your current status                                      #'),nl,
    write(' # 3. printTime : Show current time                                             #'),nl,
    write(' # 4. inventory : Show inventory                                                #'),nl,
    write(' # 5. w         : Move up 1 step                                                #'),nl,   
    write(' # 6. s         : Move down 1 step                                              #'),nl,
    write(' # 7. d         : Move right 1 step                                             #'),nl,
    write(' # 8. a         : Move left 1 step                                              #'),nl,
    write(' # 9. help      : Show command list                                             #'),nl,
    write(' # 10. quit     : Quit the game                                                 #'),nl,
    write(' ################################################################################'),nl,nl, 
    write(' ################################################################################'),nl,
    write(' #                             ~FARMING MENU~                                   #'),nl,
    write(' # 1. dig       : Dig a tile to plant crops                                     #'),nl,
    write(' # 2. plant     : Plant crops                                                   #'),nl,
    write(' # 3. harvest   : Harvest your crops                                            #'),nl,
    write(' ################################################################################'),nl,nl,
    write(' ################################################################################'),nl,
    write(' #                             ~FISHING MENU~                                   #'),nl,
    write(' # 1. fishing   : Go fishing                                                    #'),nl,
    write(' ################################################################################'), !.

help :- 
    playerPos(X, Y),
    \+ (specialTile(X, Y, _)),
    write(' ################################################################################'),nl,
    write(' #                                 ~MAIN MENU~                                  #'),nl,
    write(' # 1. map       : Show map                                                      #'),nl,
    write(' # 2. status    : Show your current status                                      #'),nl,
    write(' # 3. printTime : Show current time                                             #'),nl,
    write(' # 4. inventory : Show inventory                                                #'),nl,
    write(' # 5. w         : Move up 1 step                                                #'),nl,   
    write(' # 6. s         : Move down 1 step                                              #'),nl,
    write(' # 7. d         : Move right 1 step                                             #'),nl,
    write(' # 8. a         : Move left 1 step                                              #'),nl,
    write(' # 9. help      : Show command list                                             #'),nl,
    write(' # 10. quit     : Quit the game                                                 #'),nl,
    write(' ################################################################################'),nl,nl, 
    write(' ################################################################################'),nl,
    write(' #                             ~FARMING MENU~                                   #'),nl,
    write(' # 1. dig       : Dig a tile to plant crops                                     #'),nl,
    write(' # 2. plant     : Plant crops                                                   #'),nl,
    write(' # 3. harvest   : Harvest your crops                                            #'),nl,
    write(' ################################################################################'), !.

help :- 
    playerPos(X, Y),
    specialTile(X, Y, 'Q'),
    write(' ################################################################################'),nl,
    write(' #                           Welcome to the Quest Room                          #'),nl,
    write(' #                            What do you want to do ?                          #'),nl,
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
    write(' # 1. sleep  : Go to sleep                                                      #'),nl,
    write(' ################################################################################'), !.

help :-
    playerPos(X, Y),
    specialTile(X,Y,'R'),
    write(' ################################################################################'),nl,
    write(' #                             Welcome to the Ranch                             #'),nl,
    write(' #                            What do you want to do ?                          #'),nl,
    write(' ################################################################################'),nl,
    write(' #                             ~RANCHING MENU~                                  #'),nl,
    write(' # 1. ranchStatus   : Check your ranch                                          #'),nl,
    write(' # 2. chicken       : Check your chicken                                        #'),nl,
    write(' # 3. sheep         : Check your sheep                                          #'),nl,
    write(' # 3. cow           : Check your cow                                            #'),nl,
    write(' ################################################################################'), !.

help :-
    playerPos(X, Y),
    specialTile(X,Y,'M'),
    write(' ################################################################################'),nl,
    write(' #                             ~RANCHING MENU~                                  #'),nl,
    write(' # 1. market   : Interact with market place                                     #'),nl,
    write(' ################################################################################'), !.
    

