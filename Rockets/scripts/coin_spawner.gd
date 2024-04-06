extends Path2D

# References
@onready var coin_path_follow = $CoinPathFollow

# Spawner Settings
@export var max_number_of_coins: int

func _process(_delta):
	# Spawn more coins if there isn't the maximum number in the scene 
	if get_children().size() - 1 <= max_number_of_coins:
		print(get_children().size())
		_spawn_coin()

func _spawn_coin():
	# Load coin scene (only done once)
	var coin = preload("res://scenes/coin.tscn").instantiate()
	# Get location from path 
	coin_path_follow.progress_ratio = randf()
	# Set coin position to path position 
	coin.global_position = coin_path_follow.global_position
	# Add coin to scene 
	add_child(coin)
	
