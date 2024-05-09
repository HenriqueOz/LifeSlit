//criando os sistemas
global.particleSystem = part_system_create();
pSystemPlayer = part_system_create();
pSystemDrop = part_system_create();


particleCenter = part_type_create()
part_type_sprite(particleCenter, sDashTrail, 0, 0, 0);
part_type_colour2(particleCenter, c_white, C_GREEN);
part_type_life(particleCenter, 40, 40);
part_type_blend(particleCenter, true);
part_type_speed(particleCenter, 1, 2, .1, 0);
part_type_size(particleCenter, .8, 1, -.1, 0);

particleDash = part_type_create();
part_type_sprite(particleDash, sDashTrail, false, false, false);
part_type_blend(particleDash, true);
part_type_color1(particleDash, C_GREEN);
part_type_size(particleDash, .2, .1, -.005, 0);
part_type_alpha3(particleDash, 1, .6, .1);
part_type_speed(particleDash, 1, 2, -.05, 0);
part_type_life(particleDash, 50, 60);

particleWalkDust = part_type_create();
part_type_sprite(particleWalkDust, sWalkParticle, false, false, false);
part_type_colour2(particleWalkDust, C_GREEN, c_white);
part_type_size(particleWalkDust, 2.5, 3, -.1, 0);
part_type_speed(particleWalkDust, .5, 1, -.05, 0);
part_type_gravity(particleWalkDust, .05, 90);
part_type_alpha2(particleWalkDust, 1, .5);
part_type_orientation(particleWalkDust, 0, 360, .1, 0, true);
part_type_life(particleWalkDust, 15, 20);

particleWalkDust2 = part_type_create();
part_type_sprite(particleWalkDust2, sWalkParticle2, false, false, true);
part_type_colour1(particleWalkDust2, c_white);
part_type_size(particleWalkDust2, 2, 2.5, -.1, 0);
part_type_gravity(particleWalkDust2, .1, 90);
part_type_alpha3(particleWalkDust2, .9, .3, 0);
part_type_orientation(particleWalkDust2, 0, 360, .1, 0, false);
part_type_life(particleWalkDust2, 10, 15);

part_type_death(particleWalkDust, 1, particleWalkDust2);

particleImpact = part_type_create();
part_type_sprite(particleImpact, sHitParticle3, false, false, false);
part_type_colour2(particleImpact, c_white, C_GREEN);
part_type_size(particleImpact, .5, 1.25, -.05, 0);
part_type_alpha3(particleImpact, .65, .8, 0);
part_type_speed(particleImpact, 6, 8, -.1, 0);
part_type_orientation(particleImpact, 0, 0, 0, 0, true);
part_type_life(particleImpact, 40, 50);

particleHealing = part_type_create();
part_type_sprite(particleHealing, sLightParticle, false, false, false);
part_type_alpha3(particleHealing, 1, .5, 1);
part_type_blend(particleHealing, false);
part_type_color3(particleHealing, c_white, C_GREEN, c_lime);
part_type_direction(particleHealing, 0, 360, 0, 30);
part_type_gravity(particleHealing, 0, 0);
part_type_life(particleHealing, 60, 60);
part_type_orientation(particleHealing, 0, 360, 0, 0, true);
part_type_size(particleHealing, .1, .2	, -.01, 0);
part_type_speed(particleHealing, 2, 4, -.5, 0);

particleSpawn = part_type_create();
part_type_sprite(particleSpawn, sHitParticle3, false, false, false);
part_type_alpha3(particleSpawn, .8, .5, .1);
part_type_blend(particleSpawn, false);
part_type_color2(particleSpawn, c_white, C_GREEN);
part_type_direction(particleSpawn, 0, 360, 0, 0);
part_type_gravity(particleSpawn, 0, 0);
part_type_life(particleSpawn, 60, 60);
part_type_orientation(particleSpawn, 0, 0, 0, 0, true);
part_type_size(particleSpawn, 1, .8, -.01, 0);
part_type_speed(particleSpawn, 2, 3, -.1, 0);

#region//global particles

//hit1  
var _p = part_type_create();
part_type_sprite(_p, sHitParticle, false, false, true);
part_type_colour1(_p, c_white);
part_type_size(_p, .8, 1, -.01, 0);
part_type_alpha3(_p, 1, .5, .1);
part_type_speed(_p, 1.5, 2, -.005, 0);
part_type_orientation(_p, 0, 0, 5, 0, false);
part_type_life(_p, 30, 40);

global.particleHit1 = _p;

var _p = part_type_create();
part_type_sprite(_p, sDashTrail, false, false, false);
part_type_blend(_p, true);
part_type_color1(_p, C_GREEN);
part_type_size(_p, .2, .4, -.005, 0);
part_type_speed(_p, .5, .5, 0, 0);
part_type_gravity(_p, .005, 90)
part_type_direction(_p, 89, 91, 0, 15);
part_type_life(_p, 120, 120);

global.particleSparkles = _p;

//enemies death
var _p = part_type_create();
part_type_sprite(_p, sHitParticle2, false, false, false);
part_type_colour1(_p, c_white);
part_type_size(_p, .5, 1, -.02, 0);
part_type_alpha1(_p, 1);
part_type_speed(_p, 1, 2, 0, 0);
part_type_direction(_p, 0, 360, 0, 0);
part_type_orientation(_p, 0, 360, 0, 0, 0);
part_type_life(_p, 30, 40);

global.particleEnemyDeath = _p;

//droped item
var _p = part_type_create();
part_type_sprite(_p, sItemParticles, false, false, false);
part_type_colour1(_p, c_white);
part_type_size(_p, .5, .75, -.01, 0);
part_type_blend(_p, true);
part_type_alpha1(_p, 1);
part_type_speed(_p, .5, 1, -.01, 0);
part_type_direction(_p, 0, 360, 0, 0);
part_type_gravity(_p, .005, 90);
part_type_orientation(_p, 0, 0, 0, 0, false);
part_type_life(_p, 50, 60);

global.particleDrop = _p;

#endregion
