main_surface = noone;
redraw = false;
redraw_recommended = false;
segment = 0;
time_start = 0;
time_end = 0;

render_speeds = ds_list_create();
log_speed = true;
average = 0;
avg_count = 0;
lowest = 9999999;

fxaa_enable = false;

if (OPTIMIZATIONS) {
	display_set_timing_method(tm_sleep);
	display_set_sleep_margin(1);
}

data = true;

function force_redraw() {
	gml_pragma("forceinline");
	
	redraw = true;
	redraw_recommended = false;
	segment = 0;
	game_set_speed(RENDER_FPS, gamespeed_fps);
	time_start = current_time;
}

function force_reset() {
	if (surface_exists(main_surface)) surface_free(main_surface);
}

function get_average() {
	var i, t, o = 0;
	avg_count = ds_list_size(render_speeds);
	for (i = 0; i < avg_count; i++) {
		t = render_speeds[| i];
		o += t
		if (t < lowest) lowest = t;
	}
	average = o / ds_list_size(render_speeds);
}

resize_mode = false;

tmp_re_start = RE_START;
tmp_im_start = IM_START;
tmp_re_end = RE_END;
tmp_im_end = IM_END;

_new_scale_id = noone;
_new_iter_id = noone;