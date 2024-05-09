canSave = false
saved = false;

alarm[0] = 0;
alphaTimer = 0;
alphaStep = 0;
alpha = 0;

state = 0;

light = instance_create_layer(x, y - sprite_height/2, layer, oLightEntities);
light.color = c_white;
light.intensity = .05;
light.oscilation = 30;
light.scalex = 2;
light.scaley = 2;

//particulas
emitter = part_emitter_create(global.particleSystem);

//desenhando o ícone de interação
keyInconAlpha = 0;
drawKey = false;

//configurando o a choice box de save
label = MENU_SAVE_MSG;

callSave = function(){
	with(oSave){
		save();
		saved = true;
		state = 2;
		alphaStep = 0;
		alphaTimer = 0;
		
		if(!audio_is_playing(snSave))
			audio_play_sound(snSave, 1, 0);
		
		if(instance_exists(oPlayer)){
			oPlayer.hp = oPlayer.maxHp;
		}
	}
	return(-1);
}

closeWindow = function(){
	state = 0;
	return(-1);
}

options = [
	[MENU_POPUP[0], callSave],
	[MENU_POPUP[1], closeWindow]
];