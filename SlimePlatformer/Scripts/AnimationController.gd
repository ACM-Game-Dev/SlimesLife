extends AnimatedSprite2D


const ANIMATIONS = {
	idle = "idle",
	jump_start = "jump_start",
	move_left = "move_left",
	move_right = "move_right",
	land = "land",
	falling = "falling",
}

var active_animation = ANIMATIONS.idle

func play_animation(animation_name):
	%AnimationController.play(animation_name)

func animate_idle():
	play_animation(ANIMATIONS.idle)

func _ready():
	animate_idle()

func _on_slime_jump_start():
	play_animation(ANIMATIONS.jump_start)
	active_animation = ANIMATIONS.falling

func _on_animation_finished():
	play_animation(active_animation)

func _on_animation_looped():
	print("Looped!")

func _on_slime_fall_end():
	play_animation(ANIMATIONS.land)
	active_animation = ANIMATIONS.idle

func _on_slime_fall_start():
	play_animation(ANIMATIONS.falling)
	

