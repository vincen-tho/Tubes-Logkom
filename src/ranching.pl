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
    isAtTheRanch(_),
    write('You already at the ranch!'), !.
ranch :- 
    checkPosRanch,
    \+isAtTheRanch(_),
    totalChicken(X),
    totalSheep(Y),
    totalCow(Z),
    write('Welcome to the ranch! You have:'), nl,
    write(X), write(' '), write(chicken), nl,    
    write(Y), write(' '), write(sheep), nl,    
    write(Z), write(' '), write(cow), nl, nl,
    write('What do you want to do?'),
    assertz(isAtTheRanch(true)).   

/* Cek kondisi hewan ternak */
/* Command chicken mengecek apakah ayam bertelur atau sudah siap panen (ayam diambil untuk kemudian dikonsumsi) */
chicken :-
    \+isAtTheRanch(_),
    write('Enter to the ranch first!'), !.
chicken :-
    isAtTheRanch(_),
    egg(X), chicken(Y),
    gainedExpRanch(Z),
    (X > 0 -> write('Your chickens lay '), write(X), write(' eggs!'), nl;
    write('Your chickens didn\'t lay any eggs!'), nl), 
    (Y >= 1 -> write('You got a poultry!'), nl;
    Y > 1 -> write('You got '), write(Y), write(' poultries!'), nl;
    write('You didn\'t get any poultries'), nl),
    (X =:= 0, Y =:= 0 -> write('Please check again later!');
    write('You gained '), write(Z), write(' ranching exp!'),
    addRanchingEXP(Z), addEXP(Z)).

/* Command sheep mengecek apakah domba siap panen (domba diambil untuk kemudian dikonsumsi) atau bulunya siap dicukur (wool) */
sheep :-
    \+isAtTheRanch(_),
    write('Enter to the ranch first!'), !.
sheep :-
    wool(X), sheepMeat(Y),
    gainedExpRanch(Z),
    (X > 0 -> write('You got '), write(X), write(' wools!'), nl;
    write('You didn\'t get any wools!'), nl), 
    (Y >= 1 -> write('You got a sheep meat!'), nl;
    Y > 1 -> write('You got '), write(Y), write(' sheep meats!'), nl;
    write('You didn\'t get any sheep meats'), nl),
    (X =:= 0, Y =:= 0 -> write('Please check again later!');
    write('You gained '), write(Z), write(' ranching exp!')
    addRanchingEXP(Z), addEXP(Z)).

/* Command cow mengecek apakah sapi siap panen (sapi diambil untuk kemudian dikonsumsi) atau siap diperah susunya */
cow :-
    \+isAtTheRanch(_),
    write('Enter to the ranch first!'), !.
cow :-
    milk(X), beef(Y),
    gainedExpRanch(Z),
    (X > 0 -> write('You got '), write(X), write(' milks!'), nl;
    write('You didn\'t get any milks!'), nl), 
    (Y >= 1 -> write('You got a beef!'), nl;
    Y > 1 -> write('You got '), write(Y), write(' beefs!'), nl;
    write('You didn\'t get any beefs'), nl),
    (X =:= 0, Y =:= 0 -> write('Please check again later!');
    write('You gained '), write(Z), write(' ranching exp!')
    addRanchingEXP(Z), addEXP(Z)).

/* Hewan baru */
/* Konfigurasi apabila ada ayam baru */
newChicken :-
    retractall(totalChicken(PrevTotal)),
    NewTotal is PrevTotal+1,
    assertz(totalChicken(NewTotal)),
    retractall(produceEgg(PrevList1)),
    /* Asumsi ayam butuh waktu 20 hari buat bertelur (sample belum fix) */
    append(PrevList1,[20],NewList1),
    assertz(produceEgg(NewList1)),
    retractall(producePoultry(PrevList2)),
    /* Asumsi ayam siap panen di umur 40 hari (sample belum fix) */
    append(PrevList2,[40],NewList2),
    assertz(producePoultry(NewList2)).

