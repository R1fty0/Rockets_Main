extends Area2D
@onready var animation_player = $AnimationPlayer
@onready var _player_data = get_node("/root/Game/Player").player_data

# Note: If there is no player in the scene the game will crash!
func _on_body_entered(body):
	if (body.name == "Player"):
		# Add coin to player inventory
		_player_data._modify_coin_balance(1, true)
		# Destroy coin
		queue_free()
