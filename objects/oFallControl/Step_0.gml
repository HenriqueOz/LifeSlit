
if(instance_exists(oPlayer) && oPlayer.y > 640 && !global.lever1){	
	if(oPlayer.y > room_height - 120){
		global.cutsceneMode = false;
		save();
	}else{
		oPlayer.canControl = false;
		global.showHud = false;
		global.cutsceneMode = true;
		oPlayer.x = lerp(oPlayer.x, room_width/2, .1);
		oPlayer.hspd = 0;
	}
	
	if(oPlayer.y > room_height - 32){
		oPlayer.y++;
	}
}
