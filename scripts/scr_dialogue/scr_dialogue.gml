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
			ds_list_destroy(text_lines);
			text_lines = string_split(other.wrapped_text, "\n");
			text_current_line = 0;
			text_current_char_index = 1;
			text_current_string = text_lines[| 0];
			text_lines_max = floor(text_h / line_h);
			text_page_id = 0;
			text_side = other.side;
			text_xstart = text_xstart_side[text_side];
			dialogue_clear_draw();
		}
	}
}
function dialogue_clear_draw() {
	for (var i = 0; i < text_lines_max; i++)
		text_lines_draw[| i] = "";		
}