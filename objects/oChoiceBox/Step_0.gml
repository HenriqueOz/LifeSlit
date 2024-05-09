
if(state == 0){
	time++;
	transform = ease_in_cubic(time, 0, 1, 15);
	
	if(transform >= 1){
		state = -1;
	}
}else if(state == 1){
	time--;
	transform = ease_out_cubic(time, 0, 1, 10);
	
	if(transform <= 0){
		instance_destroy(msg);
		instance_destroy(self);
	}
}

index +=  keyboard_check_pressed(ord("S")) - keyboard_check_pressed(ord("W"));
index =  index > array_length(options) - 1 ? 0 : (index < 0 ? array_length(options) - 1 : index);

if(pastIndex != index){
	audio_play_sound(snMenuOption, 1, 0);
	pastIndex = index;
}

keyConfirm = keyboard_check_pressed(vk_space);


var _callback = options[index][1];

if(keyConfirm){
	if(_callback != -1){
		var _a = options[index][1]();
		if(_a == -1){
			state = 1;
		}
		audio_play_sound(snSelect, 1, 0);
	}else{
		state = 1;
	}
}
