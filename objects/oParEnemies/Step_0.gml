if(freezeTime-- > 0){
	image_index = freezeFrame;
	exit;
}

//cool down de tomar hit
hittedCoolDown[0]--;
flashTime[0]--;

if(hittedCoolDown[0] < 0){
	canBeHitted = true;
}

isAlive = hp <= 0 ? false : true;

if(hasLifeShard && t mod 8 == 0){
	var _xx = x + random_range(-sprite_width/2 + 5, sprite_width/2 - 5);
	var _yy = y - random(sprite_height) - 5;
	var _color = make_color_hsv(110 + random_range(-20, 20), 195, 215);
	part_particles_create_color(global.particleSystem, _xx, _yy, global.particleDrop, _color, 1);
}
t++;

if(hasLifeShard && !isAlive){
	instance_create_layer(x, y, "entities", oLifeShard);
	hasLifeShard = false;
}

if(!isAlive){
	var _list = global.deadList;
	ds_list_add(_list, id);
}