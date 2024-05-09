
followPlayer = false;

sound = false;
time = 30;	
finalAngle = 90;
spd = 5;
image_angle = 90;

image_xscale =.1;
image_yscale =.1;
depth = oUriel.depth - 1;

collide = false;

damagePlayer = function(_dmg){
	if(instance_exists(oPlayer)){
		with(oPlayer){
			if(canHurt && !invencible && state != stateDash && state != stateHurt){
				hp -= _dmg;
				state = stateHurt;
				return;
			}
		}
	}
}










