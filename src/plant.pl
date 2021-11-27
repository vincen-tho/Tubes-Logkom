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

illegalLetter('x  ').
/* DINAMIS */
/* plantTime digunakan untuk menyimpan data kapan tanaman ditanam dan lama waktu untuk dapat dipanen */
/* plantTime(X, Y, PLANTEDTIME, TIMETOHARVEST) */
:- dynamic(plantTime/4).