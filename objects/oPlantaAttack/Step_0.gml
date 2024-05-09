if(!instance_exists(oPlayer))
	instance_destroy(self);

if(timerGhost-- < 0){
	
	var _xx = x + random_range(-15, 15);
	var _yy = y + random_range(-15, 15);
	
	var _a = noone;
	
	with(instance_create_layer(_xx, _yy, layer, oGhost)){
		alphaInc = -.1;
		xscale = other.image_xscale;
		sprite = other.sprite_index;
		fog = false;
		color = choose(c_purple, c_fuchsia);
		depth = other.depth + 1;
		_a = id;
	}
	instance_destroy(_a.light);
	
	timerGhost = 2;
}

vspd += grv;
x += hspd;
y += vspd;

if(instance_exists(light)){
	light.drawX = x;
	light.drawY = y;
}