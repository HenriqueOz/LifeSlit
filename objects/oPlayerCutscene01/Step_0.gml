
//cutscene começo
if(state == 0 && drawLight){
	if(timer > 0){
		timer--;
		transform = ease_out_cubic(timer, 0, 1, 30);
	}
	
	if(instance_exists(oLightControl)){
		if(timer > 0 && timer mod 2 == 0){
			oLightControl.bright -= .05;
			oLightControl.bright = clamp(oLightControl.bright, .05, 1);
			
			if(oLightControl.bright < .3){
				var _light_numb = instance_number(oLightEntities);
				var _p_light = light;
				var _efil_light = instance_exists(oEfilCutscene01) ? oEfilCutscene01.light : undefined; 
				
				for(var i = 0; i < _light_numb - 1; i++){
					var _l = instance_find(oLightEntities, i);
					if(_l != _p_light && _l != _efil_light){
						_l.alpha -= .05;
						if(_l.alpha <= 0)
							instance_destroy(_l);
					}
				}
			}
		}
	}
	
	
	if(timer <= 0){
		timer = 15;
		state = 1;
	}
}

//cutscane parte 1
if(state == 1){
	light.scaley += .05;
	
	var _efil = oEfilCutscene01;
	if(instance_exists(_efil) && light.scaley > 2){
		var _xx = x + random_range(-20, 20);
		var _yy = random_range(0, room_height);
		
		part_particles_create(global.particleSystem, _xx, _yy, global.particleSparkles, 1);
		
		var _i = random_range(3, 6);
		camShake(_i, 3);
		
		
		if(_efil.y > y - 10){
			with(_efil){
				depth = depth - 1;
				image_speed = .5;
				grvAcceleration = 0;
				
				if(sprite_index != sEfilLevitating){
					image_index = 0;
					sprite_index = sEfilLevitating;
				}
				
				if(animationEnd()){
					if(!audio_is_playing(snUrielHit))
						audio_play_sound(snUrielHit, 1, 0);
					image_speed = 0;	
					y -= .4;
				}
			}
		}else{
			audio_play_sound(snPowerImpact, 1, 0);
			state = 2;
			timer = 0;
		}
	}
}

//cutscene parte 2
if(state == 2){
	var _part_numb = 2;
		
	with(oLightEntities){
		oEfilCutscene01.image_alpha = 0;
		alpha -= .05;
	}
	
	if(light.alpha < -5){
		randomize();
		
		var _xx = x + random_range(-20, 20);
		var _yy = y - sprite_height/2 + random_range(-20, 20);
		
		if(current_time mod 2 == 0){
			part_particles_create_color(global.particleSystem, _xx, _yy,global.particleDrop, C_GREEN, 1);
		}
		
		if(timer < 100){
			timer++;
			transform2 = ease_in_cubic(timer, 0, 1, 100);
		}else{
			timer = 100;
			state = 3;
		}
	}
}

//cutscece final
//if(keyboard_check_pressed(vk_space))
//	state = 3;

if(state == 3){
	if(!instance_exists(oPlayer2Cutscene01)){
		var _inst = instance_create_depth(x, y, depth, oPlayer2Cutscene01);
		_inst.image_alpha = 0;
		_inst.light.alpha = .1;
		oCam.target = _inst;
	}else{
		oPlayer2Cutscene01.image_alpha += .025;	
		oPlayer2Cutscene01.light.alpha += .025;
	}
	
	instance_destroy(oEfilCutscene01);
	image_alpha = 0;
	
	if(timer > 0){
		timer--;
		transform2 = ease_out_cubic(timer, 0, 1, 100);
	}else{
		oPlayer2Cutscene01.image_alpha = 1;
		oPlayer2Cutscene01.light.alpha = 1;
		instance_destroy(self);
	}
}




//y += sin(current_time/350) * .2;