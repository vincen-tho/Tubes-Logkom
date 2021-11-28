/* Dynamic */
:- dynamic(totalChicken/1).
:- dynamic(totalSheep/1).
:- dynamic(totalCow/1).
:- dynamic(gainedExpRanch/1).
:- dynamic(produceEgg/1).
:- dynamic(producePoultry/1).
:- dynamic(produceWool/1).
:- dynamic(produceSheepMeat/1).
:- dynamic(produceMilk/1).
:- dynamic(produceBeef/1).
:- dynamic(egg/1).
:- dynamic(goldenEgg/1).
:- dynamic(poultry/1).
:- dynamic(wool/1).
:- dynamic(sheepMeat/1).
:- dynamic(milk/1).
:- dynamic(beef/1).

/* Inisialisasi */
/* totalChicken(X), X berarti jumlah ayam di ranch */
totalChicken(0).
/* totalSheep(X), X berarti jumlah domba di ranch */
totalSheep(0).
/* totalCow(X), X berarti jumlah sapi di ranch */
totalCow(0).
/* produceEgg(X), X berarti list waktu yang dibutuhkan setiap ayam buat bertelur */
produceEgg([]).
/* producePoultry(X), X berarti list waktu yang dibutuhkan setiap ayam sampai siap dipanen */
producePoultry([]).
/* produceWool(X), X berarti list waktu yang dibutuhkan setiap domba sampai bulunya siap dicukur */
produceWool([]).
/* produceSheepMeat(X), X berarti list waktu yang dibutuhkan setiap domba sampai siap dipanen */
produceSheepMeat([]).
/* produceMilk(X), X berarti list waktu yang dibutuhkan setiap sapu sampai susunya siap diperah */
produceMilk([]).
/* produceBeef(X), X berarti list waktu yang dibutuhkan setiap sapi sampai siap dipanen */
produceBeef([]).
/* egg(X), X berarti jumlah telur yang dihasilkan */
egg(0).
/* goldenEgg(X), X berarti jumlah telur emas yang dihasilkan */
goldenEgg(0).
/* poultry(X), X berarti jumlah ayam yang sudah dipanen */
poultry(0).
/* wool(X), X berarti jumlah wool yang dihasilkan */
wool(0).
/* sheepMeat(X), X berarti jumlah domba yang sudah dipanen */
sheepMeat(0).
/* milk(X), X berarti jumlah susu yang dihasilkan */
milk(0).
/* beef(X), X berarti jumlah sapi yang sudah dipanen */
beef(0).

/* RULES */
/* Inisialisasi kondisi awal ranching */
initRanching :-
    /* Angka di bawah hanya sebagai sample belum fix */
    retractall(gainedExpRanch(_)),
    playerRanchingLevel(X),
    Y is X*2,
    Y1 is 5+Y,
    assertz(gainedExpRanch(Y1)), !.

/* Cek posisi player, berada di tile ranch atau tidak */
checkPosRanch :-
    playerPos(X, Y),
    (specialTile(X,Y,'R');
    write('You aren\'t at the ranch!'), fail), !.

ranch :- help.

/* Ranching */
ranchStatus :- 
    checkPosRanch,
    totalChicken(X),
    totalSheep(Y),
    totalCow(Z),
    initRanching,
    write('You have:'), nl,
    write(X), write(' '), write(chicken), nl,    
    write(Y), write(' '), write(sheep), nl,    
    write(Z), write(' '), write(cow), nl, !.

/* Menghapus semua elemen yang bernilai X */  
removeAllX(_, [], [], 0).
removeAllX(X, [[X,_]|T], L, Mark):- 
    removeAllX(X, T, L, Mark1), !,
    Mark is 1+Mark1, !.
removeAllX(X, [H|T], [H|L], Mark):- 
    removeAllX(X, T, L, Mark), !.
/* Menghapus X elemen yang berada di awal list */ 
removeXElmt(0,L,L).
removeXElmt(X, [_|T], L) :-
    X1 is X-1,
    removeXElmt(X1, T, L), !.
/* Mencari jumlah elemen pada list */
count([],0).
count([_|[]],1).
count([_|T],Count) :- 
    count(T,Count1), 
    Count is 1+Count1, !.
    
