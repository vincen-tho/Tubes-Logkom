/* DEKLARASI SEMUA TANAMAN */

/* STATIS */
/* Tanaman, huruf, dan waktu untuk panen */
plantedLetter('Reed', 'x ', 0).
plantedLetter('Wheat', 'w ', 72).
plantedLetter('Corn', 'c ', 168).
plantedLetter('Tomato', 'x ', 0).
plantedLetter('Rice', 'x ', 0).
plantedLetter('Potato', 'p ', 96).
plantedLetter('Magic Mushroom', 'm ', 120).
plantedLetter('Rice Seed', 'r ', 144).
plantedLetter('Tomato Seed', 't ', 48).

/* Tanaman, hasil panen, kuantitas */
harvestResult('w ', 'Wheat', 3).
harvestResult('c ', 'Corn', 3).
harvestResult('p ', 'Potato', 4).
harvestResult('m ', 'Magic Mushroom', 2).
harvestResult('r ', 'Rice', 2).
harvestResult('t ', 'Tomato', 2).

illegalLetter('x ').
/* DINAMIS */
/* plantTime digunakan untuk menyimpan data kapan tanaman ditanam dan lama waktu untuk dapat dipanen */
/* plantTime(X, Y, PLANTEDTIME, TIMETOHARVEST) */
:- dynamic(plantTime/4).