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
:- dynamic(isAtTheRanch/1).

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
    assertz(gainedExpRanch(Y1)).

/* Cek posisi player, berada di tile ranch atau tidak */
checkPosRanch :-
    playerPos(X, Y),
    (specialTile(X,Y,'R');
    write('You aren\'t at the ranch!'), fail).

/* Ranching */
ranch :-
    checkPosRanch,
    isAtTheRanch(true),
    write('You already at the ranch!'), !.
ranch :- 
    checkPosRanch,
    \+isAtTheRanch(true),
    totalChicken(X),
    totalSheep(Y),
    totalCow(Z),
    initRanching,
    write('Welcome to the ranch! You have:'), nl,
    write(X), write(' '), write(chicken), nl,    
    write(Y), write(' '), write(sheep), nl,    
    write(Z), write(' '), write(cow), nl, nl,
    write('What do you want to do?'),
    retractall(isAtTheRanch(_)),
    assertz(isAtTheRanch(true)). 

/* Menghapus semua elemen yang bernilai X */  
removeAllX(_, [], [], 0).
removeAllX(X, [X|T], L, Mark):- 
    removeAllX(X, T, L, Mark1), !,
    Mark is 1+Mark1.
removeAllX(X, [H|T], [H|L], Mark):- 
    removeAllX(X, T, L, Mark).
/* Menghapus X elemen yang berada di awal list */ 
removeXElmt(0,L,L).
removeXElmt(X, [_|T], L) :-
    X1 is X-1,
    removeXElmt(X1, T, L).
/* Mencari jumlah elemen pada list */
count([_|[]],1).
count([_|T],Count) :- 
    count(T,Count1), 
    Count is 1+Count1.
    
/* Cek kondisi hewan ternak */
/* Command chicken mengecek apakah ayam bertelur atau sudah siap panen (ayam diambil untuk kemudian dikonsumsi) */
chicken :-
    \+isAtTheRanch(true),
    write('Enter inside the ranch first!'), !.
chicken :-
    isAtTheRanch(true),
    egg(X), goldenEgg(X1), chicken(Y),
    gainedExpRanch(Z),
    (X > 0 -> write('Your chickens lay '), write(X), write(' eggs!'), nl;
    write('Your chickens didn\'t lay any eggs!'), nl), 
    X1 > 0 -> write('Congrats! Your chicken lay '), write(X1), write(' golden eggs!'), nl,
    (Y > 0 -> write('You got '), write(Y), write(' poultries!'), nl,
    retractall(producePoultry(P)), removeAllX(0,P,P1,Mark), assertz(producePoultry(P1)),
    retractall(produceEgg(E)), removeXElmt(Mark,E,E1), assertz(produceEgg(E1)),
    retractall(totalChicken(_)), count(producePoultry,Count), assertz(totalChicken(Count));
    write('You didn\'t get any poultries'), nl),
    (X =:= 0, Y =:= 0 -> write('Please check again later!');
    write('You gained '), write(Z), write(' ranching exp!'),
    addRanchingEXP(Z), addEXP(Z)), addBarang('Egg', X), addBarang('Poultry', Y), addBarang('Golden Egg', X1).

/* Command sheep mengecek apakah domba siap panen (domba diambil untuk kemudian dikonsumsi) atau bulunya siap dicukur (wool) */
sheep :-
    \+isAtTheRanch(true),
    write('Enter inside the ranch first!'), !.
sheep :-
    isAtTheRanch(true),
    wool(X), sheepMeat(Y),
    gainedExpRanch(Z),
    (X > 0 -> write('You got '), write(X), write(' wools!'), nl;
    write('You didn\'t get any wools!'), nl), 
    (Y > 0 -> write('You got '), write(Y), write(' sheep meats!'), nl,
    retractall(produceSheepMeat(SM)), removeAllX(0,SM,SM1,Mark), assertz(produceSheepMeat(SM1)),
    retractall(produceWool(W)), removeXElmt(Mark,W,W1), assertz(produceWool(W1)),
    retractall(totalSheep(_)), count(produceSheepMeat,Count), assertz(totalSheep(Count));
    write('You didn\'t get any sheep meats'), nl),
    (X =:= 0, Y =:= 0 -> write('Please check again later!');
    write('You gained '), write(Z), write(' ranching exp!')
    addRanchingEXP(Z), addEXP(Z)), addBarang('Wool', X), addBarang('Sheep Meat', Y).

/* Command cow mengecek apakah sapi siap panen (sapi diambil untuk kemudian dikonsumsi) atau siap diperah susunya */
cow :-
    \+isAtTheRanch(true),
    write('Enter inside the ranch first!'), !.
