text = "Porque tu criou um pop-up vazio?";
op1 = "Porque sou burro";
op2 = "Porque sou o Nicolas Stey";
calllback1 = function(){};
callback2 = function(){};
callbackArray = [];

confirm = 0;	
keyboard_clear(vk_space);
index = 0;
pastIndex = 0;

popupSurface = -1;
time = 0;
transform = 0;
state = 0;
alpha = 0;

text1 = "[c_green1]" + keyboardKeyName(global.playerLeft) + " " + keyboardKeyName(global.playerRight) + ": [/c]" + MENU_MOVE;
text2 = "[c_green1]"+ "Space: " +"[/c]" + MENU_CONFIRM;

msg = createMessage([text1,
					 text2]);
msg.depth = depth -1;