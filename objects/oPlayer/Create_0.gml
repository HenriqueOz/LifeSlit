//crindo a camera quando o player spawna
if(!instance_exists(oCam)){
	instance_create_layer(x - CAM_WIDTH/2, y - CAM_HEIGHT/2, layer, oCam);
}else{
	oCam.x = x - CAM_WIDTH/2;
	oCam.y = y - CAM_HEIGHT/2;
}

//criando a luz
light = instance_create_layer(x, y - sprite_height/2, layer, oLightEntities);
light.scalex = 1.5;
light.scaley = 1.5;
light.oscilation = 0;
light.alpha = 1;
light.intensity = 0;//ente 0 e 1
light.color = c_white//make_color_hsv(125,  105, 255);

hp = global.maxHp;//hp inicial
oldHp = global.maxHp;
maxHp = global.maxHp;//hp máximo

mana = 4;
maxMana = 4;

lifeShard = 0;
lifeShardMax = 3;
lifeShardHealing = 1;
healingCounter = 0;
healingTime = 20;

invencible = false;
invencibleTime = [0, 60];
isDeath = false;
deathEnd = false;
canHurt = true;
mask = sPlayerMask;

attackDelay = 15;
comboTimer = 0;
attackDmg = 1;
attackDirx = 0;
dmgArray = [1, 1, 2, 1];
attackId = 0;
spearDir = 1;
spearState = 0;
spearId = undefined;
spearTime = 0;
spearyScale = 0;
spearMana = 1;

spd = 3;//velocidade
hspd = 0;//velociade horizontal atuala
vspd = 0;//velociade vertical atual
jumpCut = true;//verifica se é permitido realizar um corta pulo
move = 0;//checando se o player está se movendo ou não 0 = parado, != 0 se movendo
dirx = 1;

jumpSpeed = 8;//velocidade do pulo
grounded = false;
safeCoord = [0, 0];
landed = false;
jumped = false;
grvAcceleration = 1.1;
canJump = 0;//número de frames que o player pode pular após sair da plataforma
crouched = false;

canControl = true;//se o player pode controlar o boneco

canGrab = true;
grabUnits = 0;//mecanica de escalada do jogo
grabLimit = 0;
grabSpeed = 3;

canDash = true;//mecânica de dash
dashLinear = 0;//aumento linear da velocidade do dash
dashTime = 1.5;//o tamanho máximo do dash linear
dashSpd = 16;
dashDir = 0;
dashCoolDown = 15;
dashDelay = 1;
floatTimer = 0;
dashEndState = 0;

xscale = 1;
yscale = 1;
xdraw = x;
ydraw = y;
blinkTime = 0; 
blinkGreen = 0;

global.showHud = true;
spawnTimer = 0;
hitCrystal = false;
npcId = noone;

freezeTime = 0;
freezeFrame = 0;

#region//controles

keyRight = 0;
keyLeft = 0;
keyUp = 0;
keyJump = 0;
keyJumpRelease = 0;
keyDash = 0;
keyCrouch = 0;
keyCrouchRelease = 0;
keyAttack = 0;
keyPower = 0;
keyPlane = 0;
keyItem = 0;

getInput = function(_canControl){
	if(_canControl){
		keyRight = keyboard_check(global.playerRight);
		keyLeft = keyboard_check(global.playerLeft);
		keyUp = keyboard_check(global.playerUp);
		keyJump = keyboard_check_pressed(global.playerJump);
		keyJumpRelease = keyboard_check_released(global.playerJump);
		keyDash = keyboard_check_pressed(global.playerDash); 
		keyCrouch = keyboard_check(global.playerDown); 
		keyCrouchRelease = keyboard_check_released(global.playerDown); 
		keyAttack = keyboard_check_pressed(global.playerAttack); 
		keyPower = keyboard_check_pressed(global.playerPower); 
		keyPlane = keyboard_check(global.playerFly); 
		keyItem = keyboard_check_pressed(global.playerItem); 
	}
	
	move = keyRight - keyLeft;
	hspd = lerp(hspd, move * spd, 1);
	
	keyInteract = keyboard_check_pressed(global.playerInteract); 
}

#endregion

#region//state machine

state = noone;
stateName = "";

