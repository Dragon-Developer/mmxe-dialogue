// View Size
vw = camera_get_view_width(view_camera[0]);
vh = camera_get_view_height(view_camera[0]);

// Surface Size
surf_width = 200;
surf_height = 96;

// Rectangle Current Size
width = 0;
height = 0;

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

enum box_modes {
	snes	
}

// Config
box_mode = 0;
box_speed = 3;

// Text & Palette Variables
text_init();
palette_init();

// Text Position and Size
text_xstart = 52;
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

key_p_enter = false;
draw_set_offset(0, 0);

dialogue_list = ds_list_create();
ds_list_add(dialogue_list, 
	new Dialogue(
		"DARK SHADOW",
		"Hello everyone! My name is Dark Shadow and I'm testing this wordwrapppppppppppppppppppppppp test \nBreak Line\nNice test\nIt's working",
	),
	new Dialogue(
		"",
		"Hello everyone! My name is\nWhat?"
	),
	new Dialogue(
		"RANDOM",
		"IDK"
	),
	new Dialogue(
		"TEST 4",
		"OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK OK"
	),
	new Dialogue(
		"A B C",
		"AAAAAAAAAAAAAAAAAAAAAAAAAAA BBBBBBBBBBBBBBBBBBBBBB CCCCCCCCCCCCCCCCCCCCCCCCC???"
	)
);
for (var i = 0, len = ds_list_size(dialogue_list); i < len; i++) {
	dialogue_list[| i].wrap(text_w);	
}
dialogue_index = 0;
dialogue_next = false;