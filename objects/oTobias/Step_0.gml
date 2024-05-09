/// @description Insert description here
// You can write your code in this editor


// Inherit the parent event
event_inherited();

light.drawX = x;
light.drawY = y;

if(isAlive){
	var _dir = instance_place(x, y, oTobiasDir);
	if(_dir && dir != _dir.image_angle){
		dir = _dir.image_angle;
		changeDir = true;
		rotateTimer = 15;
	}

	if(changeDir){
		if(rotateTimer-- > 0){
			if(dir == 270)
				image_angle = lerp(image_angle, -90, .1);//quando vai girar pra 270 tem que ser no sentido horário
			else
				image_angle = lerp(image_angle, dir, .1);
		}else{
			image_angle = dir;
			changeDir = false;
		}
	}else{
		x += lengthdir_x(spd, dir);
		y += lengthdir_y(spd, dir);
	}

	playerCollide = place_meeting(x, y, oPlayer);
	if(playerCollide){
		damagePlayer(1);
	}
}else{
	if(deathTimer == deathTimerAnimation){
		if(!audio_is_playing(snTobiasDeath))
			audio_play_sound(snTobiasDeath, 1, 0);
		
		part_particles_create(global.particleSystem, x, y - sprite_get_height(sprite_index)/2, global.particleEnemyDeath, 12);
	}
	
	light.alpha = 1/deathTimerAnimation * deathTimer;
	
	if(deathTimer-- < 0){
		instance_destroy(light);
		instance_destroy(self);
	}
}


