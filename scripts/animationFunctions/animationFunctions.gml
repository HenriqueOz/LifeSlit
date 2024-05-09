function restartSprite(){
		image_index = 0;
		image_speed = 1;
}

function animationEnd(){
		if(image_index > image_number - 1)	return(true);
		else	return(false);
}

function freezeSprite(_freeze){
		static _lock = false;
		static _spd = 0;
		
		if(!_lock){
			_lock = true;
			_spd = image_speed;
		}
		
		if(_freeze){
			image_speed = 0;
		}else{
			_lock = false;
			image_speed = _spd;
		}
}
	
function spriteBroadcast(messageType, callback){
	if(event_data[? "event_type"] == "sprite event"){
		if(event_data[? "message"] == messageType){
			callback();
		}
	}
}