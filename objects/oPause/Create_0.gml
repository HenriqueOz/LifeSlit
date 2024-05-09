
arrayOption = [MENU_PAUSE[0], MENU_PAUSE[1], MENU_PAUSE[2]];
index = 0;
pastIndex = 0;

keyConfirm = 0;
canControl = false;

time = 0;
transform = 0;
state = -1;

pauseSurf = -1;
pauseSurfBuffer = -1;
surfWidth = CAM_WIDTH * SCALE;
surfHeight = CAM_HEIGHT * SCALE;

PauseContinue = function(){
	global.paused = false;
	canControl = false;
		
	//resetando animações
	index = 0;
	state = 1;
	time = 10;
	
	instance_activate_all();
}

PauseOptions = function(){
	canControl = false;
	instance_create_depth(0, 0, 0, oConfig);
}

PauseMenu = function(){
	keyboard_clear(vk_escape);
	
	var _cancel = function(){
		global.paused = true;
		canControl = true;
		return;
	}
	
	var _confirm = function(){
		PauseContinue();
		index = 2;
		
		if(instance_exists(oPlayer)){
			oPlayer.canControl = false;
			oPlayer.invencible = false;
			oPlayer.canHurt = false;
		}
		fadeToRoom(rmMenu, 60, c_black);
	}
	
	create_popup(MENU_GO_TOMENU, MENU_POPUP[1], MENU_POPUP[0], _cancel, _confirm);
}