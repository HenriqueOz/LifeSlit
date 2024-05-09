 /// @description teleporta o player quando colide
if(instance_exists(oPlayer)){
	with(oPlayer){
		canControl = false;
		canHurt = false;
		grvAcceleration = 0; 
		
		if(bbox_bottom > other.bbox_bottom){
			other.under = true;
		}
		
		if(other.under){
			x = lerp(x, other.x + other.sprite_width/2, .075);
			y -= 2;
		}
		
		if(vspd > 32){
			vspd = 0;
		}
	}
	
	if(!warping){
		if(destinyY == 0){
			destinyY = oPlayer.y;
		}
		
		warp(destinyX, destinyY, rm, 20, true);
		
		//criando um novo target para no momento em que o player colide com o warp
		//pois a câmera continua seguindo o player e acabando dando um bug visualdddddddddd
		var _t = instance_create_layer(oPlayer.x, oPlayer.y, layer, oCamTarget);
		oCam.target = _t;
	
		if(instance_exists(oFade)){
			warping = true;
		}
	}
	
	if(title){
		global.showTitle = true;
	}else{
		global.showTitle = false;
	}
}


