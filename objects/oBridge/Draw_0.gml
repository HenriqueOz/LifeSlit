
image_xscale = t div timerBlock;

var i = 0;
repeat(t div timerBlock){
	var _xx = x + 32 * i;
	draw_sprite(sprite_index, image_index, _xx, y);
		
	i++;
}

if(t < timerCreate){
	var t_add = 0;
	if(instance_place(x, y - 1, oPlayer)){
		t_add = oPlayer.hspd/3;
	}
	
	t += 1 + t_add;
	if(t mod timerBlock == 0)
		camShake(2, 1);
}







