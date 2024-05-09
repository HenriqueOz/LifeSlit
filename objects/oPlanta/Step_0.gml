
event_inherited();

light.drawX = x;
light.drawY = y - sprite_height/2;

if(isAlive && instance_place(x, y, oPlayer))
	damagePlayer(1);
	
if(!isAlive)
	state = stateDeath;

state();

image_xscale = dirx;