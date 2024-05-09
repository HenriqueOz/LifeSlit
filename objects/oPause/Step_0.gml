


//atualizando as strings
arrayOption = [MENU_PAUSE[0], MENU_PAUSE[1], MENU_PAUSE[2]];

//fade in e fade out
if(state == 0){
	time++;
	transform = ease_in_cubic(time, 0, 1, 20);
}else if(state == 1){
	time--;
	transform = ease_linear(time, 0, 1, 10);
	
	if(transform <= 0){
		state = -1;
	}
}

transform = clamp(transform, 0, 1);
	
//controles do pause
if(canControl){
	index += keyboard_check_pressed(ord("S")) - keyboard_check_pressed(ord("W"));
	index = index > array_length(arrayOption) - 1 ? 0 : (index < 0 ? array_length(arrayOption) - 1 : index);
	
	if(pastIndex != index){
		audio_play_sound(snMenuOption, 1, 0);
		pastIndex = index;
	}	
}

keyConfirm = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter);

//métodos do pause
if(keyConfirm && canControl){
	
	if(!audio_is_playing(snSelect))
		audio_play_sound(snSelect, 1, 0);
	
	canControl = false;
	keyboard_clear(vk_space);
	
	switch(index){
		case(0)://resume
			PauseContinue();
		break;
			
		case(1)://options
			PauseOptions();
		break;
	
		case(2)://go to menu
			PauseMenu();
		break;
	}
}