cow :-
    isAtTheRanch(true),
    milk(X), beef(Y),
    gainedExpRanch(Z),
    (X > 0 -> write('You got '), write(X), write(' milks!'), nl;
    write('You didn\'t get any milks!'), nl), 
    (Y > 0 -> write('You got '), write(Y), write(' beefs!'), nl,
    retractall(produceBeef(B)), removeAllX(0,B,B1,Mark), assertz(produceBeef(B1)),
    retractall(produceMilk(M)), removeXElmt(Mark,M,M1), assertz(produceMilk(M1)),
    retractall(totalCow(_)), count(produceBeef,Count), assertz(totalCow(Count));
    write('You didn\'t get any beefs'), nl),
    (X =:= 0, Y =:= 0 -> write('Please check again later!');
    write('You gained '), write(Z), write(' ranching exp!')
    addRanchingEXP(Z), addEXP(Z)), addBarang('Milk', X), addBarang('Beef', Y).

/* Menghasilkan jumlah item yang waktunya sudah menyentuh angka 0*/
addItemRanch([],0).
addItemRanch([H|T],Item) :-
    H > 0,
    addItemRanch(T,Item), !.
addItemRanch([H|T],Item) :-
    H =:= 0,
    addItemRanch(T,Item1),
    Item is 1+Item1.

/* Random pick element list */
/* Source: https://stackoverflow.com/questions/50250234/prolog-how-to-non-uniformly-randomly-select-a-element-from-a-list */
choice([X|_], [P|_], Cumul, Rand, X) :-
    Rand < Cumul + P.
choice([_|Xs], [P|Ps], Cumul, Rand, Y) :-
    Cumul1 is Cumul + P,
    Rand >= Cumul1,
    choice(Xs, Ps, Cumul1, Rand, Y).
choice([X], [P], Cumul, Rand, X) :-
    Rand < Cumul + P.

choice(Xs, Ps, Y) :- random(R), choice(Xs, Ps, 0, R, Y).

/* Menghasilkan jumlah telur atau telur emas yang waktunya sudah menyentuh angka 0*/
addEggOrGoldEgg([],0,0).
addEggOrGoldEgg([H|T],Egg,GoldEgg) :-
    H > 0,
    addEggOrGoldEgg(T,Egg,GoldEgg), !.
addEggOrGoldEgg([H|T],Egg,GoldEgg) :-
    H =:= 0,
    choice(['Egg', 'Golden Egg'], [0.8, 0.2], X),
    (X = 'Egg' -> 
    addEggOrGoldEgg(T,Egg1,GoldEgg),
    Egg is 1+Egg1;
    addEggOrGoldEgg(T,Egg,GoldEgg1),
    GoldEgg is 1+GoldEgg1).

/* Menghasilkan list dengan elemen yang sama dengan 0 diganti dengan X*/
changeList([],_,[]).
changeList([H|T],X,[H1|T1]) :-
    H > 0,
    changeList(T,X,T1), !,
    H1 is H.
changeList([H|T],X,[H1|T1]) :-
    H =:= 0,
    changeList(T,X,T1),
    H1 is X.

/* Menambah egg */
addEgg :-
    retractall(produceEgg(E)), addEggOrGoldEgg(E,Y1,Y2),
    retractall(egg(X1)), X2 is X1+Y1, 
    retractall(goldenEgg(X3)), X4 is X3+Y2, 
    assertz(egg(X2)), assertz(goldenEgg(X4)),
    changeList(E, 20, Z),
    assertz(produceEgg(Z)).
/* Menambah wool */
addWool :-
    retractall(produceWool(W)), addItemRanch(W,Y),
    retractall(wool(X)), X1 is X+Y,
    assertz(egg(X1)),
    changeList(W, 60, Z),
    assertz(produceWool(Z)).
/* Menambah milk */
addMilk :-
    retractall(produceMilk(M)), addItemRanch(M,Y),
    retractall(milk(X)), X1 is X+Y,
    assertz(milk(X1)),
    changeList(M, 30, Z),
    assertz(produceMilk(Z)).
/* Menambah poultry */
addPoultry :-
    producePoultry(P), addItemRanch(P,Y),
    retractall(poultry(X)), X1 is X+Y,
    assertz(poultry(X1)).
/* Menambah sheep meat */
addSheepMeat :-
    produceSheepMeat(P), addItemRanch(P,Y),
    retractall(sheepMeat(X)), X1 is X+Y,
    assertz(sheepMeat(X1)).
/* Menambah beef */
addBeef :-
    produceBeef(P), addItemRanch(P,Y),
    retractall(beef(X)), X1 is X+Y,
    assertz(beef(X1)).

/* Mengurangi satu satuan waktu tiap element di list produce */
decOnePerElmt([],[]).
decOnePerElmt([H|T],[H1|T1]) :-
    H =:= 0,
    decOnePerElmt(T,T1),
    H1 is H.
decOnePerElmt([H|T], [H1|T1]) :-
    H > 0,
    decOnePerElmt(T,T1),
    H1 is H-1.

/* Update kondisi ranch tiap hari */
/* Rule ini harus dipanggil tiap pergantian hari */
updateRanch :-
    retractall(produceEgg(E)), retractall(producePoultry(P)), retractall(produceWool(W)),
    retractall(produceSheepMeat(SM)), retractall(produceMilk(M)), retractall(produceBeef(B)),
    decOnePerElmt(E,E1), decOnePerElmt(P,P1), decOnePerElmt(W,W1), 
    decOnePerElmt(SM,SM1), decOnePerElmt(M,M1), decOnePerElmt(B,B1),
    assertz(produceEgg(E1)), assertz(producePoultry(P1)), assertz(produceWool(W1)),
    assertz(produceSheepMeat(SM1)), assertz(produceMilk(M1)), assertz(produceBeef(B1)),
    addEgg, addWool, addMilk, addPoultry, addSheepMeat, addBeef.

