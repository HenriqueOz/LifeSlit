var _height = abs(bbox_top - bbox_bottom);
var _width = abs(bbox_left - bbox_right);

draw_set_alpha(.3 + abs(sin(current_time/250) * .3));
	draw_rectangle_color(x + width/2 - 4, y - 16, x + width/2 + 4, y + height + 16, C_GREEN, C_GREEN, C_GREEN, C_GREEN, false);
draw_set_alpha(1);


