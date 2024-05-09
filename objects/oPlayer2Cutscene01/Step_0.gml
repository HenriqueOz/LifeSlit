
light.drawX = x;
light.drawY = y - sprite_height/2;

switch(state){
	case(0):
		if(!place_meeting(x, y + 1, oParWall)){
			y += .5;
		}else{
			state = 1;
		}
	break;
	
	case(1):
		if(image_alpha > 0){
			image_alpha -= .01;
		}else{
			state = 2;
			sprite_index = sPlayerIdle;
		}
	break;
	
	case(2):
		if(image_alpha < 1){
			if(!audio_is_playing(snVIrouGente))
				audio_play_sound(snVIrouGente, 1, 0);
			image_alpha += .01;
			doorLight.alpha = image_alpha;
			holeLight.alpha = image_alpha;
			oLightControl.bright = oLightControl.bright < .6 ? oLightControl.bright + .01 : oLightControl.bright;
		}else{
			state = 3;
		}
	break;
	
	case(3):
		with(instance_create_layer(x, y, "player", oPlayer)){
			sprite = sPlayerIdle;
			sprite_index = sPlayerIdle;
		}
		instance_destroy(light);
		instance_destroy(self);
	break;
}
