if(instance_place(x, y, oPlayer) && state == -1){
	state = 0;
}

if(state == 0){
	timer++;
	camShake(3, 3);
		
	if(timer > 50){
		state = 1;
	}
}

if(state == 1){
	timer++;
	with(oBreakWall){
		breaked = true;
	}
}
