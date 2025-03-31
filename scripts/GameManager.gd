class_name GameManager extends Node2D

@onready var player: Player = $"../Player"
@onready var camera_1: Camera2D = $"../Level1/Camera1"
@onready var closing_door: PolygonStructure = $"../Level1/ClosingDoor"
@onready var warp_timer: Timer = $WarpTimer

var current_camera: Camera2D

var mirror_to_go: Mirror
var camera_to_go: Camera2D

func _ready() -> void:
	current_camera = camera_1

func print_something() -> void:
	print("something")


func warp_to_mirror(mirror: Node2D, camera: Camera2D) -> void:
	mirror_to_go = mirror
	camera_to_go = camera
	
	player.global_position = mirror_to_go.global_position	
	player.swap_gravity()
	player.oni.flip_v = !player.oni.flip_v
	current_camera.enabled = false
	camera_to_go.enabled = true
	
	current_camera = camera_to_go
	
	player.oni.play("shine")
	warp_timer.start()


func start_close_door() -> void:
	closing_door.close()


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.


func _on_warp_timer_timeout() -> void:
	player.oni.play("idle")
