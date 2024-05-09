

vspd = 0;
hspd = 0;
spd = 3;

hmove = 0;

state = 0;
timer = 0;

sprite_index = sOrigin;

layer_add_instance("player", self);

//criando a luz
light = instance_create_layer(x, y - sprite_height/2, layer, oLightEntities);
light.scalex = 1.2;
light.scaley = 1.2;
light.oscilation = 20;
light.alpha = 1;
light.intensity = .1;//ente 0 e 1
light.color = c_white;

//luz no fim da sala
var _l = instance_create_layer(room_width, room_height - 80, layer, oLightEntities);
_l.alpha = .1;
_l.scalex = 2;
_l.scaley = 2;

doorLight = _l;

var _a = instance_create_layer(100, room_height - 10, layer, oLightEntities);
_a.alpha = .1;
_a.scalex = 2;
_a.scaley = 2;

holeLight = _a;

//dialogo
line = 0;

name1 = "Garota";
name2 = "????";

//text = [
//	"- Onde é que eu to?\n- Até agora pouco minha mente estava vazia e por algum motivo, estou em outro mundo?",
//	"- É, eu devia tomar mais cuidados com os lugares que eu escolho para dormir",
//	"- Hum?\n - De onde isso veio? Era só o que me restava, perdida, confusa e agora caminhando para insanidade",
//	"- Fique calma garota, você não está maluca - Por mais surreal que essa situação seja-",
//	"- Bom, voz assustadora do além, eu não te vejo, mas te ouço claramente.\n- Poderia aparecer pra gente conversar?",
//	"- Mas eu já estou aqui",
//	"- Não tá não",
//	"- Estou sim, na sua cabeça",
//	"- Tá, então você tá dizendo que você está na minha caabeça?\n- Mesmo comigo não sentido nada em cima dela",
//	"- Eu estou na sua cabeça, mas de uma forma que você não vai conseguir me tocar\n- Digamos que ficamos próximos um do outro"
//];

//port1 = 0;
//port2 = 0;

//var _text_line = 0;

//dialog1 = [0];
//addDialog(dialog1, name1, text[0], 0, port1, port2, 1);
//addDialog(dialog1, name2, text[++_text_line], 0, port1, port2, 2);
//addDialog(dialog1, name1, text[++_text_line], 0, port1, port2, 1);
//addDialog(dialog1, name2, text[++_text_line], 0, port1, port2, 2);
//addDialog(dialog1, name1, text[++_text_line], 0, port1, port2, 1);
//addDialog(dialog1, name2, text[++_text_line], 0, port1, port2, 2);
//addDialog(dialog1, name1, text[++_text_line], 0, port1, port2, 1);
//addDialog(dialog1, name2, text[++_text_line], 0, port1, port2, 2);
//addDialog(dialog1, name1, text[++_text_line], 0, port1, port2, 1);
//addDialog(dialog1, name2, text[++_text_line], 0, port1, port2, 2);

