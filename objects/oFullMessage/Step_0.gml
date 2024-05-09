msg.alpha = alpha;

if(state == 0){
	if(instance_exists(oPlayer)){
		oPlayer.state = oPlayer.stateDialog;
		oPlayer.canControl = false;
		oPlayer.canJump = -1;
	}
	
	if(alpha >= 1){
		keyConfirm = keyboard_check_pressed(vk_space);
		if(keyConfirm){
			if(!audio_is_playing(snSelect))
				audio_play_sound(snSelect, 1, 0);
			t = 20;
			state = 1;
		}
	}else{
		t++;
		alpha = ease_in_cubic(t, 0, 1, 50);	
	}
}

if(state == 1){
	t--;
	alpha = ease_out_cubic(t, 0, 1, 20);
	
	if(alpha <= 0){
		if(onClose != -1){
			onClose();	
		}
		
		if(instance_exists(oPlayer)){
			with(oPlayer){
				canControl = true;
				state = stateFree;
			}
		}
		instance_destroy(msg);
		instance_destroy(self);
		global.canPause = true;
	}
}