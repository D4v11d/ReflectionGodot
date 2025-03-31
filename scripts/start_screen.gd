extends Node2D

@onready var start: Sprite2D = $Start
@onready var controls: Sprite2D = $Controls


func _on_start_clickable_area_mouse_entered() -> void:
	start.texture = load("res://assets/Menu/StartHover.png")


func _on_start_clickable_area_mouse_exited() -> void:
	start.texture = load("res://assets/Menu/Start.png")


func _on_controls_clickable_area_mouse_entered() -> void:
	controls.texture = load("res://assets/Menu/ControlsHover.png")



func _on_controls_clickable_area_mouse_exited() -> void:
	controls.texture = load("res://assets/Menu/Controls.png")


func _on_start_clickable_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_file("res://scenes/first_level.tscn")


func _on_controls_clickable_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
