if(!instance_exists(oCam)){
	instance_create_layer(x, y, layer, oCam);
	oCam.target = self;
}


sprite_index = sPlayerCutscene01;
mask_index = sPlayerCutscene01;
image_speed = 0;

light = instance_create_layer(x, y - sprite_height/2, layer, oLightEntities);
light.scalex = 1.2;
light.scaley = 1.2;
light.oscilation = 20;
light.alpha = .2;
light.intensity = .1;//ente 0 e 1


state = 0;
drawLight = false;
timer = 0;
transform = 1;
transform2 = 0;