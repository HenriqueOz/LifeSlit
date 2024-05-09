
if(state != stateDash){
	//if(keyboard_check_pressed(ord("T")) && canHurt){
	//	state = stateHurt;
	//	hp -= 1;
	//}

	//colisão com espinhos
	if(instance_place(x, y, oSpike) && canHurt && !invencible){
		state = stateHurt;
		hp -= 1;
	}
}

//if(keyboard_check_pressed(ord("Q"))){
//	global.playerAbiliteClimb = true;
//	global.playerAbiliteDash = true;
//	global.playerAbiliteFly = true;
//	global.playerAbilitePower = true;
	
//	global.playerHp1 = true;
//	global.playerHp2 = true;
//	global.playerHp3 = true;
//	global.playerHp4 = true;
	
//	lifeShard = 3;
//	global.maxHp = 8;
//	maxHp = 8;
//	hp = 8;
//	oldHp = 8;
//}

//hp = clamp(hp, 3, global.maxHp);
//mana = 4;
//lifeShard = 99;