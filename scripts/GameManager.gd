class_name GameManager extends Node2D


@onready var player: Player = $"../Player"
@onready var camera_1: Camera2D = $"../Level1/Camera1"

var current_camera: Camera2D

func _ready() -> void:
	current_camera = camera_1

func print_something() -> void:
	print("something")


func warp_to_mirror(mirror: Node2D, camera: Camera2D) -> void:
	player.global_position = mirror.global_position	
	player.swap_gravity()
	player.oni.flip_v = !player.oni.flip_v
	current_camera.enabled = false
	camera.enabled = true
	
	current_camera = camera
