
if(drawKey){
	draw_sprite_ext(sInteraction, 0, x - sprite_get_width(sInteraction)/2, y - sprite_height - 18 + sin(current_time/500) * 2, 1, 1, 0, c_white, alpha);
}

draw_sprite(sprite_index, image_index, x, y);

