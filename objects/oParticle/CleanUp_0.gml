//limpando o sistema de particula
//part_type_destroy(particleDash);
//part_type_destroy(particleImpact);
//part_type_destroy(particleWalkDust);
//part_type_destroy(particleWalkDust2);
//part_type_destroy(particleSpawn);
//part_type_destroy(global.particleDrop);
//part_type_destroy(global.particleEnemyDeath);
//part_type_destroy(global.particleHit1);
//part_type_destroy(global.particleSparkles);

//part_system_destroy(global.particleSystem);
//part_system_destroy(pSystemPlayer);
//part_system_destroy(pSystemDrop);

part_type_clear(particleDash);
part_type_clear(particleImpact);
part_type_clear(particleWalkDust);
part_type_clear(particleWalkDust2);
part_type_clear(particleSpawn);
part_type_clear(global.particleDrop);
part_type_clear(global.particleEnemyDeath);
part_type_clear(global.particleHit1);
part_type_clear(global.particleSparkles);

part_system_clear(global.particleSystem);
part_system_clear(pSystemPlayer);
part_system_clear(pSystemDrop);