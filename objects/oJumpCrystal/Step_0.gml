switch(state){
	case(CRYSTAL_STATE2.IDLE):
		sprite = sCrystalIdle2;
		
		if(instance_place(x, y, oAttackHitbox) && instance_exists(oPlayer) && oPlayer.state == oPlayer.stateAttack && !oPlayer.grounded){
			if(instance_exists(oPlayer)){ 
				with(oPlayer){
					hitCrystal = true;
				}
			}
			t = 30;
			
			state = CRYSTAL_STATE2.BREAKING;
		}
	break;
	
	case(CRYSTAL_STATE2.BREAKING):
		sprite = sCrystalRecharging;
		//canFillMana = false;
	
		if(t > 0){
			t--;
			transform = (sin(current_time/100) * 8) * (t/30);
		}else{
			alarm[0] = 300;
			state = CRYSTAL_STATE2.RECHARGING;
		}
	break;
	
	case(CRYSTAL_STATE2.RECHARGING):
		if(instance_exists(oPlayer)){
			if(oPlayer.grounded && alarm[0] > 0){
				alarm[0] = 0;
				sprite = sCrystalIdle2;
				t = 10;
			}
		}
		
		if(alarm[0] <= 0){
			if(t >= 10)
				repeat(12){
					var _xx = x + sprite_width/2 + random_range(-16, 16);
					var _yy = y + sprite_height/2 + random_range(-16, 16);
				
					part_particles_create_color(ps, _xx, _yy, global.particleSparkles, c_aqua, 1);
				}
			
			if(t-- < 0)
				state = CRYSTAL_STATE2.IDLE;
		}
	break;
}