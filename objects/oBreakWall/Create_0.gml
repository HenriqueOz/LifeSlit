breaked = false;

if(globalName != ""){
	if(variable_global_exists(globalName)){
		var _g = variable_global_get(globalName);
		
		if(_g == true){
			layer_set_visible("fakeWalls", false);
			instance_destroy(self);
		}
	}
}