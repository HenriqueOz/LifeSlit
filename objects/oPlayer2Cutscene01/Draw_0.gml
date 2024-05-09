draw_self();

if(state == 1 || state == 2){
	var _alpha = 1 - image_alpha;
	
	gpu_set_fog(true, C_GREEN, 0, 0);
	draw_sprite_ext(sPlayerIdle, 0, x, y, 1, 1, 0, -1, _alpha);
	gpu_set_fog(false, C_GREEN, 0, 0);
}