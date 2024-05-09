
alpha += alphaInc;
xscale += scaleInc * sign(xscale);
yscale += scaleInc * sign(yscale);

if(instance_exists(light)){
	light.scalex = xscale;
	light.scaley = yscale;
}

image_alpha = alpha;

if(alpha < 0 || xscale == 0){
	instance_destroy(self);
}
