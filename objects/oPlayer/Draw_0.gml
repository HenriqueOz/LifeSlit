//DEBUG
//draw_set_color(c_green);
//draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
//draw_set_color(c_white);

//draw_text(x, y - sprite_height - 40, stateName);
//draw_text(x, y - sprite_height - 30, sprite_get_name(sprite));
//draw_text(x, y - sprite_height - 20, spriteState);

//desenhando o fundo preto quando o player morre
if(isDeath){
	depth = layer_get_depth("frames") - 1;
	draw_set_color(c_black);
	draw_rectangle(x - 500, y - 640, x + 500, y + 640, false);
	draw_sprite_ext(sprite, image_index, x, y, dirx, yscale, 0, c_white, 1);
	draw_set_color(c_white);
}else{

#region//desenhando o indicador de direção
	if(state == statePowerCharge && instance_exists(oSpear)){
		//desenhando setas de indicação do ataque
		for(var i = 0; i < oSpear.chargeState + 1; i++){
			var a = i; 
			var _len = 60 + (10 * a);
			var _sx = 1 + (a * .3), _sy = 1 - (a * .3);
			draw_sprite_ext(sArrow, 0, x + lengthdir_x(_len, spearDir), (y + lengthdir_y(_len, spearDir)) - sprite_get_height(sPlayerIdle)/2, _sx, _sy, spearDir, -1, 1);
		}
		
		//desenhando cursor quando no state power
		var _scale = 1.2 + sin(current_time/200) * .5;
		draw_sprite_ext(sMouse, 0, mouse_x, mouse_y, _scale, _scale, -current_time/10, c_dkgray, 1);
		draw_sprite_ext(sMouse, 0, mouse_x, mouse_y, _scale, _scale, current_time/10, -1, 1);
	}
#endregion

}

//piscar o player em branco
if(blinkTime-- > 0){
	gpu_set_fog(true, c_white, 0, 0);
}

//desenhando o player normalmente
draw_sprite_ext(sprite, image_index, xdraw, ydraw, xscale * dirx, yscale, 0, c_white, image_alpha);
gpu_set_fog(false, c_white, 0, 0);

//player píscando quando o golpe carrega
if(instance_exists(spearId) && state == statePowerCharge){
	var _amount = 200/spearId.chargeState;
	
	gpu_set_fog(true, C_GREEN, 0, 0);
	draw_sprite_ext(sprite, image_index, xdraw, ydraw, xscale * dirx, yscale, 0, c_white, abs(sin(current_time/_amount) * .7));
	gpu_set_fog(false, c_white, 0, 0);
	
}

//player respawnando
if(state == stateSpawning){
	var _easeSprite = spawnState == 0 ? ease : 1;	
	gpu_set_fog(true, make_color_hsv(70 + 30 * sin(current_time), 150, 250), 0, 0);
		draw_set_alpha(1/20 * ease);
			for(var i = 0; i < 10; i++){
				var _xx = x - 16;
				var _yy = y;
				var _width = x + 16;
				var _height = y - 320;
				draw_rectangle(_xx, _yy, _width, _height, false);
			}
		draw_set_alpha(1);
	
		var _sprite = sPlayerIdle;
		var _height = sprite_get_height(_sprite);
		var _width = sprite_get_width(_sprite);
		var _chunk = 4;
		
		for(var i = 0; i < _width * _easeSprite; i += _chunk){
			for(var j = 0; j < _height * _easeSprite; j += _chunk){
				var _xx = x - _width/2 + i;
				var _yy = y - _height + j;
				
				draw_sprite_part_ext(_sprite, image_index, i, j, _chunk, _chunk, _xx, _yy, 1, 1, -1, 1 * ease);
			}
		}
	gpu_set_fog(false, c_white, 0, 0);	
}

//piscando o player em verde quando está se healando
if(state == stateHealing || blinkGreen-- > 0){
	var _alpha = state == stateHealing ? 1/healingTime * (healingCounter * 1.5) : 1/45 * blinkGreen;
	
	gpu_set_fog(true, C_GREEN, 0, 0);
	draw_sprite_ext(sprite, image_index, xdraw, ydraw, xscale * dirx, yscale, 0, -1, _alpha);
	gpu_set_fog(false, c_white, 0, 0);
}




