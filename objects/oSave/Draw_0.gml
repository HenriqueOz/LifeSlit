
var _sin = sin(current_time/500);
var _cos = cos(current_time/500);

var _ps = global.particleSystem;
var _em = emitter;
var _pt1 = global.particleSparkles;

switch(state){
	case(0):
		part_emitter_region(_ps, _em, x - 16, x + 16, y, y - 32, ps_shape_rectangle, ps_distr_invgaussian);
		part_emitter_burst(_ps, _em, _pt1, -5);
	
		//desenhando o save
		draw_sprite_ext(sprite_index, 0, x, y + sin(current_time/750) * 2, 1, 1, 0, c_white, 1);

		//desenhando as pedras da frente
		draw_sprite_part_ext(sprite_index, 1, 0, 0, sprite_width/2, sprite_height/2, x - 16, y - 55 - _sin, 1, 1, c_white, 1);
		draw_sprite_part_ext(sprite_index, 1, sprite_width/2, sprite_height/2, sprite_width, sprite_height, x, y - 25 + _sin, 1, 1, c_white, 1);
	break;
	
	case(1):
		part_emitter_burst(_ps, _em, _pt1, -4);
		part_emitter_region(_ps, _em, x - 16, x + 16, y, y - 32, ps_shape_diamond, ps_distr_invgaussian);
	
		//desenhando o save
		draw_sprite_ext(sprite_index, 0, x, y + sin(current_time/250) * 4, 1, 1, 0, c_white, 1);
		//desenhando as pedras da frente
		draw_sprite_part_ext(sprite_index, 1, 0, 0, sprite_width/2, sprite_height/2, x - 16, y - 55 - _sin * 4, 1, 1, c_white, 1);
		draw_sprite_part_ext(sprite_index, 1, sprite_width/2, sprite_height/2, sprite_width, sprite_height, x, y - 25 + _sin * 4, 1, 1, c_white, 1);
		
		gpu_set_fog(true, c_white, 0, 0);
			draw_sprite_ext(sprite_index, 0, x, y + sin(current_time/750) * 2, 1, 1, 0, c_white, 1 * abs(sin(current_time/500) * .7));
			//desenhando as pedras da frente
			draw_sprite_part_ext(sprite_index, 1, 0, 0, sprite_width/2, sprite_height/2, x - 16, y - 55 - _sin, 1, 1, c_white, 1);
			draw_sprite_part_ext(sprite_index, 1, sprite_width/2, sprite_height/2, sprite_width, sprite_height, x, y - 25 + _sin, 1, 1, c_white, 1);
		gpu_set_fog(false, c_white, 0, 0);
	break;
	
	case(2):
		var _amount = clamp(alpha, 0, 1);
		y  = lerp(y, ystart - 32 * _amount, 1);
		
		part_type_direction(oParticle.particleImpact, 85, 95, 0, 0);
		part_emitter_burst(_ps, _em, oParticle.particleImpact, -4 * _amount);
		part_emitter_region(_ps, _em, x - 16, x + 16, y, y - 32, ps_shape_diamond, ps_distr_invgaussian);
		
		part_emitter_burst(_ps, _em, _pt1, -4 * _amount);
		part_emitter_region(_ps, _em, x - 16, x + 16, y - 32, y - 320, ps_shape_diamond, ps_distr_invgaussian);
		
		//desenhando a luz
			//checando se o player está spawnando, caso sim a luz será desenhada com a velocidade baseada na animação dele
		var _lightAmount = instance_exists(oPlayer) && oPlayer.state == oPlayer.stateSpawning ? oPlayer.ease : _amount;
		
		draw_set_alpha(1/20 * _lightAmount);
			for(var i = 0; i < 10; i++){
				var _xx = x - 16 - _cos;
				var _yy = y - 30 + 640;
				var _width = x + 16 + _cos;
				var _height = y - 640;
				draw_rectangle(_xx, _yy, _width, _height, false);
			}
		draw_set_alpha(1);
		
		//desenhando o save
		draw_sprite_ext(sprite_index, 0, x, y + sin(current_time/750) * 2, 1, 1, 0, c_white, 1);
			
		//desenhando as pedras da frente
		draw_sprite_part_ext(sprite_index, 1, 0, 0, sprite_width/2, sprite_height/2, x - 16, y - 55 - _sin, 1, 1, c_white, 1);
		draw_sprite_part_ext(sprite_index, 1, sprite_width/2, sprite_height/2, sprite_width, sprite_height, x, y - 25 + _sin, 1, 1, c_white, 1);
		
		//overlay
		gpu_set_fog(true, c_white, 0, 0);
			part_emitter_burst(_ps, _em, _pt1, -2);
			part_emitter_region(_ps, _em, x - 32 * _amount, x + 32 * _amount, ystart, y - (ystart - 32 - y), ps_shape_diamond, ps_distr_invgaussian);
			
			//desenhando o save
			draw_sprite_ext(sprite_index, 0, x, y + sin(current_time/750) * 2, 1, 1, 0, c_white, .3 + abs(cos(current_time/100)) * .4);
			
			//desenhando as pedras da frente
			draw_sprite_part_ext(sprite_index, 1, 0, 0, sprite_width/2, sprite_height/2, x - 16, y - 55 - _sin, 1, 1, c_white, .3 + abs(cos(current_time/100)) * .4);
			draw_sprite_part_ext(sprite_index, 1, sprite_width/2, sprite_height/2, sprite_width, sprite_height, x, y - 25 + _sin, 1, 1, c_white, .3 + abs(cos(current_time/100)) * .4);
		gpu_set_fog(false, c_white, 0, 0);
		
		if(y == ystart && alphaStep == 1){
			state = 0;
			part_emitter_clear(global.particleSystem, _em);
		}
	break;
}

if(drawKey){
	draw_sprite_ext(sInteraction, 0, x - sprite_get_width(sInteraction)/2, y - sprite_height - 20 + _sin * 2, 1, 1, 0, c_white, keyInconAlpha);
}