extends Spatial

export(float, 0.1, 100.0, 0.1) var speed = 3.0;
export(float, 0.0, 100.0, 0.1) var accel = 10.0;
export(float, 0.0, 100.0, 0.1) var lookLerp = 10.0;
export(Vector3) var lookDir = Vector3(1, 1, 1);

var navigation = null;
var path = Array();
var velocity = Vector3();

func _ready():
	if (get_parent() extends Navigation):
		navigation = get_parent();
	
	set_pos(get_translation());
	set_fixed_process(true);

func set_navigation(nav):
	navigation = nav;

func set_pos(pos):
	if (!navigation || !navigation extends Navigation):
		return;
	pos = navigation.get_closest_point(pos);
	set_translation(pos);

func go_to_pos(pos):
	if (!navigation || !navigation extends Navigation):
		return;
	var target = navigation.get_closest_point(pos);
	update_path(target);

func go_to_segment(from, to):
	if (!navigation || !navigation extends Navigation):
		return;
	var target = navigation.get_closest_point_to_segment(from, to);
	update_path(target);

func update_path(target):
	if (!navigation || !navigation extends Navigation):
		return;
	var begin = navigation.get_closest_point(get_translation());
	path = Array(navigation.get_simple_path(begin, target, true));
	path.remove(0);

func _fixed_process(delta):
	if (!navigation || !navigation extends Navigation):
		return;
	var pos = get_translation();
	var dir = Vector3();
	var motion = speed*delta;
	
	if (!path.empty()):
		var remainder = motion;
		
		if (accel > 0.0):
			remainder = motion*accel;
		
		if (pos.distance_to(path[0]) < remainder):
			path.remove(0);
		
		if (path.empty()):
			path.clear();
		else:
			var target = path[0];
			dir = (target-pos).normalized();
			
			var targetTrans = Transform();
			var lookTarget = dir*lookDir;
			targetTrans = targetTrans.looking_at(lookTarget, Vector3(0, 1, 0));
			var targetQuat = Quat(targetTrans.basis);
			
			var trans = get_transform();
			var quat = Quat(trans.basis);
			if (lookLerp > 0.0):
				quat = quat.slerp(targetQuat, lookLerp*delta);
			else:
				quat = targetQuat;
			trans.basis = Matrix3(quat);
			set_transform(trans);
	
	if (accel > 0.0):
		velocity = velocity.linear_interpolate(dir, accel*delta);
	else:
		velocity = dir;
	
	if (self extends KinematicBody):
		kinematic_move(velocity*motion);
	else:
		translate(velocity*motion);

func kinematic_move(vec):
	var r = move(vec);
	
	if (is_colliding()):
		var n = get_collision_normal();
		
		r = n.slide(r);
		var vel = n.slide(velocity);
		
		if (velocity.dot(vel) > 0):
			r = move(r);
