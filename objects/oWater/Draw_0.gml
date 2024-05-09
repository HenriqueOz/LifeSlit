
if(!surface_exists(surfaceWater)){
	surfaceWater = surface_create(surfWidth, surfHeight);
}else{
	var _pos_x = round(global.camX);
	var _pos_y = round(global.camY);
	
	//surface_copy_part(surfaceWater, 0, 0, application_surface, bbox_left, bbox_top - surfHeight, surfWidth, surfHeight);
	surface_copy_part(surfaceWater, 0, 0, application_surface, x -_pos_x, y - surfHeight - _pos_y, surfWidth, surfHeight + 16);
	 
	//borda superior da água
	draw_set_alpha(1 - sin(current_time/500) * .5);
	draw_set_color(c_white);
		draw_rectangle(x, y, x + surfWidth, y - 2, false);
	draw_set_alpha(1);
	
	draw_surface_ext(surfaceWater, x, y + surfHeight, 1, -1, 0, -1, 1);	
	
	//cor da água
	draw_set_alpha(.3);
	draw_set_color(c_aqua);
		draw_rectangle(x, y, x + surfWidth, y + surfHeight, false);
	draw_set_alpha(1);
	draw_set_color(c_white);
}


