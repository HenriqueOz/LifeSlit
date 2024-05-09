
if(chargeState == 2){
	var _ranX = random_range(-5, 5);
	var _ranY = random_range(-5, 5);
	
	draw_sprite_ext(sprite_index, image_index, x + _ranX, y + _ranX, image_xscale, image_yscale, image_angle, C_GREEN, 1);
}

draw_self();
