/* ITEMS */
% items(X, Y, Z), X adalah nama item, Y adalah harga item, Z adalah kategori item

/* FARMING */
items('Reed', 0, 'F').
items('Wheat', 100, 'F').
items('Corn', 150, 'F').
items('Tomato', 200, 'F').
items('Rice', 250, 'F').
items('Potato', 300, 'F').
items('Magic Mushroom', 1850, 'F').

items('Rice Seed', 150, 'F').
items('Tomato Seed', 125, 'F').


/* RANCH */
items('Dung', 0, 'R').
items('Egg', 110, 'R').
items('Milk', 160, 'R').
items('Chicken', 210, 'R').
items('Wool', 250, 'R').
items('Sheep Meat', 290, 'R').
items('Beef', 400, 'R').
items('Golden Egg', 1550, 'R').

/* FISHING */
items('Bottle', 10, 'H').
items('Catfish', 80, 'H').
items('Cod', 170, 'H').
items('Salmon', 270, 'H').
items('Tuna', 450, 'H').
items('Puffer Fish', 1750, 'H').


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




