if(instance_exists(oPlayer) && image_index < image_number - 3){
	x = oPlayer.x;
	y = oPlayer.y;
}

if(animationEnd()){
	instance_destroy(self);
}