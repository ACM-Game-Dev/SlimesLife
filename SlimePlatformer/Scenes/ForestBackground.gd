extends Node2D
@export var player_path: NodePath
@export var parallax_strength: float = 10
var player = Node2D
var speed: float = 100.0

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(player_path)
	if player and player_path:
		print("Player character is valid")
	else:
		print("Player character is invalid")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player and player.global_position:
		# Check if player is valid and has a global_position before accessing it.
		print("Player position: ", player.global_position)
		global_position = player.global_position
	else:
		print("Player is not valid or does not have a global_position.")
