/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event

var _shake = random_range(-2, 2)/60 * recoverTimer;

if(isAlive){
	draw_sprite_ext(sprite_index, image_index, x + _shake, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

event_inherited();


