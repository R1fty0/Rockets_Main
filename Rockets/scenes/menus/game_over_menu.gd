extends CanvasLayer

@onready var ship_icon = $ShipIconPanel/ShipIcon
@onready var coin_amount_label = $StatsPanel/CoinStat/CoinAmountLabel
@onready var missiles_avoided_label = $StatsPanel/MissileStat/MissilesAvoidedLabel
@onready var ship_name_label = $ShipIconPanel/ShipName
@onready var score_label = $ShipIconPanel/ScoreLabel
@onready var coin_record_label = $StatsPanel/CoinStat/CoinRecordText
@onready var missile_record_label = $StatsPanel/MissileStat/MissileRecordText
const PLAYER_INVENTORY = preload("res://scripts/resources/player_inventory.tres")
@onready var save_and_load_system = $SaveAndLoadSystem

func _ready():
	ship_icon.texture = GameManager.selected_ship_resource.image
	coin_amount_label.text = str(GameManager.coins_collected)
	missiles_avoided_label.text = str(GameManager.missiles_avoided)
	score_label.text = str(GameManager.score)
	ship_name_label.text = GameManager.selected_ship_resource.name
	# Load player inventory
	save_and_load_system.load_data()
	
	# Set a new record if the player has collected more coins than their all-time record. 
	if PLAYER_INVENTORY.most_coins_collected < GameManager.coins_collected:
		PLAYER_INVENTORY.most_coins_collected = GameManager.coins_collected
		save_and_load_system.save_data()
	
	# Set a new record if the player has collected more coins than their all-time record. 
	if PLAYER_INVENTORY.most_missiles_avoided < GameManager.missiles_avoided:
		PLAYER_INVENTORY.most_missiles_avoided = GameManager.missiles_avoided
		save_and_load_system.save_data()
	
	# Add coins to player inventory
	PLAYER_INVENTORY.change_coin_balance(GameManager.coins_collected)
	save_and_load_system.save_data()
	
	coin_record_label.text = "Record: " + str(PLAYER_INVENTORY.most_coins_collected)
	missile_record_label.text = "Record: " + str(PLAYER_INVENTORY.most_missiles_avoided)
	
func _on_restart_button_button_down():
	get_tree().change_scene_to_file("res://scenes/menus/ship_select/ship_select.tscn")

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main_menu/main_menu.tscn")
