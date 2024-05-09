
//teleporta o player para a rom desejada
function warp(_tx, _ty, _rm, _time, _createPlayer){
	if(instance_exists(oFade)){
		instance_destroy(oFade);
	}
	
	fadeToRoom(_rm, _time, c_black);
	if(_createPlayer){ 
		with(instance_create_layer(0, 0, layer, oPlayerPosition)){
			if(instance_exists(oPlayer)){
				var _p = instance_create_layer(0, 0, layer, oPlayerData);
				playerData = _p.playerData; 
			}
			createPlayer = _createPlayer
			rm = _rm;
			tx = _tx;
			ty = _ty;
		}
	}
	return;
}


//cria uma lança no player
function createSpear(_dir){
	var _inst = instance_create_layer(x, y - sprite_get_height(sPlayerIdle)/2, "player", oSpear);
	
	with(_inst){
		depth = oPlayer.depth - 1;
		image_angle = _dir;
	}
	
	return(_inst.id);
}


//cria um pop-up
function create_popup(_message, _op1, _op2, _callback1, _callback2){
	//criando a instância de popup
	if(instance_exists(oPopup)){
		instance_destroy(oPopup);
	}
	
	var _inst = instance_create_depth(0, 0, 0, oPopup);
	
	with(_inst){
		text = _message;
		op1 = _op1;
		op2 = _op2;
		callback1 = _callback1;
		callback2 = _callback2;
	}
	
	return(_inst);
}

function createChoiceBox(_x, _y, _label, _options){
	if(instance_exists(oChoiceBox)){
		instance_destroy(oChoiceBox);
	}
	
	var _inst = instance_create_depth(_x, _y, -9999, oChoiceBox);
	
	with(_inst){
		label = _label;
		options = _options;
	}
}

function createMessage(_content){
	var _msg = instance_create_depth(0, 0, 0, oMessage);
	
	with(_msg){
		content = _content;
		inGame = false;
	}
	
	return(_msg);
}

function createFullMessage(_title, _content, _onClose){
	var _msg = instance_create_depth(0, 0, 0, oFullMessage);
	
	with(_msg){
		title = _title;
		content = _content;
		onClose = _onClose;
	}
	
	return(_msg);
}

function gravityAcelleration(_mass){
	vspd += GRV * _mass;
}

function collision(_col_x, _col_y){
	if(_col_x){
		if(place_meeting(x + hspd, y, oParWall)){
			while(!place_meeting(x + sign(hspd), y, oParWall)){
				x += sign(hspd);
			}
			hspd = 0;
		}
	
		x += hspd;
	}
	
	
	if(_col_y){
		if(place_meeting(x, y + vspd, oParWall)){
			while(!place_meeting(x, y + sign(vspd), oParWall)){
				y += sign(vspd);
			}
			vspd = 0;
		}
	
		y += vspd;
	}
}
	

function createOneTimeSprite(_x, _y, _sprite, _index, _xscale, _yscale, _onDestroy){
	with(instance_create_depth(_x, _y, depth, oSprite)){
		sprite_index = _sprite;
		image_index = _index;
		onDestroy = _onDestroy;
		image_xscale = _xscale;
		image_yscale = _yscale;
	}
}

function createLight(_x, _y, _xscale, _yscale, _oscilation, _alpha, _intensity){
	var light = instance_create_layer(_x, _y, layer, oLightEntities);
	light.scalex = _xscale;
	light.scaley = _yscale;
	light.oscilation = _oscilation;
	light.alpha = _alpha;
	light.intensity = _intensity;//ente 0 e 1
	
	return(light);
}

function keyboardKeyName(argument0){
	var name = global.keyboard_key_to_name[?argument0];
	if (name == undefined) 
		return "";
	return name;
}



