display_set_gui_size(GUI_WDITH, GUI_HEIGHT);

var _alphaBox = 1 * transform

//background
if(closing){
	_alphaBox = 1 * transformOut;
}
draw_set_alpha(_alphaBox)
draw_set_color(c_black);
	draw_rectangle(0, 0, GUI_WDITH, GUI_HEIGHT, false);
//draw_sprite_tiled_ext(sBoxBG, 0, current_time/50, current_time/50, 2, 2, -1, _alphaBox);
draw_set_color(c_white);
draw_set_alpha(1);
		
//título
var _title_yy = string_height_scribble(title) + 50 - scrolly;
var _scribbleTitle = scribble(title)
	.starting_format("fnPixel", c_white)
	.scale(2, 2)
	.blend(c_white, 1 * transform)
	.align(fa_center, fa_middle)
	.draw(GUI_WDITH/2, _title_yy);

var _title_w = string_width_scribble(title);
draw_sprite_stretched_ext(sLine, 0, 30, _title_yy, GUI_WDITH/2 - _title_w, 5, -1, 1 * transform);//traço esquerda
draw_sprite_stretched_ext(sLine, 0, GUI_WDITH/2 + _title_w - 30, _title_yy, GUI_WDITH/2 - _title_w, 5, -1, 1 * transform);//traço direita


//opções
draw_set_font(fnPixel);
		
var _xx = GUI_WDITH/2;
var _yy = 200;
var _distance = 400;
var _lineSpacing = 60;
			
