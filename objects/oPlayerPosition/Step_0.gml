
var _hp = playerData.hp;
var _oldHp = playerData.oldHp;
var _maxHp = playerData.maxHp;
var _mana = playerData.mana;
var _maxMana = playerData.maxMana;
var _powerCd = playerData.powerCoolDown;
var _lifeShard = playerData.lifeShard;
var _dirx = playerData.dirx;
var _hspd =	clamp(playerData.hspd, -3, 3);
var _vspd =	playerData.vspd < -8 ? -4 : playerData.vspd;

if(instance_exists(oFade) && oFade.stateFade == 1){
	if(!instance_exists(oPlayer) && createPlayer){
		with(instance_create_layer(tx, ty, "player", oPlayer)){
			hp = _hp;
			oldHp = _oldHp;
			maxHp = _maxHp;
			mana = _mana;
			maxMana = _maxMana;
			powerCoolDown = _powerCd;
			lifeShard = _lifeShard;
			dirx = _dirx;
			sprite = sPlayerIdle;
			hspd = _hspd;
			vspd = _vspd;
			
							
			if(global.playerRespwaning){
				state = stateSpawning;
				global.playerRespwaning = false;
			}
		}
	}
	show_debug_message(playerData);
	instance_destroy(oPlayerData);
	instance_destroy(self);
}
