var _player = instance_place(x, y, oPlayer);

if(_player){
	_player.canControl = false;
	global.showHud = false;
	
	fadeToRoom(rmMenu, 300, c_white);
}