stateFree = function(){
	stateName = "free";
	
	image_alpha = 1;
	
	//se eu estiver dentro de um bloco de room warp eu perco os controles do player
	if(instance_place(x, y, oRoomWarp)){
		canControl = false;
		canHurt = false;
		invencible = false;
		invencibleTime[0] = 1000;
		return;
	}
	
	//voltando a camera ao normal
	camZoom(1, self, .08);
	
	//checando se o player tomou dano
	if(hp < oldHp){
		state = stateHurt;
		return;
	}
	
	//trocar para o estado de dash	
	if(keyDash && canDash && global.playerAbiliteDash){
		dashDir = getDashDir();
		if(dashDir != -1){
			state = stateDash;
			return;
		}
	}
	
	//ataque
	if(keyAttack){
		attackDirx = dirx;
		if(grounded && vspd == 0){
			restartSprite();
			instance_destroy(oAttackHitbox);
			attackId = 0;
			state = stateAttack;
			return;
		}else{
			restartSprite();
			instance_destroy(oAttackHitbox);
			attackId = 3;
			state = stateAttack;
			return;
		}
	}
	
	//estado de planar
	if(keyPlane && !grounded && vspd > 0 && global.playerAbiliteFly){
		state = statePowerFly;	
		return;
	}
	
	//estado de poder
	if(keyPower && mana > 0 && powerCoolDown <= 0 && global.playerAbilitePower){
		state = statePowerfast;
		mana--;
	}else if(keyPower && mana <= 0){
		audio_play_sound(snCant, 0, 0);
	}
	
	//healing
	if(keyItem && hp < maxHp && lifeShard > 0 && grounded){
		hp += lifeShardHealing;
		oldHp = hp;
		lifeShard--;
		healingCounter = healingTime;
		state = stateHealing;
		return;
	}else if(keyItem){
		audio_play_sound(snCant, 0, 0);
	}
	
	//se eu pular de um lado pro outro e não tiver enconstando em nada, reseta o grab
	if(vspd != 0 && hspd != 0){
		if(!place_meeting(x + hspd, y, oCollidersFather)){
			grabUnits = 0;
			grabLimit = 0;
		}
	}
	
	//mecânica de escalada
	grab = instance_place(x + sign(hspd), y, oGrabWall) && canGrab// && !instance_place(x, y, oJumpThrough);
	if(grab && global.playerAbiliteClimb){
		if(grabUnits == 0){
			for(var i = 0; i < 128/grabSpeed; i++){
				grabLimit = i;
				if(!place_meeting(x + hspd, y - i, oGrabWall))	break;
			}
			//jogando o player um pixel pra cima pq as variaveis de escalada resetam quando ele toca o chão
			y -= 1;
			state = stateGrab;
			return;
		}
	}
	
	//checando se existe uma caixa de escolha
	if(instance_exists(oChoiceBox)){
		state = stateDialog;
		return;
	}
	
	//trocando pro estado de interação e gerenciando
	if(distance_to_object(oParEntities) < 36 && grounded){
		var _inst = instance_nearest(x, y, oParEntities);
		if(keyInteract){
			npcId = _inst.id;
			_inst.inInteraction = true;
			if(_inst.dialog[0].text != ""){
				createDialog(_inst.dialog);
			}
			if(instance_exists(oDialog)){//checando se um dialogo foi criado
				instance_create_layer(x, y, layer, oCamTarget);
				state = stateDialog;
				return;
			}
		}
	}
}

stateGrab = function(){
	stateName = "grab";
	
	image_alpha = 1;
	
	if(keyDash){
		dashDir = getDashDir();
		if(dashDir != -1){
			state = stateDash;
			return;
		}
	}
	
	//checando se o player tomou dano
	if(hp < oldHp){
		state = stateHurt;
		return;
	}
	
	var _wall = instance_place(x + sign(hspd), y, oGrabWall);
	if(_wall)
		grabLimit = _wall.sprite_height;
	
	//checando se eu posso continuar escalando
	if(hspd != 0 && grabUnits < grabLimit && grab && !keyJump){
		vspd = -grabSpeed;
		grabUnits++;
	}else{
		while(instance_place(x, y, oParWall))	y++; 
		hspd = 0;
		state = stateFree;
		animation = idle;
	}

	canJump = 10;
	//checando se ainda a um bloco na minha frente e nenhum sob o player
	grab = instance_place(x + sign(hspd), y, oGrabWall) && !place_meeting(x, y - grabSpeed, oParWall)

}

