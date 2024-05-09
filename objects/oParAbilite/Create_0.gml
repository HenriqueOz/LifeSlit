
light = instance_create_layer(x, y - sprite_height/2, layer, oLightEntities);
light.scalex = 1;
light.scaley = 1;
light.oscilation = 20;
light.alpha = 1;
light.image_angle = 0;
light.colorOverlay = false;
light.intensity = .1;//ente 0 e 1
light.color = c_white;

createParticle = 5;
globalName = "playerAbiliteDash";
title = "";
msg = "";

image = 1;
msgInst = noone;

onPickup = function(){
	var _onClose = function(){
		oPlayer.canControl = true;
		global.showHud = true;
		global.cutsceneMode = false;
	}
	
	if(object_index == oLifeUp1 || object_index == oLifeUp2 || object_index == oLifeUp3 || object_index == oLifeUp4){
		oPlayer.maxHp++;
		oPlayer.hp = oPlayer.maxHp;
		variable_global_set("maxHp", global.maxHp + 1);
	}
	
	var _em = part_emitter_create(global.particleSystem);
	var _ps = global.particleSystem;
	
	part_emitter_region(_ps, _em, x - 20, x + 20, y - 32, y, ps_shape_diamond, ps_distr_linear);
	part_emitter_burst(_ps, _em, particleBreak, 18);
	
	//salvando a habilidade pega
	var _json = loadString(global.saveNameArray[global.saveId]);
	var _saveStruct = json_parse(_json);
	
	_saveStruct.a.a1 = global.playerAbiliteDash;
	_saveStruct.a.a2 = global.playerAbiliteFly;
	_saveStruct.a.a3 = global.playerAbiliteClimb;
	_saveStruct.a.a4 = global.playerAbilitePower;
	
	_saveStruct.h.h1 = global.playerHp1;
	_saveStruct.h.h2 = global.playerHp2;
	_saveStruct.h.h3 = global.playerHp3;
	_saveStruct.h.h4 = global.playerHp4;
	
	_saveStruct.player.maxHp = global.maxHp;
	
	_json = json_stringify(_saveStruct);
	saveString(_json, global.saveNameArray[global.saveId]);
	//
	
	
	msgInst = createFullMessage(title, msg, _onClose);
	instance_destroy(self);
}


//partículas
particleBreak = part_type_create();

part_type_sprite(particleBreak, sHitParticle, false, false, false);
part_type_alpha3(particleBreak, 1, .5, 0);
part_type_blend(particleBreak, true);
part_type_color1(particleBreak, c_white);
part_type_direction(particleBreak, 0, 360, 0, 0);
part_type_gravity(particleBreak, 0, 0);
part_type_life(particleBreak, 40, 80);
part_type_orientation(particleBreak, 0, 0, 0, 0, true);
part_type_size(particleBreak, .3, .6, 0, 0);
part_type_speed(particleBreak, 4, 6, -.1, 0);
