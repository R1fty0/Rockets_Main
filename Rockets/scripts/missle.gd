extends CharacterBody2D

@export var missle_speed = 100.0
@onready var player = $"../Player"

# To Do: Get Missle to face player 
func _physics_process(_delta):
	if player == null:
		return 
	else:
		_look_at_player()
		_movement()

func _movement():
	pass
	
func _look_at_player():
	# Get player position
	var player_pos = player.position
	# Get direction to player
	var angle_to_player = atan2(player_pos.y - position.y, player_pos.x - position.x)
	# Rotate missile to face player
	rotation = angle_to_player
