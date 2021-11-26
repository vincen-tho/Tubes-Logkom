/* FAKTA */
/* DYNAMIC */

/* Role pemain */
:- dynamic(playerRole/1).

/* Level pemain */
:- dynamic(playerLevel/1).

/* Level farming pemain */
:- dynamic(playerFarmingLevel/1).

/* EXP farming pemain */
:- dynamic(playerFarmingEXP/1).
:- dynamic(farmingExpCap/1).

/* Level fishing pemain */
:- dynamic(playerFishingLevel/1).

/* EXP fishing pemain */
:- dynamic(playerFishingEXP/1).
:- dynamic(fishingExpCap/1).

/* Level ranching pemain */
:- dynamic(playerRanchingLevel/1).

/* EXP ranching pemain */
:- dynamic(playerRanchingEXP/1).
:- dynamic(ranchingExpCap/1).

/* EXP pemain */
/*exp dan cap per level*/
:- dynamic(exp/1).
:- dynamic(expCap/1).

/* Gold pemain */
:- dynamic(gold/1).

/* Status initialize */
:- dynamic(playerInitialized/1).

/* STATIC */
startingEXPCap(100).

/* RULES */
/* Inisialisasi pemain */
initializePlayer :- \+ playerInitialized(1),
                    write('Welcome to Panen, please select your job:'), nl,
                    write('1. fisherman'), nl,
                    write('2. farmer'), nl,
                    write('3. rancher'), nl,
                    write('> '),
                    read(ROLE),
                    setRole(ROLE),
                    assertz(playerLevel(0)),
                    assertz(playerFarmingLevel(0)),
                    assertz(playerFarmingEXP(0)),
                    assertz(playerFishingLevel(0)),
                    assertz(playerFishingEXP(0)),
                    assertz(playerRanchingLevel(0)),
                    assertz(playerRanchingEXP(0)),
                    assertz(exp(0)),
                    startingEXPCap(CAP),
                    assertz(expCap(CAP)),
                    assertz(farmingExpCap(CAP)),
                    assertz(fishingExpCap(CAP)),
                    assertz(ranchingExpCap(CAP)),
                    assertz(gold(0)),
                    assertz(playerInitialized(1)).

/* Mendapatkan Role */
/* Ini jangan lupa dibikin loop idenya gimana */
setRole(X) :-   roleName(X, ROLE) -> 
                (assertz(playerRole(ROLE)), write('You are now a '), write(ROLE), write('!'));
                (write('Wrong input, retry:'), nl, 
                write('> '), read(Y), setRole(Y)), !.

/* Level */
/* addEXP(X) dimana X adalah jumlah EXP yang ingin ditambahkan */
addEXP(X) :-    exp(OLDEXP),
                NEWEXP is OLDEXP+X,
                expCap(OLDCAP),
                NEWEXP >= OLDCAP,
                retract(exp(OLDEXP)),
                assertz(exp(NEWEXP)),
                retract(expCap(OLDCAP)),
                playerLevel(OLDLEVEL),
                NEWLEVEL is OLDLEVEL+1,
                retract(playerLevel(OLDLEVEL)),
                assertz(playerLevel(NEWLEVEL)),
                NEWCAP is OLDCAP+100+(50*(NEWLEVEL)),
                assertz(expCap(NEWCAP)), !.
addEXP(X) :-    exp(OLD), NEW is OLD+X, retract(exp(OLD)), assertz(exp(NEW)), !.

/* addFarmingEXP(X) dimana X adalah jumlah Farming EXP yang ingin ditambahkan*/

addFarmingEXP(X) :- playerFarmingEXP(OLD),
                    playerRole(ROLE),
                    roleName(2, GETROLE),
                    ROLE \= GETROLE,
                    NEW is OLD+X,
                    farmingExpCap(OLDCAP),
                    NEW >= OLDCAP,
                    retract(playerFarmingEXP(OLD)),
                    assertz(playerFarmingEXP(NEW)),
                    addEXP(X),
                    (playerFarmingLevel(OLDLEVEL),
                    NEWLEVEL is OLDLEVEL+1,
                    retract(playerFarmingLevel(OLDLEVEL)),
                    assertz(playerFarmingLevel(NEWLEVEL)),
                    retract(farmingExpCap(OLDCAP)),
                    NEWCAP is OLDCAP+100+(50*(NEWLEVEL)),
                    assertz(farmingExpCap(NEWCAP))), !.

