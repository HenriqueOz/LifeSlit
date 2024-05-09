
collide = place_meeting(x, y, oPlayer) || place_meeting(x, y, oParWall);

if(collide && time < 0 && !invert){
	if(!audio_is_playing(snLaser))
		audio_play_sound(snLaser, 1, 0);
	
	var _player = instance_place(x, y, oPlayer);
	if(_player){
		damagePlayer(1);
		
		if(_player.state == _player.stateDash)
			exit;
	}
}

image_xscale = lerp(image_xscale, finalxscale, .1);

if(time-- < 0 && abs(image_xscale) > .99 && !invert)
	image_yscale = lerp(image_yscale, finalyscale, .2);
	
if(invert)
	image_yscale = lerp(image_yscale, 0, .1);
	
if(image_yscale > finalyscale - .1)
	invert = true;

