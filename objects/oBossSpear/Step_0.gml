
collide = place_meeting(x, y, oPlayer) || place_meeting(x, y, oParWall);

if(followPlayer && instance_exists(oPlayer) && time > 0){
	
	direction = point_direction(x, y, oPlayer.x, oPlayer.y);
	finalAngle = direction;
}

if(time-- < 0){
	if(sound){
		sound = false;
		audio_play_sound(snCastSpear, 1, 0)
	}
	speed = spd;
}

if(collide && time < 0){
	var _player = instance_place(x, y, oPlayer);
	if(_player){
		damagePlayer(1);
		
		if(_player.state == _player.stateDash)
			exit;
	}
	
	part_type_direction(oParticle.particleImpact, (image_angle - 180) - 45, (image_angle - 180) + 45, 0, 0);
	
	camShake(2, 1);
	
	repeat(6){
		var _xx = x + random_range(-8, 8);
		var _yy = y + random_range(-16, 16);
		
		part_particles_create(global.particleSystem, _xx, _yy, global.particleSparkles, 1);
	}
	
	part_particles_create(global.particleSystem, x, y, oParticle.particleImpact, 3);
	audio_play_sound(snSpearImpact, 1, 0)
	instance_destroy(self);
}

image_angle = lerp(image_angle, finalAngle, .1);
image_xscale = lerp(image_xscale, 1, .05);
image_yscale = lerp(image_yscale, 1, .05);
