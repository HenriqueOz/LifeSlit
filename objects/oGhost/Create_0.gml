
alpha = 1;
alphaInc = 0;
xscale = 1;
yscale = 1;
scaleInc = 0;
sprite = -1;
image = 0;
rot = 0;
color = c_white;
fog = true;
fogAlpha = 1;

light = instance_create_layer(x, y, layer, oLightEntities);
light.scalex = 0;
light.scaley = 0;
light.oscilation = 1;
light.alpha = 0;
light.intensity = 0;//ente 0 e 1
light.color = c_white;