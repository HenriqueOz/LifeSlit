display_set_gui_size(GUI_WDITH, GUI_HEIGHT);

var _op = 0;
confirm = keyboard_check_pressed(vk_space);
draw_set_font(fnDialog);

//fundo escuro
draw_set_alpha(.7 * transform);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_color(c_white);
draw_set_alpha(1);
		
//desenhando a caixa de opção
var _width = string_width(text);
var _minWidth = 500;
var _maxWidth = 800
var _line = _width div _maxWidth; //retorna o total de qubras de linha
	
_width = clamp(_width, _minWidth, _maxWidth);

				//adcinando as quebras de linha
var _height = (string_height(text) * _line + string_height(op1) + 150);
		
var _xx = display_get_gui_width()/2 - _width/2;
var _yy = display_get_gui_height()/2 - _height/2;

if(!surface_exists(popupSurface)){
	popupSurface = surface_create(_width, _height);
}else{
	surface_set_target(popupSurface);
		draw_sprite_tiled_ext(sBoxBG, 0, current_time/100, current_time/100, 2, 2, -1, 1);
	surface_reset_target();
	
	draw_surface_ext(popupSurface, _xx, _yy - 30 * (1 - transform), 1, 1, 0, -1, 1 * transform);
	draw_sprite_stretched(sBoxBorder2, 0, _xx, _yy - 30 * (1 - transform), _width, _height);
}
		
//desenhando a mensagem
draw_set_color(c_white);
draw_set_font(fnDialog);
		
var _h = string_height_scribble(text);

var _scriblle = scribble(text)
		.starting_format("fnDialog", c_white)
		.align(fa_center, fa_middle)
		.wrap(_xx + _width/2, _yy + _h, false)
		.blend(c_white, 1 * transform)
		
_scriblle.draw(_xx + _width/2, _yy + _height/2 - 30 * (1 - transform));


//desenhando as opções
draw_set_font(fnDialog);
draw_set_halign(fa_center);

var _opWidth1 = string_width(op1);
var _opWidth2 = string_width(op2);
var _opHeight = string_height(op1)/2;
var _opMargin = 15;

var _text_xx1 = _xx + _opWidth1 * 2;
var _text_xx2 = _xx + _width - _opWidth1 * 2;
var _text_yy = _yy + _height - _opHeight;

//background das opções
draw_set_alpha(1 * transform);
draw_set_color($181823);
if(op2 != ""){
	draw_rectangle(_text_xx1 - _opWidth1/2 - _opMargin + 1, _text_yy - _opMargin + 1, _text_xx1 + _opWidth2/2 + _opMargin, _text_yy + _opHeight * 2 + _opMargin - 2, false);	
	draw_rectangle(_text_xx2 - _opWidth1/2 - _opMargin + 1, _text_yy - _opMargin + 1, _text_xx2 + _opWidth2/2 + _opMargin, _text_yy + _opHeight * 2 + _opMargin - 2, false);
}else{
		draw_rectangle(_xx + _width/2 - _opWidth1/2 - _opMargin + 1, _text_yy - _opMargin + 1, _xx + _width/2 + _opWidth1/2 + _opMargin, _text_yy + _opHeight * 2 + _opMargin - 2, false);	
}
draw_set_color(c_white);
draw_set_alpha(1);


//desenhando seta de seleção
draw_set_alpha(.4 * transform);
draw_set_color(C_GREEN);

if(index == 0){
	if(op2 != ""){
		draw_rectangle(_text_xx1 - _opWidth1/2 - _opMargin + 1, _text_yy - _opMargin + 1, _text_xx1 + _opWidth2/2 + _opMargin, _text_yy + _opHeight * 2 + _opMargin - 2, false);	
	}else{
		draw_rectangle(_xx + _width/2 - _opWidth1/2 - _opMargin + 1, _text_yy - _opMargin + 1, _xx + _width/2 + _opWidth1/2 + _opMargin, _text_yy + _opHeight * 2 + _opMargin - 2, false);	
	}
}else if(index == 1){
	draw_rectangle(_text_xx2 - _opWidth1/2 - _opMargin + 1, _text_yy - _opMargin + 1, _text_xx2 + _opWidth2/2 + _opMargin, _text_yy + _opHeight * 2 + _opMargin - 2, false);
}

draw_set_color(c_white);
draw_set_alpha(1);

draw_set_alpha(1 * transform);
if(op2 != ""){
	draw_sprite_stretched(sBoxBorder, 0, _text_xx1 - _opWidth2/2 - _opMargin, _text_yy - _opMargin, _opWidth1 + _opMargin * 2 , _opHeight * 2 + _opMargin * 2);	
	draw_sprite_stretched(sBoxBorder, 0, _text_xx2 - _opWidth2/2 - _opMargin, _text_yy - _opMargin, _opWidth1 + _opMargin * 2, _opHeight * 2 +_opMargin * 2 );	
}else{
	draw_sprite_stretched(sBoxBorder, 0, _xx + _width/2 - _opWidth1/2 - _opMargin, _text_yy - _opMargin, _opWidth1 + _opMargin * 2 , _opHeight * 2 + _opMargin * 2);	
}
draw_set_alpha(1);

draw_set_font(fnDialog);
draw_set_halign(fa_center);
draw_set_color(c_white);
if(op2 != ""){
	draw_text(_text_xx1, _text_yy + 4, op1);
	draw_text(_text_xx2, _text_yy + 4, op2);
}else{
	draw_text(_xx + _width/2, _text_yy + 4, op1);
}
	
if(confirm){
	if(!audio_is_playing(snSelect))
		audio_play_sound(snSelect, 1, 0);
	callbackArray[index]();
	state = 1;
}
