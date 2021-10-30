if (!resize_mode) exit;

global.re_end = ((tmp_re_end - tmp_re_start) * ((event_data[?"posX"] + event_data[?"diffX"]) / room_width)) + tmp_re_start;
global.im_end = ((tmp_im_end - tmp_im_start) * ((event_data[?"posY"] + event_data[?"diffY"]) / room_height)) + tmp_im_start;

resize_mode = false;
redraw_recommended = true;