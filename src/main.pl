/* include files */
:- include('farming.pl').
:- include('fishing.pl').
:- include('game_manager.pl').
:- include('help.pl').
:- include('house.pl').
:- include('inventory.pl').
:- include('items.pl').
:- include('map.pl').
:- include('newMP.pl').
:- include('movement.pl').
:- include('player.pl').
:- include('quest.pl').
:- include('ranching.pl').
:- include('roles.pl').
:- include('selector.pl').
:- include('plant.pl').

:- dynamic(isStarted/1).

startGame :- 
    \+isStarted(_), assertz(isStarted(true)), 
    write('                                                          '),nl,
    write(' :::::::::     :::     ::::    ::: :::::::::: ::::    ::: '),nl,
    write(' :+:    :+:  :+: :+:   :+:+:   :+: :+:        :+:+:   :+: '),nl,
    write(' +:+    +:+ +:+   +:+  :+:+:+  +:+ +:+        :+:+:+  +:+ '),nl,
    write(' +#++:++#+ +#++:++#++: +#+ +:+ +#+ +#++:++#   +#+ +:+ +#+ '),nl,
    write(' +#+       +#+     +#+ +#+  +#+#+# +#+        +#+  +#+#+# '),nl,
    write(' #+#       #+#     #+# #+#   #+#+# #+#        #+#   #+#+# '),nl,
    write(' ###       ###     ### ###    #### ########## ###    #### '),nl,
    write('                                                          '),nl,
    write('      Welcome to PANEN !                                  '),nl,
    write('                                                          '),nl,
    write('                                                          '),nl,
    write(' ################################################################################'),nl,
    write(' #                                  ~PANEN~                                     #'),nl,
    write(' # 1. start  : start your adventure                                             #'),nl,
    write(' # 2. map    : show map                                                         #'),nl,
    write(' # 3. status : show your current status                                         #'),nl,
    write(' # 4. w      : move up 1 step                                                   #'),nl,   
    write(' # 5. s      : move down 1 step                                                 #'),nl,
    write(' # 6. d      : move right 1 step                                                #'),nl,
    write(' # 7. a      : move left 1 step                                                 #'),nl,
    write(' # 8. help   : show command list                                                #'),nl,
    write(' ################################################################################'), !.

startGame :- isStarted(_) -> write('You already started the game.'), !.

:- dynamic(isRunning/1).

start :- \+isStarted(_) -> write('You need to start the game first!'), !.
start :- isStarted(_), isRunning(_) -> write('You already started your adventure!'), !.
start :- isStarted(_), \+isRunning(_), 
    assertz(isRunning(true)), 
    resetPlayerPos, 
    initializeTime, 
    initQuest,
    /*initFishing,*/
    /*initRanching,*/
    printTime, nl,
    initializePlayer, !.

map :- isRunning(_), createMap.
map :- \+isRunning(_) -> write('Start the game first!').

quit :-
    retractall(playerInitialized(_)).