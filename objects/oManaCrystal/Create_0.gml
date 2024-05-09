
light = instance_create_layer(x + sprite_width/2, y + sprite_height/2, layer, oLightEntities);
light.color = c_white;

ps = global.particleSystem;
sprite = sCrystalIdle;

enum CRYSTAL_STATE{
	IDLE,
	BREAKING,
	RECHARGING
}

alarm[0] = 0;
state = CRYSTAL_STATE.IDLE;
t = 0;
transform = 0;
canFillMana = true;