stateDialog = function(){
	stateName = "dialog";
	image_alpha = 1;
	hspd = 0;
	canHurt = false;
	canControl = false;
	global.canPause = false;
	global.showHud = false;
	global.cutsceneMode = !instance_exists(oChoiceBox);
	
	var _inst = npcId;
	
	if(instance_exists(_inst)){
		var _dir = sign(_inst.x - x); 
		dirx =  _dir != 0 ? _dir : 1; //player olhar para a direção do npc
		_inst.image_xscale = -dirx; // npc olhar para direção do player
		
		var _wallToward = place_meeting(x + 16 * -dirx, y, oParWall);
		var _groundToward = place_meeting(x + -dirx * 16, y + 1, oParWall);

		if(distance_to_object(_inst) < 30 && !_wallToward){
			if(_groundToward){
				hspd = spd * -dirx;	//me movendo na direção contrária do npc
			}
		}
	}
	
	//setando a camera para se mover na direção de quem está falando
	var _s = 0;
	if(instance_exists(oDialog)){
		_s = oDialog.speaking;
	}
	
	if(instance_exists(oCamTarget) && instance_exists(_inst) && _inst.hspd == 0){
		if(_s == 1){
			oCamTarget.x = oPlayer.x - oPlayer.x * .01;
		}else{
			oCamTarget.x = _inst.x - _inst.x * .01;
		}
		camZoom(1.5, oCamTarget, .1);
	}
	
	//voltando pro stateFree caso não haja mais objeto de dialogo
	if(!instance_exists(oDialog) && !instance_exists(oChoiceBox) && !instance_exists(oFullMessage)){
		canHurt = true;
		canControl = true;
		npcId = noone;
		instance_destroy(oCamTarget);
		global.canPause = true;
		global.cutsceneMode = false;
		global.showHud = true;
		state = stateFree;
	} 
}

playAttackSound = true;

stateAttack = function(){
	stateName = "attack";
	animation = attack;
	image_alpha = 1;
	
	var _box = oAttackHitbox;
	
	//setando velocidades para ataque terreste
	if(attackId < 2){
		if(grounded){
			hspd = 0;
			move = 0;
		}else if(attackId == 0){
			restartSprite();
			state = stateFree;
			animation = idle;
			playAttackSound = true;
			return;
		}
	}
	
	if(attackId < 2 && !grounded){
		restartSprite();
		animation = idle;
		state = stateFree;
		return;
	}
	
	canJump = -1;
	
	//criando hitbox
	if(!instance_exists(_box)){
		instance_create_layer(x, y, "player", _box);
		_box.depth = depth - 1;
		comboTimer = 15;
	}
	
	//avançando o combo
	if(comboTimer-- < 0 && keyAttack && attackId < 2 && grounded){		
		_box.image_index = 0;
		restartSprite();
		attackId++;
		playAttackSound = true;
		comboTimer = 15;
	}
	
	//setando hitbox
	_box.image_xscale = dirx;
	
	switch(attackId){
		case(0):
			if(grounded){
				if(playAttackSound){
					audio_play_sound(snAttack1, 1, 0);
					playAttackSound = false;
				}
				
				sprite = sPlayerAttack1;
				attackDmg = 1;
				_box.sprite = sSlash1;
				_box.sprite_index = sHitbox1;
			}else{
				with(_box){
					if(animationEnd()){
						other.attackId = 3;	
					}
				}
				
			}
		break;
		
		case(1):
			if(playAttackSound){
				audio_play_sound(snAttack2, 1, 0);
				playAttackSound = false;
			}
		
			sprite = sPlayerAttack2;
			attackDmg = 1;
			_box.sprite = sSlash2;
			_box.sprite_index = sHitbox2;
		break;
		
		case(2):
			if(playAttackSound){
				audio_play_sound(snAttack3, 1, 0);
				playAttackSound = false;
			}
		
			sprite = sPlayerAttack3;
			attackDmg = 2;
			_box.sprite = sSlash3;
			_box.sprite_index = sHitbox3;
			
			var _dust = instance_create_layer(x + 25 * dirx, y, "player", oDust);
			_dust.sprite_index = sDust3;
			_dust.image_xscale = dirx;
			_dust.depth = depth - 2;
			
			attackId = 4;
		break;
		
		case(3):
			if(playAttackSound){
				audio_play_sound(snAttack4, 1, 0);
				playAttackSound = false;
			}
			
			attackDmg = 1;
			sprite = sPlayerAttack4;
			_box.image_index = 0;
			_box.sprite = sSlash4;
			_box.sprite_index = sHitbox4;
			_box.x = x;
			_box.y = y;
			attackId = 4;
		break;
		
		case(4):
			
		break;	
	}
	
	//sprite_set_offset(_box.sprite_index, sprite_get_xoffset(sPlayerAttack1), sprite_get_yoffset(sPlayerAttack1));
	//sprite_set_offset(_box.sprite, sprite_get_xoffset(sPlayerAttack1), sprite_get_yoffset(sPlayerAttack1));
	var _hspd = 0;
	
	//movimento durante ataque
	if(image_index > 2 && image_index < image_number - 3 && grounded){
		if(sprite == sPlayerAttack2)	_hspd = .5;
		if(sprite == sPlayerAttack3)	_hspd = 1.5;
	}
	
	if(grounded){
		hspd = _hspd * dirx;
	}
	
	//trocando state	
	if(animationEnd()){
		restartSprite();
		//attackDelay = 10;
		state = stateFree;
		playAttackSound = true;
		if(vspd != 0){
			floatTimer = 10;
			grvAcceleration = .5;
		}else{
			floatTimer = 0;
		}
		animation = idle;
		return;
	}
	
	//trocar para o estado de dash	
	if(keyDash && _box.image_index > _box.image_number - 4){
		dashDir = getDashDir();
		playAttackSound = true;
		if(dashDir != -1){
			restartSprite();
			attackDelay = 2;
			animation = idle;
			state = stateDash;
		}
		return;
	}
	
	if(hp < oldHp){
		restartSprite();
		playAttackSound = true;
		attackDelay = 2;
		state = stateHurt;
		return;
	}
}

