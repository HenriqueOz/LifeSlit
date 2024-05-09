
var _xx = x;
var _yy = y - sprite_height/2;

draw_self();

if(state == 2){
	draw_set_alpha(1);
	draw_set_color(c_black);
		draw_rectangle(0, 0, room_width, room_height, false);
	draw_set_color(c_white);
	draw_set_alpha(1);
}