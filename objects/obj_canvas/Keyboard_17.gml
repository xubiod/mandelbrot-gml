if (redraw) exit;

switch (keyboard_lastkey) {
	case ord("S"): {
		var fn = get_save_filename("PNGs|*.png", "canvas.png");
	
		if (fn != "") {
			surface_save(main_surface, fn);
		}
		
		break;
	}
	
	case ord("R"): {
		log_speed = false;
		force_redraw();
		
		break;
	}
	
	case ord("E"): {
		resize_mode ^= true;
		
		break;
	}
	
	case ord("D"): {
		default_globals();
		redraw_recommended = true;
		
		break;
	}
	
	case ord("P"): {
		default_globals();
		force_reset();
		log_speed = true;
		
		break;
	}
	
	case ord("Q"): {
		_new_iter_id = get_integer_async("New iteration count? [4, 240]", MAX_ITERATIONS);
		log_speed = false;
		
		break;
	}
	
	case ord("J"): {
		_new_scale_id = get_integer_async("New scale? (think about it like pixel size)\nThis is capped between 0.25x (renders 4 times as much) and 256 (one pixel is 256px wide and tall)", SCALE);
		log_speed = false;
		
		break;
	}
}

keyboard_lastkey = -1;