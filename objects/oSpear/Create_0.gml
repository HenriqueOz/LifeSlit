
spd = 5;
scale = .5;
scaleLimit = [.5, .8, 1];
ghostInterval = 0;  
shake = .4;
damage = [1, 2, 3];

chargeTime = 0;
chargeState = 0;
particleMultiplyer = 0;

chargingParticle = part_type_create();
emitter = part_emitter_create(global.particleSystem);
color = C_GREEN;

enum SPEARSTATE{
	CHARGING,
	FLYING,
	IMPACT,
	CANCEL
}

state = SPEARSTATE.CHARGING;
