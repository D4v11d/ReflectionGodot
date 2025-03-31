class_name PolygonStructure extends Polygon2D

@onready var static_body_2d: StaticBody2D = $StaticBody2D

var close_door = false
var target_position_y = 0

func _ready() -> void:
	# Create and configure the CollisionPolygon2D directly
	var collision = CollisionPolygon2D.new()
	collision.polygon = polygon
	static_body_2d.add_child(collision)
	
	target_position_y = position.y + 900


func _physics_process(delta: float) -> void:
	if close_door:
		var target_point = Vector2(position.x, target_position_y)
		var direction = (target_point - position).normalized()
		var distance = position.distance_to(target_point)
		
		# Move towards the target if not already there
		if distance > 5.0:  # Stop when within 5 pixels to avoid jitter
			position += direction * 100.0 * delta
		else:
			position = target_point  # Snap to target when close enough


func close() -> void:
	close_door = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	close_door = false


func _on_area_2d_body_exited(body: Node2D) -> void:
	close_door = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	close_door = false


func _on_area_2d_area_exited(area: Area2D) -> void:
	close_door = true
