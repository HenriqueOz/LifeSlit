display_set_gui_size(GUI_WDITH, GUI_HEIGHT)

var _xx = GUI_WDITH/2;
var _yy = 0;
var _saveBox_w = 750;
var _saveBox_h = 100;
var _lineSpacing = 150;

if(!surface_exists(saveSurface)){
	saveSurface = surface_create(_saveBox_w, _saveBox_h);
}else{
	surface_set_target(saveSurface);
		draw_sprite_tiled_ext(sBoxBG, 0, current_time/50, current_time/50, 2, 2, -1, 1);
	surface_reset_target();
}

for(var i = 0; i < 3; i++){
	var _box_xx = _xx - _saveBox_w/2;
	var _box_yy = _yy + _saveBox_h + _lineSpacing * i
	var _text = slotStrings[i];
	var _margin = 30;
	
	draw_surface(saveSurface, _box_xx, _box_yy);
	
	if(index == i){
		draw_set_alpha(.2 + abs(sin(current_time/500)) * .1)
		draw_set_color(C_GREEN);
			draw_rectangle(_box_xx, _box_yy, _box_xx + _saveBox_w, _box_yy + _saveBox_h, false);
		draw_set_color(c_white);
		draw_set_alpha(1);
		
		var _options = ["[c_green1]Space:[/c] "+MENU_SAVE_OP[0], "[c_green1]V:[/c] "+MENU_SAVE_OP[1]];
		var j = 0;
		var _op_xx = _box_xx + _saveBox_w;
		var _op_yy = _box_yy;
		var _op_spacing = 30;
		
		repeat(2){
			var _op_new_yy = _op_yy + _op_spacing * j + _saveBox_h/3;
			
			if(!global.saveExistsArray[index]){
				j= 0;
				_options = ["[c_green1]Space:[/c] "+MENU_SAVE_OP[2]];
				_op_new_yy = _op_yy + _op_spacing * j + _saveBox_h/2;
			}
			
			var _scribble = scribble(_options[j])
				.starting_format("fnPixel", c_white)
				.align(fa_center, fa_middle)
				.draw(_op_xx - 120, _op_new_yy);
			
			j++;
		}
	}
	
	draw_sprite_stretched(sBoxBorder, 0, _box_xx - 1, _box_yy - 1, _saveBox_w + 3, _saveBox_h + 2);
	
	var _scribble = scribble(_text)
		.starting_format("fnPixel", c_white)
		.align(fa_left, fa_middle)
		.draw(_box_xx + _margin, _box_yy + _saveBox_h/2)
}

//desenhando o botão de voltar
var _btn_xx = GUI_WDITH/2;
var _btn_yy = GUI_HEIGHT - 100;
var _col = c_white;

if(index == 3){
	var _label_w = string_width_scribble(backBtnLabel);
	var _x_change = sin(current_time/500) * 4;
	
	draw_sprite_ext(sSelected, 0, _btn_xx - _label_w + _x_change, _btn_yy - 12, 2, 2, 0, -1, 1);
	draw_sprite_ext(sSelected, 0, _btn_xx + _label_w - _x_change, _btn_yy - 12, -2, 2, 0, -1, 1);
		
	_col = C_GREEN;
}

var _scribble = scribble(backBtnLabel)
	.starting_format("fnPixel", c_white)
	.align(fa_center, fa_middle)
	.blend(_col, 1)
	.draw(_btn_xx, _btn_yy)
