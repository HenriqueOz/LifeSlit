display_set_gui_size(GUI_WDITH, GUI_HEIGHT);

draw_set_font(fnPixel);
var _length = array_length(content);
var _text_width = 0;
var _margin = 10;
var _height = string_height(content[0]);
var _line = 0;
var _scale = 1.5;
var _lineSpacing = 30 * _scale;

for(var i = 0; i < _length; i++){
	_text_width = max(_text_width, string_width_scribble(content[i])) * _scale;
	_line++;
}

//pegamdo o id da intancia de mensagem mais recente para, então, mostraa-la
var _numb = instance_number(oMessage);
var _inst = instance_find(oMessage, _numb - 1);

//if(id == _inst.id){
	for(var i = 0; i < _length; i++){
		var _scribble = scribble("[scale, 1.5]"+content[i])
			.starting_format("fnPixel", c_white)
			.blend(c_white, alpha)
			.draw(GUI_WDITH - _text_width - _margin, GUI_HEIGHT - _lineSpacing * (_line - i) - _margin - _height);	
	}
//}

