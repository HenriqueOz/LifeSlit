
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

hp = 2;
hspd = 0;
vspd = 0;
spd = 1;

rotateTimer = 0;
dir = 0;
changeDir = false;

underFloor = instance_place(x, y + 1, oParWall);


