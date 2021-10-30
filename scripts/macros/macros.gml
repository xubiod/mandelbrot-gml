function macros(){
	#macro MAX_ITERATIONS global.max_iterations
	
	#macro RE_START global.re_start
	#macro RE_END global.re_end
	#macro IM_START global.im_start
	#macro IM_END global.im_end
	
	#macro SEGMENT_HEIGHT global.segment_height
	#macro SCALE global.render_scale
	
	#macro RENDER_FPS global.render_fps
	#macro POST_RENDER_FPS global.post_render_fps
	
	#macro __DEFAULT_MAX_ITERATIONS 80
	
	#macro __DEFAULT_RE_START -2
	#macro __DEFAULT_RE_END 1
	#macro __DEFAULT_IM_START -1
	#macro __DEFAULT_IM_END 1
	
	#macro __DEFAULT_SEGMENT_HEIGHT 1
	#macro __DEFAULT_SCALE 1
	
	#macro __DEFAULT_RENDER_FPS 960
	#macro __DEFAULT_POST_RENDER_FPS 60
	
	#macro OPTIMIZATIONS true
	
	gml_pragma("UnityBuild", "true");
}