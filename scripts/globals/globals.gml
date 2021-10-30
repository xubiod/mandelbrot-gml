function globals(){
	gml_pragma("global", "globals()");
	
	global.__default_max_iterations = __DEFAULT_MAX_ITERATIONS;
	
	global.__default_re_start = __DEFAULT_RE_START;
	global.__default_re_end = __DEFAULT_RE_END;
	
	global.__default_im_start = __DEFAULT_IM_START;
	global.__default_im_end = __DEFAULT_IM_END;
	
	global.__default_segment_height = __DEFAULT_SEGMENT_HEIGHT;
	global.__default_render_scale = __DEFAULT_SCALE;
	
	global.__default_render_fps = __DEFAULT_RENDER_FPS;
	global.__default_post_render_fps = __DEFAULT_POST_RENDER_FPS;
	
	global.max_iterations = global.__default_max_iterations;
	global.re_start = global.__default_re_start;
	global.re_end = global.__default_re_end;
	global.im_start = global.__default_im_start;
	global.im_end = global.__default_im_end;
	global.segment_height = global.__default_segment_height;
	global.render_scale = global.__default_render_scale;
	
	global.render_fps = global.__default_render_fps;
	global.post_render_fps = global.__default_post_render_fps;
}

function default_globals() {
	global.max_iterations = global.__default_max_iterations;
	global.re_start = global.__default_re_start;
	global.re_end = global.__default_re_end;
	global.im_start = global.__default_im_start;
	global.im_end = global.__default_im_end;
	global.segment_height = global.__default_segment_height;
	global.render_scale = global.__default_render_scale;
	
	global.render_fps = global.__default_render_fps;
	global.post_render_fps = global.__default_post_render_fps;
}