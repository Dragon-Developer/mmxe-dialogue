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