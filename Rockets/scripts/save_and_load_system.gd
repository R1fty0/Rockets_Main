extends Node
class_name SaveAndLoadSystem

@export var save_path = "user://save_game.save"
@export var player_inventory = preload("res://scripts/resources/player_inventory.tres")

# Save/Load:
# ships owned
# coin balance
# high score 
# most missiles avoided
# most coins collected 

# Video: https://www.youtube.com/watch?v=bPbeeS5V2bE


func setup_data():
	var data_dict = {
		"ships_owned": player_inventory.ships,
		"coin_balance": player_inventory.coin_balance,
		"high_score": player_inventory.high_score,
		"most_missiles_avoided": player_inventory.most_missiles_avoided,
		"most_coins_collected": player_inventory.most_coins_collected
	}
	return data_dict
	
func save_data():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	var json_string = JSON.stringify(setup_data())
	file.store_line(json_string)
	
func load_data():
	if not FileAccess.file_exists(save_path):
		print("No file found!")
		# Return default values if file doesn't exist. 
		player_inventory.ships = player_inventory.ships
		player_inventory.coin_balance = player_inventory.coin_balance
		player_inventory.high_score = player_inventory.high_score
		player_inventory.most_coins_collected = player_inventory.most_coins_collected
		player_inventory.most_missiles_avoided = player_inventory.most_missiles_avoided
	else:
		var file = FileAccess.open(save_path, FileAccess.READ)
		while file.get_position() < file.get_length():
			var json_string = file.get_line()
			var json = JSON.new()
			var parsed_result = json.parse(json_string)
			var data = json.get_data()
			
			player_inventory.ships = data["ships_owned"]
			player_inventory.coin_balance = data["coin_balance"]
			player_inventory.high_score = data["high_score"]
			player_inventory.most_coins_collected = data["most_coins_collected"]
			player_inventory.most_missiles_avoided = data["most_missiles_avoided"]
	
