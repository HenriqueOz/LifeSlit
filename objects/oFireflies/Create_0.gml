
light = instance_create_layer(x + 1, y + 1, layer, oLightEntities);
light.scalex = .25;
light.scaley = .25;
light.oscilation = 0;
light.alpha = .8;
light.image_angle = 0;
light.colorOverlay = true;
light.intensity = 1;//ente 0 e 1
light.color = C_GREEN;

randomize();
timer = random_range(30, 180);
dir = random(360);

depth = layer_get_depth("water");


fireflies = part_type_create();
part_type_shape(fireflies, pt_shape_pixel);
part_type_alpha3(fireflies, 1, .5, 1);
part_type_blend(fireflies, false);
part_type_color3(fireflies, c_white, C_GREEN, c_lime);
part_type_direction(fireflies, 0, 360, 0, 30);
part_type_gravity(fireflies, 0, 0);
part_type_life(fireflies, 150, 300);
part_type_orientation(fireflies, 0, 360, 0, 0, true);
part_type_size(fireflies, 1, 3	, -.05, 0);
part_type_speed(fireflies, .05, .1, 0, 0);

firefliesEmitter = part_emitter_create(global.particleSystem);





