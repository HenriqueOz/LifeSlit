
var _yy = y + sin(current_time/250) * 3;
var _col = image == 2 ? c_purple : -1;

light.drawY = _yy;

//losango
draw_sprite(sprite_index, image, x, _yy);
draw_sprite_ext(sprite_index, 0, x, _yy, 1, 1, current_time/10, _col, 1);

//símbolo
draw_set_alpha(sin(current_time/250));
	draw_sprite_ext(sprite_index, 0, x, _yy, 1, 1, 0, _col, 1);
draw_set_alpha(1);
