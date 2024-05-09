alpha += .05;
alpha = clamp(alpha, 0, 1);
msg.alpha = alpha;

if(state == 0){
	time++;
	transform = ease_in_cubic(time, 0, 1, 15);
	
	if(transform >= 1){
		state = -1;
	}
}else if(state == 1){
	time--;
	transform = ease_out_cubic(time, 0, 1, 15);
	
	if(transform <= 0){
		instance_destroy(self);
	}
}


//botão selecionado
if(op2 == ""){
	index = 0;//checando se a caixa possui apenas uma opção
}else{
	index += keyboard_check_pressed(ord("D")) - keyboard_check_pressed(ord("A"));
	if(pastIndex != index){
		audio_play_sound(snMenuOption, 1, 0);
		pastIndex = index;
	}
}

index = clamp(index, 0, 1);
callbackArray = [callback1, callback2];
