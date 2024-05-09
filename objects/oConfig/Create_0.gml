
title = MENU_OPTIONS[21];
t = 0;
transform = 0;  
transformOut = 0;  
state = 0;
closing = false;

canControl = true;
changed = false;
index = 1;// o index começa no 1 porque a primeira opção da array de opções é uma section
pastIndex = 1;
keyConfirm = 0;
move = 0;
moveIndex = 0;
scrolly = 0;
optionData = [];

getKey = false;
keysData = [];
keyLength = 11;//números de keys pro jogador

//linguagem
languageIndex = 0;
languages = [
	PTBR,
	EN
]
			//pegando a o index da linguagem selecionada	
for(var i = 0; i < array_length(languages); i++){
	if(global.language == languages[i]){
		languageIndex = i;
	}	
}

enum OPTION{
	SECTION,
	SLIDER, 
	BOOL,
	CONTROL,
	LANGUAGE,
	BTN
}

applyChanges = function(){
	changeLang(global.language);
	
	ini_open(global.iniName);
		ini_write_string(global.section.language, global.key.language, global.language);
	
		ini_write_real(global.section.settings, global.key.master, global.masterVolume);
		ini_write_real(global.section.settings, global.key.fullscreen, global.fullscreen);
		ini_write_real(global.section.settings, global.key.sfx, global.sfxVolume);
		ini_write_real(global.section.settings, global.key.bgm, global.bgmVolume);
		
		ini_write_real(global.section.controls, global.key.playerRight, global.playerRight);
		ini_write_real(global.section.controls, global.key.playerLeft, global.playerLeft);
		ini_write_real(global.section.controls, global.key.playerUp, global.playerUp);
		ini_write_real(global.section.controls, global.key.playerDown, global.playerDown);
		ini_write_real(global.section.controls, global.key.playerJump, global.playerJump);
		ini_write_real(global.section.controls, global.key.playerDash, global.playerDash);
		ini_write_real(global.section.controls, global.key.playerFly, global.playerFly);
		ini_write_real(global.section.controls, global.key.playerAttack, global.playerAttack);
		ini_write_real(global.section.controls, global.key.playerPower, global.playerPower);
		ini_write_real(global.section.controls, global.key.playerItem, global.playerItem);
		ini_write_real(global.section.controls, global.key.playerInteract, global.playerInteract);
	ini_close();
	
	self.closing = true;
}

cancelChanges = function(){
	ini_open(global.iniName);
		global.language = ini_read_string(global.section.language, global.key.language, 0);
	
		global.masterVolume = ini_read_real(global.section.settings, global.key.master, 0);
		global.bgmVolume = ini_read_real(global.section.settings, global.key.bgm, 0);
		global.sfxVolume = ini_read_real(global.section.settings, global.key.sfx, 0);
		
		global.playerRight = ini_read_real(global.section.controls, global.key.playerRight, 0);
		global.playerLeft = ini_read_real(global.section.controls, global.key.playerLeft, 0)
		global.playerUp = ini_read_real(global.section.controls, global.key.playerUp, 0);
		global.playerDown = ini_read_real(global.section.controls, global.key.playerDown, 0);
		global.playerJump = ini_read_real(global.section.controls, global.key.playerJump, 0);
		global.playerDash = ini_read_real(global.section.controls, global.key.playerDash, 0);
		global.playerFly = ini_read_real(global.section.controls, global.key.playerFly, 0);
		global.playerAttack = ini_read_real(global.section.controls, global.key.playerAttack, 0);
		global.playerPower = ini_read_real(global.section.controls, global.key.playerPower, 0);
		global.playerItem = ini_read_real(global.section.controls, global.key.playerItem, 0);
		global.playerInteract = ini_read_real(global.section.controls, global.key.playerInteract, 0);
	ini_close();
	
	self.closing = true;
}

