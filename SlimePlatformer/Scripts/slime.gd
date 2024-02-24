extends CharacterBody2D

signal jump_start
signal fall_start
signal fall_end
signal move_start
signal move_end

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

var prevVelocity = Vector2.ZERO


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var falling = false
var moving = false
var facing = 1


func jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump_start.emit()
		velocity.y = JUMP_VELOCITY

func check_fall():
	if velocity.y < 0:
		falling = true
		fall_start.emit()
	elif is_on_floor() and falling:
		falling = false
		fall_end.emit()
	

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func change_facing():
	if facing == 0:
		%AnimationController.flip_h = true
	else:
		%AnimationController.flip_h = false

func handle_movement(delta):
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		facing = 1
	elif direction < 0:
		facing = 0
	
	if direction: # Receiving a movement input
		velocity.x = direction * SPEED
		if not falling:
			move_start.emit()
			moving = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if not falling:
			move_end.emit()
			moving = false

	if not is_on_floor():
		velocity.x = lerp(prevVelocity.x,velocity.x,0.2)

func _physics_process(delta):
	apply_gravity(delta)
	jump()
	check_fall()
	change_facing()
	handle_movement(delta)
	move_and_slide()
	prevVelocity = velocity
