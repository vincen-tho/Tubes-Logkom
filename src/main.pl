/* include files */
:- include('farming.pl').
:- include('fishing.pl').
:- include('game_manager.pl').
:- include('help.pl').
:- include('house.pl').
:- include('inventory.pl').
:- include('items.pl').
:- include('map.pl').
:- include('marketPlace.pl').
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
    initInv,
    assertz(win(0)),
    assertz(lose(0)),
    printTime, nl,
    initializePlayer, !.

map :- isRunning(_), createMap, !.
map :- \+isRunning(_) -> write('Start the game first!'), !.

quit :-
    retractall(isRunning(_)),
    retracall(isStarted(_)),
    retractall(playerInitialized(_)),
    retractall(fishProbability(_)), 
    retractall(gainedExpNoFish(_)), 
    retractall(gainedExpFish(_)),
    retractall(time(_)),
    retractall(lose(_)),
    retractall(win(_)),
    retractall(playerPos(_)),
    retractall(specialTile(_)),
    retractall(shop(_)),
    retractall(playerPos(_)),
    retractall(playerLevel(_)),
    retractall(playerFarmingLevel(_)),
    retractall(playerFarmingEXP(_)),
    retractall(farmingExpCap(_)),
    retractall(playerFishingLevel(_)),
    retractall(playerFishingEXP(_)),
    retractall(fishingExpCap(_)),
    retractall(playerRanchingLevel(_)),
    retractall(playerRanchingEXP(_)),
    retractall(ranchingExpCap(_)),
    retractall(exp(_)),
    retractall(expCap(_)),
    retractall(gold(_)),
    retractall(playerInitialized(_)),
    retractall(progressQuest(_)),
    retractall(isQuest(_)),
    retractall(totalChicken(_)),
    retractall(totalSheep(_)),
    retractall(totalCow(_)),
    retractall(gainedExpRanch(_)),
    retractall(produceEgg(_)),
    retractall(producePoultry(_)),
    retractall(produceWool(_)),
    retractall(produceSheepMeat(_)),
    retractall(produceMilk(_)),
    retractall(produceBeef(_)),
    retractall(egg(_)),
    retractall(goldenEgg(_)),
    retractall(poultry(_)),
    retractall(wool(_)),
    retractall(sheepMeat(_)),
    retractall(milk(_)),
    retractall(beef(_)).

