

light.drawX = x;
light.drawY = y;

if(instance_exists(oPlayer) && !destroy){
	if(oPlayer.lifeShard ==  oPlayer.lifeShardMax){
		destroy = true;	
	}
	
	var _dist = distance_to_object(oPlayer);
	var _blocks = 10 * 32;
	_dist = clamp(_dist, 256, _blocks);
	
	
	x = lerp(x, oPlayer.x, .07/_blocks * _dist);
	y = lerp(y, oPlayer.y - 24, .07/_blocks * _dist);
	
	
	if(instance_place(x, y, oPlayer)){
		with(oPlayer){
			if(lifeShard < lifeShardMax){
				lifeShard++;
			}	
		}
		
		destroy = true;
	}
}

//caso o item nasça dentro do chão ele sobe
//while(place_meeting(x, y, oParWall) || place_meeting(x, y + 16, oParWall)){
//	y--;
//}

if(!part_emitter_exists(oParticle.pSystemDrop, emitter)){
	emitter = part_emitter_create(oParticle.pSystemDrop);
}

//emitindo particulas
var _xx = x + random_range(-10, 10);
var _yy = y + random_range(-10, 10);
var _color = make_color_hsv(110 + random_range(-20, 20), 195, 215);

if(current_time mod 4 == 0){
	part_particles_create_color(oParticle.pSystemDrop, _xx, _yy, global.particleDrop, _color, 1);
}

//movendo o item
y += sin(time * frequency) * amplitude;
time++;

//trocando pro estado de interação e gerenciando
if(instance_exists(oPlayer) && distance_to_object(oPlayer) < 50 && !destroy){

	
	if(drawKey){
		alpha += .1;
	}else{
		alpha -= .1;
	}
}else{
	if(alpha > 0){
		alpha -= .1;
	}
}

//state de destrioção do item
if(destroy){
	image_alpha -= .05;
	if(image_alpha <= 0){
		instance_destroy(light);
		instance_destroy(self);
	}
}