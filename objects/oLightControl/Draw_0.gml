if(!surface_exists(lightSurf)){
	lightSurf = surface_create(CAM_WIDTH + 64, CAM_HEIGHT + 64);
}
		
matrix_set(matrix_world, matrix_build(-global.camX, -global.camY, 0, 0, 0, 0, 1, 1, 1));
surface_set_target(lightSurf);
	draw_clear_alpha(make_color_hsv(0, 0, 255/1 * max(.1, bright)), 1);    
	gpu_set_blendmode(bm_add);

		with(oLightEntities){
			var a = scalex;
			var b = scaley;
			if(oscilation != 0){
				a = scalex + (scalex * intensity * sin(time/oscilation));
				b = scaley + (scaley * intensity * sin(time/oscilation));
			}
			
			draw_set_alpha(alpha/35);
				var _t = 40;//raio da luz
				for(var i = 0; i < _t; i++){
					draw_set_color(color);
						var _r = i * a;
						draw_circle(drawX, drawY, _r, false);
				}
			draw_set_alpha(1);
			
			//draw_sprite_ext(sLight, 0, drawX, drawY, a, b, image_angle, c_white, alpha);
		}
		
surface_reset_target();
gpu_set_blendmode(bm_normal);
matrix_set(matrix_world, matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1));


gpu_set_blendmode_ext(bm_dest_color, bm_zero);	
	camera_apply(oCam.cam);
	draw_surface_ext(lightSurf, global.camX, global.camY, 1, 1, 0, c_white, 1);		
gpu_set_blendmode(bm_normal);

