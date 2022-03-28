function text_init() {
	enum text_fonts
	{
		normal,
		normal2,
		big,
		custom
	}
	global.text_font_array[text_fonts.normal] = [spr_text_font_normal, 33, 7, plt_text_font_normal];
	global.text_font_array[text_fonts.normal2] = [spr_text_font_normal_2, 33, 7, plt_text_font_normal_2];
	global.text_font_array[text_fonts.big] = [spr_text_font_big, 65, 8, plt_text_font_normal];

	text_set_font(text_fonts.normal);
}
