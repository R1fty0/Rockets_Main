extends Area2D

@onready var icon = $TrackerIcon
@export var distance_from_player = 15

var target_coin

func _process(_delta):
	# Get a new target coin if one isn't set 
	if target_coin == null: 
		get_target_coin()
	# Get direction to coin
	var coin_direction = Vector2.ZERO.direction_to(target_coin.global_position)
	# Set icon position 
	icon.position = coin_direction * distance_from_player
	# Set icon rotation 
	icon.rotation = coin_direction.angle() 

func get_target_coin():
	# Get coins in rage
	var coins_in_range = get_overlapping_areas()
	# Get position of closest coin 
	if coins_in_range.size() > 1:
		target_coin = coins_in_range[0]
	
