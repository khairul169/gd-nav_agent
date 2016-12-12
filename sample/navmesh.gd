extends Navigation

onready var robot = get_node("robot");

var camrot = 0.0;

func _input(event):
	if (event.type == InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT and event.pressed):
		var from = get_node("cambase/Camera").project_ray_origin(event.pos)
		var to = from + get_node("cambase/Camera").project_ray_normal(event.pos)*100
		
		robot.go_to_segment(from, to);
	
	if (event.type == InputEvent.MOUSE_MOTION):
		if (event.button_mask & BUTTON_MASK_RIGHT):
			camrot -= event.relative_x*0.005;
			get_node("cambase").set_rotation(Vector3(0, camrot, 0));

func _ready():
	OS.set_target_fps(30.0);
	set_process_input(true)
