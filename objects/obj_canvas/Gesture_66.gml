if (!resize_mode) exit;

tmp_re_start = RE_START;
tmp_im_start = IM_START;
tmp_re_end = RE_END;
tmp_im_end = IM_END;

global.re_start = ((tmp_re_end - tmp_re_start) * (event_data[?"posX"] / room_width)) + tmp_re_start;
global.im_start = ((tmp_im_end - tmp_im_start) * (event_data[?"posY"] / room_height)) + tmp_im_start;