addFarmingEXP(X) :- playerFarmingEXP(OLD),
                    playerRole(ROLE),
                    roleName(2, GETROLE),
                    ROLE = GETROLE,
                    NEW is OLD+X*2,
                    farmingExpCap(OLDCAP),
                    NEW >= OLDCAP,
                    retract(playerFarmingEXP(OLD)),
                    assertz(playerFarmingEXP(NEW)),
                    addEXP(X*2),
                    (playerFarmingLevel(OLDLEVEL),
                    NEWLEVEL is OLDLEVEL+1,
                    retract(playerFarmingLevel(OLDLEVEL)),
                    assertz(playerFarmingLevel(NEWLEVEL)),
                    retract(farmingExpCap(OLDCAP)),
                    NEWCAP is OLDCAP+100+(50*(NEWLEVEL)),
                    assertz(farmingExpCap(NEWCAP))), !.

addFarmingEXP(X) :- playerFarmingEXP(OLD),
                    playerRole(ROLE),
                    roleName(2, GETROLE),
                    ROLE \= GETROLE,
                    NEW is OLD+X,
                    farmingExpCap(OLDCAP),
                    NEW < OLDCAP,
                    retract(playerFarmingEXP(OLD)),
                    assertz(playerFarmingEXP(NEW)),
                    addEXP(X), !.

addFarmingEXP(X) :- playerFarmingEXP(OLD),
                    playerRole(ROLE),
                    roleName(2, GETROLE),
                    ROLE = GETROLE,
                    NEW is OLD+X*2,
                    farmingExpCap(OLDCAP),
                    NEW < OLDCAP,
                    retract(playerFarmingEXP(OLD)),
                    assertz(playerFarmingEXP(NEW)),
                    addEXP(X*2), !.

/* addFishingEXP(X) dimana X adalah jumlah Fishing EXP yang ingin ditambahkan*/
addFishingEXP(X) :- playerFishingEXP(OLD),
                    playerRole(ROLE),
                    roleName(1, GETROLE),
                    ROLE \= GETROLE,
                    NEW is OLD+X,
                    fishingExpCap(OLDCAP),
                    NEW >= OLDCAP,
                    retract(playerFishingEXP(OLD)),
                    assertz(playerFishingEXP(NEW)),
                    addEXP(X),
                    (playerFishingLevel(OLDLEVEL),
                    NEWLEVEL is OLDLEVEL+1,
                    retract(playerFishingLevel(OLDLEVEL)),
                    assertz(playerFishingLevel(NEWLEVEL)),
                    retract(fishingExpCap(OLDCAP)),
                    NEWCAP is OLDCAP+100+(50*(NEWLEVEL)),
                    assertz(fishingExpCap(NEWCAP))), !.

addFishingEXP(X) :- playerFishingEXP(OLD),
                    playerRole(ROLE),
                    roleName(1, GETROLE),
                    ROLE = GETROLE,
                    NEW is OLD+X*2,
                    fishingExpCap(OLDCAP),
                    NEW >= OLDCAP,
                    retract(playerFishingEXP(OLD)),
                    assertz(playerFishingEXP(NEW)),
                    addEXP(X*2),
                    (playerFishingLevel(OLDLEVEL),
                    NEWLEVEL is OLDLEVEL+1,
                    retract(playerFishingLevel(OLDLEVEL)),
                    assertz(playerFishingLevel(NEWLEVEL)),
                    retract(fishingExpCap(OLDCAP)),
                    NEWCAP is OLDCAP+100+(50*(NEWLEVEL)),
                    assertz(fishingExpCap(NEWCAP))), !.

addFishingEXP(X) :- playerFishingEXP(OLD),
                    playerRole(ROLE),
                    roleName(1, GETROLE),
                    ROLE \= GETROLE,
                    NEW is OLD+X,
                    fishingExpCap(OLDCAP),
                    NEW < OLDCAP,
                    retract(playerFishingEXP(OLD)),
                    assertz(playerFishingEXP(NEW)),
                    addEXP(X), !.

addFishingEXP(X) :- playerFishingEXP(OLD),
                    playerRole(ROLE),
                    roleName(1, GETROLE),
                    ROLE = GETROLE,
                    NEW is OLD+X*2,
                    fishingExpCap(OLDCAP),
                    NEW < OLDCAP,
                    retract(playerFishingEXP(OLD)),
                    assertz(playerFishingEXP(NEW)),
                    addEXP(X*2), !.

