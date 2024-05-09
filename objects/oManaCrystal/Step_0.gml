switch(state){
	case(CRYSTAL_STATE.IDLE):
		sprite = sCrystalIdle;
		
		if(instance_place(x, y, oAttackHitbox) && instance_exists(oPlayer) && oPlayer.state == oPlayer.stateAttack){
			if(instance_exists(oPlayer)){ 
				with(oPlayer){
					hitCrystal = true;
					if(other.canFillMana){
						mana++;
						oHud.manaTimer = 45;
					}
				}
			}
			t = 30;
			
			state = CRYSTAL_STATE.BREAKING;
		}
	break;
	
	case(CRYSTAL_STATE.BREAKING):
		sprite = sCrystalRecharging;
		//canFillMana = false;
	
		if(t > 0){
			t--;
			transform = (sin(current_time/100) * 8) * (t/30);
		}else{
			alarm[0] = 300;
			state = CRYSTAL_STATE.RECHARGING;
		}
	break;
	
	case(CRYSTAL_STATE.RECHARGING):
		if(instance_exists(oPlayer)){
			if(oPlayer.grounded && alarm[0] > 0){
				alarm[0] = 0;
				sprite = sCrystalIdle;
				t = 10;
			}
		}
		
		if(alarm[0] <= 0){
			if(t >= 10)
				repeat(12){
					var _xx = x + sprite_width/2 + random_range(-16, 16);
					var _yy = y + sprite_height/2 + random_range(-16, 16);
				
					part_particles_create(ps, _xx, _yy, global.particleSparkles, 1);
				}
			
			if(t-- < 0)
				state = CRYSTAL_STATE.IDLE;
		}
	break;
}