
//definindo o alpha do íconce de interação
if(distance_to_object(oPlayer) < 30 && !instance_exists(oDialog) && !instance_exists(oChoiceBox) && state != 2){
	if(keyInconAlpha < 1) keyInconAlpha += .05;
	drawKey = true;
}else{
	if(keyInconAlpha >= 0) keyInconAlpha -= .05;
	else drawKey = false;
} 

//checando interação com o player
if(distance_to_object(oPlayer) < 30 && state != 2){
	canSave = true;
	if(keyboard_check_pressed(global.playerInteract) && !instance_exists(oChoiceBox)){
		createChoiceBox(x, y - sprite_height * 2, label, options);
		state = 1;
	}
}else{
	canSave = false;
}