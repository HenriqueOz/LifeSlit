if(instance_exists(oPlayer)){
	if(bbox_bottom >= oPlayer.bbox_bottom - 1){
		sprite_index = sJumpTrought;
	}else{
		sprite_index = -1;
	}
			
	with(oPlayer){
		if(keyCrouch && keyJump){
			other.sprite_index = -1;
		}
	}
}