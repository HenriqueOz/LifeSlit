


width = abs(bbox_left - bbox_right);
blocks = width/32;

timerBlock = 5;
timerCreate = blocks * timerBlock;
t = 0;

image_xscale = 1;//tem que ser aqui, senão caga o calculo de largura
depth--;

if(!variable_global_get(key)){
	timerCreate = 0;
	mask_index = sEmpty;
}





