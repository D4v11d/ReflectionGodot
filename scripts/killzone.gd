class_name Killzone extends Area2D

@onready var timer: Timer = $Timer


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().reload_current_scene()

	
