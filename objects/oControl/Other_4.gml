/// @description iniciando as rooms
if(room != rmDeath){
	if(!instance_exists(oParticle) && layer_exists("efx")){
		instance_create_layer(0, 0, "efx", oParticle);
	}
}

