extends Node

var is_player_dead: bool = false
@onready var game_over_scene = preload("res://scenes/game_over.tscn")

func _process(delta):
	if is_player_dead:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