/* Cek kondisi hewan ternak */
/* Command chicken mengecek apakah ayam bertelur atau sudah siap panen (ayam diambil untuk kemudian dikonsumsi) */
chicken :-
    egg(X), goldenEgg(X1), poultry(Y),
    gainedExpRanch(Z),
    (X > 0, X1 =:= 0 -> write('Your chickens lay '), write(X), write(' eggs!'), nl,
    X2 is 0, retractall(egg(_)), assertz(egg(X2));
    X > 0, X1 > 0 -> write('Your chickens lay '), write(X), write(' eggs!'), nl,
    write('Congrats! Your chickens lay '), write(X1), write(' golden eggs too!'), nl,
    X2 is 0, retractall(egg(_)), assertz(egg(X2)), retractall(goldenEgg(_)), assertz(goldenEgg(_));
    X =:= 0, X1 > 0 -> write('Congrats! Your chickens lay '), write(X1), write(' golden eggs!'), nl,
    X2 is 0, retractall(goldenEgg(_)), assertz(goldenEgg(X2));
    write('Your chickens didn\'t lay any eggs!'), nl), 
    (Y > 0 -> write('You got '), write(Y), write(' poultries!'), nl,
    X3 is 0, retractall(poultry(_)), assertz(poultry(X3)),
    producePoultry(P), produceEgg(E), 
    retractall(producePoultry(_)), removeAllX(0,P,P1,Mark), assertz(producePoultry(P1)),
    retractall(produceEgg(_)), removeXElmt(Mark,E,E1), assertz(produceEgg(E1)),
    retractall(totalChicken(_)), count(P1,Count), assertz(totalChicken(Count));
    write('You didn\'t get any poultries!'), nl),
    (X =:= 0, X1 =:= 0, Y =:= 0 -> write('Please check again later!');
    (playerRole(rancher) -> Z1 is Z*2; Z1 is Z),
    write('You gained '), write(Z1), write(' ranching exp!'),
    addRanchingEXP(Z), addEXP(Z), addBarang('Egg', X), addBarang('Poultry', Y), addBarang('Golden Egg', X1)), !.

/* Command sheep mengecek apakah domba siap panen (domba diambil untuk kemudian dikonsumsi) atau bulunya siap dicukur (wool) */
sheep :-
    wool(X), sheepMeat(Y),
    gainedExpRanch(Z),
    (X > 0 -> write('You got '), write(X), write(' wools!'), nl,
    X1 is 0, retractall(wool(_)), assertz(wool(X1));
    write('You didn\'t get any wools!'), nl), 
    (Y > 0 -> write('You got '), write(Y), write(' sheep meats!'), nl,
    X2 is 0, retractall(sheepMeat(_)), assertz(sheepMeat(X2)),
    produceSheepMeat(SM), produceWool(W),
    retractall(produceSheepMeat(_)), removeAllX(0,SM,SM1,Mark), assertz(produceSheepMeat(SM1)),
    retractall(produceWool(_)), removeXElmt(Mark,W,W1), assertz(produceWool(W1)),
    retractall(totalSheep(_)), count(SM1,Count), assertz(totalSheep(Count));
    write('You didn\'t get any sheep meats!'), nl),
    (X =:= 0, Y =:= 0 -> write('Please check again later!');
    (playerRole(rancher) -> Z1 is Z*2; Z1 is Z),
    write('You gained '), write(Z1), write(' ranching exp!'),
    addRanchingEXP(Z), addEXP(Z), addBarang('Wool', X), addBarang('Sheep Meat', Y)), !.

/* Command cow mengecek apakah sapi siap panen (sapi diambil untuk kemudian dikonsumsi) atau siap diperah susunya */
cow :-
    milk(X), beef(Y),
    gainedExpRanch(Z),
    (X > 0, haveBucket -> write('You got '), write(X), write(' milks!'), nl,
    X1 is 0, retractall(milk(_)), assertz(milk(X1));
    write('You didn\'t get any milks!'), nl), 
    (Y > 0 -> write('You got '), write(Y), write(' beefs!'), nl,
    X2 is 0, retractall(beef(_)), assertz(beef(X2)),
    produceBeef(B), produceMilk(M),
    retractall(produceBeef(_)), removeAllX(0,B,B1,Mark), assertz(produceBeef(B1)),
    retractall(produceMilk(_)), removeXElmt(Mark,M,M1), assertz(produceMilk(M1)),
    retractall(totalCow(_)), count(B1,Count), assertz(totalCow(Count));
    write('You didn\'t get any beefs!'), nl),
    (X =:= 0, Y =:= 0 -> write('Please check again later!');
    (playerRole(rancher) -> Z1 is Z*2; Z1 is Z),
    write('You gained '), write(Z1), write(' ranching exp!'),
    addRanchingEXP(Z), addEXP(Z), addBarang('Milk', X), addBarang('Beef', Y)), !.

