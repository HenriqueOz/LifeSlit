/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if(instance_exists(oDialog)){
	if(oDialog.closeDialog){
		fadeToRoom(rmMenu, 60, c_black);
		oPlayer.keyInteract = 0;
		oPlayer.canControl = false;
		time = 1;
	}
}

if(time > 0){
	instance_destroy(oDialog);
}

