class_name Player extends CharacterBody2D

@onready var oni: AnimatedSprite2D = $Oni
@onready var dash_timer: Timer = $DashTimer
@onready var dash_again_timer: Timer = $DashAgainTimer
@onready var animation_time: Timer = $AnimationTime
@onready var warp_timer: Timer = $WarpTimer
@onready var camera_1: Camera2D = $"../Scenario/Camera1"
@onready var dash_sound: AudioStreamPlayer2D = $DashSound

const SPEED = 700.0
const JUMP_VELOCITY = -1500.0
const DASH_SPEED = 4000.0

# For crate push
const MAX_VELOCITY = 150.0
const PUSH_FORCE = 100.0

var is_dashing = false
var dash_available = true
var air_dash_available = true

var looking_direction = 1

func _ready() -> void:
	oni.flip_h = true

func _physics_process(delta: float) -> void:
	if is_on_floor() or is_on_ceiling():
		air_dash_available = true
	
	# Apply gravity unless dashing
	if not is_dashing:
		velocity += get_gravity() * 4 * delta * get_gravity_direction()

	# Handle jump (supports gravity swap)
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or is_on_ceiling()):
		velocity.y = JUMP_VELOCITY * get_gravity_direction()

	# Get the input direction and handle the movement/deceleration
	var direction := Input.get_axis("move_left", "move_right")
	if direction and !is_dashing:
		looking_direction = direction
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction > 0:
		oni.flip_h = true
	elif direction < 0:
		oni.flip_h = false
	
	# Dash
	handle_dash()
	
	# Push Crates
	handle_push_crate()

	move_and_slide()

func handle_dash() -> void:
	if Input.is_action_just_pressed("dash") and dash_available:
		if not is_on_floor() and not is_on_ceiling() and not air_dash_available:
			return
		
		dash_sound.play()
		dash_timer.start()
		animation_time.start()
		dash_again_timer.start()
		dash_available = false
		velocity.x = looking_direction * DASH_SPEED
		is_dashing = true
		velocity.y = 0
		oni.play("dash")
		if not is_on_floor() and not is_on_ceiling():
			air_dash_available = false

func handle_push_crate() -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var crate = collision.get_collider()
		if crate.is_in_group("crates") and abs(crate.get_linear_velocity().x) < MAX_VELOCITY:
			crate.apply_central_impulse(collision.get_normal() * -PUSH_FORCE)

func _on_dash_timer_timeout() -> void:
	velocity.x = move_toward(velocity.x, 0, SPEED)
	is_dashing = false

func _on_animation_time_timeout() -> void:
	oni.play("idle")

func _on_dash_again_timer_timeout() -> void:
	dash_available = true

func get_gravity_direction() -> float:
	if is_dashing:
		return 0.0
	else:
		return 1.0 if camera_1.is_current() else -1.0
