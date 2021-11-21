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
                    write('Welcome to panen, please select your job:'), nl,
                    write('1. Fisherman'), nl,
                    write('2. Farmer'), nl,
                    write('3. Rancher'), nl,
                    write('> '),
                    assertz(playerRole('Default')),
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
                (retract(playerRole('Default')), assertz(playerRole(ROLE)), write('You are now a '), write(ROLE), write('!'));
                (write('Input salah, ulangi:'), nl, 
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
                    NEW is OLD+X,
                    retract(playerFarmingEXP(OLD)),
                    assertz(playerFarmingEXP(NEW)),
                    addEXP(X),
                    farmingExpCap(OLDCAP),
                    (NEW >= OLDCAP) ->
                    (playerFarmingLevel(OLDLEVEL),
                    NEWLEVEL is OLDLEVEL+1,
                    retract(playerFarmingLevel(OLDLEVEL)),
                    assertz(playerFarmingLevel(NEWLEVEL)),
                    retract(farmingExpCap(OLDCAP)),
                    NEWCAP is OLDCAP+100+(50*(NEWLEVEL)),
                    assertz(expCap(NEWCAP))), !.

/* addFishingEXP(X) dimana X adalah jumlah Farming EXP yang ingin ditambahkan*/
addFishingEXP(X) :- playerFishingEXP(OLD),
                    NEW is OLD+X,
                    retract(playerFishingEXP(OLD)),
                    assertz(playerFishingEXP(NEW)),
                    addEXP(X),
                    fishingExpCap(OLDCAP),
                    (NEW >= OLDCAP) ->
                    (playerFishingLevel(OLDLEVEL),
                    NEWLEVEL is OLDLEVEL+1,
                    retract(playerFishingLevel(OLDLEVEL)),
                    assertz(playerFishingLevel(NEWLEVEL))),
                    retract(fishingExpCap(OLDCAP)),
                    NEWCAP is OLDCAP+100+(50*(NEWLEVEL)),
                    assertz(expCap(NEWCAP)), !.

/* addRanchingEXP(X) dimana X adalah jumlah Farming EXP yang ingin ditambahkan*/
addRanchingEXP(X) :- playerRanchingEXP(OLD),
                    NEW is OLD+X,
                    retract(playerRanchingEXP(OLD)),
                    assertz(playerRanchingEXP(NEW)),
                    addEXP(X),
                    ranchingExpCap(OLDCAP),
                    (NEW >= OLDCAP) ->
                    (playerRanchingLevel(OLDLEVEL),
                    NEWLEVEL is OLDLEVEL+1,
                    retract(playerRanchingLevel(OLDLEVEL)),
                    assertz(playerRanchingLevel(NEWLEVEL))),
                    retract(ranchingExpCap(OLDCAP)),
                    NEWCAP is OLDCAP+100+(50*(NEWLEVEL)),
                    assertz(expCap(NEWCAP)), !.

/* Gold */
/* addGold(X) dimana X adalah jumlah Gold yang ingin ditambahkan */
addGold(X) :- gold(OLD), NEW is OLD+X, retract(gold(OLD)), assertz(gold(NEW)), !.


/* Print player status */
status :- playerRole(ROLE), playerLevel(LEVEL), playerFarmingLevel(FARMINGLEVEL), playerFarmingEXP(FARMINGEXP), playerFishingLevel(FISHINGLEVEL), playerFishingEXP(FISHINGEXP), playerRanchingLevel(RANCHINGLEVEL), playerRanchingEXP(RANCHINGEXP), exp(EXP), gold(GOLD), expCap(CAP),
write('Your status: '), nl,
write('Job: '), write(ROLE), nl,
write('Level: '), write(LEVEL), nl,
write('Level farming: '), write(FARMINGLEVEL), nl,
write('Exp farming: '), write(FARMINGEXP), nl,
write('Level fishing: '), write(FISHINGLEVEL), nl,
write('Exp farming: '), write(FISHINGEXP), nl,
write('Level ranching: '), write(RANCHINGLEVEL), nl,
write('Exp ranching: '), write(RANCHINGEXP), nl,
write('Exp: '), write(EXP), nl,
write('Gold: '), write(GOLD), nl,
write('Minimum exp needed for next level: '), write(CAP), nl.