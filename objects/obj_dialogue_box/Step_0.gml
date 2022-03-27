key_p_enter = keyboard_check_pressed(vk_enter);
text_fast_write = keyboard_check(ord("X"));
var t = state_timer++;
switch (state) {
	#region Open Dialogue Box
	case diag_states.open_box:
		// SNES
		if (box_mode == box_modes.snes) {
			// Increase size
			width = clamp(width + box_speed, 0, surf_width);
			height = clamp(height + box_speed, 0, surf_height);
			// Change
			if (width == surf_width && height == surf_height) {
				state_set(diag_states.writing_text);
				dialogue_list[| dialogue_index].apply(id);
			}
		}
	break;
	#endregion
	#region Write Text
	case diag_states.writing_text:
		if (key_p_enter) {
			text_skip = true;
			text_fast_write = true;
		}
		var flag = true;
		while (flag) {
			flag = false;
			// Writing new text characters
			if (text_fast_write || (t mod text_frequency == 0)) {
				// If it has reached the end of the line
				if (text_current_char_index > string_length(text_current_string)) {
					text_current_char_index = 1;
					text_current_line++;
					text_add_full_line = false;
					if (text_current_line >= min(text_lines_max, ds_list_size(text_lines))) {
						if (text_current_line < ds_list_size(text_lines)) {
							while (text_current_line > 0) {
								ds_list_delete(text_lines, 0);
								text_current_line--;
							}
							text_current_string = text_lines[| 0];
						} else {
							text_page_id++;
							dialogue_next = true;
						}
						state_set(diag_states.waiting);
						text_skip = false;
					} else {
						text_current_string = text_lines[| text_current_line];	
					}
				} else {
					text_lines_draw[| text_current_line] += string_char_at(text_current_string, text_current_char_index++);
				}
			}
			if ((text_skip && state == diag_states.writing_text) || text_add_full_line)
				flag = true;
		}
	break;
	#endregion
	#region Wait Player Input
	case diag_states.waiting:
		if (t mod 16 == 0) {
			text_down_arrow_show = !text_down_arrow_show;
			if (t == 0) {
				text_down_arrow_show = true;	
			}
		}
		if (key_p_enter || text_fast_write) {
			state_set(diag_states.close_text);
			if (dialogue_next)
				dialogue_index++;
			text_down_arrow_show = false;
		}
	break;
	#endregion
	#region Close Text
	case diag_states.close_text:
		text_y -= 3;
		if (abs(text_y) > surf_height) {
			state_set((dialogue_index < ds_list_size(dialogue_list)) ? diag_states.writing_text : diag_states.close_box);
			dialogue_clear_draw();
			if (state == diag_states.writing_text && dialogue_next) {
				dialogue_list[| dialogue_index].apply(id);
				dialogue_next = false;
			}
			text_x = text_xstart;
			text_y = text_ystart;
		}
	break;
	#endregion
	#region Close Dialogue Box
	case diag_states.close_box:
		// SNES
		if (box_mode == box_modes.snes) {
			// Decrease size
			width = clamp(width - box_speed, 0, surf_width);
			height = clamp(height - box_speed, 0, surf_height);
			// Change
			if (width == 0 && height == 0) {
				instance_destroy();
				exit;
			}
		}
	break;
	#endregion
}

rect_x = (surf_width - width) / 2;
rect_y = (surf_height - height) / 2;