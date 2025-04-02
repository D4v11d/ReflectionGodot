extends Node2D

# Start Screen variables
@onready var start_screen: Sprite2D = $StartScreen
@onready var start: Sprite2D = $StartScreen/Start
@onready var controls: Sprite2D = $StartScreen/Controls


# Controls variables
@onready var controls_screen: Sprite2D = $ControlsScreen
@onready var back: Sprite2D = $ControlsScreen/Back

@onready var click_sfx: AudioStreamPlayer2D = $ClickSFX

# Start Game Hover
func _on_start_clickable_area_mouse_entered() -> void:
	start.texture = load("res://assets/UI/StartHover.png")

func _on_start_clickable_area_mouse_exited() -> void:
	start.texture = load("res://assets/UI/Start.png")



# Controls Hover
func _on_controls_clickable_area_mouse_entered() -> void:
	controls.texture = load("res://assets/UI/ControlsHover.png")


func _on_controls_clickable_area_mouse_exited() -> void:
	controls.texture = load("res://assets/UI/Controls.png")


# Start Game Click
func _on_start_clickable_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		click_sfx.play()
		get_tree().change_scene_to_file("res://scenes/level_2.tscn")


# Controls Click
func _on_controls_clickable_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		click_sfx.play()
		start_screen.visible = false
		controls_screen.visible = true


# Controls Screen Back Hover
func _on_back_clickable_area_mouse_entered() -> void:
	back.texture = load("res://assets/UI/Buttons/BackHover.png")

func _on_back_clickable_area_mouse_exited() -> void:
	back.texture = load("res://assets/UI/Buttons/Back.png")


# Controls Screen Back Click
func _on_back_clickable_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		click_sfx.play()
		start_screen.visible = true
		controls_screen.visible = false
