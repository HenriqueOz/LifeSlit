/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Inherit the parent event
event_inherited();

y += sin(current_time/250) * .15;
light.drawY = y;


if(inInteraction){
	variable_global_set(globalName, true);
	
	var _json = loadString(global.saveNameArray[global.saveId]);
	var _saveStruct = json_parse(_json);
	
	_saveStruct.k.k1 = global.key1;
	_saveStruct.k.k2 = global.key2;
	_saveStruct.k.k3 = global.key3;
	_saveStruct.k.k4 = global.key4;
	_saveStruct.k.k5 = global.key5;
	
	_json = json_stringify(_saveStruct);
	saveString(_json, global.saveNameArray[global.saveId]);
	
	repeat(10){
		var _xx = x + random_range(-12, 12);
		var _yy = y + random_range(-12, 12);
		
		part_particles_create(global.particleSystem, _xx, _yy, global.particleSparkles, 1);
	}
	
	instance_destroy(self);
}