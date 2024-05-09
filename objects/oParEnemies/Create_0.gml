t = 0; 
hp = 100;
isAlive = true;
hasLifeShard = false;

grounded = false;

canBeHitted = true; //se o inimigo pode ser atingido
hitted = false;	//se o inimigo foi atingido

			//atual	 //máximo
hittedCoolDown = [0, 20];
flashTime = [0, 10];

freezeTime = 0;
freezeFrame = 0;

deathTimer = 0;
deathTimerAnimation = 30;

bright = shader_get_uniform(shBright, "bright");
light = noone;

takeDamage = function(_dmg){
	if(hittedCoolDown[0] <= 0 && canBeHitted){
		//inimigo piscando
		flashTime[0] = flashTime[1];
		hittedCoolDown[0] = hittedCoolDown[1]; 
		hitted = true;
		canBeHitted = false;
	
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
	
		//camera tremendo
		if(hp <= 0){
			with(oPlayer){
				freezeTime = 8;
				freezeFrame = image_index;
			}
			freezeTime = 8;
			freezeFrame = image_index;
			deathTimer = 30;
			camShake(3, 2);
		}else{
			camShake(2, 1);
		}
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

changeSprite = function(_spr){
	if(sprite_index != _spr){
		image_index = 0;
		sprite_index = _spr;
	}
}