/* Menghasilkan jumlah item yang nilainya adalah 0 */
addItemRanch1([],0).
addItemRanch1([H|T],Item) :-
    H > 0,
    addItemRanch1(T,Item), !.
addItemRanch1([H|T],Item) :-
    H =:= 0,
    addItemRanch1(T,Item1),
    Item is 1+Item1, !.

/* Menghasilkan jumlah item yang nilai X adalah 0 dan nilai Y adalah 0 */
addItemRanch2([],0).
addItemRanch2([[X,Y]|T],Item) :-
    (X > 0; X =:= 0, \+Y =:= 0),
    addItemRanch2(T,Item), !.
addItemRanch2([[X,Y]|T],Item) :-
    X =:= 0, Y =:= 0,
    addItemRanch2(T,Item1),
    Item is 1+Item1, !.

/* Menghasilkan jumlah telur atau telur emas yang waktunya sudah menyentuh angka 0*/
addEggOrGoldEgg([],0,0).
addEggOrGoldEgg([H|T],Egg,GoldEgg) :-
    H > 0,
    addEggOrGoldEgg(T,Egg,GoldEgg), !.
addEggOrGoldEgg([H|T],Egg,GoldEgg) :-
    H =:= 0,
    (playerRole(rancher) ->
    choice(['Egg', 'Golden Egg'], [0.75, 0.25], X),
    (X = 'Egg' -> 
    addEggOrGoldEgg(T,Egg1,GoldEgg),
    Egg is 1+Egg1;
    addEggOrGoldEgg(T,Egg,GoldEgg1),
    GoldEgg is 1+GoldEgg1);
    choice(['Egg', 'Golden Egg'], [0.8, 0.2], X),
    (X = 'Egg' -> 
    addEggOrGoldEgg(T,Egg1,GoldEgg),
    Egg is 1+Egg1;
    addEggOrGoldEgg(T,Egg,GoldEgg1),
    GoldEgg is 1+GoldEgg1)), !.

/* Menghasilkan list dengan elemen yang sama dengan 0 diganti dengan X*/
changeList1([],_,[]).
changeList1([H|T],X,[H1|T1]) :-
    H > 0,
    changeList1(T,X,T1), !,
    H1 is H, !.
changeList1([H|T],X,[H1|T1]) :-
    H =:= 0,
    changeList1(T,X,T1),
    H1 is X, !.

/* Menghasilkan list dengan nilai X yang sama dengan 0 dan Y sama dengan 0, Y diganti Z */
changeList2([],_,[]).
changeList2([[X,Y]|T],Z,[[X1,Y1]|T1]) :-
    (X > 0; X =:= 0, \+Y =:= 0),
    changeList2(T,Z,T1), !,
    X1 is X, Y1 is Y, !.
changeList2([[X,Y]|T],Z,[[X1,Y1]|T1]) :-
    X =:= 0, Y =:= 0,
    changeList2(T,Z,T1),
    X1 is X, Y1 is Z, !.

/* Menambah egg */
addEgg :-
    produceEgg(E), egg(X1), goldenEgg(X3),
    retractall(produceEgg(_)), addEggOrGoldEgg(E,Y1,Y2),
    retractall(egg(_)), X2 is X1+Y1, 
    retractall(goldenEgg(_)), X4 is X3+Y2, 
    assertz(egg(X2)), assertz(goldenEgg(X4)),
    playerRanchingLevel(Level),
    (playerRole(rancher) ->
    Time1 is 15-Level,
    changeList1(E, Time1, Z);
    Time1 is 20-Level,
    changeList1(E, Time1, Z)),
    assertz(produceEgg(Z)), !.
/* Menambah wool */
addWool :-
    produceWool(W), wool(X),
    retractall(produceWool(W)), addItemRanch1(W,Y),
    retractall(wool(_)), X1 is X+Y,
    assertz(wool(X1)),
    playerRanchingLevel(Level),
    (playerRole(rancher) ->
    Time1 is 50-Level,
    changeList1(W, Time1, Z);
    Time1 is 60-Level,
    changeList1(W, Time1, Z)),
    assertz(produceWool(Z)), !.
