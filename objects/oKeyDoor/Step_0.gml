
if(variable_global_exists(globalName))
	key = variable_global_get(globalName);

if(key && distance_to_object(oPlayer) < 16){
	repeat(64){
		randomize();
		var _xx = x + random(32);
		var _yy = y  + random(128);
		part_particles_create(global.particleSystem, _xx, _yy, global.particleSparkles, 1);
	}
		
	camShake(2, 5);
	instance_destroy(self);
}