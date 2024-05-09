
buttons[0] = MENU_START[0];
buttons[1] = MENU_START[1];
buttons[2] = MENU_START[2];
buttons[3] = MENU_START[3];

if(stepAnimation == 0){
	t++;
	transform = ease_linear(t, 0, 1, 180);
	
	if(keyboard_check(vk_anykey)){
		transform = 1;
		transform2 = 1;
	}
	
	if(transform >= 1){
		t = 0;
		canControl = true;
		stepAnimation = 1;
	}
}else if(stepAnimation == 1){
	if(transform2 < 1){
		t++;
		transform2 = ease_linear(t, 0, 1, 100);
	}
	
	if(canControl){
		confirm = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter);
		index += keyboard_check_pressed(ord("S")) - keyboard_check_pressed(ord("W"));
		index = (index > btnLength - 1 ? 0 : (index < 0 ? btnLength - 1 : index));
		
		if(pastIndex != index){
			audio_play_sound(snMenuOption, 1, 0);
			pastIndex = index;
		}

		if(confirm){
			if(!audio_is_playing(snSelect))
				audio_play_sound(snSelect, 1, 0);
			buttonFunctions[index]();
		}
	}
}

	


