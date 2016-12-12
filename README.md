# GD Nav Agent
Navigation Agent for Godot Engine

## Custom Nodes
- Navigation Agent
- Kinematic Agent

## Exported Variables
- **float** speed - Move speed.
- **float** accel - Move acceleration.
- **float** lookLerp - Look speed.
- **Vector3** lookDir - Look direction.

## Variables
- **Array** path - Path queue.
- **Vector3** velocity - Agent's linear velocity.

## Methods
- set_navigation(**Navigation** nav) - Set the navigation node. By default this is set to parent of node.
- set_pos(**Vector3** pos) - Set agent's position.
- go_to_pos(**Vector3** pos) - Move agent to a position.
- go_to_segment(**Vector3** from, **Vector3** to) - Move agent by intersecting a segment between two points.

