
if(state == 0){
	t++;
	transform = ease_linear(t, 0, 1, 30);
	
	if(transform >= 1){
		state = 1;
		transformOut = 2;
	}
	
}else if(state == 1){
	//animação de fechar
	if(closing){
		t--;
		transform = ease_linear(t, 0, 1, 30);
		transformOut = ease_linear(t + 50, 0, 2, 80);
		canControl = false;
	}
	
	if(canControl){
		keyConfirm = keyboard_check_pressed(vk_space);
		move = keyboard_check_pressed(ord("D")) - keyboard_check_pressed(ord("A"));
		moveIndex = keyboard_check_pressed(ord("S")) - keyboard_check_pressed(ord("W"));
		index += moveIndex;
		index = index > optionLength - 1 ? 0 : (index < 0 ? optionLength - 1 : index);
		
		if(pastIndex != index){
			audio_play_sound(snMenuOption, 1, 0);
			pastIndex = index;
		}
		
		//scroll
		if(optionLength > 5){
			var _scrollSize = 55;
			var _scrollMax = 40 * optionLength;
			var _scrollMove = _scrollSize * index;
			if(index <= 1){
				scrolly = 0;
			}else{
				scrolly = _scrollMove;
			}
			scrolly = clamp(scrolly, 0, _scrollMax);
		}
		
		if(keyboard_check_pressed(vk_escape)){
			goBack();
		}
		
		if(move != 0){
			changed = true;
		}
		
		//pegando o tipo de opção coerente ao meu index
		var _op_type = optionData[index][1];
		var _global_var = optionData[index][3];
		
		switch(_op_type){
			case(OPTION.SECTION):
				index += keyboard_check_pressed(ord("S")) - keyboard_check_pressed(ord("W"));
				index = index > optionLength - 1 ? 0 : (index < 0 ? optionLength - 1 : index);
			break;
			
			case(OPTION.SLIDER):
				//adicionando o movimento do slider e clampiando o valor
				optionData[index][2] = clamp(optionData[index][2] + move, 0, 10);
				
				var _value = optionData[index][2];
				variable_global_set(_global_var, _value);
			break;
			
			case(OPTION.BOOL):
				if(move != 0){
					var _globalName = optionData[index][3];
					variable_global_set(_globalName, !variable_global_get(_globalName));
				}
			break;
			
			case(OPTION.LANGUAGE):
				var _globalName = optionData[index][3];
				var _list_length = array_length(languages);
				
				languageIndex = clamp(languageIndex + move, 0, _list_length - 1);
				global.language = languages[languageIndex];
			break;
			
			case(OPTION.BTN):
				var _callback = optionData[index][2];
				
				if(keyConfirm){
					if(!audio_is_playing(snSelect))
						audio_play_sound(snSelect, 1, 0);
					_callback();
				}
			break;
			
			case(OPTION.CONTROL):
				if(keyConfirm){
					io_clear();
					canControl = false;	
					getKey = true;
				}
			break;
		}
	}
	
	//fechando o menu de opções
	if(transformOut <= 0){
		if(room == rmMenu){
			oMenuControl.canControl = true;
		}else if(global.paused){
			oPause.canControl = true;
		}

		instance_destroy(self);
	}
}

//pegando a tecla apertada
if(getKey){
	if(keyboard_check_pressed(vk_anykey)){	
		keysData = [
			global.playerRight,
			global.playerLeft,
			global.playerUp,
			global.playerDown,
			global.playerDash,
			global.playerAttack,
			global.playerItem,
			global.playerInteract,
			global.playerFly,
			global.playerJump,
			global.playerPower
		];
		
		var _length = array_length(keysData);
		var _keycode = keyboard_lastkey;
		var _keyName = keyboardKeyName(keyboard_lastkey);
		var _change = true;
		
		for(var i = 0; i < _length; i++){
			if(_keycode == keysData[i]){
				_change = false;
			}
		}
		
		if(_keyName != "" && _change){
			changed = true;
			var _globalName = optionData[index][3];
			variable_global_set(_globalName, _keycode);
			canControl = true;
		}else{
			var _popup = create_popup(MENU_IN_USE_KEY[0]+"[c_green1]"+_keyName+"[/c]"+MENU_IN_USE_KEY[1] , MENU_POPUP[2], "", function(){self.canControl = true}, 0);
			_popup.depth = depth - 1;
		}
		
		getKey = false;
	}
}