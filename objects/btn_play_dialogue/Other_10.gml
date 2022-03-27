/// @description Click
event_inherited();

if (instance_exists(dialogue_box)) {
	with (dialogue_box) {
		state_set(diag_states.close_box);
	}
} else {
	dialogue_box = instance_create_layer(0, 0, layer, obj_dialogue_box);	
}