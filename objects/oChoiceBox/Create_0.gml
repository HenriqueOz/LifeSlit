msg = createMessage(["[c_green1]" + keyboardKeyName(global.playerUp) + " " + keyboardKeyName(global.playerDown) + ": [/c]" + MENU_MOVE,
					 "[c_green1]"+ "Space: " +"[/c]" + MENU_CONFIRM ]);


boxSurface = -1;
time = 0; 
state = 0;
transform = 0;

label = "";
options = [];

index = 0;
pastIndex = 0;
keyConfirm = 0;
getHugeString = true;  
stringWidth = 0;
