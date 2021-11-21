/* include files */
:- include('map.pl').
:- include('movement.pl').
:- include('items.pl').
:- include('inventory.pl').
:- include('marketPlace.pl').

startGame :- 
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
    write(' ################################################################################').

help :- 
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
    write(' ################################################################################').


:- dynamic(isRunning/1).
start :- isRunning(_) -> write('You already started your adventure!').
start :- \+isRunning(_), assertz(isRunning(true)), resetPlayerPos, createMap.

map :- isRunning(_), createMap.
map :- \+isRunning(_) -> write('Start the game first!').

