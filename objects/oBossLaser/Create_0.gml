
time = 60;

image_xscale =.1;
image_yscale =.1;
finalxscale = 1;
finalyscale = 1;

collide = false;
invert = false;

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










