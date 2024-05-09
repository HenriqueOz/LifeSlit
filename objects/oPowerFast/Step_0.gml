	

image_xscale = dirx;
x += spd * dirx;
t++;

if(partNumb < 1)
	partNumb += .5;
else
	partNumb = 0;
part_particles_create(global.particleSystem, x, y, global.particleEnemyDeath, partNumb);
				
//caso colida
if(t > 0){
	if(instance_place(x, y, oCollidersFather) || instance_place(x, y, oParEnemies) || instance_place(x, y, oLever) || instance_place(x, y, oUriel)){
		var _l = instance_place(x, y, oLever);
		if(instance_exists(_l))
			_l.inInteraction = true;
		
		var _u = instance_place(x, y, oUriel);
		if(instance_exists(_u))
			_u.powerDamage = true;
		
		
		repeat(7){
			var _xx = x + random_range(-10, 10);	
			var _yy = y + random_range(-10, 10);	
			
			part_particles_create(global.particleSystem, _xx, _yy, global.particleSparkles, 1);
		}
		
		with(instance_place(x, y, oParEnemies)){
			takeDamage(other.damage);
		}
		
		audio_play_sound(snPowerImpact, 1, 0);
		
		camShake(3, 5);
		createOneTimeSprite(x, y, sPowerImpact, 0, dirx, 1, 0);
		instance_destroy(self);
	}
}


	