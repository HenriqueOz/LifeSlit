if(!global.canPause)	exit;

gpu_set_blendenable(false);

//equanto pausado desenhar a surface armazenada no momento do pause
if(global.paused){
	//desenhando a cópia da surface do game nela mesma pós pause
	surface_set_target(application_surface);
		if(surface_exists(pauseSurf)){
			draw_surface(pauseSurf, 0, 0);
		}else{
			pauseSurf = surface_create(surfWidth, surfHeight);
			buffer_set_surface(pauseSurfBuffer, pauseSurf, 0);
		}
	surface_reset_target();
}

//clicando para pausar
if(keyboard_check_pressed(vk_escape) && global.canPause && !instance_exists(oPopup) && !instance_exists(oConfig)){
	if(!global.paused){
		global.paused = true;
		canControl = true;
		state = 0;//iniciando animação do pause
		index = 0;
		
		//pausando objetos
		instance_deactivate_all(true);
		instance_activate_object(oControl);
		instance_activate_object(oPopup);

		//copiando a surface no momento do pause
		pauseSurf = surface_create(surfWidth, surfHeight);
		surface_set_target(pauseSurf);
			draw_surface(application_surface, 0, 0);
		surface_reset_target();
	
		//buffer
		if(buffer_exists(pauseSurfBuffer)){
			buffer_delete(pauseSurfBuffer);
		}
	
		pauseSurfBuffer = buffer_create(surfWidth * surfHeight * 4, buffer_fixed, 1);
		buffer_get_surface(pauseSurfBuffer, pauseSurf, 0);
	}else{
		PauseContinue();
		if(buffer_exists(pauseSurfBuffer))	buffer_delete(pauseSurfBuffer);
	}
}

gpu_set_blendenable(true);