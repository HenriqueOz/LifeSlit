event_inherited();

draw_sprite_ext(sLight, 0, x, y, .5, .5, 0, make_color_hsv(110 + random_range(-20, 20), 195, 215), .5);

if(destroy){
	gpu_set_fog(true, c_white, 0, 0);
		draw_self();
	gpu_set_fog(false, c_white, 0, 0);
}else{
	draw_self();
}
