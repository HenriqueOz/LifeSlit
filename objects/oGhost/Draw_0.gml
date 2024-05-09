
if(fog){
	gpu_set_fog(true, color, 0, 0);
}
	draw_sprite_ext(sprite, image, x, y, xscale, yscale, rot, color, alpha);
gpu_set_fog(false, c_white, 0, 0);
