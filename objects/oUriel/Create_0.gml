if(!global.urielAlive){
	instance_destroy(self);
	exit;
}

particleWarn = part_type_create();
part_type_shape(particleWarn, pt_shape_circle);
part_type_alpha3(particleWarn, 1, .5, .1);
part_type_blend(particleWarn, false);
part_type_color2(particleWarn, c_white, c_white);
part_type_direction(particleWarn, 0, 360, 0, 0);
part_type_gravity(particleWarn, 0, 0);
part_type_life(particleWarn, 30, 30);
part_type_orientation(particleWarn, 0, 360, 0, 0, true);
part_type_size(particleWarn, .1, .9, .05, 0);

warnParticles = function(_number, _x, _y){
	part_particles_create(global.particleSystem, _x, _y, particleWarn, _number);
}

inBattle = true;

hp = 40;
cooldown = 50;
t = 0;
attackWarnerTime = 0;
ghostTimer = 3;
powerDamage = false;

hitAble = false;
moving = false
attacks = 0;
x = room_width/2;

start = function(){
	var _xx = room_width/2;
	var _yy = room_height - 136;
	
	if(floor(x) != _xx || floor(y) != _yy){
		x = lerp(x, _xx, .045);
		y = lerp(y, _yy, .045);
	}else{
		moving = true;
		state = wait;
	}
}

throwx = random_range(32, room_width -32);
throwy = random_range(64, room_height - 48);
counterThrow = 0;
coolDownThrow = 0;

throwSpear = function(){
	moving = false;
	
	if(counterThrow < 4){
		if(coolDownSpear-- < 0){
			var _spear = instance_create_layer(x, y - sprite_height/2, layer, oBossSpear);
			//_spear.direction = point_direction(x, y - sprite_height/2, oPlayer.x, oPlayer.y);	
			_spear.image_angle = 90;
			_spear.followPlayer = true;
			_spear.time = 60;
			_spear.spd = 10;
			
			randomize();
			throwx = irandom_range(64, room_width - 64);
			throwy = irandom_range(96, room_height - 180);
			
			if(counterThrow == 2){
				throwy = room_height - 140;
			}
			
			audio_play_sound(snCastSpear, 1, 0);
			
			coolDownSpear = 30;
			counterThrow += 1;
			warnParticles(5, x, y - sprite_height/2);
		}else{
			x = lerp(x, throwx, .2);
			y = lerp(y, throwy, .2);
		}
	}
	
	if(counterThrow >= 4){
		attacks++;
		counterThrow = 0;
		coolDownSpear = 0;
		moving = true;
		oldState = state;
		state = wait;
		return;
	}
}


slashx = 64;
slashxEnd = 0;
slashing = false;
slashEnd = false;
slashDir = -1;

slash = function(){
	moving = false;
	
	slashx = slashDir == 1 ? 64 : room_width - 64;
	
	if(!slashEnd){
		if(!slashing){
			var _d = room_width - slashx;
			x = lerp(x, _d, .07);
			y = lerp(y, room_height - 40, .07);
		
			if(round(x) == _d && round(y) == room_height - 40){
				slashing = true;
				if(!audio_is_playing(snSlash))
					audio_play_sound(snSlash, 1, 0)
				warnParticles(1, x, y - sprite_height/2);
			}
		
		}else{
			var _col = collision_rectangle(x - sprite_width/2, y - sprite_height, x + sprite_width/2, y, oPlayer, false, false);
			if(_col){
				damagePlayer(1);
			}

			x = lerp(x, slashx, .1);
		
			if(round(x) == slashx){
				slashEnd = true;
				slashing = false;
			}
			
			slashxEnd = irandom_range(32, room_width - 32);
		}
	}else{
		x = lerp(x, slashxEnd, .1);
		y = lerp(y, room_height - 136, .1);
			
		if(round(y) == room_height - 136 && round(x) ==  slashxEnd){
			slashEnd = false;
			moving = true;
			slashDir = choose(1, -1);
			attacks++;
			oldState = state;
			state = wait;
			return;
		}
	}
}


counterRain = 0;
coolDownSpear = 60;
emptySpear = 4;
emptySpear2 = 14;

