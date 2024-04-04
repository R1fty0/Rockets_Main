extends Node

var is_player_dead: bool = false

func _process(delta):
	if is_player_dead:
		print("Game Over!")