/* addRanchingEXP(X) dimana X adalah jumlah Ranching EXP yang ingin ditambahkan*/

addRanchingEXP(X) :-playerRanchingEXP(OLD),
                    playerRole(ROLE),
                    roleName(3, GETROLE),
                    ROLE \= GETROLE,
                    NEW is OLD+X,
                    ranchingExpCap(OLDCAP),
                    NEW >= OLDCAP,
                    retract(playerRanchingEXP(OLD)),
                    assertz(playerRanchingEXP(NEW)),
                    addEXP(X),
                    (playerRanchingLevel(OLDLEVEL),
                    NEWLEVEL is OLDLEVEL+1,
                    retract(playerRanchingLevel(OLDLEVEL)),
                    assertz(playerRanchingLevel(NEWLEVEL)),
                    retract(ranchingExpCap(OLDCAP)),
                    NEWCAP is OLDCAP+100+(50*(NEWLEVEL)),
                    assertz(ranchingExpCap(NEWCAP))), !.

addRanchingEXP(X) :-playerRanchingEXP(OLD),
                    playerRole(ROLE),
                    roleName(3, GETROLE),
                    ROLE = GETROLE,
                    NEW is OLD+X*2,
                    ranchingExpCap(OLDCAP),
                    NEW >= OLDCAP,
                    retract(playerRanchingEXP(OLD)),
                    assertz(playerRanchingEXP(NEW)),
                    addEXP(X*2),
                    (playerRanchingLevel(OLDLEVEL),
                    NEWLEVEL is OLDLEVEL+1,
                    retract(playerRanchingLevel(OLDLEVEL)),
                    assertz(playerRanchingLevel(NEWLEVEL)),
                    retract(ranchingExpCap(OLDCAP)),
                    NEWCAP is OLDCAP+100+(50*(NEWLEVEL)),
                    assertz(ranchingExpCap(NEWCAP))), !.

addRanchingEXP(X) :-playerRanchingEXP(OLD),
                    playerRole(ROLE),
                    roleName(3, GETROLE),
                    ROLE \= GETROLE,
                    NEW is OLD+X,
                    ranchingExpCap(OLDCAP),
                    NEW < OLDCAP,
                    retract(playerRanchingEXP(OLD)),
                    assertz(playerRanchingEXP(NEW)),
                    addEXP(X), !.

addRanchingEXP(X) :-playerRanchingEXP(OLD),
                    playerRole(ROLE),
                    roleName(3, GETROLE),
                    ROLE = GETROLE,
                    NEW is OLD+X*2,
                    ranchingExpCap(OLDCAP),
                    NEW < OLDCAP,
                    retract(playerRanchingEXP(OLD)),
                    assertz(playerRanchingEXP(NEW)),
                    addEXP(X*2), !.

/* Gold */
/* addGold(X) dimana X adalah jumlah Gold yang ingin ditambahkan */
addGold(X) :- gold(OLD), NEW is OLD+X, retract(gold(OLD)), assertz(gold(NEW)).


/* Print player status */
status :- playerRole(ROLE), playerLevel(LEVEL), playerFarmingLevel(FARMINGLEVEL), playerFarmingEXP(FARMINGEXP), playerFishingLevel(FISHINGLEVEL), playerFishingEXP(FISHINGEXP), playerRanchingLevel(RANCHINGLEVEL), playerRanchingEXP(RANCHINGEXP), exp(EXP), gold(GOLD), expCap(CAP),
write('Your status: '), nl,
write('Job: '), write(ROLE), nl,
write('Level: '), write(LEVEL), nl,
write('Level farming: '), write(FARMINGLEVEL), nl,
write('Exp farming: '), write(FARMINGEXP), nl,
write('Level fishing: '), write(FISHINGLEVEL), nl,
write('Exp fishing: '), write(FISHINGEXP), nl,
write('Level ranching: '), write(RANCHINGLEVEL), nl,
write('Exp ranching: '), write(RANCHINGEXP), nl,
write('Exp: '), write(EXP), nl,
write('Gold: '), write(GOLD), nl,
write('Minimum exp needed for next level: '), write(CAP), nl.