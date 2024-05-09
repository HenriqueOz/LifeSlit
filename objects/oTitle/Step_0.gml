alpha += alphaDec;
global.showHud = false;

if(alpha == 1){
	alarm[0] = 60;
}

if(alpha <= 0 || !global.showTitle){
	instance_destroy(self);
	global.showTitle = false;
	global.showHud = true;
}