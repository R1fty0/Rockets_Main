extends Area2D
@onready var animation_player = $AnimationPlayer


# Note: If there is no player in the scene the game will crash!
func _on_body_entered(body):
	if (body.name == "Player"):
		GameManager.coins_collected += 1
		queue_free()
