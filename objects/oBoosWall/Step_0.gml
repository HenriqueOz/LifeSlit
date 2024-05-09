
if(!variable_global_get(key)){
	mask_index = sEmpty	
}else{
	if(particle-- < 0){
		var _xx = x + irandom_range(0, width);
		var _yy = y + irandom_range(0, height);
		
		part_particles_create(global.particleSystem, _xx, _yy, global.particleSparkles, 1);
		
		particle = 1;
	}
}

