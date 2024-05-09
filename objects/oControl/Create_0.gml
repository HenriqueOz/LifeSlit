//show_debug_overlay(1);

//setup do save
global.saveName1 = "save1.life";
global.saveName2 = "save2.life";
global.saveName3 = "save3.life";

global.saveExists1 = file_exists(global.saveName1) ? true : false;
global.saveExists2 = file_exists(global.saveName2) ? true : false;
global.saveExists3 = file_exists(global.saveName3) ? true : false;

global.saveNameArray = [
	global.saveName1,
	global.saveName2,
	global.saveName3
]

global.saveExistsArray = [
	global.saveExists1,
	global.saveExists2,
	global.saveExists3
]

global.saveId = 0;

global.playerRespwaning = false;
global.playerData = {};

global.allyDisapear = false;

//setup particulas
global.particleSystem = part_system_create();
global.particleHit1 = part_type_create();
global.particleSparkles = part_type_create();
global.particleDrop = part_type_create();
global.particleEnemyDeath = part_type_create();

//setup cameras
global.camX = 0;
global.camY = 0;

//setup mouse
global.mouseMoving = false;
global.mousePos = [0, 0];
global.mouseDir = 0;
mousexPast = mouse_x;
mouseyPast = mouse_y;
timeShow = 0;

//cutscene mode
global.cutsceneMode = false;
yinc = 0;

//tela cheia
global.fullscreen = false;

//pause
global.canPause = true;
global.paused = false;

//titulos das areas
global.showTitle = false;

//linguagens
global.language = os_get_language();

//ini config
global.masterVolume = 10;
global.bgmVolume = 10;
global.sfxVolume = 10;

global.playerRight = ord("D");
global.playerLeft = ord("A");
global.playerUp = ord("W");
global.playerDown = ord("S");
global.playerJump = vk_space;
global.playerDash = vk_shift;
global.playerFly = vk_control;
global.playerAttack = ord("J");
global.playerPower = ord("K");
global.playerItem = ord("E");
global.playerInteract = ord("F");

global.section = {
	controls : "Controls", 
	settings : "Settings",
	language : "Language"
};

global.key = {
	language : "LANGUAGE",
	
	playerRight : "RIGHT",
	playerLeft : "LEFT",
	playerUp : "UP",
	playerDown : "DOWN",
	playerJump : "JUMP",
	playerDash : "DASH",
	playerFly : "FLY",
	playerAttack : "ATTACK",
	playerPower : "POWER",
	playerItem : "ITEM",
	playerInteract : "INTERACT",
	
	fullscreen : "FULLSCREEN",
	master : "MASTER",
	sfx : "SFX",
	bgm : "BGM"
};

global.value = {
	language : global.language,
	
	playerRight : global.playerRight,
	playerLeft : global.playerLeft,
	playerUp : global.playerUp,
	playerDown : global.playerDown,
	playerJump : global.playerJump,
	playerDash : global.playerDash,
	playerFly : global.playerFly,
	playerAttack : global.playerAttack,
	playerPower : global.playerPower,
	playerItem : global.playerItem,
	playerInteract : global.playerInteract,
	
	fullscreen : global.fullscreen,
	masterVolume : global.masterVolume,
	sfxVolume : global.sfxVolume,
	bgmVolume : global.bgmVolume
}

global.iniName = "config.ini";

//carregando o ini
if(!file_exists(global.iniName)){
	ini_open(global.iniName);
		ini_write_string(global.section.language, global.key.language, global.value.language);
	
		ini_write_real(global.section.settings, global.key.fullscreen, global.value.fullscreen);
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
}else{
	ini_open(global.iniName);
		global.language = ini_read_string(global.section.language, global.key.language, EN);
	
		global.fullscreen = ini_read_real(global.section.settings, global.key.fullscreen, 0);
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
}

//carregando aúdio groups
audioGroupLoaded = false;
audio_group_load(GroupMusic);
audio_group_load(GroupSFX); 

window_set_fullscreen(global.fullscreen);

//escalonando o tamamnho da tela
if(!global.fullscreen){
	//surface_resize(application_surface, CAM_WIDTH * SCALE, CAM_HEIGHT * SCALE);
	window_set_size(CAM_WIDTH * SCALE, CAM_HEIGHT * SCALE);
	window_center();
}else{
	//surface_resize(application_surface, CAM_WIDTH, CAM_HEIGHT);
}
