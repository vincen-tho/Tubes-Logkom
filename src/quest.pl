:- dynamic(progressQuest/4).
:- dynamic(isQuest/1).

% isQuest untuk melihat apakah sedang menjalankan quest
% progressQuest(QuestId, CountFarming, CountFishing, CountRanching)
% quest(QuestId, HasilFarming, HasilFishing, HasilRanching, Exp, Gold)

% sample quest
quest(1,1,1,1,25,25).
quest(2,1,2,3,50,50).
quest(3,2,3,4,100,75).
quest(4,3,4,5,125,100).

initQuest :- 
    assertz(progressQuest(1,0,0,0)),
    assertz(isQuest(0)).

resetQuest :-
    retract(isQuest(X)),
    assertz(isQuest(0)),
    progressQuest(QuestId, CFarm, CFish, CRanch),
    retract(progressQuest(QuestId, CFarm, CFish, CRanch)),
    assertz(progressQuest(0, 0, 0, 0)).

questFinished :- 
    (playerPos(X, Y),
    specialTile(X, Y, 'Q'),
    isQuest(Z), Z =:= 1,
    progressQuest(QuestId, CFarm, CFish, CRanch),
    quest(QuestId, HasilFarm, HasilFish, HasilRanch, Exp, Gold),
    CFarm >= HasilFarm, CFish >= HasilFish, CRanch >= HasilRanch) ->
    (addFarmingEXP(Exp), addFishingEXP(Exp), addRanchingEXP(Exp), addGold(Gold),
    write('You have completed your quest.'),
    write('Exp reward: '), print(Exp), nl,
    write('Gold reward: '), print(Gold));
    isQuest(Z), Z =:= 1 -> write('Complete your quest first!');
    isQuest(Z), Z =:= 0 -> write('Get your quest first!'), !.
    
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
    quest(QuestId, HasilFarm, HasilFish, HasilRanch, Exp, Gold),
    write('Quest details:'), nl,
    write('Harvest items: '), print(HasilFarm), nl,
    write('Fish: '), print(HasilFish), nl,
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
    progressQuest(QuestId, CFarm, CFish, CRanch),
    write('Your progress:'),nl,
    write('Harvest items: '), print(CFarm), nl,
    write('Fish: '), print(CFish), nl,
    write('Ranch item: '), print(CRanch), !.

printProgress :-
    playerPos(X, Y),
    specialTile(X, Y, 'Q'),
    isQuest(Z), Z =:= 0, write('You are currently not doing any quest.'), !.

/* belum di test 
   TODO :
     - satuin dengan farming, fishing, ranching
     - save Exp dan gold reward to player */



