event_inherited();

light = instance_create_layer(x, y, layer, oLightEntities);
light.scalex = 1;
light.scaley = 1;
light.oscilation = 20;
light.alpha = 1;
light.image_angle = 0;
light.colorOverlay = false;
light.intensity = .1;//ente 0 e 1
light.color = c_white;

hp = 2;

depth = layer_get_depth("water");
spd = .2;
dir = 0;
dirx = 1;
changeDirTimer = 0;
startTimer = 30;
moveTimer = 0;
deathTimerAnimation = 20;
playSound = true;

playerCollide = false;

stateFree = function(){
	
	if(!isAlive){
		deathTimer = deathTimerAnimation;
		startTimer = 30;
		state = stateDeath;
		return;
	}
	
	if(hit){
		hitTimer = deathTimerAnimation;
		startTimer = 30;
		state = stateHitted;
		return;
	}
	
	sprite_index = sPriquitoIdle;
	
	if(changeDirTimer-- < 0){
		changeDirTimer = 180;
		moveTimer = random_range(30, 120);
		if(point_distance(x, y, xstart, ystart) < 48){
			randomize();
			dir = random(360);
		}else{
			dir = point_direction(x, y, xstart, ystart);
		}
	}else{
		if(moveTimer-- > 0){
			x += lengthdir_x(spd, dir);
			y += lengthdir_y(spd, dir);	
		}
	}
	
	y += sin(current_time/150) * .25;
	
	if(distance_to_object(oPlayer) < 200 && startTimer-- < 0){
		startTimer = 30;
		state = stateChase;
	}else{
		if(distance_to_object(oPlayer) > 200)
			startTimer = 30;	
				
		if(startTimer < 30)
			dir = point_direction(x, y, oPlayer.x, oPlayer.y);
	}
}

chasing = true;
spdAmount = 0;
ghostTimer = 0;

stateChase = function(){
	if(!isAlive){
		deathTimer = deathTimerAnimation;
		state = stateDeath;
		return;
	}
	
	if(hit){
		hitTimer = deathTimerAnimation;
		state = stateHitted;
		return;
	}

	
	if(ghostTimer-- < 0){
		var _a = noone;
		
		with(instance_create_layer(x, y, "water", oGhost)){
			alphaInc = -.1;
			xscale = other.image_xscale;
			sprite = other.sprite_index;
			fog = false;
			color = c_aqua;
			depth = other.depth + 1;
			_a = id;	
		}
		ghostTimer = 1;
		
		instance_destroy(_a.light);
	}	
	
	if(chasing){
		dir = point_direction(x, y, oPlayer.x, oPlayer.y);
		spdAmount += 1;
		if(spdAmount >= 20 || playerCollide){
			audio_play_sound(snPiriquitoHit, 1, 0);
			spdAmount = 45;
			chasing = false;	
		}
	}else{
		spdAmount -= 1;
		
		if(spdAmount <= 0){
			state = stateFree;
			chasing = true;
			return;
		}
	}
	
	x += lengthdir_x(spd * spdAmount, dir);
	y += lengthdir_y(spd * spdAmount, dir);
}

hit = false;
hitTimer = 0;

stateHitted = function(){
	sprite_index = sPriquitoHurt;
	
	if(playSound){
		audio_play_sound(snPiriquitoDamage1, 1, 0);
		playSound = false;	
	}
	
	if(!isAlive){
		deathTimer = deathTimerAnimation;
		state = stateDeath;
		return;
	}
	
	if(hitTimer-- > 0){
		x += lengthdir_x(spd * hitTimer, dir - 180);
		y += lengthdir_y(spd * hitTimer, dir - 180);
	}else{
		spdAmount = -20;
		hit = false;
		playSound = true;
		state = stateFree;
	}
}

stateDeath = function(){
	x += lengthdir_x(deathTimer/4, dir - 180);
	y += lengthdir_y(deathTimer/4, dir - 180);
	
	sprite_index = sPriquitoHurt;
	
	if(deathTimer == deathTimerAnimation){
		audio_play_sound(snPiriquitoDeath, 1, 0);
		part_particles_create(global.particleSystem, x, y - sprite_get_height(sprite_index)/2, global.particleEnemyDeath, 12);
	}
	
	light.alpha = 1/deathTimerAnimation * deathTimer;
	
	if(deathTimer-- < 0){
		instance_destroy(light);
		instance_destroy(self);
	}
}

state = stateFree;