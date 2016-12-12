# GD Nav Agent
Navigation Agent for Godot Engine

## Custom Nodes
- Navigation Agent
- Kinematic Agent

## Exported Variables
- **float** speed - Agent Speed per Second.
- **float** accel - Move Acceleration.
- **float** lookLerp - Look Speed.
- **Vector3** lookDir - Look Direction;

## Variables
- **Array** path - Path Queue.
- **Vector3** velocity - Agent Linear Velocity.

## Methods
- set_navigation(**Navigation** nav) - Set the Navigation Node.
- set_pos(**Vector3** pos) - Set Agent Position.
- go_to_pos(**Vector3** pos) - Move Agent to a Position.
- go_to_segment(**Vector3** from, **Vector3** to) - Move Agent by Intersecting a Segment.

