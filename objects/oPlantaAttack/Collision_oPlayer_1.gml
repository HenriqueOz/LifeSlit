if(instance_exists(oPlayer)){
	with(oPlayer){
		if(canHurt && !invencible && state != stateDash && state != stateHurt){
			hp -= 1;
			state = stateHurt;
			instance_destroy(other.id);
			return;
		}
	}
	
}