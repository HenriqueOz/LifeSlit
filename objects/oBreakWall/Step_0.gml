
if(instance_place(x, y, oAttackHitbox) && !breaked){
	breaked = true;
	camShake(3, 5);
		
	repeat(6){
		var _xx = x + random_range(0, sprite_width);
		var _yy = y + random_range(0, sprite_height);
		
		part_particles_create(global.particleSystem, _xx, _yy, global.particleSparkles, 1);
	}
}

if(breaked){
	audio_play_sound(snRock, 1, 0);
	
	var i = 0;
	
	repeat(8){
		var _width = abs(bbox_right - bbox_left);
		var _height = abs(bbox_top - bbox_bottom);
			
		randomize();
			
		var _xx = random_range(bbox_left, bbox_left + _width);
		var _yy = random_range(bbox_top, bbox_top + _height);
			
		var _r = instance_create_depth(_xx, _yy, depth, oStoneParticles);
		_r.direction = 180/5 * i;
		
		i++;
	}

	if(globalName != ""){
		if(variable_global_exists(globalName)){
			variable_global_set(globalName, true);
		}
		
		//salvando a parede descoberta
		var _json = loadString(global.saveNameArray[global.saveId]);
		var _saveStruct = json_parse(_json);
	
		_saveStruct.w.w1 = global.fakeWall1;
		_saveStruct.w.w2 = global.fakeWall2;
		_saveStruct.w.w3 = global.fakeWall3;
		_saveStruct.w.w4 = global.fakeWall4;
		_saveStruct.w.w5 = global.fakeWall5;
		_saveStruct.w.w6 = global.fakeWall6;
		_saveStruct.w.w7 = global.fakeWall7;
		_saveStruct.w.w8 = global.fakeWall8;
		_saveStruct.w.w9 = global.fakeWall9;
		_saveStruct.w.w10 = global.fakeWall10;
	
		_json = json_stringify(_saveStruct);
		saveString(_json, global.saveNameArray[global.saveId]);
		
	}

	layer_set_visible("fakeWalls", false);
	instance_destroy(self);
}