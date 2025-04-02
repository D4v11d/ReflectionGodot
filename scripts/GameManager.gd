class_name GameManager extends Node2D

@onready var player: Player = $"../Player"
@onready var camera_1: Camera2D = $"../Scenario/Camera1"
@onready var warp_timer: Timer = $WarpTimer

@onready var how_to_move: Label = $"../Scenario/How to move"
@onready var enter_mirror_world: Label = $"../Scenario/Enter Mirror World"
@onready var good_luck: Label = $"../Scenario/Good Luck!"

@export var closing_wall: PolygonStructure

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
	
	# switch player to Mirror World
	player.global_position = mirror_to_go.global_position
	player.air_dash_available = true
	
	player.oni.flip_v = !player.oni.flip_v
	
	# switch camera to Mirror World
	current_camera.enabled = false
	camera_to_go.enabled = true
	current_camera = camera_to_go


func start_close_door() -> void:
	closing_wall.close()


func _on_show_good_luck_body_entered(body: Node2D) -> void:
	if body is Player:
		how_to_move.visible = false
		enter_mirror_world.visible = false
		good_luck.visible = true
