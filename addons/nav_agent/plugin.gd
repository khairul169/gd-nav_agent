tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("Navigation Agent", "Spatial", preload("nav_agent.gd"), preload("icon.png"));
	add_custom_type("Kinematic Agent", "KinematicBody", preload("nav_agent.gd"), preload("icon.png"));

func _exit_tree():
	remove_custom_type("Navigation Agent");
	remove_custom_type("Kinematic Agent");

