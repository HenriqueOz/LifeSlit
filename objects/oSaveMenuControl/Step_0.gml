
slot1 = global.saveExists1 ? MENU_SAVE_FILES[0] : emptySlot;
slot2 = global.saveExists2 ? MENU_SAVE_FILES[1] : emptySlot;
slot3 = global.saveExists3 ? MENU_SAVE_FILES[2] : emptySlot;

if(canControl){
	index += keyboard_check_pressed(ord("S")) - keyboard_check_pressed(ord("W"));
	keyConfirm = keyboard_check_pressed(vk_space);
	keyDelete = keyboard_check_pressed(ord("V"));
	
	index = index > 3 ? 0 : (index < 0 ? 3 : index);
	
	if(pastIndex != index){
			audio_play_sound(snMenuOption, 1, 0);
		pastIndex = index;
	}
	
	//carregando save
	if(index <= 2 && keyConfirm){
		canControl = false;
		global.saveId = index;
		
		if(!audio_is_playing(snSelectPlay))
				audio_play_sound(snSelectPlay, 1, 0);
		
		//checando se o save existe
		if(global.saveExistsArray[global.saveId]){
			load();
		}else{
			//se não existir ele carrega a cutscene inicial
			fadeToRoom(rmCave00, 120, c_black);
		}
	}
	
	//deletando save
	if(index <= 2 && keyDelete && global.saveExistsArray[index]){
		canControl = false;
		
		var _save = slotStrings[index];
		var _label = MENU_DELETE[0] + "[c_green1]"+_save+"[/c]" + MENU_DELETE[1];
		var _del = function(){
			var _file = global.saveNameArray[index];
			file_delete(_file);
			self.slotStrings[index] = self.emptySlot;
			self.canControl = true;
			return;
		}
		
		var _cancel = function(){
			self.canControl = true;
			return;
		}
		
		create_popup(_label, MENU_POPUP[1], MENU_POPUP[0], _cancel, _del);
	}
	
	//voltando pro menu
	if(index == 3 && keyConfirm){
		if(!audio_is_playing(snSelect))
				audio_play_sound(snSelect, 1, 0);
		
		canControl = false;
		fadeToRoom(rmMenu, 30, c_black);
	}
}