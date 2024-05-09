function fadeToRoom(_room, _duration, _color){
	if(instance_exists(oFade)){
		instance_destroy(oFade)
	}
	
	var _instFade = instance_create_depth(0, 0, 0, oFade);

	with (_instFade) {
		targetRoomFade = _room;
		durationFade = _duration;
		colorFade = _color;
	}
	
}