/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

light = createLight(x, y - sprite_height/2, 1, 1, 0, 1, 0);

name1 = "Huma";
name2 = "[c_fuchsia]Ally[/c]";

text = [
	"Bom dia forasteira"
]

addDialog(dialog, name2, text[0], 0, 0, 0, 1);
addDialog(dialog, name2, text[1], 0, 0, 0, 1);
addDialog(dialog, name2, text[2], 0, 0, 0, 1);
addDialog(dialog, name2, text[3], 0, 0, 0, 1);


time = 0;
