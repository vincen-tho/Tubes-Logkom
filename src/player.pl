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


/* RULES */
/* initializePlayer :- */