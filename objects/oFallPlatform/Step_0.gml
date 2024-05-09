

switch(state){
	//player pisou
	case(0):
		if(instance_place(x, y, oPlayer)){
			mask_index = sEmpty;
			time = breakTime;
			state = 1;
		}
	
		if(instance_place(x, y - 1, oPlayer)){
			time = breakTime;
			state = 1;
		}

	break;
	
	//tremendo e quebrando
	case(1):
		if(time-- < 0){
			if(sprite_index != spriteBreaking){
				image_index = 0;
				sprite_index = spriteBreaking;
			}else if(animationEnd()){
				sprite_index = spriteBroke;
				mask_index = sEmpty;
				time = respawnTime;
				state = 2;	
			}
		}
	break;
	
	//respawnando e voltando pro state 0
	case(2):
		if(time-- < 0){
			if(sprite_index != spriteRespawning){
				image_index = 0;
				sprite_index = spriteRespawning;
			}else if(animationEnd()){
				sprite_index = spriteNormal;
				mask_index = spriteNormal;
				time = 0;
				state = 0;	
			}
		}
	break;
}