playerHurtSound = true;

stateHurt = function(){
	stateName = "hurt"
	instance_destroy(oAttackHitbox);
	image_alpha = 1;
	depth = layer_get_depth("player");
	layer_add_instance("player", self);
	if(instance_exists(spearId)){
		with(spearId){
			spd = 0;
			state = SPEARSTATE.CANCEL;
		}
		spearState = 0;
	}
	
	if(playerHurtSound){
		audio_play_sound(snHurt, 1, 0);;
		playerHurtSound = false;
	}
	
	//entrando no modo dano
	if(!invencible){
		camShake(5, 3);
		invencibleTime[0] = invencibleTime[1];
		invencible = true;
		canHurt = false;
	}
	
	//travando o player quando tomar dano
	if(invencibleTime[0] > invencibleTime[1] - 10){
		animation = hurt;
		hspd = 0;
		vspd = 0;
		move = false;
		canJump = -1;
		canControl = false;
	}else{
		playerHurtSound = true;
		state = stateFree;
		canControl = true;
	}
	
	//checando se o player morreu
	if(hp <= 0){
		canWarp = false;
		image_alpha = 1;
		restartSprite();
		isDeath = true;
		invencible = false;
		animation = idle;
		state = stateDeath;
		
		audio_play_sound(snDeath, 1, 0);
	}
	//igualando o hp antigo ao atual
	oldHp = hp;
}

stateDeath = function(){
	stateName = "death";
	image_alpha = 1;
	global.showHud = false;
	global.canPause = false;
	animation = death;
	blinkTime = 0;
	invencibleTime[0] = 0;
	canWarp = false;
	sprite = sPlayerDeath;
	canControl = false;
	grvAcceleration = 0;
	hspd = 0;
	vspd = 0;
	
	audio_stop_sound(snCaveBg);
	audio_stop_sound(snLoop);
	audio_stop_sound(snIntro);
	
	if(animationEnd() && !deathEnd){
		image_speed = 0;
		fadeToRoom(rmDeath, 120, c_black);
		deathEnd = true;
	}
	
	camZoom(1.5, oPlayer, .3);
	with(oCam){
		amount = 1;
	}
	
	animation = function(){ return }; 
}

dashSound = true;

