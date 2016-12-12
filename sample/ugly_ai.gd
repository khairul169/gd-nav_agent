extends "res://addons/nav_agent/nav_agent.gd"

var nextThink = 0.0;

func _ready():
	set_process(true);

func _process(delta):
	nextThink -= delta;
	if (nextThink > 0.0):
		return;
	nextThink = 5.0;
	
	var newPos = Vector3(rand_range(-5.0, 5.0), rand_range(-5.0, 5.0), rand_range(-5.0, 5.0));
	go_to_pos(newPos);
