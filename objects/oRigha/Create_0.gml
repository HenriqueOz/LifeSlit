
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


randomize();

hp = 4;

spd = .25;
hspd = 0;
vspd = 0;
dirx = choose(1, -1);//o sprite é virado pra esquerda

image_xscale = 1;
sprite_index = sRighaIdle;

mass = 1.3;
dmg = 1;


#region//state free 
alarm[0] = random_range(20, 60);
stop = false;

stateFree = function(){
	canBeHitted = true;
	
	//timer de movimento
	if(stop){
		changeSprite(sRighaIdle);
		hspd = 0;
	}else{
		changeSprite(sRighaWalk);
	}
	
	//agrando o player
	if(instance_exists(oPlayer)){
		var _range = 320;
		var _player_dir = instance_exists(oPlayer) ? sign(x - oPlayer.x) : 0;
		var _dist_y = point_distance(y, y, oPlayer.y, oPlayer.y);
		var _dist_x = point_distance(x, x, oPlayer.x, oPlayer.x);
	
		if(_dist_y < 2 && _dist_x < _range && oPlayer.vspd == 0){
			var i = 0;
			while(i < _range){
				if(place_meeting(x + i * -_player_dir, y, oParWall))
					break;
					
				if(place_meeting(x + i * -_player_dir, y, oPlayer)){
					dirx = -_player_dir;
					attackTimer = 45;
					state = stateAttack;
					break;
				}
				i++;
			}
		}
	}
	
	
	//checando se o inimigo colidiu com uma parede ou se não há mais chão a frente, caso ocorra ele muda de direção
	var _emptyAhead = !place_meeting(x + sign(hspd) * sprite_get_width(sprite_index)/2, y + 1, oParWall)
	
	if(place_meeting(x + sign(hspd), y, oCollidersFather) || _emptyAhead){
		dirx = -dirx;
	}
}

#endregion

#region//state attack
attackTimer = 0;
ghostTimer = 0;

stateAttack = function(){
	if(attackTimer-- > 0){
		changeSprite(sRighaPreparing);
		hspd = 0;
		return;
	}
	
	changeSprite(sRighaAttack);
	hspd = 5 * dirx;
	
	if(ghostTimer-- < 0){
		with(instance_create_layer(x, y, layer, oGhost)){
			alphaInc = -.1;
			xscale = other.dirx;
			sprite = other.sprite_index;
			fog = false;
			color = c_aqua;
		}
		ghostTimer = 3;
	}
	
	if(collision_rectangle(x, y, x + 30 * dirx, y - 20, oPlayer, false, false)){
		damagePlayer(1);
	}
	
	
	if(!place_meeting(x + sign(hspd) * sprite_get_width(sprite_index), y + 1, oParWall)){
		state = stateFree;
	}
	
	if(place_meeting(x + sign(hspd), y, oParWall)){
		recoverTimer = 30;
		camShake(2, 2);
		state = stateRecover;
	}
}

#endregion

#region//state recover
recoverTimer = 0;

stateRecover = function(){
	hspd = 0;
	if(recoverTimer-- < 0){
		changeSprite(sRighaRecover);
		if(animationEnd()){
			recoverTimer = 0;
			dirx = -dirx;
			state = stateFree;
		}
	}else{
		changeSprite(sRighaDizzy);
	}
}

#endregion

#region//state death

stateDeath = function(){
	hspd = 0;
	canBeHitted = false;
	image_speed = 0;
	
	if(deathTimer == 30){
		audio_play_sound(snPlantaDeath, 1, 0);
		part_particles_create(global.particleSystem, x, y - sprite_get_height(sprite_index)/2, global.particleEnemyDeath, 12);
	}
	
	if(deathTimer-- < 0){
		instance_destroy(self);
	}
}

#endregion

state = stateFree;



