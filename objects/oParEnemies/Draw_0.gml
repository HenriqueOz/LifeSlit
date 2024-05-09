
//se o inimigo carregar um lifeshard aparecerá um ícone sob sua cabeça
if(hasLifeShard){
	gpu_set_fog(true, make_color_hsv(110 + random_range(-20, 20), 195, 215), 0, 0);
		draw_sprite_ext(sprite_index, image_index, x + 1, y, image_xscale, image_yscale, image_angle, -1, 1);
		draw_sprite_ext(sprite_index, image_index, x - 1, y, image_xscale, image_yscale, image_angle, -1, 1);
		draw_sprite_ext(sprite_index, image_index, x, y - 1, image_xscale, image_yscale, image_angle, -1, 1);
		draw_sprite_ext(sprite_index, image_index, x, y + 1, image_xscale, image_yscale, image_angle, -1, 1);
	gpu_set_fog(false, c_white, 0, 0);
	draw_self();
}

//piscar em branco quando levar dano
if(flashTime[0] > 0){ 
	shader_set(shBright);
	shader_set_uniform_f(bright, 1);
	draw_self();
	shader_reset();
}

if(!isAlive){
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, C_GREEN, 1/deathTimerAnimation * deathTimer);
}
