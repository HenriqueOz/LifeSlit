function Quad(_vb, _x1, _y1, _x2, _y2){
	vertex_position_3d(_vb, _x1, _y1, 0);
	vertex_position_3d(_vb, _x1, _y1, 1);
	vertex_position_3d(_vb, _x2 , _y2, 0);
	
	vertex_position_3d(_vb, _x1, _y1, 1);
	vertex_position_3d(_vb, _x2 , _y2, 0);
	vertex_position_3d(_vb, _x2 , _y2, 1);
	 
} 

vx = camera_get_view_x(oCam.cam);
vy = camera_get_view_y(oCam.cam);

if(mouse_check_button_pressed(mb_left)){
	instance_create_depth(mouse_x, mouse_y, depth, oLight);
}

vertex_begin(vb, vf);
var _vb = vb;

with(oWallLight){
	Quad(_vb, x, y, x + sprite_width, y + sprite_height);
	Quad(_vb, x + sprite_width, y, x, y + sprite_height);
}

vertex_end(vb);