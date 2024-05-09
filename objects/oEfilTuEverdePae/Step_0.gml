/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//configurando a luz para me seguir
light.drawX = x;
light.drawY = y - sprite_height/2;

vspd += GRV * grvAcceleration;

if(hspd != 0){
	image_xscale = sign(hspd);
}

//se ele estiver dormingo ele fica respirando
if(sprite_index == sEfilSleeping){
	if(image_speed == 0){
		if(alarm[0] <= 0)
			alarm[0] = 120;
	
		image_yscale += breath;
	}else{
		if(animationEnd())
			image_speed = 0;
	}
}

//animando
if(hspd != 0){
	sprite_index = sEfilWalking;
}

//colisão
x += hspd;

if(place_meeting(x, y + vspd, oParWall)){
	while(!place_meeting(x, y + sign(vspd), oParWall)){
		y += sign(vspd);
	}
	vspd = 0;
}

y += vspd;

