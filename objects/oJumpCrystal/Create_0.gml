
light = instance_create_layer(x + sprite_width/2, y + sprite_height/2, layer, oLightEntities);
light.color = c_white;

ps = global.particleSystem;
sprite = sCrystalIdle2;

enum CRYSTAL_STATE2{
	IDLE,
	BREAKING,
	RECHARGING
}

alarm[0] = 0;
state = CRYSTAL_STATE2.IDLE;
t = 0;
transform = 0;
