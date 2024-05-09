var _player = collision_rectangle(x - 1, y - 1, x + sprite_width + 1, y + sprite_height + 1, oPlayer, false, false);

if(_player != noone && _player.state == _player.stateDash){
	camShake(5, 2);
	_player.x += 16 * _player.dirx;
	
	with(oPlayer){
		while(instance_place(x, y, oWall))
			y--;
	}
}

if(_player && instance_place(x, y, oPlayer)){
	_player.x += 16 * _player.dirx;
}

if(time-- < 0){
	var _xx = x + irandom_range(0, width);
	var _yy = y + irandom_range(0, height);
	
	part_particles_create(global.particleSystem, _xx, _yy, global.particleDrop, 1);
	
	time = particleCd;
}