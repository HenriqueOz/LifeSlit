
stepCd = 3;

//emtidade
grvAcceleration = 1.1;
hspd = 0;
vspd = 0;
spd = 1;

breath = .0008;

//criando a luz
light = instance_create_layer(x, y - sprite_height/2, layer, oLightEntities);
light.scalex = 1.2;
light.scaley = 1.2;
light.oscilation = 20;
light.alpha = 1;
light.intensity = .1;//ente 0 e 1
light.color = C_GREEN;
