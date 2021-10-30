gml_pragma("forceinline");

if (!surface_exists(main_surface)) {
	main_surface = surface_create(room_width / SCALE, room_height / SCALE);
	force_redraw();
}

if (redraw) {
	surface_set_target(main_surface);
	// if (segment == 0) draw_clear(c_black);
	
	var cr, ci, ms, _x, _y;
	var wid = surface_get_width(main_surface);
	var hei = surface_get_height(main_surface);
	
	for (_y = segment * SEGMENT_HEIGHT; _y < (segment + 1) * SEGMENT_HEIGHT; _y++) {
		for (_x = 0; _x < wid; _x++) {
			cr = RE_START + (_x / wid) * (RE_END - RE_START);
			ci = IM_START + (_y / hei) * (IM_END - IM_START);
			
			ms = mandelbrot(cr, ci);
			
			draw_point_color(_x, _y, make_color_hsv(0,0,(ms / MAX_ITERATIONS) * 255));
		}
	}
	
	surface_reset_target();
	if (segment++ >= hei / SEGMENT_HEIGHT) {
		redraw = false;
		time_end = current_time;
	}
}

draw_surface_stretched(main_surface, 0, 0, room_width, room_height);

if (redraw) exit;

//if (fxaa_enable) shader_set(sha_fxaa);
//draw_surface_stretched(main_surface, 0, 0, room_width, room_height);
//if (fxaa_enable) shader_reset();

if (!redraw) {
	if (game_get_speed(gamespeed_fps) != POST_RENDER_FPS) { game_set_speed(POST_RENDER_FPS, gamespeed_fps); if (log_speed) { ds_list_add(render_speeds, (time_end - time_start)); get_average(); } }
	// data ^= mouse_check_button_pressed(mb_left);
	if (data) {
		draw_set_font(font_bounds);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		var _str = string(time_end - time_start) + "ms to render\nAvg. of default params: " + string(average) + "ms for " + string(avg_count) + " renders\nFastest render: " + string(lowest) + "ms\n"+
			"Scale at " + string(SCALE) + "x, Max iter.: " + string(MAX_ITERATIONS) + 
			"\nRendered at " + string(room_width / SCALE) + "x" + string(room_height / SCALE) +
			"\n\nGM Runtime ver. " + GM_runtime_version + "\nSleep margin: " + string(display_get_sleep_margin()) + 
			"ms\nMax game speed at render: " + string(RENDER_FPS) + "fps," + string(1000000 / RENDER_FPS) + 
			"us\nMax game speed post-render: " + string(POST_RENDER_FPS) + "fps," + string(1000000 / POST_RENDER_FPS) + "us\n\n" +
			(redraw_recommended ? "Redraw required for changes" : "");
		
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
	var _str = "Ctrl-S: Save\nCtrl-R: Force render\nCtrl-E: Resize mode (" + (resize_mode ? "on" : "off") + ")\n" +
			"Ctrl-D: Default params\nCtrl-P: Default and rerender (logs speed for average calculation)\n" +
			"Ctrl-J: Set new scale (causes immediate redraw)\n" +
			"Ctrl-Q: Set new iteration count (causes immediate redraw)";
		
	draw_set_color(c_black);
	for (var i = -1; i < 2; i++) {
		for (var j = -1; j < 2; j++) {
			draw_text(2 + i, room_height - 2 + j, _str);
		}
	}
	
	draw_set_color(c_white);
	draw_text(2, room_height - 2, _str);
	
	var _str = string(((RE_END - RE_START) * (mouse_x / room_width)) + RE_START) + " + " + string(((IM_END - IM_START) * (mouse_y / room_height)) + IM_START) + "i";
	if (resize_mode) _str += "\n" + string(RE_START) + " + " + string(IM_START) + "i\n" + string(RE_END) + " + " + string(IM_END) + "i";
	
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