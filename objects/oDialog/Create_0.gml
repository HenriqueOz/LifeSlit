//startando o dialo go
alpha = 0;
dialog = [];
openDialog = true;
closeDialog = false;
line = 0;//linha do dialog em que estamos
overPlayer = false;

//desenhando o texto
dialogSurface = -1;
textX = 0;
textY = 0;
scale = 0;
char = "";
space = 0;
letter = 1;

//valores default
name = "";	
text = "";
snd = 0;
portrait1 = 0;
portrait2 = 0;
speaking = 0;
color = 0;
onClose = -1;

//typewriter
typist = scribble_typist();
typist.in(.3, 2);
typist.ease(SCRIBBLE_EASE.LINEAR,//ease method
	-4, -4, //x, y
	.2, .2, //xscale, yscale
	45,	  //rotation
	.2	  //alpha duration
);
index = 0;
delay = 5;

//bright shader
uniformBright = shader_get_uniform(shBright, "bright");