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
		log_speed = true;
		force_redraw();
		
		break;
	}
}

keyboard_lastkey = -1;