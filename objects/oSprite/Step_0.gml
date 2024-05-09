if(animationEnd()){
	if(onDestroy != 0){
		onDestroy();
	}
	instance_destroy(self);
}