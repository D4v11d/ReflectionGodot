extends Node2D

@onready var sprite: Sprite2D = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var texture = load('res://assets/Mirrors/blue-512.png')
	sprite.texture = texture


# Called every frame. 'delta' is the elapsed time sinc the previous frame.
func _process(delta: float) -> void:
	pass



func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
