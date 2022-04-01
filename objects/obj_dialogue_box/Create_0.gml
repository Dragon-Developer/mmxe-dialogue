// View Size
vw = camera_get_view_width(view_camera[0]);
vh = camera_get_view_height(view_camera[0]);

// Surface Size
surf_width = 200;
surf_height = 96;

// Rectangle Current Size
width = 0;
height = 0;
function boxSizeIncrease(speed) {
	width = clamp(width + speed, 0, surf_width);
	height = clamp(height + speed, 0, surf_height);	
}

// Centered Position
x = (vw - surf_width) / 2;
y = (vh - surf_height) / 2;
rect_x = surf_width / 2;
rect_y = surf_height / 2;

// Surface
surf = -1;

// Colors
rectangle_color = c_black;

// State
state = diag_states.open_box;
state_timer = 0;

enum diag_states {
	open_box,
	open_mugshot,
	writing_text,
	waiting,
	close_text,
	close_box
}

enum box_modes { snes }
enum TEXT_LETTER_SOUND { X1, X2 }
// Config
box_mode = 0;
box_speed = 3;

// Text & Palette Variables
text_init();
palette_init();
dialogue_font = text_fonts.normal;

// Text Position and Size
text_side = MUGSHOT_SIDE.LEFT;
text_xstart_side = [52, 2, 6];
text_xstart = text_xstart_side[text_side];
text_ystart = 2;
text_x = text_xstart;
text_y = text_ystart;
text_wborder = 8;
text_hborder = 16;
text_w = surf_width - text_x - text_wborder;
text_h = surf_height - text_y - text_hborder;
text_frequency = 4;
text_fast_write = false;
text_add_full_line = true;

line_h = 12;
text_add_full_line = false;
text_lines = ds_list_create();
text_lines_draw = ds_list_create();
text_skip = false;
text_page_id = 0;
text_down_arrow_show = false;
text_down_arrow = 4;
text_down_arrow_x = floor((surf_width - 2*global.text_font_width) / 2);
text_down_arrow_y = text_h - 8;
text_letter_array[TEXT_LETTER_SOUND.X1] = {
	sound: snd_text_letter_x1,
	frequency: [4, 1]
}
text_letter_array[TEXT_LETTER_SOUND.X2] = {
	sound: snd_text_letter_x2,
	frequency: [4, 2]
}
text_letter = text_letter_array[TEXT_LETTER_SOUND.X2];
function clearDrawLines() {
	for (var i = 0; i < text_lines_max; i++)
		text_lines_draw[| i] = "";		
}

key_p_enter = false;
draw_set_offset(0, 0);

enum MUGSHOT_SIDE { LEFT, RIGHT, NONE };

dialogue_list = ds_list_create();
ds_list_add(dialogue_list,
	new Dialogue(
		"SOTI",
		"Jara hu kaqui we?",
		MUGSHOT_SIDE.LEFT
	),
	new Dialogue(
		"WAKIRO",
		"Hu nite Hu' ka jakani ririqui ka teto hu...",
		MUGSHOT_SIDE.RIGHT
	),
	new Dialogue(
		"HUTE",
		"Te torate ri ri ka ri jaka hu ra tedyja ka rate. Ra tedyja hura ri ja karuhuwe. Ka ru we qui ka terara ri teteyu hu ka huhuni kaka huhu ka. Ru ri hu kate ka ra ka ni. Ka te wejanite ri huqui hu yu ka ru Ra ka Dyte ka kate hu to ni raqui. Ja huhu tekari ka, wete ka teto hu torateru hu rate, Hu terate ka katewe Hu yu hu ra ka rahu quihute raja.",
		MUGSHOT_SIDE.NONE
	),
	new Dialogue(
		"TEDYJA",
		"Hu hu ru jaradyte ka ra nihu tekahuwe. Kate rahuwete huhu kate, nika kaka huhu teteyu. Kate.",
		MUGSHOT_SIDE.RIGHT
	),
	new Dialogue(
		"LAKOWE",
		"Hu tera ka ru kaqui\nhu' ka hute te (ka! Huqui)\njara ka hu kaqui te?\nru huqui hu dyhu we ra-tori\nhu ru ra tera hu teka kate raja.",
		MUGSHOT_SIDE.LEFT
	)
);
loadDialogueFromFile("dialogue.json");
dialogue_index = 0;
dialogue_next = false;
dialogue_color = colors.blue;
dialogue_title_color = colors.blue;