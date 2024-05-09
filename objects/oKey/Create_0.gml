/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Inherit the parent event
event_inherited();

light = instance_create_layer(x, y, layer, oLightEntities);
light.scalex = 1;
light.scaley = 1;
light.oscilation = 20;
light.alpha = 1;
light.image_angle = 0;
light.colorOverlay = false;
light.intensity = .1;//ente 0 e 1
light.color = c_white;

if(variable_global_get(globalName)){
	instance_destroy(self);
}



