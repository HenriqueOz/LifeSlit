
if (stateFade == 0) {
	timerFade++;
	global.canPause = false;
	
	if (timerFade >= durationFade) {
		room_goto(targetRoomFade);
		
		stateFade = 1;
	}
}

else if (stateFade == 1) {
	timerFade--;
	global.canPause = true;
	
	if (timerFade <= 0) {
		instance_destroy();
	}
}

alphaFade = timerFade / durationFade;