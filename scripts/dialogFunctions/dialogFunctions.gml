//pegando a array da instância desejada que armazena os dialogos
function createDialog(_data){
	if(!instance_exists(oDialog)){
		with(instance_create_depth(x, y, depth - 1, oDialog)){
			dialog = _data;
		}
	}
}

function addDialog(_data, _name, _text, _snd, _port1, _port2, _speaking, _onClose = -1){
	_data[line] = {
		name : _name != "" ? _name : "",
		text : _text != "" ? _text : "",
		snd : _snd != 0 ? _snd : 0,
		portrait1 : _port1 != asset_sprite ? _port1 : 0,
		portrait2 : _port1 != asset_sprite ? _port2: 0,
		speaking : _speaking != 0 ? _speaking : 1,
		onClose : _onClose != -1 ? _onClose : -1
	}
	line++;
}