stateDash = function(){
	stateName = "dash";
	
	//setando o dash
	mask = sPlayerMask;
	hspd = 0;
	vspd = 0;
	grvAcceleration = 0;
	
	//checando se posso dar dar o dash
	if(canDash && !crouched && dashCoolDown < 0){
		if(dashSound){
			audio_play_sound(snDash, 1, 0);	
			dashSound = false;
		}
		
		//criar o efeito de fantasma		
		var _createGhost = function(){
			with(instance_create_layer(x, y - sprite_height/2, "player", oGhost)){
				rot = other.dashDir;
				sprite = sPlayerDash;
				yscale = other.dirx;
				if(other.dashDir == 90)	{
					sprite = sPlayerLandSoft;
					rot = 0;
					xscale = other.dirx;
					yscale = 1;
				}
				if(other.dashDir == 270){
					sprite = sPlayerFall;
					rot = 0;
					xscale = other.dirx;
					yscale = 1;
				}
				color = make_color_hsv(80  + (80/other.dashTime) * other.dashLinear, 80, 245);
				alpha = 1;
				alphaInc = -.06;
			}
		}
		
		//iniciando o dash
		if(dashDelay-- < 0){
			if(dashLinear == 0){
				dashEndState = stateFree;
			}
			
			//checando se posso inicar o movimento
			if(dashLinear < dashTime){
				image_alpha = 0;
				
				//movimento do dash
				hspd = lengthdir_x(dashSpd * dashLinear, dashDir);
				vspd = lengthdir_y(dashSpd * dashLinear, dashDir);	
				
				//rastro
				var _spark = instance_create_layer(x + random_range(-20, 20), y + random_range(-20, 20) - sprite_height/2, layer, oGhost);
				with(_spark){
					depth = other.depth - 1;
					sprite = sDashTrail;
					xscale = random_range(.4, .6);
					yscale = xscale;
					color = C_GREEN;
					scaleInc = random_range(-.01, -.025);
					alpha = 1;
					alphaInc = scaleInc;
					
					light.alpha = 1;
					light.color = c_white;
				}
				
				if(dashLinear * 100 mod 40 == 0){
					_createGhost();
				}

				part_type_direction(oParticle.particleDash, dashDir - 180 - 30, dashDir - 180 + 30, 0, 0);
				repeat(3){
					var _xx = x + irandom_range(-10, 10);
					var _yy = y - 22 + irandom_range(-10, 10);
					
					part_particles_create(oParticle.pSystemPlayer, _xx, _yy, oParticle.particleDash, 1);
				}
				
				dashLinear += .2;
				
				//buffer de state
				if(dashEndState == stateFree){
					if(keyAttack){
						animation = attack;
						image_alpha = 1;
						dashEndState = stateAttack;
					}
					
					if(keyPower && mana > 0){
						dashEndState = statePowerfast;
						alarm[0] = 15;
					}else if(keyPower && mana <= 0){
						audio_play_sound(snCant, 0, 0);
					}
				}else if(dashEndState == stateAttack){
						if(grounded){
							restartSprite();
							instance_destroy(oAttackHitbox);
							attackId = 0;
						}else if(attackDelay < 0){
							restartSprite();
							instance_destroy(oAttackHitbox);
							attackId = 3;
						}
				}
			}else{
				dashCoolDown = 15;
				dashDelay = 1;
				dashLinear = 0;
				
				if(grounded){
					attackId = 0;
				}else{
					attackId = 3;
				}
				
				hspd = 0;
				vspd = 0;
				floatTimer = 10;
				grvAcceleration = .5;
				
				image_alpha = 1;
				xscale = .90;
				yscale = 1.05;
				
				canDash = false;
				dashSound = true;
				
				state = dashEndState;
			}
		}
	}else{
		canDash = false;
		dashSound = true;
		state = stateFree;
		image_alpha = 1;
		xscale = 1;
		yscale = 1;
		hspd = 0;
		vspd = 0;
	}
	
}

stateHealing = function(){
	stateName = "healing";
	image_alpha = 1;
	hspd = 0;
	vspd = 0;
	grvAcceleration = 0;
	
	if(!audio_is_playing(snHeal))
		audio_play_sound(snHeal, 1, 0);
	
	if(healingCounter > healingTime/2){
		var _len = random_range(20, 50);
		var _dir = random(360);
		var _xx = x + lengthdir_x(_len, _dir);
		var _yy = y + lengthdir_y(_len, _dir) - 20;
		var _part_dir = point_direction(_xx, _yy, x, y - 20);
		
		part_type_direction(oParticle.particleCenter, _part_dir, _part_dir, 0, 0);
		part_particles_create(oParticle.pSystemPlayer, _xx, _yy, oParticle.particleCenter, 1);
		part_particles_create(oParticle.pSystemPlayer, _xx - random_range(-10, 10), _yy, global.particleSparkles, 1);
	}
	
	if(healingCounter-- <= 0){	
		state = stateFree;
	}
}

