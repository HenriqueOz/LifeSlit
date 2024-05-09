if(variable_global_get(key)){
	timerCreate = blocks * timerBlock;
	mask_index = sprite_index;
}

var _p = instance_place(x, y, oPlayer);
if(_p){
	with(_p){
		while(instance_place(x, y, oBridge))
			y--;
	}
}