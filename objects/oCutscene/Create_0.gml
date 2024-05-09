
cutscene1 = function(){
	
	static _state = 0;
	var _efil = oEfilCutscene01;
	
	if(instance_exists(_efil)){
		switch(_state){
			//efil andando
			case(0):
				with(_efil){
					if(x > room_width/2 + 8){
						hspd = -spd;
						if(!audio_is_playing(snEfilSteps)){
							if(stepCd-- < 0){
								stepCd = 5;
								audio_play_sound(snEfilSteps, 1, 0);
							}
						}
					}else{
						hspd = 0;
						restartSprite();
						sprite_index = sEfilSitting;
						_state++;
					}
				}
			break;
				
			//efil deitando
			case(1):
				with(_efil){
					if(animationEnd() && sprite_index == sEfilSitting){
						restartSprite();
						sprite_index = sEfilSleeping;
					}
			
					if(animationEnd() && sprite_index == sEfilSleeping){
						var _player = oPlayerCutscene01;
						if(instance_exists(_player)){
							_player.drawLight = true;
							_player.timer = 180;
						}
						image_speed = 0;
						_state++;
					}
				}
			break;
				
			case(2):
				if(oPlayerCutscene01.transform2 <= 0){
					_state = 0;
					global.flagCutcene1 = true;
					instance_destroy(self);
				}
			break;
		}
	}
}


cutscenes = [
	cutscene1 
]

currentCutscene = cutscenes[@ cutsceneId];   