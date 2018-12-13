# sieve

![Sieves](https://raw.githubusercontent.com/Teslov-Mikhail/sieve/master/screenshots/screenshot_20181213_175615.png "Sieves")

Minetest mod that adds Sieve/Sifter to the game.

### Dependencies

```
default
farming?
```

### Crafting

W - Wood
S - Steel ingot
I - Stick

```
W S W
W W W
I I I
```

![Crafting](https://raw.githubusercontent.com/Teslov-Mikhail/sieve/master/screenshots/screenshot_20181213_175828.png "Crafting")

### Built-in Outpus

#### Gravel

![Gravel](https://github.com/Teslov-Mikhail/sieve/raw/master/screenshots/screenshot_20181213_180811.png "Gravel")

- Flint `70%`
- Coal `20%`
- Iron `5%`
- Copper `5%`
- Tin `5%`
- Mese `0.5%`
- Gold `2%`
- Diamond `0.2%`
- Clay `40%`

#### Dirt ( Only with farming mod )

![Dirt](https://github.com/Teslov-Mikhail/sieve/raw/master/screenshots/screenshot_20181213_180849.png "Dirt")

- Wheat seed `50%`
- Wheat seed x 2 `10%`
- Cotton seed `20%`
- Cotton seed x 2 `2.5%`

### API

`chance` is a number from 1 to 1000.
500 means 50% chance, 1000 is 100% etc.

```lua
sieve.register_siftable("mod:item_name", {
  { "mod:drop_1 amount", chance },
  { "mod:drop_2 amount", chance }
})
```

#### Example

```lua
sieve.register_siftable("default:gravel", {
  { "default:default_flint", 700 },
  { "default:coal_lump", 200 },
  { "default:iron_lump", 50 },
  { "default:copper_lump", 50 },
  { "default:tin_lump", 50 },
  { "default:mese_crystal", 5 },
  { "default:gold_lump", 20 },
  { "default:diamond", 2 },
  { "default:clay_lump", 400 }
})
```
