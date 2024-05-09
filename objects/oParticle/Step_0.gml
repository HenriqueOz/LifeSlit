//setando a direção das particulas de hit em função da direção do player
if(instance_exists(oPlayer)){
	var _dir = oPlayer.dirx == 1 ? 0 : 180;
	part_type_direction(global.particleHit1, _dir - 45,_dir + 45, 0, 0); 	
}

//if(mouse_check_button_pressed(mb_middle)){
//	repeat(10){
//		var _ang = random(360);
//		var _len = irandom_range(60, 80);
//		var _xx = 200 + lengthdir_x(_len, _ang);
//		var _yy = 200 + lengthdir_y(_len, _ang);
//		var _part_dir = point_direction(_xx, _yy, 200, 200);
//		part_type_direction(particleCenter, _part_dir, _part_dir, 0, 0);
//		part_particles_create(global.particleSystem, _xx, _yy, particleCenter, 1);
//	}
//}