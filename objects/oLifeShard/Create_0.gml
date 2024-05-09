event_inherited();

y -= sprite_get_height(sprite_index);

time = 0;
frequency = .1;
amplitude = .1;
destroy = false;

destroy = false;
emitter = -1;

//desenhar key de interação
alpha = 0;
drawKey = true;

//criando a luz
light = instance_create_layer(x, y, layer, oLightEntities);
light.scalex = 1;
light.scaley = 1;
light.oscilation = 20;
light.alpha = 1;
light.image_angle = 0;
light.colorOverlay = false;
light.intensity = .1;//ente 0 e 1
light.color = c_white;
