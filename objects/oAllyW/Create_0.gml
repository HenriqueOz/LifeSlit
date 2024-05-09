/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if(global.allyDisapear){
	instance_destroy(self);
	exit;
}

light = createLight(x, y - sprite_height/2, 1, 1, 0, 1, 0);

name1 = "Huma";
name2 = "[c_fuchsia]Ally[/c]";

text = [
	"Eai forasteira[delay, 150], é bom ver um rosto novo por aqui sabia?",
	"ahh![delay, 200] foi mal, acabei esquecendo de me apresentar.[delay, 200] Bom, eu sou a Ally, e como você pode ver, eu sou um elfo...",
	"E você, qual seu nome?",
	"É...[delay, 150] ei[delay, 350], eu perguntei o seu nome",
	"[shake]O queridona[/shake][delay, 350], Tu não sabe falar não é?",
	"Além de muda você é [shake]idiota[/shake] pra ficar me olhando com essa cara de [shake]songa monga[/shake]?",
	"Ah tanto faz[delay, 350], eu ia perguntar como você veio parar aqui mas pelo visto você é meio burrinha.",
	"Enfim, eu tenho que ir,  tá dando a hora do meu treino de caratê.",
	"Só mais uma coisa, não sei quem você é e nem como tá aqui, mas toma cuidado nessa bosta de caverna, tem uns bichos chatos demais que provavelmente vão ficar enchendo seu saco caso eles te vejam, então vê se não morre, é só isso."
];

addDialog(dialog, name2, text[0], 0, 0, 0, 1);
addDialog(dialog, name2, text[1], 0, 0, 0, 1);
addDialog(dialog, name2, text[2], 0, 0, 0, 1);
addDialog(dialog, name2, text[3], 0, 0, 0, 1);
addDialog(dialog, name2, text[4], 0, 0, 0, 1);
addDialog(dialog, name2, text[5], 0, 0, 0, 1);
addDialog(dialog, name2, text[6], 0, 0, 0, 1);
addDialog(dialog, name2, text[7], 0, 0, 0, 1);
addDialog(dialog, name2, text[8], 0, 0, 0, 1);


time = 0;
