
// Inherit the parent event
event_inherited();

light = instance_create_layer(x, y - sprite_height/2, layer, oLightEntities);
light.scalex = 1;
light.scaley = 1.5;
light.oscilation = 30;
light.alpha = 1;
light.image_angle = 0;
light.colorOverlay = false;
light.intensity = .1;//ente 0 e 1
light.color = c_white;

hp = 4;

range = 288;
randomize()
dirx = choose(1, -1);
attack = noone;
timer = 0;
hspd = 0;
coolDown = 30;
timerWalk = 30;
tx = 0;
ty = 0;

stateFree = function(){
	
	
	var _blockAhead = place_meeting(x + sprite_width * dirx, y + 1, oParWall);
	if(!_blockAhead || place_meeting(x + sprite_width * dirx, y, oSpike)){
		dirx = -dirx;
	}
	
	if(distance_to_object(oPlayer) > range){
		if(timerWalk-- < 0){
			randomize();
			timerWalk = random_range(30, 300);
			hspd = choose(.1, 0);
		}
	}else{
		hspd = 0;
	}
	
	if(timer-- < 0 && distance_to_object(oPlayer) < range && !instance_exists(attack)){
		dirx = -sign(x - oPlayer.x);
		state = stateAttack;
		timer = coolDown;
		tx = oPlayer.x;
		ty = oPlayer.y;
	}
	
	//x += hspd * dirx;
}

stateAttack = function(){

	var _xset = x + 15 * dirx;
	var _yset = y - 20;
	var _x = tx - _xset;//distância
	var _y = ty - _yset;//altura
	var _v = 7 * sign(_x)//velocidade
	var _v2 = _v * _v;//quadrado da velocidade
	var _g = .2;//gravidade
					
	var _a = _v2 * _v2 - _g * (_g * _x * _x - 2 * _y * _v2);
	//checando se é possível fazer o ataque
	if(_a > 0){
		changeSprite(sPlantaAtck);
		
		var _b = -(_v2 + sqrt(_a)) / (_g * _x); 
		var _an = arctan(_b);
		var _hsp = cos(_an) * _v;   
		var _vsp = sin(_an) * _v - _g * 0.5;   
		
		if(!instance_exists(attack) && animationEnd() && sprite_index == sPlantaAtck){
			attack = instance_create_layer(_xset, _yset, "water", oPlantaAttack);
			with(attack){
				hspd = _hsp;
				vspd = _vsp; 
				grv = _g;
			}
			
			audio_play_sound(snPlantaShoot, 1, 0);
			changeSprite(sPlantaIdle);
			state = stateFree;
			timer = 20;	
		}
	}else{	
		changeSprite(sPlantaIdle);
		state = stateFree;
		timer = 20;
	}
}

stateHurt = function(){}

stateDeath = function(){
	
	if(deathTimer == deathTimerAnimation){
		audio_play_sound(snPlantaDeath, 1, 0);
		part_particles_create(global.particleSystem, x, y - sprite_get_height(sprite_index)/2, global.particleEnemyDeath, 12);
	}
	
	light.alpha = 1/deathTimerAnimation * deathTimer;
	
	if(deathTimer-- < 0){
		instance_destroy(light);
		instance_destroy(self);
	}
}

state = stateFree;