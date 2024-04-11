extends Area2D
@onready var animation_player = $AnimationPlayer


# Note: If there is no player in the scene the game will crash!
func _on_body_entered(body):
	if (body.name == "Player"):
		# Get data from player 
		var player_data = body.player_data
		# Add coin to player inventory
		player_data._modify_coin_balance(1, true)
		# Destroy coin
		queue_free()
