:- dynamic(progressQuest/4)
:- dynamic(isQuest/1).

% isQuest untuk melihat apakah sedang menjalankan quest
% progressQuest(QuestId, CountFarming, CountFishing, CountRanching)
% quest(QuestId, HasilFarming, HasilFishing, HasilRanching, Exp, Gold)

quest(1,1,2,3,50,50).
quest(2,2,3,4,100,75).
quest(3,3,4,5,125,100).

initQuest :- 
    assertz(progressQuest(0,0,0,0)),
    assertz(isQuest(true)).

resetQuest :-
    retract(isQuest(_)),
    assertz(isQuest(false)),
    progressQuest(QuestId, CFarm, CFish, CRanch),
    retract(progressQuest(QuestId, CFarm, CFish, CRanch)),
    assertz(progressQuest(0, 0, 0, 0)).

completedQuest :- 
    progressQuest(QuestId, CFarm, CFish, CRanch),
    quest(QuestId, HasilFarm, HasilFish, HasilRanch, _, _),
    
getQuest :-
    isQuest(_),
    retract(isQuest(_)),
    assertz(isQuest(true)),
    progressQuest(QuestId, CFarm, CFish, CRanch),
    NewQuestId is QuestId + 1,
    retract(progressQuest(QuestId, CFarm, CFish, CRanch)),
    assertz(progressQuest(NewQuestId, 0, 0, 0)).


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

/* belum di test,
    todo list:
    bikin command yang ngeprint progress quest skarang gimana */