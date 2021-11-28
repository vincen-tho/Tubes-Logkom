:- dynamic(progressQuest/4).
:- dynamic(isQuest/1).

% isQuest untuk melihat apakah sedang menjalankan quest
% progressQuest(QuestId, CountFarming, CountFishing, CountRanching)
% quest(QuestId, HasilFarming, HasilFishing, HasilRanching, Exp, Gold)

% quest list
quest(1,1,0,0,25,25).
quest(2,0,1,0,25,25).
quest(3,0,0,1,25,25).
quest(4,1,2,0,50,50).
quest(5,0,2,1,50,50).
quest(6,1,1,1,50,50).
quest(7,0,1,2,50,50).
quest(8,2,1,0,50,50).
quest(9,2,1,0,75,75).
quest(10,2,2,1,75,75).
quest(11,1,1,3,75,75).
quest(12,4,1,0,75,75).
quest(13,3,0,2,75,75).
quest(14,2,1,2,75,75).
quest(15,4,1,1,100,125).
quest(16,3,2,1,100,125).
quest(17,3,2,2,100,125).
quest(18,3,3,1,100,125).
quest(19,1,4,1,100,125).
quest(20,2,3,2,100,125).
quest(21,4,2,1,100,125).
quest(22,3,2,3,115,155).
quest(23,3,3,3,115,155).
quest(24,3,4,2,115,155).
quest(25,1,5,4,115,155).
quest(26,4,4,1,115,155).
quest(27,0,4,5,115,155).
quest(28,3,8,2,155,200).
quest(29,9,1,4,155,200).
quest(30,1,2,11,155,200).
quest(31,4,4,6,155,200).
quest(32,7,2,5,155,200).
quest(33,5,5,5,155,200).
quest(34,10,5,3,155,225).
quest(35,7,7,5,155,250).


initQuest :- 
    assertz(progressQuest(0,0,0,0)),
    assertz(isQuest(0)).

resetQuest :-
    retract(isQuest(_)),
    assertz(isQuest(0)),
    progressQuest(QuestId, CFarm, CFish, CRanch),
    TempQuestId is QuestId,
    retract(progressQuest(QuestId, CFarm, CFish, CRanch)),
    assertz(progressQuest(TempQuestId, 0, 0, 0)).

questFinished :- 
    playerPos(X, Y),
    specialTile(X, Y, 'Q'),
    isQuest(Z), Z =:= 1,
    progressQuest(QuestId, CFarm, CFish, CRanch),
    quest(QuestId, HasilFarm, HasilFish, HasilRanch, Exp, Gold),
    CFarm >= HasilFarm, CFish >= HasilFish, CRanch >= HasilRanch,
    (addFarmingEXP(Exp), addFishingEXP(Exp), addRanchingEXP(Exp), addGold(Gold),
    write('You have completed your quest.'), nl,
    write('Exp reward: '), print(Exp), nl,
    write('Gold reward: '), print(Gold)),
    retract(isQuest(Z)),
    assertz(isQuest(0)), !.

questFinished :-
    (isQuest(Z), Z =:= 1)
    -> write('Complete your quest first!');
    write('Get your quest first!'), !.
    
getQuest :-
    playerPos(X, Y),
    specialTile(X, Y, 'Q'),
    isQuest(Z), Z =:= 0,
    retract(isQuest(Z)),
    assertz(isQuest(1)),
    progressQuest(QuestId, CFarm, CFish, CRanch),
    NewQuestId is QuestId + 1,
    retract(progressQuest(QuestId, CFarm, CFish, CRanch)),
    assertz(progressQuest(NewQuestId, 0, 0, 0)),
    write('New quest obtained!'), !.

getQuest :-
    playerPos(X, Y),
    specialTile(X, Y, 'Q'),
    isQuest(Z), Z =:= 1, write('Finish your current quest first!'), !.

addCountFarm(X) :-
    progressQuest(QuestId, CFarm, CFish, CRanch),
    NewCFarm is CFarm + X,
    retract(progressQuest(QuestId, CFarm, CFish, CRanch)),
    assertz(progressQuest(QuestId, NewCFarm, CFish, CRanch)).

addCountFish(X) :-
    progressQuest(QuestId, CFarm, CFish, CRanch),
    NewCFish is CFish + X,
    retract(progressQuest(QuestId, CFarm, CFish, CRanch)),
    assertz(progressQuest(QuestId, CFarm, NewCFish, CRanch)).

addCountRanch(X) :-
    progressQuest(QuestId, CFarm, CFish, CRanch),
    NewCRanch is CRanch + X,
    retract(progressQuest(QuestId, CFarm, CFish, CRanch)),
    assertz(progressQuest(QuestId, CFarm, CFish, NewCRanch)).    

printQuest :-
    playerPos(X, Y),
    specialTile(X, Y, 'Q'),
    isQuest(Z), Z =:= 1,
    progressQuest(QuestId, _, _, _),
    quest(QuestId, HasilFarm, HasilFish, HasilRanch, Exp, Gold),
    write('Quest details:'), nl,
    write('Harvest item: '), print(HasilFarm), nl,
    write('Fish item: '), print(HasilFish), nl,
    write('Ranch item: '), print(HasilRanch), nl,
    write('Exp reward: '), print(Exp), nl,
    write('Gold reward: '), print(Gold), !.

printQuest :-
    playerPos(X, Y),
    specialTile(X, Y, 'Q'),
    isQuest(Z), Z =:= 0, write('Get your quest first!'), !.

printProgress :-
    playerPos(X, Y),
    specialTile(X, Y, 'Q'),
    isQuest(Z), Z =:= 1,  
    progressQuest(_, CFarm, CFish, CRanch),
    write('Your progress:'),nl,
    write('Harvest item: '), print(CFarm), nl,
    write('Fish item: '), print(CFish), nl,
    write('Ranch item: '), print(CRanch), !.

printProgress :-
    playerPos(X, Y),
    specialTile(X, Y, 'Q'),
    isQuest(Z), Z =:= 0, write('You are currently not doing any quest.'), !.

quest :- help.

/* for debugging purposes
addCountAll(X):-
    addCountFarm(X), addCountFish(X), addCountRanch(X). 
*/