statePowerCharge = function(){
	stateName = "powerCharge";
	image_alpha = 1;
	hspd = 0;
	vspd = 0;
	grvAcceleration = 0;
	
	switch(spearState){
			case(0):
				//criando a lança
				restartSprite();
				dirx = 1;
				spearId = createSpear(spearDir);
				spearState++;
			break;
		
			case(1):
				if(!instance_exists(spearId)){
					spearState = 2;
					spearyScale = dirx;
					return;
				}
			
				repeat(spearId.particleMultiplyer - 1){
					var _ang = random(360);
					var _len = irandom_range(60, 80);
					var _xx = x + lengthdir_x(_len, _ang);
					var _yy = y + lengthdir_y(_len, _ang) - sprite_height/2;
					var _part_dir = point_direction(_xx, _yy, x, y - sprite_height/2);
					part_type_direction(oParticle.particleCenter, _part_dir, _part_dir, 0, 0);
					part_particles_create(global.particleSystem, _xx, _yy, oParticle.particleCenter, 1);
				}
		
				//carregando o golpe
				depth = -3;
				with(spearId){
					depth = other.depth - 1;
					image_angle = other.spearDir;
					spd = 0;
				}
			
				image_index = spearDir div (360/16);
				animation = function(){ return; }
				sprite = sPlayerDirection;
				spearyScale = sign(spearId.image_yscale);
				spearDir = point_direction(x, y - sprite_height/2, mouse_x, mouse_y);
				
				//soltando a lança
				if(mouse_check_button_released(mb_right) || !mouse_check_button(mb_right)){
					depth = layer_get_depth("player");
					layer_add_instance("player", self);
				
					//tempo travado no ar após atirar a lança
					spearTime = 5;

					//confirma o tiro
					with(spearId){
						spd = 8 * (chargeState + 1);
						state = SPEARSTATE.FLYING;
					}
					mana -= spearMana;
					spearState++;
				
				}else if(keyAttack || hp < oldHp){
					//cancela o tiro
					depth = layer_get_depth("player");
					layer_add_instance("player", self);
					
					with(spearId){
						spd = 0;
						state = SPEARSTATE.CANCEL;
					}
				
					spearState++;
				}
			break;
		
			case(2):
				//tempo travado depois de atirar a lança
				if(spearTime-- < 0){
					dirx = spearyScale;
					spearState = 0;
					animation = idle;
					state = stateFree;		
				}
			break;
		}	
}

statePowerFly = function(){
	stateName = "powerFly";
	
	if(keyPlane && vspd > 0 && !place_meeting(x, y + 1, oParWall)){
		if(sprite == sPlayerJump || sprite == sPlayerFall || sprite == sPlayerFall2){
			animation = function(){};
			sprite = sPlayerFly;
				
			repeat(10){
				var _xx = x + random_range(-20, 20);	
				var _yy = y - random(50);	
					
				part_particles_create(oParticle.pSystemPlayer, _xx, _yy, global.particleSparkles, 1);
			}
		}
		
		if(sprite == sPlayerFly && animationEnd()){
			sprite = sPlayerFly2;
		}
		
		floatTimer = 1;
		grvAcceleration = .3;
	}else{
		sprite = sPlayerFall2;
		animation = air;
		floatTimer = 0;
		state = stateFree;
	}
}

xx = x;
yy = y;
ddirx = 0;
powerCoolDown = 0;
playPowerSound = true;

statePowerfast = function(){
	stateName = "powerFast";
	animation = powerFast;
	hspd = 0;
	vspd = 0;
	floatTimer = 1;
	grvAcceleration = .2;
	depth = -999;
	
	if(sprite != sPlayerPowerFast){
		image_speed = 1;
		image_index = 0;
		sprite = sPlayerPowerFast
		blinkTime = 2;
		
		if(playPowerSound){
			audio_play_sound(snPower, 1, 0);
			playPowerSound = false;
		}
		
		ddirx = dirx;
		xx = x;
		yy = y;
		
		var _onDestroy = function(){
			with(instance_create_layer(xx, yy - 28, "player", oPowerFast)){
					dirx = other.ddirx;
					image_xscale = dirx;
					sprite_index = sPower
			}	
		}
		
		createOneTimeSprite(x - 100 * dirx, y + 32, sPowerCast, 0, dirx, 1, _onDestroy);
		camShake(3, 5);
		//powerCoolDown = 15 * 60;
		alarm[0] = 5;
	}
}


