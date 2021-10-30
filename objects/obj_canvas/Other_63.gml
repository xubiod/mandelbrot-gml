var i_d = ds_map_find_value(async_load, "id");
switch (i_d) {
	case _new_scale_id: {
		if (ds_map_find_value(async_load, "status")) SCALE = clamp(ds_map_find_value(async_load, "value"), 0.25, 256);
		force_reset();
		break;
	}
	
	case _new_iter_id: {
		if (ds_map_find_value(async_load, "status")) MAX_ITERATIONS = clamp(ds_map_find_value(async_load, "value"), 8, 240);
		force_reset();
		break;
	}
	
	default: {
		break;
	}
}