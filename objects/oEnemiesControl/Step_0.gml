
if(room == rmMenu){
	//limpando os ids dos inimigos que já foram mortos
	ds_list_clear(global.deadList);
}

if(check){
	//destruindo os inimigos que já foram mortos
	for(var k = 0; k < ds_list_size(global.deadList); k++){
		instance_destroy(global.deadList[| k]);
	}
	
	//distribuíndo os itens de healing na room
	var _numb = instance_number(oParEnemies);
	if(_numb > 0){
		enemiesList = ds_list_create();

		//cadastrando os inimigos da room em uma grid
		for(var i = 0; i < _numb; i++){
			var _id = instance_find(oParEnemies, i);
			ds_list_add(enemiesList, _id);
			_id.hasLifeShard = false;
		}
	
		//embaralhando a grid
		randomize();
		ds_list_shuffle(enemiesList);
	
		//setando os três primeiros inimigos da grid para carregarem o item
		if(instance_exists(oHealingNumber)){
			for(var i = 0; i < oHealingNumber.itens; i++){
				if(_numb < 3 && i == _numb)
					break;
		
				var _id = enemiesList[| i];
				_id.hasLifeShard = true;
			}
		}
	
		ds_list_destroy(enemiesList);
		check = false;
	}else{
		check = false;
	}
}