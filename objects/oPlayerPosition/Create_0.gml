///@description reposiciona o players

tx = 0;
ty = 0;
rm = 0;
createPlayer = true;

//dados default do player
playerData = {
	x : tx,
	y : ty,
	hp : global.maxHp,
	oldHp : global.maxHp,
	maxHp : global.maxHp,
	mana : 4,
	maxMana : 4,
	powerCoolDown : 0,
	lifeShard : 0,
	dirx : 1,
	hspd : 0,
	vspd : 0
};