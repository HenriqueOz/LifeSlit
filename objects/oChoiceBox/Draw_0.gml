var _length = array_length(options);

draw_set_font(fnMenuBox);

//definindo a tamanho da caixa de dialogo
if(getHugeString){
	stringWidth = string_width_scribble(label);
	for(var i = 0; i < _length; i++){
		var _h = string_width_scribble(options[i][0]);
		stringWidth = max(_h, stringWidth);
	}
	getHugeString = false;
}

var _lines = _length + 1;//quantidade de opções somada com a label
var _margin = 10;
var _box_ww =  stringWidth;
var _box_hh = ((string_height_scribble(label)) * _lines);

//desenhando a caixa de escolha
if(!surface_exists(boxSurface)){
	boxSurface = surface_create(_box_ww + _margin * 3, _box_hh + _margin * 3);
}else{
	surface_set_target(boxSurface);
		draw_sprite_tiled(sBoxBG, 0, current_time/150, current_time/150);	
	surface_reset_target();
	draw_surface_ext(boxSurface, x - _margin, y - _margin, 1, 1, 0, -1, 1 * transform);
	draw_sprite_stretched_ext(sBoxBorder2, 0, x - _margin, y -_margin, _box_ww + _margin * 3, _box_hh + _margin * 3, -1, 1 * transform);
}

//desenhando a label
var _label_xx = x;
var _label_yy = y;

var _scribbleLabel = scribble("[scale, .5]"+label)
	.starting_format("fnDialog", c_white)
	.blend(C_GREEN, 1 * transform)
	.draw(_label_xx, _label_yy - _margin/2);


//desenhando as opções
var _text_xx = x;
var _text_yy = y + string_height_scribble(label);

for(var i = 0; i < _length; i++){
	var _text = options[i][0];
	var _col = c_white;
	 
	if(index == i){
		var _selected_yy = _text_yy + 15 * i;
		draw_set_color(C_GREEN);
		draw_set_alpha(.2);
		draw_rectangle(x, _selected_yy, x + _box_ww, _selected_yy + string_height_scribble(_text) - 2, false);
		draw_set_alpha(1);
		draw_set_color(c_white);
		
		draw_sprite(sSelectionBox, current_time/500, _text_xx - 6, _text_yy + string_height_scribble(_text) * i + 4);
	}
	
	var _scribbleOp = scribble("[scale, .5]"+_text)
		.starting_format("fnDialog", c_white)
		.blend(_col, 1 * transform)
		.draw(_text_xx, (_text_yy + 15 * i * transform));
}