for(var i = 0; i < optionLength; i++){
	_yy = 200 + _lineSpacing * i - scrolly;
	
	//background das opções
	//if(optionData[i][1] != OPTION.SECTION && optionData[i][1] != OPTION.BTN){ 
	//	draw_set_color($181823);
	//	draw_set_alpha(1 * transform);
	//		draw_rectangle(_xx - _distance - 20, _yy, _xx + _distance + 20, _yy + 50, false);
	//	draw_set_alpha(1);
	//	draw_set_color(c_white);
	//}
	
	//opção selecionada
	var _col = c_white;
	
	if(index == i){
		if(optionData[i][1] != OPTION.BTN && optionData[i][1] != OPTION.SECTION){
			draw_set_alpha(.3);
				draw_set_color(C_GREEN);
				draw_set_alpha(.3 * transform);
				draw_rectangle(_xx - _distance - 20, _yy, _xx + _distance + 20, _yy + 50, false);
				draw_set_alpha(1);
				draw_set_color(c_white);
			draw_set_alpha(1);
		}else{
			_col = C_GREEN;
		}
		
		//checando o tipo de opção e executando a funç]ao referente a ela
	}
	
	//borda das opções
	//if(optionData[i][1] != OPTION.SECTION && optionData[i][1] != OPTION.BTN)
		//draw_sprite_stretched_ext(sBoxBorder, 0, _xx - _distance - 21, _yy - 1, 843, 52, -1, 1 * transform);
	
	//vaalores das opções
	var _text = optionData[i][0];	
	_col = optionData[i][1] == OPTION.SECTION ? C_GREEN : c_white;
	var _text_xx = _xx - _distance;
	var _text_yy = _yy + string_height_scribble(_text)/2;	
	
	var _scribble = scribble(_text)
		.starting_format("fnPixel", c_white)
		.blend(_col, 1 * transform)
			
	if(optionData[i][1] == OPTION.BTN || optionData[i][1] == OPTION.SECTION){
		if(index == i){
			_scribble.blend(C_GREEN);
		}
		_scribble.align(fa_center, fa_top);
		_text_xx = GUI_WDITH/2;
	}
	_scribble.draw(_text_xx, _text_yy)	
	
	//pegando o tipo de opção e o valor da mesm, para então desenha-la conforme seu valor atual
	var _op_type = optionData[i][1];
	var _op_value = optionData[i][2];
	var _op_text = string(_op_value);
	var _op_width = string_width(_op_text);
	var _op_xx = _xx + _distance - 175;
	
	switch(_op_type){
		case(OPTION.SLIDER):
				draw_set_halign(fa_left);
				draw_set_alpha(1 * transform);
					draw_text(_op_xx, _text_yy, _op_text);
				draw_set_alpha(1);
		break;
		
		case(OPTION.BOOL):
			var _bool = "";
			var _globalName = optionData[i][3];
			
			if(variable_global_get(_globalName) == true){
				_bool = MENU_BOOL[0];
			}else{
				_bool = MENU_BOOL[1];
			}
		
			draw_set_halign(fa_center);
			draw_set_alpha(1 * transform);
				draw_text(_op_xx, _text_yy, _bool);
			draw_set_alpha(1);
			
			//setas nos valores
			var _textWidth = max(50, string_width(_bool));
			
			if(index == i){
				var _x_change = cos(current_time/250) * 4;
				draw_sprite_ext(sSelected, 0, _op_xx - _textWidth + 10 + _x_change, _text_yy + 8, 1, 1, 0, -1, 1 * transform);
				draw_sprite_ext(sSelected, 0, _op_xx + _textWidth - 14 - _x_change, _text_yy + 8, -1, 1, 0, -1, 1 * transform);
			}
		break;
		
		case(OPTION.LANGUAGE):
			var _lang = string_upper(languages[languageIndex]);
			
			draw_set_halign(fa_center);
			draw_set_alpha(1 * transform);
				draw_text(_op_xx, _text_yy, _lang);
			draw_set_alpha(1);
			
			//setas nos valores
			var _textWidth = max(50, string_width(_lang));
			
			if(index == i){
				var _x_change = cos(current_time/250) * 4;
				if(languageIndex > 0)
					draw_sprite_ext(sSelected, 0, _op_xx - _textWidth + 10 + _x_change, _text_yy + 8, 1, 1, 0, -1, 1 * transform);
				if(languageIndex < array_length(languages) - 1)					
					draw_sprite_ext(sSelected, 0, _op_xx + _textWidth - 14 - _x_change, _text_yy + 8, -1, 1, 0, -1, 1 * transform);
			}
		break;
		
		case(OPTION.CONTROL):
			var _globalName = optionData[i][3];
			var _key = keyboardKeyName(variable_global_get(_globalName));
			
			draw_set_halign(fa_left);
			
			if(index == i && getKey){
				draw_set_halign(fa_center);
				_key = MENU_PRESS_KEY;
			}
			
			
			draw_set_alpha(1 * transform);
				draw_text(_op_xx, _text_yy, _key);
			draw_set_alpha(1);
		break;
	}
	
	//setas nos valores
	if(optionData[i][1] == OPTION.SLIDER && index == i){
		var _x_change = index == i ? cos(current_time/250) * 4 : 0;
		draw_sprite_ext(sSelected, 0, _op_xx - _op_width/2 - 14 + _x_change, _text_yy + 8, 1, 1, 0, -1, 1 * transform);
		draw_sprite_ext(sSelected, 0, _op_xx + _op_width + _op_width/2 + 14 - _x_change, _text_yy + 8, -1, 1, 0, -1, 1 * transform);
	}
	
	if(optionData[i][1] == OPTION.BTN && index == i){
		var _x_change = index == i ? cos(current_time/250) * 4 : 0;
		var _text_w = string_width_scribble(optionData[i][0]);
		draw_sprite_ext(sSelected, 0, GUI_WDITH/2 - _text_w/2 + _x_change - 30, _text_yy + 4, 2, 2, 0, -1, 1 * transform);
		draw_sprite_ext(sSelected, 0, GUI_WDITH/2 + _text_w/2 - _x_change + 30, _text_yy + 4, -2, 2, 0, -1, 1 * transform);
	}
}

