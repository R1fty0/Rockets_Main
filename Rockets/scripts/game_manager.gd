extends Node

signal game_ended 

const PLAYER_INVENTORY = preload("res://scripts/resources/player_inventory.tres")
var selected_ship_resource: ShipData = preload("res://scripts/resources/orion.tres")
var is_player_dead: bool = false

# Stuff for game over screen.
var score: float = 0.00
var coins_collected: int = 0
var missiles_avoided: int = 0

func _process(_delta):
	if is_player_dead:
		end_game()

func start_game():
	get_tree().change_scene_to_file("res://scenes/levels/game.tscn")

func end_game():
	game_ended.emit()
	get_tree().change_scene_to_file("res://scenes/menus/game_over.tscn")