/* Konfigurasi apabila ada domba baru */
newSheep :-
    retractall(totalSheep(PrevTotal)),
    NewTotal is PrevTotal+1,
    assertz(totalSheep(NewTotal)),
    retractall(produceWool(PrevList1)),
    /* Asumsi domba butuh waktu 60 hari sampai bulunya siap dicukur (sample belum fix) */
    append(PrevList1,[60],NewList1),
    assertz(produceWool(NewList1)),
    retractall(produceSheepMeat(PrevList2)),
    /* Asumsi domba siap panen di umur 80 hari (sample belum fix) */
    append(PrevList2,[80],NewList2),
    assertz(produceSheepMeat(NewList2)).

/* Konfigurasi apabila ada sapi baru */
newCow :-
    retractall(totalCow(PrevTotal)),
    NewTotal is PrevTotal+1,
    assertz(totalCow(NewTotal)),
    retractall(produceMilk(PrevList1)),
    /* Asumsi sapi butuh waktu 30 hari sampai susunya siap diperah (sample belum fix) */
    append(PrevList1,[30],NewList1),
    assertz(produceMilk(NewList1)),
    retractall(produceBeef(PrevList2)),
    /* Asumsi sapi siap panen di umur 100 hari (sample belum fix) */
    append(PrevList2,[100],NewList2),
    assertz(produceBeef(NewList2)).

/* Menghasilkan jumlah item yang waktunya sudah menyentuh angka 0*/
addItem([],0).
addItem([H|T],Item) :-
    H > 0,
    addItem(T,Item), !.
addItem([H|T],Item) :-
    H =:= 0,
    addItem(T,Item1),
    Item is 1+Item1.

/* Menghasilkan list dengan elemen yang sama dengan 0 diganti dengan X*/
changeList([],_,[]).
changeList([H|T],X,[H1|T1]) :-
    H > 0,
    changeList(T,X,T1),
    H1 is H.
changeList([H|T],X,[H1|T1]) :-
    H =:= 0,
    changeList(T,X,T1),
    H1 is X.

/* Menambah egg */
addEgg :-
    produceEgg(E), addItem(E,Y),
    (Y > 0 ->
    egg(X), X1 is X+Y, 
    retractall(egg(_)), assertz(egg(X1)),
    changeList(E, 20, Z),
    retractall(produceEgg(_)), assertz(produceEgg(Z))).
/* Menambah wool */
addWool :-
    produceWool(W), addItem(W,Y),
    (Y > 0 ->
    wool(X), X1 is X+Y,
    retractall(wool(_)), assertz(egg(X1)),
    changeList(W, 60, Z),
    retractall(produceWool(_)), assertz(produceWool(Z))).
/* Menambah milk */
addMilk :-
    produceMilk(M), addItem(M,Y),
    (Y > 0 ->
    milk(X), X1 is X+Y,
    retractall(milk(_)), assertz(milk(X1)),
    changeList(M, 30, Z),
    retractall(produceMilk(_)), assertz(produceMilk(Z))).

/* TODO: menambah poultry, sheep meat, dan beef */

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
    produceEgg(E), producePoultry(P), produceWool(W), 
    produceSheepMeat(SM), produceMilk(M), produceBeef(B),
    decOnePerElmt(E,E1), decOnePerElmt(P,P1), decOnePerElmt(W,W1), 
    decOnePerElmt(SM,SM1), decOnePerElmt(M,M1), decOnePerElmt(B,B1),
    retractall(produceEgg(_)), retractall(producePoultry(_)), retractall(produceWool(_)),
    retractall(produceSheepMeat(_)), retractall(produceMilk(_)), retractall(produceBeef(_)),
    assertz(produceEgg(E1)), assertz(producePoultry(P1)), assertz(produceWool(W1)),
    assertz(produceSheepMeat(SM1)), assertz(produceMilk(M1)), assertz(produceBeef(B1)),
    