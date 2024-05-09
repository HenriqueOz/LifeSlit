/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if(inInteraction){
	createChoiceBox(x, y - 32 * 4, "Lojinha do Zé", options);
	content = createMessage(["[c_green1]Space:[/c] Confirmar"]);
	inInteraction = false;
}
