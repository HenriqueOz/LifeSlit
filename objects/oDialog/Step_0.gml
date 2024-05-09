//pegando os valores da array
text = string(dialog[line].text);
name = dialog[line].name;
snd = dialog[line].snd;
portrait1 = dialog[line].portrait1;
portrait2 = dialog[line].portrait1
speaking = dialog[line].speaking;
onClose = dialog[line].onClose;

//checando se a caixa está cobrindo o player
if(instance_exists(oPlayer) && room_height - oPlayer.y < 96){
	overPlayer = true;
}


//deshando a caixa de dialogo melhor
if(alpha < 1 && openDialog){
	alpha += .05;
}else{
	var _length = array_length(dialog);
	openDialog = false;
	
	//typewriter.. PS: mudei para a typewriter do scribble
	//if(index <= string_length(text) && alarm[0] <= 0){
	//	randomize();
	//	alarm[0] = delay;
	//}

	//avançando o dialogo
	if(keyboard_check_pressed(global.playerInteract)){
		if(typist.get_state() != 1){
			typist.skip();
			index = string_length(text);
		}else{
			if(onClose != -1){
				onClose();
			}
			
			if(line < _length - 1){
				index = 0;
				line++;
			}else{
				closeDialog = true;
			}
		}
	}
	//fechando o dialogo
	if(closeDialog){
		alpha -= .05;
		if(alpha < 0) instance_destroy(self);
	}
}



