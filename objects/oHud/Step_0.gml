 if(!global.showHud && alpha > 0){
	alpha -= alphaDec * 3;
}

if(global.showHud && alpha < 1){
	alpha += alphaDec;
}

manaTimer--;