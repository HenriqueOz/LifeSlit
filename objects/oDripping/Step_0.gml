
if(state == 0){
	if(timer-- < 0){
		randomize();
		timer = random_range(minTime, maxTime);
		state = 1;
	}else{
		if(y - ystart < 16){
			y += .1;
		}
	}
}else if(state == 1){
	
	if(!impact){
		vspd = 6;
		
		if(place_meeting(x, y + 10, oPlayer)){
			vspd = 0;
			image_speed = 1;
			impact = true;
		}
			
		if(place_meeting(x, y + vspd, oCollidersFather)){
			while(!place_meeting(x, y + 1, oCollidersFather)) y += 1;
			vspd = 0;
			image_speed = 1;
			impact = true;
		}
		
	}else{
		vspd = 0;
		
		if(playSound  && !audio_is_playing(snDripWater)){
			audio_play_sound(snDripWater, 1, 0);
			playSound = false;
		}
		
		if(image_speed > 0 && animationEnd()){
			impact = false;
			image_speed = 0;
			image_index = 0;
			y = ystart;
			playSound = true;
			state = 0;
		}
	}

}

y += vspd;