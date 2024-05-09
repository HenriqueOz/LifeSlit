
if(sprite_index != -1){
	if(state == 1 && time > 15){
		randomise();
		var _xx = x + random_range(-3, 3);
		var _yy = y + random_range(-3, 3);
	
		draw_sprite(sprite_index, image_index, _xx, _yy);
	}else{
		draw_self();
	}
}