/* Menambah milk */
addMilk :-
    bucketLevel(Level),
    produceMilk(M), milk(X),
    retractall(produceMilk(_)), addItemRanch1(M,Y),
    retractall(milk(_)), X1 is Level+X+Y,
    assertz(milk(X1)),
    playerRanchingLevel(Level),
    (playerRole(rancher) ->
    Time1 is 25-Level,
    changeList1(M, Time1, Z);
    Time1 is 30-Level,
    changeList1(M, Time1, Z)),
    assertz(produceMilk(Z)), !.
/* Menambah poultry */
addPoultry :-
    producePoultry(P), poultry(X), addItemRanch2(P,Y),
    retractall(poultry(_)), X1 is X+Y,
    assertz(poultry(X1)),
    retractall(producePoultry(_)),
    changeList2(P,1,Z),
    assertz(producePoultry(Z)), !.
/* Menambah sheep meat */
addSheepMeat :-
    produceSheepMeat(SM), sheepMeat(X), addItemRanch2(SM,Y),
    retractall(sheepMeat(_)), X1 is X+Y,
    assertz(sheepMeat(X1)),
    retractall(produceSheepMeat(_)),
    changeList2(SM,1,Z),
    assertz(produceSheepMeat(Z)), !.
/* Menambah beef */
addBeef :-
    produceBeef(B), beef(X), addItemRanch2(B,Y),
    retractall(beef(_)), X1 is X+Y,
    assertz(beef(X1)),
    retractall(produceBeef(_)),
    changeList2(B,1,Z),
    assertz(produceBeef(Z)), !.

/* Mengurangi satu satuan waktu tiap element di list produce */
decOnePerElmt1([],[]).
decOnePerElmt1([H|T],[H1|T1]) :-
    H =:= 0,
    decOnePerElmt1(T,T1),
    H1 is H, !.
decOnePerElmt1([H|T], [H1|T1]) :-
    H > 0,
    decOnePerElmt1(T,T1),
    H1 is H-1, !.

/* Mengurangi satu satuan waktu tiap element di list produce */
decOnePerElmt2([],[]).
decOnePerElmt2([[X,Y]|T],[[X1,Y1]|T1]) :-
    X =:= 0,
    decOnePerElmt2(T,T1),
    X1 is X, Y1 is Y, !.
decOnePerElmt2([[X,Y]|T], [[X1,Y1]|T1]) :-
    X > 0,
    decOnePerElmt2(T,T1),
    X1 is X-1, Y1 is Y, !.

/* Update kondisi ranch tiap hari */
/* Rule ini harus dipanggil tiap pergantian hari */
updateRanch :-
    produceEgg(E), producePoultry(P), produceWool(W), 
    produceSheepMeat(SM), produceMilk(M), produceBeef(B),
    decOnePerElmt1(E,E1), decOnePerElmt2(P,P1), decOnePerElmt1(W,W1), 
    decOnePerElmt2(SM,SM1), decOnePerElmt1(M,M1), decOnePerElmt2(B,B1),
    retractall(produceEgg(_)), retractall(producePoultry(_)), retractall(produceWool(_)),
    retractall(produceSheepMeat(_)), retractall(produceMilk(_)), retractall(produceBeef(_)),
    assertz(produceEgg(E1)), assertz(producePoultry(P1)), assertz(produceWool(W1)),
    assertz(produceSheepMeat(SM1)), assertz(produceMilk(M1)), assertz(produceBeef(B1)),
    addEgg, addWool, addMilk, addPoultry, addSheepMeat, addBeef, !.

/* Append L2 ke L1 sebanyak X kali */
appendXElmt(0, L, _, L).
appendXElmt(X, L1, L2, L3) :-
    append(L1, L2, Res),
    X1 is X-1,  
    appendXElmt(X1, Res, L2, L3), !.

