if(instance_exists(oPlayer)){
	with(oPlayer){
		if(canHurt && !invencible && state != stateDash && state != stateHurt){
			hp -= 1;
			state = stateHurt;
			
			repeat(6){
				var _xx = other.x + random_range(-8, 8);
				var _yy = other.y + random_range(-8, 8);
		
				part_particles_create(global.particleSystem, _xx, _yy, global.particleSparkles, 1);
			}
			
			instance_destroy(other.id);
			return;
		}
	}
}