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

/* Level fishing pemain */
:- dynamic(playerFishingLevel/1).

/* EXP fishing pemain */
:- dynamic(playerFishingEXP/1).

/* Level ranching pemain */
:- dynamic(playerRanchingLevel/1).

/* EXP ranching pemain */
:- dynamic(playerRanchingEXP/1).

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
                    write('Select your job (farmer/rancher/fisher): '), nl,
                    assertz(playerRole('Default')),
                    assertz(playerLevel(0)),
                    assertz(playerFarmingLevel(0)),
                    assertz(playerFarmingEXP(0)),
                    assertz(playerFishingLevel(0)),
                    assertz(playerFishingEXP(0)),
                    assertz(playerRanchingLevel(0)),
                    assertz(playerRanchingEXP(0)),
                    assertz(exp(0)),
                    startingEXPCap(X),
                    assertz(expCap(X)),
                    assertz(gold(0)),
                    assertz(playerInitialized(1)).

/* Mendapatkan Role */
farmer :- playerRole('Default'), retract(playerRole('Default')), assertz(playerRole('Farmer')), !.
farmer :- \+ playerRole('Default'), print('Failed to obtain role!'), !.
rancher :- playerRole('Default'),retract(playerRole('Default')), assertz(playerRole('Rancher')), !.
rancher :- \+ playerRole('Default'), print('Failed to obtain role!'), !.
fisher :- playerRole('Default'), retract(playerRole('Default')), assertz(playerRole('Fisher')), !.
fisher :- \+ playerRole('Default'), print('Failed to obtain role!'), !.

/* Level */
/* addEXP(X) dimana X adalah jumlah EXP yang ingin ditambahkan */
addEXP(X) :- exp(OLDEXP), NEWEXP is OLDEXP+X, expCap(OLDCAP), NEWEXP >= OLDCAP, retract(exp(OLDEXP)), assertz(exp(NEWEXP)), retract(expCap(OLDCAP)), playerLevel(OLDLEVEL), NEWLEVEL is OLDLEVEL+1, retract(playerLevel(OLDLEVEL)), assertz(playerLevel(NEWLEVEL)), NEWCAP is OLDCAP+100+(50*(NEWLEVEL)),  assertz(expCap(NEWCAP)), !.
addEXP(X) :- exp(OLD), NEW is OLD+X, retract(exp(OLD)), assertz(exp(NEW)), !.

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