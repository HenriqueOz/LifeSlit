
light = instance_create_layer(x, y - sprite_height/2, layer, oLightEntities);
light.scalex = 1;
light.scaley = 1.5;
light.oscilation = 30;
light.alpha = 1;
light.image_angle = 0;
light.colorOverlay = false;
light.intensity = .1;//ente 0 e 1
light.color = c_fuchsia;

if(!instance_exists(oPlayer))
	instance_destroy(self);

hspd = 0;
vspd = 0;
grv = 0;

timerGhost = 2;

