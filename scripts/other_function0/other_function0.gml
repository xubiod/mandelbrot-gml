function other_function0(_px, _py) {
	// ported from https://en.wikipedia.org/wiki/Mandelbrot_set#Computer_drawings
	gml_pragma("forceinline");
	
	var _xtmp = 0;
	var _x = 0;
	var _y = 0;
	var n = 0;
	
	var _x2 = 0; var _y2 = 0;
	
	while (((_x2 + _y2)) <= 4 && n < MAX_ITERATIONS) {
		_x2 = _x * _x;
		_y2 = _y * _y;
		_xtmp = _x2 - _y2 + _px;
		_y = _x * (_y << 1) + _py;
		_x = _xtmp;
		n++;
	}
	
	return n;
}