ease = 0;
spawnState = 0;

stateSpawning = function(){
	stateName = "spawning";
	canHurt = false;
	canControl = false;
	grvAcceleration = 0;
	vspd = 0;
	hspd = 0;
	sprite = sPlayerIdle;
	global.canPause = false;
	global.showHud = false;
	global.cutsceneMode = true;
	
	var _save = instance_nearest(x, y, oSave);
	
	if(_save){
		_save.state = 2;
		x = _save.x - 40;
		y = _save.y;
	}
	
	if(instance_place(x, y, oCollidersFather)){
		y--;
	}
	
	//ease function
	if(spawnState == 0){
		spawnTimer++;
		ease = ease_in_expo(spawnTimer, 0, 1, 60);
		image_alpha = 0;
		
		if(ease >= 1){
			spawnState = 1
			spawnTimer = 30;
		}
	}else if(spawnState == 1){
		spawnTimer--;
		ease = ease_out_expo(spawnTimer, 0, 1, 30);
		image_alpha = 1;
		
		if(ease <= 0){
			blinkTime = 7;
			//particulaas
			repeat(20){
				var _xx = x + random_range(-10, 10);
				var _yy = y - sprite_height/2 + random_range(-10, 10);
				
				part_particles_create_color(oParticle.pSystemPlayer, _xx, _yy, global.particleDrop, make_color_hsv(110 + random_range(-20, 20), 195, 215), 1);
			}
		}
	}
	
	
	
	//fim da animação
	if(ease <= 0 && spawnState == 1){
		canHurt = true;
		canControl = true;
		global.canPause = true;
		global.showHud = true;
		global.cutsceneMode = false;
		
		if(_save)
			_save.state = 0;
		
		state = stateFree;
	}
}

state = stateFree;

#endregion

#region//funções

getDashDir = function(){
	var _dx = keyRight - keyLeft;
	var _dy = keyCrouch - keyUp;
	var _dir = 0;
	
	if(crouched)
		return(-1);
	
	if(_dx == 1){
		_dir = 0;
	}else if(_dx == -1){
		_dir = 180;
	}
		
	//baixo
	if(_dy == 1){
		if(_dx == 1){
			_dir = 315;
		}else if(_dx == -1){
			_dir = 225;
		}else{
			_dir = 270;
		}
	}else if(_dy == -1){
		//cima
		if(_dx == 1){
			_dir = 45;
		}else if(_dx == -1){
			_dir = 135;
		}else{
			_dir = 90;
		}
	}
	
	if(_dx != 0 || _dy != 0)
		return(_dir);
	else
		return(-1);
		
}

//função do mitinho
blink = function(){
	//efeito de pisacar quando invencivel
	if(invencible && invencibleTime[0] > 0)	
		image_alpha = abs(sin(current_time) + .2);
	
	//player ficar branco quando levar hit
	//if(invencibleTime[0] > invencibleTime[1] - 5){
	//	if(invencible){
	//		blinkTime = 5;
	//	}
	//}
	
	//quando o tempo de invencibilidade acabar
	if(invencible && invencibleTime[0]-- < 0){
		image_alpha = 1;
		invencible = false;
		canHurt = true;
	}
}

#endregion

#region//animation

spriteState = "";
sprite = 0;

idle = function(){
	spriteState = "idle";
	sprite = sPlayerIdle;
	
	if(abs(hspd) > 1){
		restartSprite();
		sprite = sPlayerToRun;
		animation = run;
	}
	
	//caso eu caia ou pule
	if(keyJump || vspd != 0){
		restartSprite();
		animation = air;
	}
	
	//agachar
	if(keyCrouch && grounded && hspd == 0 && state != stateDash ){
		restartSprite();
		animation = crouch;
	}
	
	//dialogo
	if(hspd == 0 && state == stateDialog){
		restartSprite();
		animation = dialog;
	}
	
	//ataque
	if(state == stateAttack){
		animation = attack;
	}
}

