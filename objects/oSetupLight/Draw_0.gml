var _u_pos = u_pos;
var _u_pos2 = u_pos2;
var _u_zz = u_zz;
var _vb = vb;
var _vx = vx;
var _vy = vy;

if(!surface_exists(shadowSurface)){
	shadowSurface = surface_create(640, 360);
}

matrix_set(matrix_world, matrix_build(-_vx, -_vy, 0, 0, 0, 0, 1, 1, 1));
surface_set_target(shadowSurface);
draw_clear_alpha(c_dkgray, 0);
with(oLight){
	gpu_set_blendmode_ext_sepalpha(bm_zero, bm_one, bm_one, bm_zero);
	shader_set(shShadow);
	shader_set_uniform_f(_u_pos2, x, y);
	vertex_submit(_vb, pr_trianglelist, -1);
	
	gpu_set_blendmode_ext_sepalpha(bm_inv_dest_alpha, bm_one, bm_zero, bm_zero);
	shader_set(shLight);
	shader_set_uniform_f(_u_pos, x, y);
	shader_set_uniform_f(_u_zz, size);
	draw_rectangle_color(_vx, _vy, _vx + 640, _vy + 360, color, color, color, color, false);
}
shader_reset();
gpu_set_blendmode_ext(bm_zero, bm_src_alpha);
draw_surface(application_surface, vx, vy);
surface_reset_target();
matrix_set(matrix_world, matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1));


gpu_set_blendmode_ext(bm_dest_color, bm_inv_dest_alpha);
draw_surface(shadowSurface, _vx, _vy);

shader_reset();
gpu_set_blendmode(bm_normal);
