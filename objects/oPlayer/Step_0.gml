if(freezeTime-- > 0){
	image_index = freezeFrame;
	if(instance_exists(oAttackHitbox))
		oAttackHitbox.image_index = freezeFrame;
	exit;
}

if(instance_exists(oUriel) && oUriel.state == oUriel.death){
	io_clear();
	hspd = 0;
}

//rodando os scripts
getInput(canControl);
state();
blink();//piscar o player caso ele tome dano
animation();

//setando váriaveis
sprite_index = sprite;
mask_index = mask;

//luz seguindo o player
light.drawX = x;
light.drawY = y - sprite_height/2;

if(animation != crouch){
	crouched = false;
	mask = sPlayerMask;
}
	
if(hspd != 0 && state != stateAttack){
	dirx = sign(hspd);
}

dashCoolDown--;

powerCoolDown--;
powerCoolDown = clamp(powerCoolDown, 0, 60 * 15);

hp = clamp(hp, 0, global.maxHp);
oldHp = clamp(oldHp, 0, global.maxHp);
mana = clamp(mana, 0, maxMana);

if(instance_exists(oFullMessage))
	global.showHud = false;	


#region//colisão
//-------------colisão-------------//
	
//gravidade
if(state != statePowerFly){
	vspd += GRV * grvAcceleration;
}else{
	vspd += .05;
}

if(floatTimer-- < 0)
	grvAcceleration = 1.1;

//checando se estou no chão e se acabei de cair nele
grounded = place_meeting(x, y + 1, oParWall);

if(grounded){ 
	if(place_meeting(x + 30 * dirx, y + 1, oParWall))
		safeCoord = [x, y];
	
	jumpCut = true;
	canDash = true;
	grabUnits = 0;
	grabLimit = 0;
}else{
	crouched = false;
	mask = sPlayerMask;
}

if(landed){
	var _pt = oParticle.particleWalkDust;
	part_type_direction(_pt, 0, 45, 0, .1);
	part_particles_create(oParticle.pSystemPlayer, x, y, _pt, 1);
	part_type_direction(_pt, 135, 180, 0, .1);
	part_particles_create(oParticle.pSystemPlayer, x, y, _pt, 1);
	
	if(!audio_is_playing(snLanded)){
		audio_play_sound(snLanded, 0, 0);
	}
	
	attackDelay = 5;
	dashCoolDown = -1;

	landed = false;
}

if(jumped){
	var _dir = 1;
	repeat(2){
		var _inst = instance_create_layer(x, y, "player", oDust);
		_inst.sprite_index = sJumpParticle;
		_inst.image_xscale = _dir;
		_dir = -1;
	}
	
	audio_play_sound(snJump, 1, 0);
	jumped = false;
}

//descendo da jumpThrought 
if(place_meeting(x, y + vspd, oJumpThrough)){
	if(keyJump && keyCrouch){
		y++;
		canJump = -1;
	}
}

//checandpo se player pode pular, com base nos frames extras de pulo na varial canJump
if((canJump-- > 0 && keyJump) || hitCrystal){
	jumped = true;
	vspd = -jumpSpeed;
	canJump = 0;
	
	if(hitCrystal){
		canDash = true;
		dashCoolDown = 0;
		dashLinear = 0;
		jumpCut = false;

		hitCrystal = false;
	}
}

//corta pulo
if(keyJumpRelease && vspd < 0 && jumpCut){
	vspd /= 3;
}

//colisão vertical
if(place_meeting(x, y + vspd, oParWall)){
	if(vspd > 0){
		canJump = 10;
	}
	while(!place_meeting(x, y + sign(vspd), oParWall)){
		y += sign(vspd);
	}
	vspd = 0;
}

y += vspd;

//upward slope
if(place_meeting(x + hspd, y, oLeftSlope) || place_meeting(x + hspd, y, oRightSlope)){
	if(state != stateDash){
		hspd = clamp(hspd, -2, 2);
	}else{
		y -= 6;
	}
	for(var _i = 0; _i < 6; _i ++;){
		if(!place_meeting(x + hspd, y - _i, oParWall) && place_meeting(x + hspd, y, oParWall)){
			y -= _i;
			break;
		}
	}
}

//colisão horizontal
if(place_meeting(x + hspd, y, oParWall)){	
	while(!place_meeting(x + sign(hspd), y, oParWall)){
		x += sign(hspd);
	}
	hspd = 0;
}else{
	//downward slope
	for(var _i = 5; _i > 0; _i--;){
		if(!place_meeting(x + hspd, y + _i, oParWall) && (place_meeting(x, y + 1, oRightSlope) || place_meeting(x, y + 1, oLeftSlope))){
			y += _i;
			break;
		}
	}
}

x += hspd;

//arrumando a escala
xscale = 1;
yscale = 1;

//coordenadas para desenhar o sprite do player
xdraw = x;
ydraw = y;


#endregion