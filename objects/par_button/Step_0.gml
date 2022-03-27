mouse_hover = point_in_rectangle(mouse_x, mouse_y, x, y, x + width, y + height) > 0;
// If the mouse is over the button
if (mouse_hover) {
	// If the user has pressed the mouse left button
	if (mouse_check_button_pressed(mb_left))
		mouse_hold = true;
	// Run Click Event if the user released the mouse button after holding this button
	if (mouse_hold && mouse_check_button_released(mb_left))
		event_click = true;
}
if (!mouse_check_button(mb_left))
	mouse_hold = false;

mouse_index = mouse_hover + 2*mouse_hold;
image_index = clamp(mouse_index, 0, image_number - 1);
// Run Click Event
if (event_click) {
	event_click = false;
	event_user(0);
}