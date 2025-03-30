class_name PolygonStructure extends Polygon2D

@onready var static_body_2d: StaticBody2D = $StaticBody2D

func _ready() -> void:
	# Create and configure the CollisionPolygon2D directly
	var collision = CollisionPolygon2D.new()
	collision.polygon = polygon
	static_body_2d.add_child(collision)
