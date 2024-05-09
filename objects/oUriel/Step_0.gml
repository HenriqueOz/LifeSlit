if(freezeTime-- > 0){
	image_index = freezeFrame;
	exit;
}

//checando se ele tomou um poder
if(powerDamage){
	takeDamage(2);
	powerDamage = false;
}

//fugindo depois de levar uns hits
if(runCheck && moving){
	run();
}

//checando se pode levar hit
if(hitCooldown-- < 0){
	hitAble = true;
}else{
	hitAble = false;
}

//criando ghost
if(ghostTimer-- < 0 && hp > 0){
	var _a = noone;
		
	with(instance_create_layer(x, y, layer, oGhost)){
		alphaInc = -.1;
		xscale = other.image_xscale;
		sprite = other.sprite_index;
		image = other.image_index;
		fog = false;
		color = make_color_hsv(45, 200, 200);
		depth = other.depth + 1;
		_a = id;	
	}
	//ghostTimer = 1;
		
	instance_destroy(_a.light);
}	

//movimento
if(moving){
	if(place_meeting(x + 5, y, oBoosWall) || place_meeting(x - 5, y, oBoosWall)){
		getRunx();
		runCheck = true;		
	}
	
	x += cos(current_time/200) * 1;
	y += sin(current_time/400) * 1;
}

//checando se está vivo
if(hp <= 0){
	state = death;
}

//state machine
state();

x = clamp(x, 32, room_width - 32);