//alterando o tamanho das luzes deixando elas mais pixeladas
surface_resize(application_surface, 1, 1);
display_set_gui_maximize();
application_surface_draw_enable(false);

vx = 0;
vy = 0;

u_pos = shader_get_uniform(shLight, "u_pos");
u_zz = shader_get_uniform(shLight, "zz");
u_pos2 = shader_get_uniform(shShadow, "u_pos");

vertex_format_begin();
vertex_format_add_position_3d();
vf = vertex_format_end();
vb = vertex_create_buffer(); 

shadowSurface = -1;

function BGbegin(){
	gpu_set_colorwriteenable(1, 1, 1, 0);
}

function BGend(){
	gpu_set_colorwriteenable(1, 1, 1, 1);
}

bglayer = layer_get_id("bg1");
layer_script_begin(bglayer, BGbegin);
layer_script_begin(bglayer, BGend);