gml_pragma("forceinline");

if (!surface_exists(main_surface)) {
	main_surface = surface_create(room_width / __DEFAULT_SCALE, room_height / __DEFAULT_SCALE);
	force_redraw();
}

if (redraw) {
	surface_set_target(main_surface);
	// if (segment == 0) draw_clear(c_black);
	
	var cr, ci, ms, _x, _y;
	var wid = room_width / __DEFAULT_SCALE;
	var hei = room_height / __DEFAULT_SCALE;
	
	for (_y = segment * __DEFAULT_SEGMENT_HEIGHT; _y < (segment + 1) * __DEFAULT_SEGMENT_HEIGHT; _y++) {
		for (_x = 0; _x < wid; _x++) {
			cr = __DEFAULT_RE_START + (_x / wid) * (__DEFAULT_RE_END - __DEFAULT_RE_START);
			ci = __DEFAULT_IM_START + (_y / hei) * (__DEFAULT_IM_END - __DEFAULT_IM_START);
			
			ms = mandelbrot_maxperf(cr, ci);
			
			draw_point_color(_x, _y, make_color_hsv(0,0,(ms / __DEFAULT_MAX_ITERATIONS) * 255));
		}
	}
	
	surface_reset_target();
	if (segment++ >= hei / __DEFAULT_SEGMENT_HEIGHT) {
		redraw = false;
		time_end = current_time;
	}
}

if (redraw) exit;

draw_surface_stretched(main_surface, 0, 0, room_width, room_height);

//if (fxaa_enable) shader_set(sha_fxaa);
//draw_surface_stretched(main_surface, 0, 0, room_width, room_height);
//if (fxaa_enable) shader_reset();

if (!redraw) {
	if (game_get_speed(gamespeed_fps) != __DEFAULT_POST_RENDER_FPS) { game_set_speed(__DEFAULT_POST_RENDER_FPS, gamespeed_fps); if (log_speed) { ds_list_add(render_speeds, (time_end - time_start)); get_average(); } }
	// data ^= mouse_check_button_pressed(mb_left);
	if (data) {
		draw_set_font(font_bounds);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		var _str = "Max performance mode (all constants)\n" + string(time_end - time_start) + "ms to render\n" +
			"Avg. of default params: " + string(average) + "ms for " + string(avg_count) + " renders\nFastest render: " + string(lowest) + "ms\n"+
			"Scale at " + string(__DEFAULT_SCALE) + "x, Max iter.: " + string(__DEFAULT_MAX_ITERATIONS) + 
			"\nRendered at " + string(room_width / __DEFAULT_SCALE) + "x" + string(room_height / __DEFAULT_SCALE) +
			"\n\nGM Runtime ver. " + GM_runtime_version + "\nSleep margin: " + string(display_get_sleep_margin()) + 
			"ms\nMax game speed at render: " + string(__DEFAULT_RENDER_FPS) + "fps," + string(1000000 / __DEFAULT_RENDER_FPS) + 
			"us\nMax game speed post-render: " + string(__DEFAULT_POST_RENDER_FPS) + "fps," + string(1000000 / __DEFAULT_POST_RENDER_FPS) + "us";
		
		draw_set_color(c_black);
		for (var i = -1; i < 2; i++) {
			for (var j = -1; j < 2; j++) {
				draw_text(2 + i, 2 + j, _str);
			}
		}
	
		draw_set_color(c_white);
		draw_text(2, 2, _str);
	}
	
	draw_set_color(c_black);
	draw_set_font(font_bounds);
	
	#region bounds
	for (var i = -1; i < 2; i++) {
		for (var j = -1; j < 2; j++) {
			draw_set_halign(fa_left);
			draw_set_valign(fa_center);
			draw_text(2 + i, room_height/2 + j, RE_START);
			
			draw_set_halign(fa_right);
			draw_set_valign(fa_center);
			draw_text(room_width - 2 + i, room_height/2 + j, RE_END);
			
			draw_set_halign(fa_middle);
			draw_set_valign(fa_top);
			draw_text(room_width/2 + i, 2 + j, IM_START);
			
			draw_set_halign(fa_middle);
			draw_set_valign(fa_bottom);
			draw_text(room_width/2 + i, room_height - 2 + j, IM_END);
		}
	}
	
	draw_set_color(c_white);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_center);
	draw_text(2, room_height/2, RE_START);
	
	draw_set_halign(fa_right);
	draw_set_valign(fa_center);
	draw_text(room_width - 2, room_height/2, RE_END);
	
	draw_set_halign(fa_middle);
	draw_set_valign(fa_top);
	draw_text(room_width/2, 2, string(IM_START) + "i");
	
	draw_set_halign(fa_middle);
	draw_set_valign(fa_bottom);
	draw_text(room_width/2, room_height - 2, string(IM_END) + "i");
	#endregion
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_bottom);
	var _str = "Ctrl-S: Save\nCtrl-R: Force render";// + "Ctrl-F: Toggle FXAA shader on postrender (" + (fxaa_enable ? "on" : "off") + ")";
		
	draw_set_color(c_black);
	for (var i = -1; i < 2; i++) {
		for (var j = -1; j < 2; j++) {
			draw_text(2 + i, room_height - 2 + j, _str);
		}
	}
	
	draw_set_color(c_white);
	draw_text(2, room_height - 2, _str);
	
	var _str = string(((__DEFAULT_RE_END - __DEFAULT_RE_START) * (mouse_x / room_width)) + __DEFAULT_RE_START) + " + " + string(((__DEFAULT_IM_END - __DEFAULT_IM_START) * (mouse_y / room_height)) + __DEFAULT_IM_START) + "i";
	
	var _x = min(mouse_x, room_width - string_width(_str) - 4);
	var _y = max(mouse_y, string_height(_str) + 4);
		
	draw_set_color(c_black);
	for (var i = -1; i < 2; i++) {
		for (var j = -1; j < 2; j++) {
			draw_text(_x + i, _y + j, _str);
		}
	}
	
	draw_set_color(c_white);
	draw_text(_x, _y, _str);
}
// draw_surface_part_ext(main_surface, (mouse_x / SCALE) - 16, (mouse_y / SCALE) - 16, 32, 32, mouse_x - (16 * SCALE), mouse_y - (16 * SCALE), 4, 4, c_white, 1);