/* Append L2 ke L1 sebanyak X kali */
appendXElmt(0, L, _, L).
appendXElmt(X, L1, L2, L3) :-
    append(L1, L2, Res),
    X1 is X-1,  
    appendXElmt(X1, Res, L2, L3).

/* Hewan baru */
/* newAnimal(X), X berarti banyak hewan baru */
/* Konfigurasi apabila ada ayam baru */
newChicken(X) :-
    retractall(totalChicken(PrevTotal)),
    NewTotal is PrevTotal+X,
    assertz(totalChicken(NewTotal)),
    retractall(produceEgg(PrevList1)),
    /* Asumsi ayam butuh waktu 20 hari buat bertelur (sample belum fix) */
    appendXElmt(X,PrevList1,[20],NewList1),
    assertz(produceEgg(NewList1)),
    retractall(producePoultry(PrevList2)),
    /* Asumsi ayam siap panen di umur 40 hari (sample belum fix) */
    appendXElmt(X,PrevList2,[40],NewList2),
    assertz(producePoultry(NewList2)).

/* Konfigurasi apabila ada domba baru */
newSheep(X) :-
    retractall(totalSheep(PrevTotal)),
    NewTotal is PrevTotal+X,
    assertz(totalSheep(NewTotal)),
    retractall(produceWool(PrevList1)),
    /* Asumsi domba butuh waktu 60 hari sampai bulunya siap dicukur (sample belum fix) */
    appendXElmt(X,PrevList1,[60],NewList1),
    assertz(produceWool(NewList1)),
    retractall(produceSheepMeat(PrevList2)),
    /* Asumsi domba siap panen di umur 80 hari (sample belum fix) */
    appendXElmt(X,PrevList2,[80],NewList2),
    assertz(produceSheepMeat(NewList2)).

/* Konfigurasi apabila ada sapi baru */
newCow(X) :-
    retractall(totalCow(PrevTotal)),
    NewTotal is PrevTotal+X,
    assertz(totalCow(NewTotal)),
    retractall(produceMilk(PrevList1)),
    /* Asumsi sapi butuh waktu 30 hari sampai susunya siap diperah (sample belum fix) */
    appendXElmt(X,PrevList1,[30],NewList1),
    assertz(produceMilk(NewList1)),
    retractall(produceBeef(PrevList2)),
    /* Asumsi sapi siap panen di umur 100 hari (sample belum fix) */
    appendXElmt(X,PrevList2,[100],NewList2),
    assertz(produceBeef(NewList2)).

/* Hewan dijual */
/* Jual chicken */
sellChicken(X) :-
    retractall(totalChicken(PrevTotal)),
    NewTotal is PrevTotal-X,
    assertz(totalChicken(NewTotal)),
    retractall(produceEgg(PrevList1)),
    /* Asumsi ayam butuh waktu 20 hari buat bertelur (sample belum fix) */
    removeXElmt(X,PrevList1,NewList1),
    assertz(produceEgg(NewList1)),
    retractall(producePoultry(PrevList2)),
    /* Asumsi ayam siap panen di umur 40 hari (sample belum fix) */
    removeXElmt(X,PrevList2,NewList2),
    assertz(producePoultry(NewList2)).
    
/* Jual sheep */
sellSheep(X) :-
    retractall(totalSheep(PrevTotal)),
    NewTotal is PrevTotal+X,
    assertz(totalSheep(NewTotal)),
    retractall(produceWool(PrevList1)),
    /* Asumsi domba butuh waktu 60 hari sampai bulunya siap dicukur (sample belum fix) */
    removeXElmt(X,PrevList1,NewList1),
    assertz(produceWool(NewList1)),
    retractall(produceSheepMeat(PrevList2)),
    /* Asumsi domba siap panen di umur 80 hari (sample belum fix) */
    removeXElmt(X,PrevList2,NewList2),
    assertz(produceSheepMeat(NewList2)).

/* Jual cow */
sellCow(X) :-
    retractall(totalCow(PrevTotal)),
    NewTotal is PrevTotal+X,
    assertz(totalCow(NewTotal)),
    retractall(produceMilk(PrevList1)),
    /* Asumsi sapi butuh waktu 30 hari sampai susunya siap diperah (sample belum fix) */
    removeXElmt(X,PrevList1,NewList1),
    assertz(produceMilk(NewList1)),
    retractall(produceBeef(PrevList2)),
    /* Asumsi sapi siap panen di umur 100 hari (sample belum fix) */
    removeXElmt(X,PrevList2,NewList2),
    assertz(produceBeef(NewList2)).

/* 
TODO:
    - kalo udah gak di tile ranch lagi, isAtTheRanch-nya di retract
    - kalo jual/beli ayam, domba, atau sapi, kondisi di ranch harus diupdate
*/