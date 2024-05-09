/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

content = noone;

close = function(){
	instance_destroy(content);
	return(-1);
}

options = [
	["120       Item A", close],	//apra alinhar os valores tenho q dar 2 espaços por letra da maior string e 1 espaço por espaço
	["90	    Item B", close],
	["65		Item C", close],
	["10        Item D", close]
];

