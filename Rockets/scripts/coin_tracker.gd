extends Area2D

@onready var icon = $TrackerIcon
@export var distance_from_player = 30

@onready var coin_spawner = get_node("/root/Game/CoinSpawner")

var target_coin: Area2D

func _process(_delta):
	# Get a new target coin if one isn't set 
	if target_coin == null:
		get_target_coin()
	update_icon() 

func update_icon():
	var coin_direction = Vector2.ZERO.direction_to(target_coin.global_position)
	# Set gun position 
	icon.position = coin_direction * distance_from_player
	# Set gun rotation 
	icon.rotation = coin_direction.angle() 

func get_target_coin():
	# Get all coins 
	var coins = coin_spawner.get_children()
	
	# Target the first coin in the array 
	target_coin = coins[1]
