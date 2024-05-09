
//fora do boss

var _player = instance_exists(oPlayer) && oPlayer.hp <= 0 && room != rmMenu && room != rmSave;
if(_player)
	exit;

if(room != rmBoss){	
	audio_stop_sound(snLoop);
	audio_stop_sound(snIntro);
	
	//menu
	if(room == rmMenu && !audio_is_playing(snMenuMusic)){
		audio_stop_sound(snCaveBg);
		global.music = audio_play_sound(snMenuMusic, 1, 1);
	}

	//gameplay
	if(room != rmCave00 && room != rmLoad){
		if(room != rmMenu && room != rmSave && !audio_is_playing(snCaveBg)){
			audio_stop_sound(snMenuMusic);
			global.music = audio_play_sound(snCaveBg, 1, 1);
		}
	}else{
		audio_stop_sound(snMenuMusic);
		if(instance_exists(oPlayer) && !audio_is_playing(snCaveBg)){
			audio_play_sound(snCaveBg, 1, 0);
		}
	}
}

//no boss
if(room == rmBoss){
	if(global.urielAlive){
		if(bossState == 0){
			audio_stop_sound(snCaveBg);
			if(!audio_is_playing(snIntro)){
				audio_play_sound(snIntro, 1, 0);
			}
			bossState = 1;
		}
	
		if(bossState == 1){
			if(!audio_is_playing(snIntro) && !audio_is_playing(snLoop)){
				audio_play_sound(snLoop, 1, 0);
			}
		}
	}else{
		audio_stop_sound(snLoop);
		audio_stop_sound(snIntro);
		audio_stop_sound(snCaveBg);
	}
}


