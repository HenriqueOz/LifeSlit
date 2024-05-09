depth = -9999;

//iniciando o jogo - waprando da room de loading para o menu quando os aúdios serem carregados 
if(audio_group_is_loaded(GroupMusic) && audio_group_is_loaded(GroupSFX) && !audioGroupLoaded){
	audioGroupLoaded = true;
	fadeToRoom(rmMenu, 1, c_black);
}

//chegar existência do save
global.saveExists1 = file_exists(global.saveName1) ? true : false;
global.saveExists2 = file_exists(global.saveName2) ? true : false;
global.saveExists3 = file_exists(global.saveName3) ? true : false;

global.saveExistsArray = [
	global.saveExists1,
	global.saveExists2,
	global.saveExists3
]

//checando se o mouse está se movendo
global.mouseMoving = point_distance(mousexPast, mouseyPast, mouse_x, mouse_y);
mousexPast = mouse_x;
mouseyPast = mouse_y;
window_set_cursor(cr_none);


//setar tela cheia
if(keyboard_check_pressed(vk_f11) || keyboard_check(vk_alt) && keyboard_check_pressed(vk_enter)){
	keyboard_clear(vk_enter);
	global.fullscreen = !global.fullscreen;
	window_set_fullscreen(global.fullscreen);
	
	if(!global.fullscreen){
		//surface_resize(application_surface, CAM_WIDTH * SCALE, CAM_HEIGHT * SCALE);
		window_set_size(CAM_WIDTH * SCALE, CAM_HEIGHT * SCALE);
		window_center();
	}
	
	ini_open(global.iniName);
		ini_write_real(global.section.settings, global.key.fullscreen, global.fullscreen);
	ini_close();
}




//setando sistema de pause
if(room == rmDeath){//setando o can pause como true na room de morte, pq quando o player morre ele se torna false
	global.canPause = true;
}

if(room == rmMenu || room == rmSave){
	global.canPause = false;
}

//if(keyboard_check_pressed(ord("G"))){
//	warp(80, 300, rmBoss, 10, true); 
//}


//debug controls
//if(keyboard_check_pressed(ord("R")))	game_restart(); 

//parallax
var _tx = global.camX;
var _ty = global.camY;
var _amount = 0;

if(layer_exists("bg1")){
	_amount = .5;
	layer_x("bg1", _tx * _amount);
	layer_y("bg1", _ty * _amount);
}
if(layer_exists("bg2")){
	_amount = .90;
	layer_x("bg2",_tx * _amount);
	layer_y("bg2",  _ty * _amount);
}
if(layer_exists("bg3")){
	_amount = .95;
	layer_x("bg3", _tx * _amount);
	layer_y("bg3",  _ty * _amount);
}
if(layer_exists("bg4")){
	_amount = .98;
	layer_x("bg4", _tx * _amount);
	layer_y("bg4",  _ty * _amount);
}
if(layer_exists("bg5")){
	_amount = 1;
	layer_x("bg5", _tx * _amount);
	layer_y("bg5",  _ty * _amount);
}

