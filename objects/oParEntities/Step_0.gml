//trocando pro estado de interação e gerenciando
if(distance_to_object(oPlayer) < 36 && !instance_exists(oDialog) && !instance_exists(oChoiceBox)){
	if(alpha < 1) alpha += .05;
	drawKey = true;
}else{
	if(alpha >= 0) alpha -= .05;
	else drawKey = false;
} 