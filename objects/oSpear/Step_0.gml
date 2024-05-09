
#region//particles

var _ps = global.particleSystem;

//charging particle
part_type_sprite(chargingParticle, sHitParticle2, false, false, false);
part_type_colour2(chargingParticle, c_white, color);
part_type_size(chargingParticle, .5, .8, 0, 0);
part_type_alpha3(chargingParticle, .8, .5, .2);
part_type_speed(chargingParticle, .5, 1, -.1, 0);
part_type_direction(chargingParticle, 0, image_angle - 180, 0, 0);
part_type_orientation(chargingParticle, 0, image_angle - 180, 0, 0, 0);
part_type_life(chargingParticle, 15, 20);

//impact particle
part_type_direction(oParticle.particleImpact, (image_angle - 180) - 45, (image_angle - 180) + 45, 0, 0);



#endregion

//setando o estado da lança

var _t = 25 * (chargeState + 1);

if(chargeTime < _t){
	particleMultiplyer = 1;
	chargeState = 0;
}else if(chargeTime > _t && chargeTime < 25 * 3){
	particleMultiplyer = 2;
	chargeState = 1;
}else if(chargeTime > _t){
	particleMultiplyer = 3;
	chargeState = 2;
}


var _r = 0;

switch(state){
	case(SPEARSTATE.CHARGING):
		chargeTime++;
		
		var _xx = x + random_range(-20, 20);
		var _yy = y + random_range(-20, 20);
		part_particles_create_color(global.particleSystem, _xx, _yy, global.particleDrop, make_color_hsv(50 + random_range(-15, 15), 150, 255), 1);
		
		if(scale < scaleLimit[chargeState])	scale += .05;		
	break;
	
	case(SPEARSTATE.FLYING):
		x += lengthdir_x(spd, image_angle);
		y += lengthdir_y(spd, image_angle);	
		
		//rastro
		if(ghostInterval-- < 0){
			with(instance_create_layer(x, y, "player", oGhost)){
				rot = other.image_angle;
				sprite = other.sprite_index;
				yscale = sign(other.image_yscale);
				alpha = .7;
				scaleInc = .02;
				alphaInc = -.05;
			}
			ghostInterval = 3;
		}
		
		//caso colida
		if(instance_place(x, y, oCollidersFather) || instance_place(x, y, oParEnemies))
			state = SPEARSTATE.IMPACT;
	break;
	
	case(SPEARSTATE.IMPACT):
		with(instance_place(x, y, oParEnemies)){
			takeDamage(other.damage[other.chargeState]);
		}
		camShake(3 * chargeState + 1, 3);
		part_particles_create(global.particleSystem, x, y, oParticle.particleImpact, 9);
		instance_destroy(self);
	break;
	
	case(SPEARSTATE.CANCEL):
		scale -= .05
		if(scale < 0)	instance_destroy(self);
	break;
}

	
image_xscale = scale;
if(image_angle > 90 && image_angle < 270) image_yscale = -scale;
else image_yscale = scale;
