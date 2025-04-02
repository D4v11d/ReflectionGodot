class_name Box extends RigidBody2D

@export var other_world_box: Box

var other_world_last_position_x

func _ready() -> void:
	if other_world_box:
		other_world_last_position_x = other_world_box.position.x

func _physics_process(delta: float) -> void:
	if other_world_box:
		# Calculate how much other_world_box moved horizontally since last frame
		var other_world_moved_x = other_world_box.position.x - other_world_last_position_x
		# Update the last known position for the next frame
		other_world_last_position_x = other_world_box.position.x
		# Adjust current_box's horizontal velocity to move oppositely, preserve y velocity
		linear_velocity.x = -other_world_moved_x / delta
