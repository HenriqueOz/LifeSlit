display_set_gui_size(GUI_WDITH, GUI_HEIGHT);

//desenhando caixa atrás do titulo
//draw_set_alpha(alpha/10);
//for(var i = 0; i < 80; i += 4){
//	var _xx = 0; 
//	var _yy = display_get_gui_height()/6 - 60
//	var _width = display_get_gui_width();
//	var _height = 120;
	
//	draw_set_color(c_black);
//	draw_rectangle(_xx, _yy + i, _width, _height + i, false);
//	draw_set_color(c_white);
//}
//draw_set_alpha(1);


if(global.showTitle){
	var _scribble = scribble("[scale, 1.5]"+title+"[scale, 1]")
		.starting_format("fnPixel", c_white)
		.align(fa_middle, fa_center)
		.blend(c_white, alpha)
		.draw(display_get_gui_width()/2, display_get_gui_height()/6);
		
	draw_sprite_ext(sTitleUnderline, 0, display_get_gui_width()/2, display_get_gui_height()/6 + string_height_scribble(title) + 10, 2, 2, 0, c_white, alpha);
}