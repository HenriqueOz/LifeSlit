
// Inherit the parent event
event_inherited();

if(inInteraction && !instance_exists(msg)){
	msg = createFullMessage(title, content, onClose);
}

y += sin(current_time/500) * .1;