/* Hewan baru */
/* newAnimal(X), X berarti banyak hewan baru */
/* Konfigurasi apabila ada ayam baru */
newChicken(X) :-
    totalChicken(PrevTotal),
    NewTotal is PrevTotal+X,
    retractall(totalChicken(_)),
    assertz(totalChicken(NewTotal)),
    produceEgg(PrevList1),
    retractall(produceEgg(_)),
    playerRanchingLevel(Level),
    (playerRole(rancher) ->
    Time1 is 15-Level,
    appendXElmt(X,PrevList1,[Time1],NewList1);
    Time1 is 20-Level,
    appendXElmt(X,PrevList1,[20],NewList1)),
    assertz(produceEgg(NewList1)),
    producePoultry(PrevList2),
    retractall(producePoultry(_)),
    (playerRole(rancher) ->
    Time2 is 35-Level,
    appendXElmt(X,PrevList2,[[Time2,0]],NewList2);
    Time2 is 40-Level,
    appendXElmt(X,PrevList2,[[Time2,0]],NewList2)),
    assertz(producePoultry(NewList2)), !.

/* Konfigurasi apabila ada domba baru */
newSheep(X) :-
    totalSheep(PrevTotal),
    NewTotal is PrevTotal+X,
    retractall(totalSheep(_)),
    assertz(totalSheep(NewTotal)),
    produceWool(PrevList1),
    retractall(produceWool(_)),
    playerRanchingLevel(Level),
    (playerRole(rancher) ->
    Time1 is 50-Level,
    appendXElmt(X,PrevList1,[Time1],NewList1);
    Time1 is 60-Level,
    appendXElmt(X,PrevList1,[Time1],NewList1)),
    assertz(produceWool(NewList1)),
    produceSheepMeat(PrevList2),
    retractall(produceSheepMeat(_)),
    (playerRole(rancher) ->
    Time2 is 70-Level,
    appendXElmt(X,PrevList2,[[Time2,0]],NewList2),
    Time2 is 80-Level,
    appendXElmt(X,PrevList2,[[Time2,0]],NewList2)),
    assertz(produceSheepMeat(NewList2)), !.

/* Konfigurasi apabila ada sapi baru */
newCow(X) :-
    totalCow(PrevTotal),
    NewTotal is PrevTotal+X,
    retractall(totalCow(_)),
    assertz(totalCow(NewTotal)),
    produceMilk(PrevList1),
    retractall(produceMilk(_)),
    playerRanchingLevel(Level),
    (playerRole(rancher) ->
    Time1 is 25-Level,
    appendXElmt(X,PrevList1,[Time1],NewList1);
    Time1 is 30-Level,
    appendXElmt(X,PrevList1,[Time1],NewList1)),
    assertz(produceMilk(NewList1)),
    produceBeef(PrevList2),
    retractall(produceBeef(_)),
    (playerRole(rancher) ->
    Time2 is 90-Level,
    appendXElmt(X,PrevList2,[[Time2,0]],NewList2);
    Time2 is 100-Level,
    appendXElmt(X,PrevList2,[[Time2,0]],NewList2)),
    assertz(produceBeef(NewList2)), !.

/* Hewan dijual */
/* Jual chicken */
sellChicken(X) :-
    totalChicken(PrevTotal),
    NewTotal is PrevTotal-X,
    retractall(totalChicken(_)),
    assertz(totalChicken(NewTotal)),
    produceEgg(PrevList1),
    retractall(produceEgg(_)),
    removeXElmt(X,PrevList1,NewList1),
    assertz(produceEgg(NewList1)),
    producePoultry(PrevList2),
    retractall(producePoultry(_)),
    removeXElmt(X,PrevList2,NewList2),
    assertz(producePoultry(NewList2)), !.
    
/* Jual sheep */
sellSheep(X) :-
    totalSheep(PrevTotal),
    NewTotal is PrevTotal+X,
    retractall(totalSheep(_)),
    assertz(totalSheep(NewTotal)),
    produceWool(PrevList1),
    retractall(produceWool(_)),
    removeXElmt(X,PrevList1,NewList1),
    assertz(produceWool(NewList1)),
    produceSheepMeat(PrevList2),
    retractall(produceSheepMeat(_)),
    removeXElmt(X,PrevList2,NewList2),
    assertz(produceSheepMeat(NewList2)), !.

/* Jual cow */
sellCow(X) :-
    totalCow(PrevTotal),
    NewTotal is PrevTotal+X,
    retractall(totalCow(_)),
    assertz(totalCow(NewTotal)),
    produceMilk(PrevList1),
    retractall(produceMilk(_)),
    removeXElmt(X,PrevList1,NewList1),
    assertz(produceMilk(NewList1)),
    produceBeef(PrevList2),
    retractall(produceBeef(_)),
    removeXElmt(X,PrevList2,NewList2),
    assertz(produceBeef(NewList2)), !.