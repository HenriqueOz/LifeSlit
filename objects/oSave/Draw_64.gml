display_set_gui_size(GUI_WDITH, GUI_HEIGHT);

if(saved){
	if(alphaStep == 0){
		alphaTimer++;	
		alpha = ease_in_cubic(alphaTimer, 0, 1, 20);
		
		if(alphaTimer == 100){
			alphaStep = 1;
		}
	}else{
		alphaTimer--;
		alpha = ease_out_cubic(alphaTimer, 0, 1, 60);
		if(alpha <= 0){ 
			saved = false;
		}
	}
}

//desenhando mensagem de save
draw_set_font(fnPixel);

var _message = "[scale, 1.5]"+MENU_SAVE_POP+"[sSaveIcon]";
var _str_width = string_width_scribble(_message);
var _str_height = string_height_scribble(_message);
var _str_xx = display_get_gui_width() - _str_width - 30;
var _str_yy = _str_height;
	
var _scibble = scribble(_message)
	.blend(c_white, alpha)
	.starting_format("fnPixel", c_white)
	.draw(_str_xx, _str_yy);

