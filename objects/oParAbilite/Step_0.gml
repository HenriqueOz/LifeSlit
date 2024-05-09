


if(variable_global_get(globalName) == true){
	instance_destroy(self);
	exit;
}

if(createParticle-- < 0){
	part_particles_create_color(global.particleSystem, x + random_range(-20, 20), y - random_range(20, -20), oParticle.particleHealing, -1, 3);
	createParticle = 2;
}

if(instance_exists(oPlayer)){
	var _player = instance_place(x, y, oPlayer);
	
	if(_player){		
		variable_global_set(globalName, true);
		_player.canControl = false;
		_player.blinkGreen = 45;
		
		onPickup();
	}
}