run = function(){
	spriteState = "run";
	if(animationEnd() && sprite == sPlayerToRun){
		restartSprite();
		sprite = sPlayerRun;
	}
	
	if(abs(hspd) > 0  && sprite != sPlayerToRun) sprite = sPlayerRun;
	
	if(abs(hspd) == 0 && sprite == sPlayerRun){
		restartSprite();
		sprite = sPlayerBreak;
	}
	
	if(animationEnd() && sprite == sPlayerBreak) 	animation = idle;
	
	if(sprite == sPlayerJump || sprite == sPlayerFall || sprite == sPlayerFall2){
		animation = idle;
	}
	
	//ataque
	if(state == stateAttack){
		animation = attack;
	}
	
	//caso eu caia ou pule
	if(!grounded){
		restartSprite();
		sprite = sPlayerIdle;
		animation = air;
	}
	
	//climnb
	if(state == stateGrab){
		restartSprite();
		animation = climb;
	}
	
	//dialogo
	if(state == stateDialog && hspd == 0){
		restartSprite();
		animation = dialog;
	}
}
	
air = function(){
	spriteState = "air";
		
	if(vspd < 0){
		sprite = sPlayerJump;	
	}else if(sprite != sPlayerFall && sprite != sPlayerFall2 && vspd > 0){
		restartSprite();
		sprite = sPlayerFall;
	}
	
	if(animationEnd() && sprite == sPlayerFall){
		restartSprite();
		sprite = sPlayerFall2;
	}
	
	if(grounded && (sprite == sPlayerFall || sprite == sPlayerFall2 || sprite == sPlayerJump) && vspd == 0 && sprite != sPlayerLandSoft && sprite != sPlayerAttack4 && sprite != sPlayerRun){
		landed = true;
		
		if(hspd == 0 || move == 0){
			restartSprite();
			sprite = sPlayerLandSoft;
		}else{
			animation = run;
		}
	}
	
	if(sprite == sPlayerAttack4 || sprite == sPlayerRun || sprite == sPlayerToRun){
		animation = idle;
	}
	
	if(animationEnd() && sprite == sPlayerLandSoft){
		animation = idle;
	}
	
	if(sprite == sPlayerIdle){
		animation = idle;
	}
	
	//climnb
	if(state == stateGrab){
		restartSprite();
		animation = climb;
	}
	
	//ataque
	if(state == stateAttack){
		animation = attack;
	}
}

crouch = function(){
	
	spriteState = "crouch";
	
	if(keyCrouch && sprite != sPlayerToCrouch && sprite != sPlayerFromCrouch){
		sprite = sPlayerToCrouch;
	}
	
	if(animationEnd() && sprite == sPlayerToCrouch){
		crouched = true;
		mask = sPlayerMask2;
		image_speed = 0;
		image_index = sprite_get_number(sPlayerToCrouch) - 1;
	}
	
	if(keyCrouchRelease && sprite == sPlayerToCrouch){
		image_speed = sprite_get_speed(sPlayerIdle);
		restartSprite();
		sprite = sPlayerFromCrouch;
	}
	
	if(animationEnd() && sprite == sPlayerFromCrouch){
		crouched = false;
		animation = idle;
	}
	
	if(keyJump || !grounded && !crouched){
		restartSprite();
		crouched = false;
		animation = air;
	}
	
	if(hspd != 0 || vspd != 0){
		crouched = false;
		animation = idle;
	}
	
	//dialogo
	if(state == stateDialog && hspd == 0){
		restartSprite();
		crouched = false;
		animation = dialog;
	}
	
	//ataque
	if(state == stateAttack){
		crouched = false;
		animation = attack;
	}
}

climb = function(){
	spriteState = "climb";
	sprite = sPlayerClimb;
	
	if(state != stateGrab){
		animation = idle;
	}
}

dialog = function(){
	spriteState = "dialog";
	sprite = sPlayerIdle;
	
	if(state != stateDialog || hspd != 0){
		animation = idle;
	}
}

powerFast = function(){
	spriteState = "powerFast";
	
	if(animationEnd() && sprite == sPlayerPowerFast){
		layer_add_instance("player", self);
		playPowerSound = true;
		state = stateFree;
		animation = idle;
	}
}


attack = function(){
	spriteState = "attack";
	
	if(state != stateAttack){
		animation = idle;
	}
}

death = function(){
	spriteState = "death";
	
	if(state != stateDeath){
		animation = idle;
	}
}

hurt = function(){
	spriteState = "hurt";
	sprite = sPlayerHurt;
	
	if(invencibleTime[0] < invencibleTime[1] - 10){
		restartSprite();
		animation = idle;
	}
	
}

animation = idle;
		
#endregion
