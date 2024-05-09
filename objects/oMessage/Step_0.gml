
var _col = instance_place(x, y, oPlayer);
if(_col && inGame){
	alpha += .1;
}else if(!_col && inGame){
	alpha -= .1;
}

if(!inGame){
	alpha += .1;
}

alpha = clamp(alpha, 0, 1);