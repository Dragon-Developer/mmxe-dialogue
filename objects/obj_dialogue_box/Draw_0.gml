// Create surface if it doesn't exist
if (!surface_exists(surf))
	surf = surface_create(surf_width, surf_height);

text_set_font(dialogue_font);
// Draw on the surface if it exists
if (surface_exists(surf)) {
	surface_set_target(surf);
	draw_clear_alpha(c_white, 0);
	draw_set_color(rectangle_color);
	draw_rectangle(rect_x, rect_y, rect_x + width, rect_y + height, false);
	draw_set_color(c_white);
	for (var i = 0; i < ds_list_size(text_lines_draw); i++) {
		var c = dialogue_color;
		if (i == 0 && text_page_id == 0)
			c = dialogue_title_color;
		draw_string(text_x, line_h*i + text_y, text_lines_draw[| i], c);
	}
	if (text_down_arrow_show) {
		palette_texture_set(global.text_font_palette);
		palette_shader();
		draw_sprite(global.text_font_sprite, text_down_arrow, text_down_arrow_x, text_down_arrow_y);
		palette_reset();
	}
	// Erase part outside of the rectangle
	draw_set_color(c_black);
	gpu_set_blendmode(bm_subtract);
	draw_set_alpha(1);
	draw_rectangle(0, 0, surf_width, rect_y, false);
	draw_rectangle(0, 0, rect_x, surf_height, false);
	draw_rectangle(0, surf_height - rect_y, surf_width, surf_height, false);
	draw_rectangle(surf_width - rect_x, 0, surf_width, surf_height, false);
	gpu_set_blendmode(bm_normal);
	draw_set_color(c_white);
	surface_reset_target();
	draw_surface(surf, x, y);
}