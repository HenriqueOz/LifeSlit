
if(isAlive){

	if(startTimer > 0 && distance_to_object(oPlayer) < 200 && state = stateFree){
		draw_sprite_ext(sprite_index, image_index, x + 3, y, image_xscale, image_yscale, image_angle, c_red, 1/30 * startTimer);
		draw_sprite_ext(sprite_index, image_index, x - 3, y, image_xscale, image_yscale, image_angle, c_red, 1/30 * startTimer);
		draw_sprite_ext(sprite_index, image_index, x, y + 3, image_xscale, image_yscale, image_angle, c_red, 1/30 * startTimer);
		draw_sprite_ext(sprite_index, image_index, x, y - 3, image_xscale, image_yscale, image_angle, c_red, 1/30 * startTimer);
	}
	
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);	
	
}

event_inherited();