laserRain = function(){
	var i = 1;
	var _dist = 32;
	var _e = irandom_range(0, 10); randomise();
	emptySpear = emptySpear < 9 ? emptySpear + _e : emptySpear - _e;
	emptySpear2 = emptySpear <= 9 ? emptySpear + 9 : emptySpear - 9;
	var _xx = 16;
	var _yy = 16;

	if(coolDownSpear-- < 0 && !instance_exists(oBossSpear)){
		audio_play_sound(snCastLaser, 1, 0);
		
		repeat(18){
			if(i != emptySpear && i != emptySpear2){
				var _laser = instance_create_layer(_xx + _dist * i, _yy, layer, oBossLaser);
				_laser.finalxscale = 20;
				_laser.finalyscale = 1;
				_laser.image_angle = 270;	
			}
			i++;
		}
		
		warnParticles(1, x, y - sprite_height/2);
		coolDownSpear = 150;
		counterRain++;
		
		getRunx();
		runCheck = true;
	}

	
	if(counterRain >= 3){
		attacks++;
		counterRain = 0;
		coolDownSpear = 90;
		oldState = state;
		state = wait;
		return;
	}
}


laserDownState = 1;
laserxEnd = 0;

laserDown = function(){
	moving = false;

	if(laserDownState == 1){
		x = lerp(x, room_width - 48, .05);
		y = lerp(y, room_height - 56, .05);
		
		if(round(x) == room_width - 48 && round(y) == room_height - 56){
			warnParticles(1, x, y - sprite_height/2);
			laserDownState = 2;
		}
	}
	
	if(laserDownState == 2){
		var _laser = instance_create_layer(room_width - 32, room_height - 120, layer, oBossLaser);
		_laser.finalxscale = 50;
		_laser.finalyscale = 2;
		_laser.image_angle = 180;
		audio_play_sound(snCastLaser, 1, 0);
		
		laserDownState = 3;
		laserxEnd = irandom_range(32, room_width - 32);
	}
	
	if(laserDownState == 3){
		x = lerp(x, laserxEnd, .05);
		y = lerp(y, room_height - 136, .05);
		
		if(round(x) == laserxEnd && round(y) == room_height - 136){
			moving = true;
			attacks++;
			oldState = state;
			state = wait;
			return;
		}
	}
}

spearDir = 1;

spearRainInc = function(){
	var i = 1;
	var _dist = 32;
	var _xx = 16;
	var _yy = 16;

	if(coolDownSpear-- < 0){		
		repeat(18){
			var _spear = instance_create_layer(_xx + _dist * i, _yy, layer, oBossSpear);
			_spear.direction = 270;
			_spear.image_angle = 270;
			_spear.finalAngle = 270;
			_spear.image_blend = C_GREEN;
			_spear.time = hp > 10 ? irandom_range(30, 150) : irandom_range(30, 120);
			
			i++;
		}
		
		warnParticles(1, x, y - sprite_height/2);
		coolDownSpear = 180;
		counterRain++;
		
		getRunx();
		runCheck = true;
	}

	
	if(counterRain >= 3){
		attacks++;
		counterRain = 0;
		coolDownSpear = 90;
		oldState = state;
		state = wait; 
		return;
	}
}


spearRainFollow = function(){
	var i = 1;
	var _dist = 32;
	var _xx = 16;
	var _yy = 16;

	if(coolDownSpear-- < 0 && counterRain < 2){
		repeat(18){
			var _spear = instance_create_layer(_xx + _dist * i, _yy, layer, oBossSpear);
			_spear.direction = 270;
			_spear.image_angle = 270;
			_spear.finalAngle = 270;
			_spear.image_blend = C_GREEN;
			_spear.followPlayer = true
			_spear.spd = 8;
			_spear.time = 20 * i;
			_spear.sound = true;
			
			i++;
		}
		
		warnParticles(1, x, y - sprite_height/2);
		coolDownSpear = 360;
		counterRain++;
		
		getRunx();
		runCheck = true;
	}
	
	if(counterRain >= 2 && coolDownSpear < 0){
		attacks++;
		counterRain = 0;
		coolDownSpear = 90;
		oldState = state;
		state = wait; 
		return;
	}
}


//inimigo para de atacar para repor energias. É nessa hora que o player bate nele
recoverState = 0;
timerRecover = 180;

