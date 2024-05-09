display_set_gui_size(GUI_WDITH, GUI_HEIGHT);
draw_set_alpha(alpha);

//---------------DESENHANDO A HUD----------------------//

var _s = sHud;
var _icon = 0;//setando o index do sprite
var _lifeFull = 1;
var _lifeEmpty = 2;
var _manaFull = 3;
var _manaEmpty = 4;
var _item = 5;

var _xoffset = 25;
var _yoffset = 25;

if(instance_exists(oPlayer)){
	draw_sprite(sHud, _icon, _xoffset, _yoffset);
	
	//vida
	for(var i = 0; i < oPlayer.maxHp; i++){
		//desenhando a vida máxima
		var _space = 40;
		draw_sprite(sHud, _lifeEmpty, _xoffset + 30 + _space * i, _yoffset - 25);	
	
		//desenhando a vida atual
		if(i < oPlayer.hp){
			draw_sprite(sHud, _lifeFull, _xoffset + 30 + _space * i, _yoffset - 25);	
				
			//animação de healing na hud - ATT: não me pergunte como eu fiz, nem eu sei direito a verificação que fiz pra executar a animação, ass: Sopa
			if(oPlayer.state == oPlayer.stateHealing && i + 1 == oPlayer.hp){
				gpu_set_fog(true, c_white, 0, 0);
					draw_sprite_ext(sHud, _lifeFull, _xoffset + 30 + _space * i, _yoffset - 25, 1, 1, 0, -1, 1/oPlayer.healingTime * oPlayer.healingCounter);	
				gpu_set_fog(false, c_white, 0, 0);
			}
		}
			

	}

	//mana
	for(var i = 0; i < oPlayer.maxMana; i++){
		//desenhando a mana máxima
		var _space = 35;
		draw_sprite(sHud, _manaEmpty, _xoffset + _space * i, _yoffset + 5);	
	
		//desenhando a mana atual
		if(i < oPlayer.mana){
			draw_sprite(sHud, _manaFull, _xoffset + _space * i, _yoffset + 5);	
			
			if(manaTimer > 0 && i + 1 == oPlayer.mana){
				var _scale = 1 + .05/45 * manaTimer;
				
				gpu_set_fog(true, c_white, 0, 0);
					draw_sprite_ext(sHud, _manaFull, _xoffset + _space * i, _yoffset + 5, _scale, _scale, 0, -1, 1/45 * manaTimer);	
					draw_sprite_ext(sHud, _manaFull, _xoffset + _space * i, _yoffset + 5, 1, 1, 0, -1, 1/45 * manaTimer);	
				gpu_set_fog(false, c_white, 0, 0);
			}
		}
	}

	//item de healing
	var _textEfx = "";
		
	if(oPlayer.state == oPlayer.stateFree && oPlayer.keyItem && oPlayer.lifeShard <= 0){
		_textEfx = "[shake][pulse][wave]"
	}
		
	if(oPlayer.state == oPlayer.stateHealing){
		_textEfx = "[wave]"
		draw_sprite_ext(sHud, _item, _xoffset - 25, _yoffset + 15, 1, 1, 0, -1, 1);
	}else{
		draw_sprite(sHud, _item, _xoffset - 25, _yoffset + 15);
	}

	var _scribble = scribble(_textEfx+string(oPlayer.lifeShard))
		.starting_format("fnPixel", c_white)
		.blend(c_white, alpha)
		.transform(1.2, 1.2)
		.draw(_xoffset + 110, _yoffset + 120);
		
		
	//barra de poderes
	//var _sprites = [sPowerSymbol];
	//var _coolDown = [oPlayer.powerCoolDown];
	//var _xx = GUI_WDITH/2;
	//var _yy = GUI_HEIGHT - 48;
	//var _space = 40 * (powerNumber - 1);
	
	//for(var i = 0; i < powerNumber; i++){
	//	var _n_xx = _xx - _space/(i - 1);
		
	//	draw_sprite(_sprites[i], 1, _n_xx, _yy);
		
	//	if(_coolDown[i] <= 0){
	//		draw_sprite(_sprites[i], 0, _n_xx, _yy);
	//	}
		
	//	if(_coolDown[i] > 0){
	//		draw_text(_xx + 24, _yy + 20, floor(_coolDown[i]/60));
	//	}
	//}
	
}




draw_set_alpha(1);

//desenhando as bordas de cutscene
if(global.cutsceneMode){
	yinc += 8;
}else{
	yinc -= 15;
}

yinc = clamp(yinc, -1, GUI_HEIGHT/7);	

if(yinc > 0){
	draw_set_color(c_black);
	draw_rectangle(0, 0, GUI_WDITH, yinc, false);
	draw_rectangle(0, GUI_HEIGHT, GUI_WDITH, GUI_HEIGHT - yinc, false);
	draw_set_color(c_white);
}

