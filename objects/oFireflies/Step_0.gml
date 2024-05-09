
//part_emitter_region(global.particleSystem, firefliesEmitter, x - 32, x + 32, y - 32, y + 32, ps_shape_ellipse, ps_distr_gaussian);
//part_emitter_burst(global.particleSystem, firefliesEmitter, fireflies, -6);

if(timer-- < 0){
	randomize();
	timer = random_range(30, 180);
	dir = random(360);
}

light.drawX = x + 1;
light.drawY = y + 1;

x += lengthdir_x(.1, dir);
y += lengthdir_y(.1, dir) + sin(current_time/250) * .1;

x = clamp(x, 0, room_width);
y = clamp(y, 0, room_height);