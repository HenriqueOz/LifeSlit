event_inherited();

//emtidade
grvAcceleration = 1.1;
hspd = 0;
vspd = 0;
spd = 1;

breath = .0008;

//criando a luz
light = instance_create_layer(x, y - sprite_height/2, layer, oLightEntities);
light.scalex = 1.2;
light.scaley = 1.2;  
light.oscilation = 20;
light.alpha = 1;
light.intensity = .1;//ente 0 e 1
light.color = c_white;

left = sPlayerPortrait;
right = sPlayerPortrait;

var _chooseBox1 = function(){
	createChoiceBox(x + 50, self.y - 50, "O que você quer comer?", 
		[
			["Lasanha", -1],
			["Feijão", -1]
		]
	)
}

line = 0;
addDialog(dialog, "[c_lime][wheel]huma[/wheel][/C]", "tu é verde pai", 0, left, right, 1);
addDialog(dialog, "efil", "so nada", 0, left, right, 2);
addDialog(dialog, "[c_lime]huma[/C]", "texto bem, [shake]grande [rainbow]gigante[/rainbow] giga bumbum[/shake] de nenem blaster big tonico com fins de testar a porcaria do string warp pra ver se esse vunvunzela funciona",  0, left, right , 1, _chooseBox1);
 