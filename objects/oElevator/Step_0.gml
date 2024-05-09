key = variable_global_get(globalName);

if(!key)
	exit;


diry = target > y ? 1 : -1;

if(y != target){
	var _finalVspd = spd * diry;
	
	var _playerAbove = place_meeting(x, y - 1, oPlayer);
	var _playerInside = place_meeting(x, y, oPlayer);
	if(_playerAbove || _playerInside){
		with(oPlayer){
			//colocando o player de volta no elevador caso ele seja exprimido contra uma quina
			if(place_meeting(x, y - 1, oParWall) || place_meeting(x, y, oParWall)){
				if(bbox_right > other.bbox_right){
					while(bbox_right > other.bbox_right) x--;	
				}else if(bbox_left < other.bbox_left){
					while(bbox_left < other.bbox_left) x++;		
				}
			}
			
			if(_playerInside)
				oPlayer.y--;
			
			y += other.spd * other.diry;
		}
	}
	
	if(!instance_place(x, y + 48, oPlayer)){
		vspd = _finalVspd;
	}else if(vspd > 0){
		vspd = 0;
	}
}else{
	vspd = 0;
	
	if(t-- < 0){
		target = target == ystart ? yend : ystart;
		t = delay;		
	}
}

y += vspd;