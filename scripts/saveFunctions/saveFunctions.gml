function save(){
	//limpando os ids dos inimigos que já foram mortos
	ds_list_clear(global.deadList);
	
	var _saveStruct = {
		player : {
			maxHp : global.maxHp,	
			x : oPlayer.x,
			y : oPlayer.y,
			room : room
		},
		
		f : {
			f1 : global.flagCutcene1
		},
		
		w : {
			w1 : global.fakeWall1,
			w2 : global.fakeWall2,
			w3 : global.fakeWall3,
			w4 : global.fakeWall4,
			w5 : global.fakeWall5,
			w6 : global.fakeWall6,
			w7 : global.fakeWall7,
			w8 : global.fakeWall8,
			w9 : global.fakeWall9,
			w10 : global.fakeWall10
		},
		
		a : {
			a1 : global.playerAbiliteDash,
			a2 : global.playerAbiliteFly,
			a3 : global.playerAbiliteClimb,
			a4 : global.playerAbilitePower
		},
		
		h : {
			h1 : global.playerHp1,
			h2 : global.playerHp2,
			h3 : global.playerHp3,
			h4 : global.playerHp4
		},
		
		l : {
			l1 : global.lever1,
			l2 : global.lever2,
			l3 : global.lever3,
			l4 : global.lever4,
			l5 : global.lever5
		},
		
		k : {
			k1 : global.key1,
			k2 : global.key2,
			k3 : global.key3,
			k4 : global.key4,
			k5 : global.key5,
		},
		
		b : global.urielAlive
	}	
	
	//save automático após a queda da cutscene 2
	if(room == rmCave03){
		_saveStruct.player.x = 287;
		_saveStruct.player.y = 320;
		_saveStruct.player.room = rmCave04;
	}
	
	var _json = json_stringify(_saveStruct);
	saveString(_json, global.saveNameArray[global.saveId]);
}


function load(){
	//limpando os ids dos inimigos que já foram mortos
	ds_list_clear(global.deadList);
	
	var _json = loadString(global.saveNameArray[global.saveId]);
	var _saveStruct = json_parse(_json);
	
	//setando as cutscenes que já aconteceram
	var _flagData = _saveStruct.f;
	global.flagCutcene1 = _flagData.f1;
	
	//fake walls que já foram abertas
	var _wallData = _saveStruct.w;
	global.fakeWall1 = _wallData.w1;
	global.fakeWall2 = _wallData.w2;
	global.fakeWall3 = _wallData.w3;
	global.fakeWall4 = _wallData.w4;
	global.fakeWall5 = _wallData.w5;
	global.fakeWall6 = _wallData.w6;
	global.fakeWall7 = _wallData.w7;
	global.fakeWall8 = _wallData.w8;
	global.fakeWall9 = _wallData.w9;
	global.fakeWall10 = _wallData.w10;
	
	//player abilities
	var _abiliteData = _saveStruct.a;
	global.playerAbiliteDash = _abiliteData.a1;
	global.playerAbiliteFly = _abiliteData.a2;
	global.playerAbiliteClimb = _abiliteData.a3;
	global.playerAbilitePower = _abiliteData.a4;
	
	//player Hp
	var _hpData = _saveStruct.h;
	global.playerHp1 = _hpData.h1;
	global.playerHp2 = _hpData.h2;
	global.playerHp3 = _hpData.h3;
	global.playerHp4 = _hpData.h4;
	
	//alavancas puxadas
	var _leverData = _saveStruct.l;
	global.lever1 = _leverData.l1;
	global.lever2 = _leverData.l2;
	global.lever3 = _leverData.l3;
	global.lever4 = _leverData.l4;
	global.lever5 = _leverData.l5;
	
	//keys pegas
	var _keyData = _saveStruct.k;
	global.key1 = _keyData.k1;
	global.key2 = _keyData.k2;
	global.key3 = _keyData.k3;
	global.key4 = _keyData.k4;
	global.key5 = _keyData.k5;
	
	//boss vivo
	global.urielAlive = _saveStruct.b;
	
	//warpando o player
	global.playerRespwaning = true;
	var _playerData = _saveStruct.player;
	global.maxHp = _playerData.maxHp;
	warp(_playerData.x, _playerData.y, _playerData.room, 30, true);
}
 
//gravando uma string como um buffer
function saveString(_string, _file){
	//reservando memória para criar o arquivo de save
	var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
	//escrevendo o arquivo de save
	buffer_write(_buffer, buffer_string, _string);
	//gravandono armazenamento do root o arquivo de save
	buffer_save(_buffer, _file);
	//apagando a memória alocada para criação do save
	buffer_delete(_buffer);
} 

//lendo uma string armazenada em um buffer
function loadString(_file){
	//carregando o buffer
	var _buffer = buffer_load(_file);
	//lendo os dados armazenados no buffer
	var _string = buffer_read(_buffer, buffer_string);
	
	//apagando memória alocada pelo buffer
	buffer_delete(_buffer);
	//retornando as informções que foram lidas no buffer
	return _string;
}