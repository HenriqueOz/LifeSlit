
draw_self();

if(hitCooldown > 5){
	gpu_set_fog(true, c_white, 0, 0);
		draw_self();
	gpu_set_fog(false, c_white, 0, 0);
}

