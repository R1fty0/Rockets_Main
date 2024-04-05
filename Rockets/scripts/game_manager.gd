extends Node

var is_player_dead: bool = false

func _process(delta):
	if is_player_dead:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
