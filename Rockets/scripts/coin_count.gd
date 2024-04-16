extends Label

const PLAYER_DATA = preload("res://resources/player_data.tres")

func _process(delta):
	text = str(PLAYER_DATA.coin_balance)