restoreDefault = function(){
	canControl = false;
	
	var _restore = function(){
		ini_open(global.iniName);
			//ini_write_string(global.section.language, global.key.language, global.value.language);
		
			ini_write_real(global.section.settings, global.key.master, global.value.masterVolume);
			ini_write_real(global.section.settings, global.key.sfx, global.value.sfxVolume);
			ini_write_real(global.section.settings, global.key.bgm, global.value.bgmVolume);
			
			ini_write_real(global.section.controls, global.key.playerRight, global.value.playerRight);
			ini_write_real(global.section.controls, global.key.playerLeft, global.value.playerLeft);
			ini_write_real(global.section.controls, global.key.playerUp, global.value.playerUp);
			ini_write_real(global.section.controls, global.key.playerDown, global.value.playerDown);
			ini_write_real(global.section.controls, global.key.playerJump, global.value.playerJump);
			ini_write_real(global.section.controls, global.key.playerDash, global.value.playerDash);
			ini_write_real(global.section.controls, global.key.playerFly, global.value.playerFly);
			ini_write_real(global.section.controls, global.key.playerAttack, global.value.playerAttack);
			ini_write_real(global.section.controls, global.key.playerPower, global.value.playerPower);
			ini_write_real(global.section.controls, global.key.playerItem, global.value.playerItem);
			ini_write_real(global.section.controls, global.key.playerInteract, global.value.playerInteract);
		ini_close();
	
		cancelChanges();
	}
	
	var _cancel = function(){
		self.canControl = true;
		return;
	}
	
	create_popup(MENU_RESTORE, MENU_POPUP[1], MENU_POPUP[0], _cancel, _restore);
	depth += 1;
}

goBack = function(){
	canControl = false;
	
	if(changed){
		create_popup(MENU_APLLY, MENU_POPUP[1], MENU_POPUP[0], cancelChanges, applyChanges);
		depth++;
		changed = false;
	}else{
		closing = true;
	}
}

optionData = [
	[MENU_OPTIONS[0],	OPTION.SECTION, 0, 0, 0],
	[MENU_OPTIONS[1],	OPTION.BOOL,		global.fullscreen,	"fullscreen"],
	[MENU_OPTIONS[2],	OPTION.LANGUAGE,	global.language,	"language"],

	[MENU_OPTIONS[3],	OPTION.SECTION, 0, 0, 0],
	[MENU_OPTIONS[4],	OPTION.SLIDER, global.masterVolume,		"masterVolume"],
	[MENU_OPTIONS[5],	OPTION.SLIDER, global.bgmVolume,		"bgmVolume"],
	[MENU_OPTIONS[6],	OPTION.SLIDER, global.sfxVolume,		"sfxVolume"],
	
	[MENU_OPTIONS[7],	OPTION.SECTION, 0, 0, 0],
	[MENU_OPTIONS[8],	OPTION.CONTROL, global.playerRight,		"playerRight"],
	[MENU_OPTIONS[9],	OPTION.CONTROL, global.playerLeft,		"playerLeft"],
	[MENU_OPTIONS[10],	OPTION.CONTROL, global.playerUp,		"playerUp"],
	[MENU_OPTIONS[11],	OPTION.CONTROL, global.playerDown,		"playerDown"],
	[MENU_OPTIONS[12],	OPTION.CONTROL, global.playerJump,		"playerJump"],
	[MENU_OPTIONS[13],	OPTION.CONTROL, global.playerDash,		"playerDash"],
	[MENU_OPTIONS[14],	OPTION.CONTROL, global.playerFly,		"playerFly"],
	[MENU_OPTIONS[15],	OPTION.CONTROL, global.playerAttack,	"playerAttack"],
	[MENU_OPTIONS[16],	OPTION.CONTROL, global.playerPower,		"playerPower"],
	[MENU_OPTIONS[17],	OPTION.CONTROL, global.playerItem,		"playerItem"],
	[MENU_OPTIONS[18],	OPTION.CONTROL, global.playerInteract,	"playerInteract"],
	
	[MENU_OPTIONS[19], OPTION.BTN, restoreDefault, 0],
	[MENU_OPTIONS[20], OPTION.BTN, goBack, 0]
]

//remoendo a opção de mudar a língua do jogo quanod não estiver no menu
if(room != rmMenu){
	array_delete(optionData, 2, 1);
}

optionLength = array_length(optionData);