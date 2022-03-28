function Dialogue(name, text, side, color, title_color) constructor {
	self.name = name;
	self.text = text;
	self.wrapped_text = "";
	self.side = side;
	self.color = color;
	self.title_color = title_color;
	function wrap(width) {
		self.wrapped_text = "(" + self.name + ")\n" + string_wordwrap_width(self.text, width);
	}
	function apply(diagbox) {
		with (diagbox) {
			text_set_font(dialogue_font);
			text_side = other.side;
			text_xstart = text_xstart_side[text_side];
			dialogue_color = other.color;
			dialogue_title_color = other.title_color;
			text_w = surf_width - text_xstart_side[MUGSHOT_SIDE.LEFT] - text_wborder;
			if (text_side == MUGSHOT_SIDE.NONE) {
				text_w = surf_width - text_xstart - text_wborder;	
			}
			other.wrap(text_w);
			ds_list_destroy(text_lines);
			text_lines = string_split(other.wrapped_text, "\n");
			text_current_line = 0;
			text_current_char_index = 1;
			text_current_string = text_lines[| 0];
			text_lines_max = floor(text_h / line_h);
			text_page_id = 0;
			clearDrawLines();
		}
	}
}
function getFont(str) {
	switch (string_upper(str)) {
		case "2": return text_fonts.normal2;
		default: return text_fonts.normal;
	}
}
function getSide(str) {
	switch (string_upper(str)) {
		case "LEFT": return MUGSHOT_SIDE.LEFT
		case "RIGHT": return MUGSHOT_SIDE.RIGHT;
	}
	return MUGSHOT_SIDE.NONE;
}
function getDialogueColor(str) {
	switch (string_upper(str)) {
		case "RED": return colors.red;
		case "DARK_BLUE": return colors.dark_blue;
		case "DARK_GREEN": return colors.dark_green;
		case "DARK_ORANGE": return colors.dark_orange;
		case "DARK_PURPLE": return colors.dark_purple;
		case "WHITE": return colors.gray;
		case "PINK": return colors.pink;
		case "ORANGE": return colors.orange;
		case "PURPLE": return colors.purple;
	}
	return colors.blue;
}
function loadDialogueFromFile(fname) {
	if (file_exists(fname)) {
		ds_list_clear(dialogue_list);
		var file = file_text_open_read(fname), json = "";
		while (!file_text_eof(file)) {
			json +=	file_text_readln(file);
		}
		var json_dialogue = json_parse(json);
		if (variable_struct_exists(json_dialogue, "font")) {
			dialogue_font = getFont(json_dialogue.font);
		}
		if (variable_struct_exists(json_dialogue, "default_color")) {
			dialogue_color = getDialogueColor(json_dialogue.default_color);
		}
		if (variable_struct_exists(json_dialogue, "dialogues") && is_array(json_dialogue.dialogues)) {
			foreach(json_dialogue.dialogues as (dialogue) {
				var c = (variable_struct_exists(dialogue, "color")) ? getDialogueColor(dialogue.color) : dialogue_color;
				var title_c = (variable_struct_exists(dialogue, "title_color")) ? getDialogueColor(dialogue.title_color) : c;
				ds_list_add(dialogue_list, new Dialogue(
					dialogue.name,
					dialogue.text,
					getSide(dialogue.side),
					c,
					title_c
				));
			});
		}
		file_text_close(file);
	}
}