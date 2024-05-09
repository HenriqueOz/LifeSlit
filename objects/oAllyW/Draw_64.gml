display_set_gui_size(GUI_WDITH, GUI_HEIGHT);

if(time-- > 0){
	draw_set_color(c_black);
		draw_rectangle(0, 0, GUI_WDITH, GUI_HEIGHT, false)
	draw_set_color(c_white);
}