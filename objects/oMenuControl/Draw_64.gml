display_set_gui_size(GUI_WDITH, GUI_HEIGHT);

draw_set_font(fnPixel);

var _xoffset = GUI_WDITH/2;
var _yoffset = GUI_HEIGHT/2;
var _spacing = 30;

//desenhando o título
var _sin = sin(current_time/500);
var _scale = 2;
var _t_width = sprite_get_width(sMainTitle) * _scale;
var _t_height = sprite_get_height(sMainTitle) * _scale;

draw_sprite_ext(sMainTitle, 3, _xoffset - _t_width/2, _t_height, _scale, _scale, 0, -1, 1 * abs(_sin) * transform2);//glow
draw_sprite_ext(sMainTitle, 1, _xoffset - _t_width/2, _t_height, _scale, _scale, 0, -1, 1 * transform2);//normal
draw_sprite_ext(sMainTitle, 2, _xoffset - _t_width/2, _t_height, _scale, _scale, 0, -1, 1 * abs(_sin) * transform);//outline
draw_sprite_ext(sMainTitle, 4, _xoffset - _t_width/2, _t_height + 50 * (1 - transform2), _scale, _scale, 0, -1, 1 * transform2);//coisa do meio


//desenhando os botões
_yoffset += 100;

for(var i = 0; i < btnLength * transform2; i++){
	var _text_width = string_width_scribble(buttons[i]);
	var _text_height = string_height_scribble(buttons[i]);
	var _text = buttons[i];
	var _boxHeight = _text_height + 2;
	var _col = c_white;
		
	//deixando o botão de continue cinza se não existir um save
	//if(!global.saveExists && i == 1){
	//	_col = c_dkgray;
	//}
	
	if(index == i && stepAnimation == 1){
		var _box_y = _yoffset + _spacing * i;
		var _margin = 32;
		var _x_change = _sin * 8;
		
		draw_sprite_ext(sSelected, 0, _xoffset - _text_width/2 - _margin + _x_change, _box_y - 10, 2, 2, 0, -1, 1);
		draw_sprite_ext(sSelected, 0, _xoffset + _text_width/2 + _margin - _x_change, _box_y - 10, -2, 2, 0, -1, 1);
		
		_col = C_GREEN
	}
	
	var _scribble = scribble(_text)
		.starting_format("fnPixel", c_white)
		.align(fa_center, fa_middle)
		.blend(_col, 1 * transform2)
		.draw(_xoffset, _yoffset + _spacing * i - (5 * (1 - transform2)));
}