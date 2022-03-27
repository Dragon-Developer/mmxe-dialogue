/// @description Returns a given string, word wrapped to a pixel width,
///				 with line break characters inserted between words.
///				 Uses the currently defined font to determine text width.
///              GMLscripts.com/license
/// @param string      text to word wrap, string
/// @param width       maximum pixel width before a line break, real
/// @param break       line break characters to insert into text, string
/// @param split       split words that are longer than the maximum, bool
function string_wordwrap_width(text_current, _width, breakline = false, split = false) {
	var pos_space, pos_current, text_output, break_line;
	pos_space = -1;
	pos_current = 1;
	break_line = (breakline) ? "" : "\n";
	text_output = "";
	// Adding spaces
	var word_current = "";
	var new_text = "";
	while (pos_current <= string_length(text_current)) {
		var char = string_char_at(text_current, pos_current);
		if (char == " ") {
			new_text += word_current + " ";
			word_current = "";
		}
		else if (get_string_width(word_current + char) > _width) {
			new_text += word_current + " ";
			word_current = char;
		}
		else 
			word_current += char;
		pos_current++;
	}
	pos_current = 1;
	text_current = new_text + word_current;
	var force_break = false;
	while (string_length(text_current) >= pos_current) {
	    if (force_break || get_string_width(string_copy(text_current, 1, pos_current)) > _width) {
	        // If there is a space in this line then we can break there
	        if (pos_space != -1) {
	            text_output += string_copy(text_current, 1, pos_space);
				if (!force_break) text_output += break_line;
	            // Remove the text we just looked at from the current text string
	            text_current = string_copy(text_current, pos_space + 1, string_length(text_current) - (pos_space));
	            pos_current = 1;
	            pos_space = -1;
				force_break = false;
	        } else if (split) {
	            // If not, we can force line breaks
	            text_output += string_copy(text_current, 1, pos_current - 1) + break_line;
	            // Remove the text we just looked at from the current text string
	            text_current = string_copy(text_current, pos_current, string_length(text_current) - (pos_current - 1));
	            pos_current = 1;
	            pos_space = -1;
	        }
	    }
		var c = string_char_at(text_current, pos_current);
	    if (c == " " || c == break_line)
			pos_space = pos_current;
		if (c == break_line)
			force_break = true;	
	    pos_current += 1;
	}
	if (string_length(text_current) > 0)
		text_output += text_current;
	return text_output;


}
