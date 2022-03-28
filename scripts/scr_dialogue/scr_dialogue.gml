function Dialogue(name, text, side) constructor {
	self.name = name;
	self.text = text;
	self.wrapped_text = "";
	self.side = side;
	function wrap(width) {
		self.wrapped_text = "(" + self.name + ")\n" + string_wordwrap_width(self.text, width);
	}
	function apply(diagbox) {
		with (diagbox) {
			text_side = other.side;
			text_xstart = text_xstart_side[text_side];
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
function getSide(str) {
	switch (str) {
		case "LEFT": return MUGSHOT_SIDE.LEFT; break;
		case "RIGHT": return MUGSHOT_SIDE.RIGHT; break;
	}
	return MUGSHOT_SIDE.NONE;
}
function loadDialogueFromFile(fname) {
	if (file_exists(fname)) {
		ds_list_clear(dialogue_list);
		var file = file_text_open_read(fname), json = "";
		while (!file_text_eof(file)) {
			json +=	file_text_readln(file);
		}
		var json_dialogue = json_parse(json);
		if (variable_struct_exists(json_dialogue, "dialogues") && is_array(json_dialogue.dialogues)) {
			foreach(json_dialogue.dialogues as (dialogue) {
				ds_list_add(dialogue_list, new Dialogue(
					dialogue.name,
					dialogue.text,
					getSide(dialogue.side)
				));
			});
		}
		file_text_close(file);
	}
}