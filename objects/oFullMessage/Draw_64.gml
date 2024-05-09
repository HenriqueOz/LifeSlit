display_set_gui_size(GUI_WDITH, GUI_HEIGHT);

//background
var _alphaAmount = .5;

if(room == rmMenu){
	_alphaAmount = 1;
}

draw_set_alpha(alpha * _alphaAmount);
draw_set_color(c_black);
	draw_rectangle(0, 0, GUI_WDITH, GUI_HEIGHT, false);
draw_set_color(c_white);
draw_set_alpha(1);

//texto
var _xx = GUI_WDITH/2;
var _yy = GUI_HEIGHT/2;

var _scbTitle = scribble(title)
	.starting_format("fnPixel", c_white)
	.transform(2, 2)
	.blend(c_white, alpha)
	.align(fa_center, fa_middle)
	.draw(_xx, _yy - 200);
	
var _scbContent = scribble(content)
	.starting_format("fnPixel", c_white)
	.blend(c_white, alpha)
	.transform(1, 1)
	.wrap(GUI_WDITH - 200, GUI_HEIGHT)
	.align(fa_center, fa_middle)
	.draw(_xx, string_height_scribble(title) + _yy - 100);	


