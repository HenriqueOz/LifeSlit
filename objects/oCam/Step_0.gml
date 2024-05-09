if(instance_exists(target)){
	var _cx = 0
	var _cy = 0;
	var _frame = 0
	var _transition = 0;
	
	with(target){
		_transition = instance_place(x, y, oRoomWarp);
		_frame = instance_place(x, y, oCamFrame);
	}
	
	//screenshake
	if(time > 0){
		time --;
	}else{
		magnitude = 0;
	}
	
	//zoom
	var _w = CAM_WIDTH;
	var _h = CAM_HEIGHT;
	
	if(zoom != 0){
		_w = CAM_WIDTH/zoom;
		_h = CAM_HEIGHT/zoom;
		
		cw = lerp(cw, _w, smooth);
		ch = lerp(ch, _h, smooth);
	}
	
	var y_player = target.y - target.sprite_height/2;
	
	var _tx = target.x - cw/2;
	var _ty = target == oPlayer ? y_player - ch/2 : target.y - ch/2;
	
	
	//if(!_transition){
		if(_frame){	
			var cxmin = _frame.x;
			var cxmax = _frame.x + _frame.width - cw;
		
			var cymin = _frame.y;
			var cymax = _frame.y + _frame.height - ch;
		
			_cx = clamp(_tx, cxmin, cxmax);
			_cy = clamp(_ty, cymin, cymax);
			
			amount = .04;
			if((target.y > y + CAM_HEIGHT || target.y < y - CAM_HEIGHT) ||
				(target.x > x + CAM_WIDTH || target.x < x - CAM_WIDTH)){
				amount = .1;
			}
		}else{
			_cx = _tx;
			_cy = _ty;
		}
	//}
	
	if(target == oPlayer && target.isDeath){
		_cx = _tx;
		_cy = _ty - 40;
		amount = 1;
	}
	
	//a câmera seguir o player perfeitamente
	if(instance_exists(oFallControl) && oPlayer.y >= 400){
		amount = 1;
	}
	
	x = lerp(x, _cx, amount);
	y = lerp(y, _cy, amount);
	
	var _finalCx = clamp(x + random_range(-magnitude, magnitude), 0, room_width - cw);
	var _finalCy = clamp(y + random_range(-magnitude, magnitude), 0, room_height - ch);
	camera_set_view_size(cam, cw, ch);
	camera_set_view_pos(cam, _finalCx, _finalCy);
	camera_set_view_angle(cam, random_range(-magnitude, magnitude) * .5);
}

global.camX = camera_get_view_x(cam);
global.camY = camera_get_view_y(cam);

if(room == rmMenu){
	instance_destroy(self);
}
