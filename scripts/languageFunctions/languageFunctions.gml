
function changeLang(_lang){
	switch(global.language){
		case(EN):
			global.strMenu = ["START", "SETTINGS", "CREDITS", " EXIT "];
			global.strOptions = [
				"GENERAL", "Fullscreen", "Language",
				"SOUND", "Main Volume", "Music Volume", "Effects Volume",
				"CONTROLS", "Right", "Left", "Up", "Down", "Jump", "Dash", "Float", "Attack", "Cast", "Use Item", "Intertact",
				"Restore Defaults", "Back",
				"Settings"];
			global.strBool = ["On", "Off"];
			global.strPressKey = "Press a Key";
			global.strPopup = ["Yes", "No ", "Ok"];
			global.strExit = "Are you sure you want to exit?";
			global.strBackToMenu = "Return to title screen?";
			global.strApply = "Apply Changes?";
			global.strRestoreConfig = "Restore settings to default?";
			global.strInUseKey = ["The key ", " is already in use"];
			global.strPause = ["Continue", "Settings", "Return to Title Screen"];
			global.strSaveFiles = ["Save 1", "Save 2", "Save 3", "New Game"];
			global.strSaveOption = ["Load", "Delete", "Start"];
			global.strBack = "Back";
			global.strSaveMessage = "Save Progress?";
			global.strSavePop = "Game Saved";
			global.strMove = "Move";
			global.strConfirm = "Confirm";
			global.strClose = "Close";
			global.strDeleteSave = ["Are you sure you want do delete ",  "?. You can't revert this action"];
			global.strCredits = ["Programmer and Artist", "Level Design", "Musics and Sound Effects", "Documentation and Texts", "Special Thanks"];
			//////////////////////////////////
			global.strAlly1 = [
				"AH[delay, 500], hey stranger![delay, 500] What are you doing here ?!?",
				"You don't speak too much, right?[delay, 500] Well, I am Ally![delay, 500] Nice too meet you",
				"I don't know why you are here[delay, 500], but I am here to serach for old notes",
				"There is a rumor in my village that an old writer came to a strange cavern and left some of his notes in her[delay, 500], and this cavern looks really strange to me",
				"If you find a note tell to me[delay, 500], I would be happy",
				"Ah, apparently he hid his notes very well[delay, 500], I remeber they have said that they are hidden in secretes rooms",
				"[shake]UNTIL LATER[/shake]"
			];
			global.strAlly2 = [
				"AH! Hi again Mistress Silence. [delay, 500]For some reasons those red platforms started to moving[delay, 500], Do you did something?",
				"I had forgot[delay, 500], you don't speak.[delay, 500] Well[delay, 500], I will take this as a yes.",
				"I have not finded any note yet[delay, 500], but this place have some weak walls[delay, 500], anyway, I am not stronger enough to do something about it.",
				"You was looking busy[delay, 500], see you later[delay, 500]",
				"[shake]BYE[/shake]!"
			];
			global.strAlly3 =  [
				"Are you chasing me?![delay, 500] Just joking, but we have meet each other often, right?",
				"I have stopped searching for the notes[delay, 500], it is a really hard job to do",
				"Now I am in this bizarre blue cavern[delay, 500], the red one scared me, but this one is a way creepier than the other",
				"I will stay here and think about my situation",
				"[shake]GOOD BYE[/shake]!"
			]
			global.strAlly4 = [
				"I never tought see your face will make me happy, Mrs Silence",
				"I have reached this place, and here is really lovely when you look to the other ones",
				"I am considering lay on this grass and sleep!",
				"Well, i have looked the upper part, but there is a shiny wall who blocks my way",
				"I will try to do what i was doing before[delay, 500], dig tunnels!",
				"If every thing goes finy, I meet you there",
				"[shake]BYE BYE[/shake]!"
			];
			global.strAlly5 = [
				"Digging holes is really funny!",
				"This earthquakes closed them[delay, 500], so i can't go back through them",
				"You look really tired[delay, 500], Are you okay?",
				"I think I am",
				"DID YOU SPEAKS?!?!!!! YOU CAN SPEAK?!?!!!!!!!![delay, 500]",
				"I AM FREAKING",
				"Right[delay, 500], stay calm...",
				"You have asked before... My name is Huma",
				"Huma...",
				"...",
				"Thank you for remember[dealy, 500]. You look tired, go and find some place to rest",
				"[shake]HASTA LUEGO[delay, 500], [c_green1]HUMA[/c][/shake]!"
			];
			////////////////////////////////
			global.strBook1 = "??/??/20\n\nI vaguely remember seeing a light before suddenly waking up in this place, I don't know exactly what I was doing, but I know that this place doesn't smell good, it's really stinky and humid here .\nAccording to my expert analysis, this place is a strange, very strange cave.\nI found an isolated and safe place, at least it seems like it. I'll rest here and take a look at the surroundings later.\nSomehow I came back in one piece. I came across some creatures, somewhat exotic, but I had a good time. None of them attacked me, which surprises me, since the concentration of life in them is low, so theoretically they should be hostile.\nI decided to leave my notes stored in these resting places, maybe someone will find them.\n\nAss. BB";
		break;
		
		case(PTBR):
			global.strMenu = ["JOGAR", "OPÇÕES", "CRÉDITOS", " SAIR "];
			global.strOptions = [
				"GERAL", "Tela Cheia", "Linguagem",
				"SOM", "Volume Principal", "Volume da Música", "Volume dos Efeitos",
				"CONTROLES", "Direita", "Esquerda", "Cima", "Baixo", "Pular", "Esquiva", "Planar", "Ataque", "Magia", "Usar Item", "Interagir",
				"Restaurar Padrões", "Voltar",
				"Configurações"];
			global.strBool = ["Ligado", "Desligado"];
			global.strPressKey = "Pressione Uma Tecla";
			global.strPopup = ["Sim", "Não", "Ok"];
			global.strExit = "Você tem certeza de que deseja sair?";
			global.strBackToMenu = "Voltar a tela inicial?";
			global.strApply = "Aplicar Alterações?";
			global.strRestoreConfig = "Restaurar configuraçõs ao padrão?";
			global.strInUseKey = ["A tecla ", " já está em uso"];
			global.strPause = ["Continuar", "Opções", "Voltar ao Menu"];
			global.strSaveFiles = ["Jogo 1", "Jogo 2", "Jogo 3", "Novo Jogo"];
			global.strSaveOption = ["Carregar", "Excluir", "Iniciar"];
			global.strBack = "Voltar";
			global.strSaveMessage = "Salvar o Progresso?";
			global.strSavePop = "Jogo Salvo";
			global.strMove = "Mover";
			global.strConfirm = "Confirmar";
			global.strClose = "Fechar";
			global.strDeleteSave = ["Tem certeza de que deseja excluir o progresso de ",  "?. Não será possível reverter está ação"];
			global.strCredits = ["Programação e Arte", "Level Design", "Músicas e Efeitos Sonoros", "Documentação e Textos", "Agradecimentos"];
			/////////////////////////////////////
			global.strAlly1 = [
				"AH[delay, 500], eai forasteira![delay, 500] O que faz por aqui ?!?",
				"Você não é de falar muito né?[delay, 500] Bom, eu me chamo Ally![delay, 500] Prazer em te conhecer",
				"Não sei porque você está aqui[delay, 500], mas eu vim até esse buraco pra procurar notas antigas",
				"Existe um rumor na minha vila de que um antigo escritor deixou notas em uma caverna exótica[delay, 500], e essa caverna parece bem exótica pra mim",
				"Caso você encontre alguma escritura dele me avise[delay, 500], vou ficar feliz",
				"Ah, aparentemente ele escondia elas muito bem[delay, 500], em salas escondidas no caso",
				"[shake]ATÉ MAIS[/shake]"
			];
			global.strAlly2 = [
				"AH! Oi de novo senhorita silenciosa. [delay, 500]Do nada aquelas plataformas vermelhas na sala que eu estava começaram a se mover[delay, 500], você fez algo?",
				"Verdade[delay, 500], você não fala nada.[delay, 500] Bom[delay, 500], vou levar como um sim.",
				"Ainda não encontrei nenhuma anotação[delay, 500], mas parece que existem umas paredes meio frágeis nesse lugar[delay, 500], mas meus braços não são bons com armas pra cavar elas.",
				"Você parecia ocupada[delay, 500], então nos vemos depois[delay, 500]",
				"[shake]TCHAU[/shake]!"
			];
			global.strAlly3 =  [
				"Você tá me perseguindo?![delay, 500] Só brincando, mas a gente tá se encontrando bastante até",
				"Eu decidi parar de procurar os livros que eu tinha falado[delay, 500], muito difícil de achar",
				"E ainda por cima vim parar aqui nesse buraco azul[delay, 500], o vermelho já me dava medo, mas agora essa aqui me assuta",
				"Vou ficar aqui um pouco e pensar no que fazer",
				"[shake]TÉ MAIS[/shake]!"
			]
			global.strAlly4 = [
				"Nunca achei que fosse ficar feliz ao ver sua cara, senhorita silêncio",
				"Consegui chegar nesse lugar, aqui é bem mais aconchegante do que os outros que a gente se encontrou",
				"Da até vontade de dormir nessa graminha!",
				"Bom, eu consegui dar uma olhadinha lá em cima, mas tem uma parede brilhante que não me deixa passar",
				"Vou tentar fazer o que eu estava fazendo antes[delay, 500], cavar túneis!",
				"Se tudo der certo a gente se encontra lá em cima",
				"[shake]BYE BYE[/shake]!"
			]
			global.strAlly5 = [
				"Minha ideia de cavar buracos deu certo!",
				"Só que esses tremores que deram fecharam eles[delay, 500], então só me resta sair daqui mesmo",
				"Você parece meio acabadinha[delay, 500], tá tudo bem?",
				"Acho que sim",
				"VOCÊ FALOU!!!!! VOCÊ SABE FALAR!!!!!!!!![delay, 500]",
				"EU VOU SURTAR",
				"Tá[delay, 500], me acalmei...",
				"Você tinha perguntado aquela hora... Eu me chamo Huma",
				"Huma...",
				"...",
				"Obrigado por me falar seu nome[dealy, 500]. Você parece ocupada, então vou te deixar ir",
				"[shake]SE CUIDA[delay, 500], [c_green1]HUMA[/c][/shake]!"
			];
			///////////////////////////
			global.strBook1 = "??/??/20\n\nLembro vagamente de ter visto uma luz antes de acordar repentinamente nesse lugar, não sei ao certo o que eu estava fazendo, mas sei que esse lugar não cheira bem, aqui é realmente bem fedido e úmido.\nSegundo minhas análises de especialista, esse local é uma caverna, estranha, bem estranha.\nEncontrei um lugar isolado e seguro, pelo menos parece. Vou descansar por aqui e dar uma olhada no ambiente depois.\nDe alguma forma voltei inteiro. Me deparei com algumas criaturas, um tanto quanto exóticas, mas passo bem. Nenhuma delas me atacou, o que me surpreende, já que a concentração de vida nelas é baixa, então teoricamente elas deveriam ser hostis.\nDecidi deixar minhas notas guardadas nesses lugares de descanso, talvez alguém encontre.\n\nAss. BB";
		break;
	}
	
	#macro MENU_START		global.strMenu//botões do menu principal
	#macro MENU_OPTIONS		global.strOptions//opções/configurações
	#macro MENU_BOOL		global.strBool//ligado ou desligado
	#macro MENU_PRESS_KEY	global.strPressKey//pressione uma tecla
	#macro MENU_POPUP		global.strPopup//sim, não, ok
	#macro MENU_EXIT		global.strExit//deseja sair do jogo
	#macro MENU_GO_TOMENU	global.strBackToMenu//deseja voltar ao menu
	#macro MENU_APLLY		global.strApply//aplicar alterções
	#macro MENU_RESTORE		global.strRestoreConfig//restaurar configurações
	#macro MENU_IN_USE_KEY	global.strInUseKey//tecla já em uso
	#macro MENU_PAUSE		global.strPause//bot]oes do pause
	#macro MENU_SAVE_FILES	global.strSaveFiles//nome dos saves e do save vazio
	#macro MENU_SAVE_OP		global.strSaveOption//excluir ou carregar save
	#macro MENU_BACK		global.strBack//voltar
	#macro MENU_SAVE_MSG	global.strSaveMessage//opções do menu de salvamento dentro do jogo
	#macro MENU_SAVE_POP	global.strSavePop//overlay dizendo que o jogo foi salvo
	#macro MENU_CONFIRM		global.strConfirm
	#macro MENU_MOVE		global.strMove
	#macro MENU_CLOSE		global.strClose
	#macro MENU_DELETE		global.strDeleteSave
	#macro MENU_CREDITS		global.strCredits
	
	#macro DIALOG_ALLY1		global.strAlly1
	#macro DIALOG_ALLY2		global.strAlly2
	#macro DIALOG_ALLY3		global.strAlly3
	#macro DIALOG_ALLY4		global.strAlly4
	#macro DIALOG_ALLY5		global.strAlly5
	
	#macro BOOK1			global.strBook1
}