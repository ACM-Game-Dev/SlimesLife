extends AnimatedSprite2D


const ANIMATIONS = {
	idle = "idle",
	jump_start = "jump_start",
	move_left = "move_left",
	move_right = "move_right",
	land = "land",
	falling = "falling",
	move = "move",
}

var active_animation = ANIMATIONS.idle

func set_active_animation(animation_type):
	if active_animation != animation_type:
		active_animation = animation_type

func play_animation(animation_name):
	%AnimationController.play(animation_name)

func _ready():
	play_animation(ANIMATIONS.idle)

func _on_animation_finished():
	play_animation(active_animation)

# Jump Handlers
func _on_slime_jump_start():
	play_animation(ANIMATIONS.jump_start)
	active_animation = ANIMATIONS.falling

# Falling handlers
func _on_slime_fall_start():
	play_animation(ANIMATIONS.falling)

func _on_slime_fall_end():
	play_animation(ANIMATIONS.land)
	active_animation = ANIMATIONS.idle

# Horizontal Movement handlers

func _on_slime_move_start():
	set_active_animation(ANIMATIONS.move)

func _on_slime_move_end():
	set_active_animation(ANIMATIONS.idle)

