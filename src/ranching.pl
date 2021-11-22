/* Include */
:- include('player.pl').
:- include('map.pl').

/* Dynamic */
:- dynamic(totalChicken/1).
:- dynamic(totalSheep/1).
:- dynamic(totalCow/1).
:- dynamic(gainedExpRanch/1).
:- dynamic(produceEgg/1).
:- dynamic(produceChicken/1).
:- dynamic(produceWool/1).
:- dynamic(produceSheep/1).
:- dynamic(produceMilk/1).
:- dynamic(produceCow/1).
:- dynamic(egg/1).
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
/* produceChicken(X), X berarti list waktu yang dibutuhkan setiap ayam sampai siap dipanen */
produceChicken([]).
/* produceWool(X), X berarti list waktu yang dibutuhkan setiap domba sampai bulunya siap dicukur */
produceWool([]).
/* produceSheep(X), X berarti list waktu yang dibutuhkan setiap domba sampai siap dipanen */
produceSheep([]).
/* produceMilk(X), X berarti list waktu yang dibutuhkan setiap sapu sampai susunya siap diperah */
produceMilk([]).
/* produceCow(X), X berarti list waktu yang dibutuhkan setiap sapi sampai siap dipanen */
produceCow([]).
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
    retract(gainedExpRanch(_)),
    playerRanchingLevel(X),
    Y is X*2,
    Y1 is 5+Y,
    assertz(gainedExpRanch(Y1)).

/* Ranching */
/* TODO: tambah pengecekan posisi player, sedang berada di tile ranch atau tidak */
ranch :- 
    totalChicken(X),
    totalSheep(Y),
    totalCow(Z),
    write('Welcome to the ranch! You have:'), nl,
    write(X), write(' '), write(chicken), nl,    
    write(Y), write(' '), write(sheep), nl,    
    write(Z), write(' '), write(cow), nl, nl,
    write('What do you want to do?').   

/* Cek kondisi hewan ternak */
/* Command chicken mengecek apakah ayam bertelur atau sudah siap panen (ayam diambil untuk kemudian dikonsumsi) */
chicken :-
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
    retract(totalChicken(PrevTotal)),
    NewTotal is PrevTotal+1,
    assertz(totalChicken(NewTotal)),
    retractall(produceEgg(PrevList1)),
    /* Asumsi ayam butuh waktu 20 hari buat bertelur (sample belum fix) */
    append(PrevList1,[20],NewList1),
    assertz(produceEgg(NewList1)),
    retractall(produceChicken(PrevList2)),
    /* Asumsi ayam siap panen di umur 40 hari (sample belum fix) */
    append(PrevList2,[40],NewList2),
    assertz(produceChicken(NewList2)).

/* Konfigurasi apabila ada domba baru */
newSheep :-
    retract(totalSheep(PrevTotal)),
    NewTotal is PrevTotal+1,
    assertz(totalSheep(NewTotal)),
    retractall(produceWool(PrevList1)),
    /* Asumsi domba butuh waktu 60 hari sampai bulunya siap dicukur (sample belum fix) */
    append(PrevList1,[60],NewList1),
    assertz(produceWool(NewList1)),
    retractall(produceSheep(PrevList2)),
    /* Asumsi domba siap panen di umur 80 hari (sample belum fix) */
    append(PrevList2,[80],NewList2),
    assertz(produceSheep(NewList2)).

/* Konfigurasi apabila ada sapi baru */
newCow :-
    retract(totalCow(PrevTotal)),
    NewTotal is PrevTotal+1,
    assertz(totalCow(NewTotal)),
    retractall(produceMilk(PrevList1)),
    /* Asumsi sapi butuh waktu 30 hari sampai susunya siap diperah (sample belum fix) */
    append(PrevList1,[30],NewList1),
    assertz(produceMilk(NewList1)),
    retractall(produceCow(PrevList2)),
    /* Asumsi sapi siap panen di umur 100 hari (sample belum fix) */
    append(PrevList2,[100],NewList2),
    assertz(produceCow(NewList2)).

/* 
TODO: 
    - buat rules yang nambahin hasil egg, poultry, wool, sheep meat, milk, dan beef setelah melewati kondisi tertentu
    - tambah rules yang mengurangi waktu di list produce tiap hari
*/ 