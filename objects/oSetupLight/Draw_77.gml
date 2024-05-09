draw_clear_alpha(c_teal, 1);

gpu_set_blendmode_ext(bm_one, bm_zero);
draw_surface_ext(application_surface, 0, 0, 1, 1, 0, c_white, 1);
gpu_set_blendmode(bm_normal);