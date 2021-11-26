/* DEKLARASI SEMUA TANAMAN */

/* STATIS */
/* Tanaman dan huruf */
plantedLetter('Reed', 'x ').
plantedLetter('Wheat', 'w ').
plantedLetter('Corn', 'c ').
plantedLetter('Tomato', 'x ').
plantedLetter('Rice', 'x ').
plantedLetter('Potato', 'p ').
plantedLetter('Magic Mushroom', 'm ').
plantedLetter('Rice Seed', 'r ').
plantedLetter('Tomato Seed', 't ').

/* DINAMIS */
/* plantTime(X, Y, PLANTEDTIME) */
:- dynamic(plantTime/3).