if(state == -1) exit;	//caso a animação tenha acabao ele para de rendenizar o menu de pause

display_set_gui_size(GUI_WDITH, GUI_HEIGHT);

var _width = display_get_gui_width();
var _height = display_get_gui_height();

//background
draw_set_alpha(.8 * transform);// o tranform vai retirando porcentagens dos valores finais
draw_set_color(c_black);
draw_rectangle(0, 0, _width, _height, false);
draw_set_color(c_white);
draw_set_alpha(1);

//desenhando as opções
var _text_xx = _width/2;
var _text_height = 200;
var _text_yy = _height/2 - _text_height/2;

draw_set_halign(fa_center); 
draw_set_font(fnPixel);

for(var i = 0; i < array_length(arrayOption); i++){
	var _opNumber = array_length(arrayOption);
	var _text = arrayOption[i];
	
	if(i == index){
		draw_set_color(C_GREEN);
		draw_set_alpha((.2 + abs(sin(current_time/750) * .1)) * transform);
		draw_rectangle(0, _text_yy + _text_height/_opNumber * i - 8, _width, _text_yy + _text_height/_opNumber * i + string_height(_text) + 4, false);
		draw_set_alpha(1);
		draw_set_color(c_white);
		
		draw_sprite_ext(sSelected, 0, _text_xx - string_width(_text)/2 - 48 + sin(current_time/500) * 12, _text_yy + _text_height/_opNumber * i + 2, 2, 2, 0, c_white, 1 * transform);
		draw_sprite_ext(sSelected, 0, _text_xx + string_width(_text)/2 + 48 -sin(current_time/500) * 12,  _text_yy + _text_height/_opNumber * i + 2, -2, 2, 0, c_white, 1 * transform);
	}else{
		draw_set_color(c_white);
	}
	draw_set_alpha(1 * transform);
		var _animate_yy = state == 0 ? transform : 1;
		draw_text(_text_xx, _text_yy + _text_height/_opNumber * i * _animate_yy, _text);
	draw_set_alpha(1);
	draw_set_color(c_white);
}
