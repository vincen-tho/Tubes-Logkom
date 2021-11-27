/* barang */
% barang(X, Y, Z), X adalah nama item, Y adalah harga item, Z adalah kategori item

/* FARMING */
barang('Reed', 0, 'F').
barang('Wheat', 100, 'F').
barang('Corn', 150, 'F').
barang('Tomato', 200, 'F').
barang('Rice', 250, 'F').
barang('Potato', 300, 'F').
barang('Magic Mushroom', 1850, 'F').

barang('Rice Seed', 150, 'F').
barang('Tomato Seed', 125, 'F').


/* RANCH */
barang('Dung', 0, 'R').
barang('Egg', 110, 'R').
barang('Milk', 160, 'R').
barang('Chicken', 210, 'R').
barang('Wool', 250, 'R').
barang('Sheep Meat', 290, 'R').
barang('Beef', 400, 'R').
barang('Golden Egg', 1550, 'R').

/* FISHING */
barang('Bottle', 10, 'H').
barang('Catfish', 80, 'H').
barang('Cod', 170, 'H').
barang('Salmon', 270, 'H').
barang('Tuna', 450, 'H').
barang('Puffer Fish', 1750, 'H').


/* EQUIPMENT */
% equipment(X, Y), X adalah nama equipment, Y adalah kategori

/* FARMING */
equipment('Shovel', 'F').
equipment('Water Sprinkler', 'F').

/* RANCHING */
equipment('Shearer', 'R').
equipment('Bucket', 'R').

/* FISHING */
equipment('Fishing Rod', 'H').
equipment('Bait', 'H').




