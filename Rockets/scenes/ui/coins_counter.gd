extends TextureRect

@onready var coin_count_label: Label = $CoinCountLabel
var scene_name: StringName

func _ready():
	scene_name = get_tree().get_current_scene().name

func _process(_delta):
	if scene_name == "Game":
		coin_count_label.text = str(GameManager.coins_collected)
	else:
		coin_count_label.text = str(GameManager.PLAYER_INVENTORY.coin_balance)
	
