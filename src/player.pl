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

/* STATIC */
startingEXPCap(100).

/* RULES */
/* Inisialisasi pemain */
initializePlayer :- assertz(playerRole('Default')),
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
                    assertz(gold(0)).

/* Mendapatkan Role */
farmer :- playerRole('Default'), retract(playerRole('Default')), assertz(playerRole('Farmer')), !.
farmer :- \+ playerRole('Default'), print('Gagal mendapatkan role!'), !.
rancher :- playerRole('Default'),retract(playerRole('Default')), assertz(playerRole('Rancher')), !.
rancher :- \+ playerRole('Default'), print('Gagal mendapatkan role!'), !.
fisher :- playerRole('Default'), retract(playerRole('Default')), assertz(playerRole('Fisher')), !.
fisher :- \+ playerRole('Default'), print('Gagal mendapatkan role!'), !.