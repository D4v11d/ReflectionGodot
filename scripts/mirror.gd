class_name Mirror extends Node2D

@onready var game_manager: GameManager = %GameManager
@onready var mirror_light: Sprite2D = $MirrorLight
@onready var mirror: Sprite2D = $Mirror

@export var mirror_to_go: Mirror
@export var camera_to_go: Camera2D

var can_enter_mirror = false

# Called every frame. 'delta' is the elapsed time sinc the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_enter_mirror:
		game_manager.warp_to_mirror(mirror_to_go, camera_to_go)



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Player entered area")
		can_enter_mirror = true
		mirror.visible = false
		mirror_light.visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		print("Player exited area")
		can_enter_mirror = false
		mirror.visible = true
		mirror_light.visible = false
