class_name Player extends CharacterBody2D

@onready var oni: AnimatedSprite2D = $Oni
@onready var dash_timer: Timer = $DashTimer
@onready var dash_again_timer: Timer = $DashAgainTimer
@onready var animation_time: Timer = $AnimationTime

const SPEED = 400.0
const JUMP_VELOCITY = -700.0
const DASH_SPEED = 2500.0

var is_dashing = false
var dash_available = true
var air_dash_available = true

var gravity_direction = 1
var pre_dash_gravity_direction = 1
var looking_direction = 1


func _physics_process(delta: float) -> void:
	
	if is_on_floor():
		air_dash_available = true
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * 2 * delta * gravity_direction

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or is_on_ceiling()):
			velocity.y = JUMP_VELOCITY * gravity_direction

	# Get the input direction and handle the movement/deceleration.
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

	move_and_slide()


func swap_gravity() -> void:
	gravity_direction *= -1
	pre_dash_gravity_direction = gravity_direction


func handle_dash() -> void:
	if Input.is_action_just_pressed("dash") and dash_available:
		# start timers
		dash_timer.start() # air time
		animation_time.start() # animation time
		dash_again_timer.start() # time before player can dash again
		dash_available = false
			
		velocity.x = looking_direction * DASH_SPEED
		is_dashing = true
		pre_dash_gravity_direction = gravity_direction  # Save current gravity direction
		if !is_on_floor() && !is_on_ceiling(): 
			gravity_direction = 0  # Disable gravity during dash
		velocity.y = 0
		oni.play("dash")


func _on_dash_timer_timeout() -> void:
	gravity_direction = pre_dash_gravity_direction  # Restore pre-dash gravity direction
	velocity.x = move_toward(velocity.x, 0, SPEED)
	is_dashing = false


func _on_animation_time_timeout() -> void:
	
	oni.play("idle")


func _on_dash_again_timer_timeout() -> void:
	dash_available = true