recover = function(){
	if(recoverState == 0){
		moving = false;
		
		x = lerp(x, room_width/2, .05);
		y = lerp(y, room_height - 40, .05);
		
		if(round(x) == room_width/2 && round(y) == room_height - 40){
			timerRecover = 180;
			recoverState = 1;
		}
	}
	
	if(recoverState == 1){
		if(hitCooldown-- < 0){
			hitAble = true;
		}else{
			hitAble = false;
		}
		
		if(timerRecover-- < 0){		
			x = lerp(x, room_width/2, .05);
			y = lerp(y, room_height - 180, .05);
		
			if(round(x) == room_width/2 && round(y) == room_height - 180){
				moving = true;
				hitAble = false;
				recoverState = 0;
				attacks = 0;
				oldState = state;
				state = wait;
			}
		}
	}
}


wait = function(){
	attacks =  0;
	runCheck = false;

	if(t-- < 0){
		t = cooldown;
		randomize();
			
		state = choose(laserRain, spearRainInc, throwSpear, slash, laserDown, spearRainFollow);
		while(state == oldState)
			state = choose(laserRain, spearRainInc, throwSpear, slash, laserDown, spearRainFollow);	
				
	}
}


deathTimer = 300;
deathState = 1;
timerSound = 0;

death = function(){
	instance_destroy(oBossSpear);
	instance_destroy(oBossLaser);
	moving = false;
	image_speed = 1;
	
	x = lerp(x, room_width/2, .05);
	y = lerp(y, room_height/2 - 40, .1);
	
	if(deathState == 1){
		camShake(2, 3);
		
		if(timerSound-- < 0){
			audio_play_sound(snUrielHit, 1, 0);
			timerSound = 15;
		}
		
		global.showHud = false;
		global.urielAlive = false;
		
		var _json = loadString(global.saveNameArray[global.saveId]);
		var _saveStruct = json_parse(_json);
			_saveStruct.b = global.urielAlive;
		_json = json_stringify(_saveStruct);
		saveString(_json, global.saveNameArray[global.saveId]);
		
		var _a = noone;
		with(instance_create_layer(x + irandom_range(-28, 28), y + irandom_range(-20, 40), layer, oGhost)){
			alphaInc = -.1;
			xscale = other.image_xscale;
			sprite = other.sprite_index;
			fog = false;
			color = make_color_hsv(45, 200, 200);
			depth = other.depth + 1;
			_a = id;	
		}
		//ghostTimer = 1;
		
		instance_destroy(_a.light);
		
		if(deathTimer-- < 0){
			deathState = 2;
			image_alpha = 0;
		}
	}else{
		if(deathTimer++ > 300){
			global.showHud = true;
			oPlayer.canControl = true;
			instance_destroy(self);
		}
	}
}

state = start;
oldState = wait;

/////////////////////////////////////

runx = 0;
runCheck = false;
running = false;

run = function(){
	if(distance_to_point(x, runx) > 10){
		x = lerp(x, runx, .1);	
	}else{
		runCheck = false;
	}
}

getRunx = function(){
	if(x > room_width - 64){
		runx = x - 128;
	}else if(x < 64){
		runx = x + 128;
	}else{
		runx = x + irandom_range(-128, 128);
	}
}


freezeTime = 8;
freezeFrame = image_index;
hitCooldown = 5;
hitCounter = 0;


takeDamage = function(_dmg){
	if(hitAble){	
		//criando particulas
		if(instance_exists(oParticle)){
			repeat(4){
				var _xx = irandom_range(-5, 5);
				var _yy = irandom_range(-5, 5);
				part_particles_create_color(global.particleSystem, x + _xx, y - sprite_get_height(sprite_index)/2 + _yy, global.particleHit1, C_GREEN, 1);
			}
		}
	
		//tomando o dano
		hp -= _dmg;
		hitCounter++;
		audio_play_sound(snUrielHit, 1, 0);
		
		if(hitCounter == 2 || hp <= 10 && !runCheck){
			getRunx();
			cooldown = 20;
			runCheck = true;
			hitCounter = 0;
		}
	
		//camera tremendo
		if(hp > 0){
			camShake(2, 2);
			hitCooldown = 15;
		}
	}

}

changeSprite = function(_spr){
	if(sprite_index != _spr){
		image_index = 0;
		sprite_index = _spr;
	}
}
	
damagePlayer = function(_dmg){
	if(instance_exists(oPlayer)){
		with(oPlayer){
			if(canHurt && !invencible && state != stateDash && state != stateHurt){
				hp -= _dmg;
				state = stateHurt;
				return;
			}
		}
	}
}











