/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if(global.allyDisapear && time <= 0){
	camZoom(1, oPlayer, 1);
	oPlayer.canControl = true;
	dialog = {};
	instance_destroy(light);
	instance_destroy(self);
}

if(time > 0){
	instance_destroy(oDialog);
}

if(instance_exists(oDialog)){
	if(oDialog.closeDialog){
		time = 30;
		oPlayer.keyInteract = 0;
		oPlayer.canControl = false;
		global.allyDisapear = true;
		instance_destroy(oDialog)
	}
}

