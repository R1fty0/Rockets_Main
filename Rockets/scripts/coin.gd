extends Area2D
@onready var animation_player = $AnimationPlayer
const PLAYER_DATA = preload("res://resources/player_data.tres")

# Note: If there is no player in the scene the game will crash!
func _on_body_entered(body):
	if (body.name == "Player"):
		# Add coin to player inventory
		PLAYER_DATA._modify_coin_balance(1, true)
		# Destroy coin
		queue_free()
