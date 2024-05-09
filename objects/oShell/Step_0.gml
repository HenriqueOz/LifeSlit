
//player quicando
if(instance_exists(oPlayer)){
	if(oPlayer.y > bbox_top && oPlayer.vspd > 0 && instance_place(x, y - sprite_height, oPlayer)){
		image_yscale = .75;
		
		with(oPlayer){
			jumped = true;
			vspd = 0;
			if(keyboard_check(global.playerJump)){
				vspd -= 10;
			}else{
				vspd -= 8;
			}
			canJump = 0;
		}
	}
}

//aceleração
var _hitbox = instance_place(x, y, oAttackHitbox);
var _spear = instance_place(x, y, oSpear);
var _dir = sign(x - oPlayer.x);

if((_hitbox || _spear) && abs(acelleration) <= .05){
	acelleration = 4 * _dir;
}

acelleration = lerp(acelleration, 0, .1);
hspd = spd * acelleration;

//inverter direção horizontal ao colidir
if(place_meeting(x + sign(hspd), y, oParWall) || place_meeting(x + sign(hspd), y, oShell)){
	acelleration = -acelleration;
}

//colisão com outros cascos
if(place_meeting(x + hspd, y, oShell)){
	while(!place_meeting(x + sign(hspd), y, oShell)){
		x += sign(hspd);
	}
	hspd = 0;
}

if(place_meeting(x, y + vspd, oShell)){
	while(!place_meeting(x, y + sign(vspd), oShell)){
		y += sign(vspd);
	}
	vspd = 0;
}

//colisão básica
gravityAcelleration(mass);
collision(true, true);

image_yscale = lerp(image_yscale, 1, .1);
x = clamp(x, 0, room_width);