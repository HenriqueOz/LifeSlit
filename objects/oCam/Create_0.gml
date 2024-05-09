
target = oPlayer;

view_enabled = true;
view_visible = true;

amount = .04;

cam = view_camera[0];
camera_set_view_size(cam, CAM_WIDTH, CAM_HEIGHT);
camera_set_view_pos(cam, 0, 0);
cw = camera_get_view_width(cam);
ch = camera_get_view_height(cam);
 
//screenShake
time = 0;
magnitude = 0;

//zoom
zoom = 0;
smooth = false;
