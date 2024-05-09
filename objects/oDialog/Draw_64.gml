display_set_gui_size(GUI_WDITH, GUI_HEIGHT);

var _box = sDialogBox;
var _width = sprite_get_width(_box);
var _height = sprite_get_height(_box);
var _xx = display_get_gui_width()/2 - _width/2;
var _yy = display_get_gui_height() - _height - 30;

//desenhando o portrait do dialogo
var _px1 = 0, _px2 = 0;
var _py = 0;
var _distance = 0;

//alterando coordenadas caso a caixa esteja sob o player
if(overPlayer){
	_yy = display_get_gui_height() - _height - CAM_HEIGHT - 30;//altura da caixa de diáologo
	_py = display_get_gui_height() - sprite_get_height(portrait1);
	_distance = 100;//aumenta a distância no eixo X entre os portraits
}else{
	_py = _yy - sprite_get_height(portrait1) + 15;
}

_px2 = _xx + _width - sprite_get_width(portrait1) + _distance;
_px1 = _xx + sprite_get_width(portrait1) + 20 - _distance;

if(portrait1 != 0 ){
	//deixar o portrait 2 mais escuro
	if(speaking == 2){
		draw_sprite_ext(portrait1, 0, _px1, _py, -1, 1, 0, c_gray, alpha - .05);
	}else{
		draw_sprite_ext(portrait1, 0, _px1, _py, -1, 1, 0, c_white, alpha);
	}
}

if(portrait2 != 0 ){	
	//deixar o portrait 1 mais escuro
	if(speaking == 1){
		draw_sprite_ext(portrait2, 0, _px2, _py, 1, 1, 0, c_gray, alpha - .05);
	}else{
		draw_sprite_ext(portrait2, 0, _px2, _py, 1, 1, 0, c_white, alpha);
	}
}


//desenhando a caixa de dialogo
if(!surface_exists(dialogSurface)){
	dialogSurface = surface_create(_width, _height);
}else{
	surface_set_target(dialogSurface);
		draw_sprite(sDialogBox, 1, 0, 0);
		
		gpu_set_colorwriteenable(1, 1, 1, 0);//conservando o alpha do sprite desenhado acima e comunicando uma mudança das cores
			draw_sprite_tiled_ext(sBoxBG, 0, current_time/150, current_time/150, 2, 2, -1, alpha);
		gpu_set_colorwriteenable(1, 1, 1, 1);//voltando ao normal, assim finalizando o sistema de overlay
	surface_reset_target();
	
	draw_surface(dialogSurface, _xx, _yy);
	draw_sprite(sDialogBox, 0, _xx, _yy);
}
//draw_sprite_ext(_box, 0, _xx, _yy, 1, 1, 0, c_white, alpha);


//desenhando o texto
var _tx = _xx + 80;
var _ty = _yy + 60;

var _scriblleDialog = scribble(text)
		.starting_format("fnDialog", c_white)
		.wrap(_width - 120 , _height - 75, false)
		.blend(c_white, alpha)
		.draw(_tx, _ty + 5, typist)

 
//desenhando o nome
draw_set_halign(fa_left);

var _nx = _tx;
var _ny = _ty - 35;
var _scriblleName = scribble(name)
		.starting_format("fnNames", c_white)
		.blend(c_white, alpha)

if(speaking == 1){
	_scriblleName.draw(_nx, _ny);
}else if(speaking == 2){
	_scriblleName.draw(display_get_gui_width() - _nx - 28, _ny);
}

//desenhando a seta
if(typist.get_state() == 1){
	draw_sprite_ext(sConfirmArrow, 0, _xx + _width - 70, (_yy + _height - 40) + sign(sin(current_time/100)) * 3, 1, 1, 0, c_white, alpha);
}

draw_set_alpha(1);
