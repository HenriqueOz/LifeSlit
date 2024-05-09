
// Inherit the parent event
event_inherited();

if(!key && inInteraction){
	variable_global_set(globalName, true);
	key = true;
	
	//salvando a key
	var _json = loadString(global.saveNameArray[global.saveId]);
	var _saveStruct = json_parse(_json);
	
	_saveStruct.l.l1 = global.lever1;
	_saveStruct.l.l2 = global.lever2;
	_saveStruct.l.l3 = global.lever3;
	_saveStruct.l.l4 = global.lever4;
	_saveStruct.l.l5 = global.lever5;
	
	_json = json_stringify(_saveStruct);
	saveString(_json, global.saveNameArray[global.saveId]);
	//
}

if(key){
	if(sprite_index != sLeverActive){
		image_index = 0;
		sprite_index = sLeverActive;
	}else{
		if(animationEnd()){
			instance_destroy(self)
		}
	}
}

if(sprite_index != sLeverActive){
	y += sin(current_time/300) * .1;
}
