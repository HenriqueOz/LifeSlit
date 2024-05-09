event_inherited();

//movimento
image_xscale = dirx;
hspd = dirx * spd;

light.drawX = x;
light.drawY = y - sprite_height/2;

//state
if(!isAlive && state != stateDeath){
	instance_create_depth(x, y - 8, depth - 1, oShell);
	state = stateDeath;	
}

state();

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

if(collision_rectangle(x - 8, y - 8, x + 8, y + 8, oPlayer, false, false) && isAlive){
	damagePlayer(1);
}


//colisão
gravityAcelleration(mass);
collision(true, true);

image_yscale = lerp(image_yscale, 1, .1);
x = clamp(x, 0, room_width);
