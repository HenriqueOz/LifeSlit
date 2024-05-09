
confirm = 0; 
canControl = true;// mudar pra false
stepAnimation = 0;// mudar pra 0
transform = 0;// mudar pra 0
transform2 = 0;// mudar pra 0
t = 0;

buttons = array_create(4, [
	MENU_START[0],
	MENU_START[1],
	MENU_START[2],
	MENU_START[3]
	]
);


btnLength = array_length(buttons);
index = 0;
pastIndex = 0;

btnPlay = function(){
	self.canControl = false;
	fadeToRoom(rmSave, 30, c_black);
}

btnOptions = function(){
	self.canControl = false;
	instance_create_depth(0, 0, 0,oConfig);
}

btnCredits = function(){
	self.canControl = false;//apagar isso quando houver uma room de option
	
	var _onClose = function(){
		self.canControl = true;
		return;
	}
	
	var _title = "";
	var _content = "[c_green1]"+MENU_CREDITS[0]+"[/c]\nPedro\n\n[c_green1]"+MENU_CREDITS[1]+"[/c]\nNicolas\nPedro\n\n[c_green1]"+MENU_CREDITS[2]+"[/c]\nLucas\n\n[c_green1]"+MENU_CREDITS[3]+"[/c]\nGuinter\nIsabelly\n\n[c_green1]"+MENU_CREDITS[4]+"[/c]\nJuros\nGil Noga\nJuju Adams (Scribble)\nMatheus (Trailer)";
	
	createFullMessage(_title, _content, _onClose);
}

btnExit = function(){
	self.canControl = false;
	create_popup(MENU_EXIT, MENU_POPUP[1], MENU_POPUP[0], function(){
		self.canControl = true;
		return;
	}, 
	function(){
		game_end();
	});
}

buttonFunctions = [
	btnPlay,
	btnOptions,
	btnCredits,
	btnExit
];

oMusic.music = snMenuMusic;	


