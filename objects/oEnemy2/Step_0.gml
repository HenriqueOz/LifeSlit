event_inherited();

light.drawX = x;
light.drawY = y;

state();

playerCollide = place_meeting(x, y, oPlayer);
if(playerCollide && state == stateChase){
	damagePlayer(1);
}

if(instance_exists(oPlayer)){
	if(oPlayer.isDeath){
		depth = oPlayer.depth + 1;
	}		
}

x = clamp(x, 32, room_width - 32);
y = clamp(y, 32, room_height - 32);


if(dir < 90 || dir > 270){
	image_xscale = -1;
}else{
	image_xscale = 1;
}

