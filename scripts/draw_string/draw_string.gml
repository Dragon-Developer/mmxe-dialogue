enum colors {
	blue,
	dark_blue,
	dark_green,
	orange,
	dark_orange,
	dark_orange_off,
	purple,
	pink,
	dark_purple,
	red,
	gray
}
/// @description - Draw String on Screen
function draw_string(x, y, text, color = colors.blue) {	
	plt_index = color;

	palette_texture_set(global.text_font_palette);
	palette_shader();

	var xx = x - 2;
	for (var i = 1; i <= string_length(text); i++) {
	    var _char = string_copy(text, i, 1);
	
	    if (_char != " ") {
			draw_sprite_offset(global.text_font_sprite, char_index(_char), xx, y - 1);
	    }
		xx += global.text_font_width;
	}
	palette_reset();
}
