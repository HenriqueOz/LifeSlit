///@description footstep
if(abs(hspd) > 1.5 && grounded){
	spriteBroadcast("footstep", function(){
		part_type_direction( oParticle.particleWalkDust, 0, 180 * dirx, 0, .1);
		part_type_direction( oParticle.particleWalkDust2, 0, 180 * dirx, 0, .1);
		part_particles_create(oParticle.pSystemPlayer, x, y,  oParticle.particleWalkDust, 2);
		
		audio_play_sound(choose(snFootstep1, snFootstep2), 1, 0);
	});
}


