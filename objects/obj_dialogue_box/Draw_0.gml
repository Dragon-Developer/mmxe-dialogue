// Create surface if it doesn't exist
if (!surface_exists(surf))
	surf = surface_create(surf_width, surf_height);

// Draw on the surface if it exists
if (surface_exists(surf)) {
	surface_set_target(surf);
	draw_clear_alpha(c_white, 0);
	draw_set_color(rectangle_color);
	draw_rectangle(rect_x, rect_y, rect_x + width, rect_y + height, false);
	draw_set_color(c_white);
	for (var i = 0; i < ds_list_size(text_lines_draw); i++) {
		draw_string(text_x, line_h*i + text_y, text_lines_draw[| i]);
	}
	if (text_down_arrow_show) {
		draw_sprite(global.text_font_sprite, text_down_arrow, text_down_arrow_x, text_down_arrow_y);
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