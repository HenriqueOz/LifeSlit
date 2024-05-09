
var _yy = sin(current_time/500) * 2 + transform;
var _xx = x;

//if(canFillMana){
//	gpu_set_fog(true, c_purple, 0, 0);
//		draw_sprite_ext(sprite, 0, _xx + 1, y + _yy, 1, 1, 0, -1, 1); 	
//		draw_sprite_ext(sprite, 0, _xx - 1, y + _yy, 1, 1, 0, -1, 1); 	
//		draw_sprite_ext(sprite, 0, _xx, y + _yy + 1, 1, 1, 0, -1, 1); 	
//		draw_sprite_ext(sprite, 0, _xx, y + _yy - 1, 1, 1, 0, -1, 1); 	
//	gpu_set_fog(false, -1, 0, 0);
//}

draw_sprite(sprite, 0, _xx, y + _yy); 
draw_sprite_ext(sLight, 0, x + sprite_width/2, y + sprite_height/2 + _yy, .75, .75, 0, C_GREEN, .2); 

gpu_set_fog(true, c_white, 0, 0);
	var _percentual = t/30;

	draw_sprite_ext(sprite, 0, _xx, y + _yy, 1, 1, 0, -1, 1 * _percentual); 	
gpu_set_fog(false, c_white, 0, 0);

