extends Node

# Resources 
@export var red_ship_data: ShipData
@export var green_ship_data: ShipData
@export var blue_ship_data: ShipData
@export var orange_ship_data: ShipData
@export var player_data: PlayerData

# UI References
@onready var _ship_name = $"../ShipInfoBox/ShipName"
@onready var _ship_icon = $"../ShipVisualBox/ShipIcon"
@onready var action_button = $"../ActionButton"

# Meters
@onready var speed_meter = $"../ShipInfoBox/SpeedMeter"
@onready var boost_meter = $"../ShipInfoBox/BoostMeter"
@onready var turning_meter = $"../ShipInfoBox/TurningMeter"


@onready var ships = [red_ship_data, blue_ship_data, green_ship_data, orange_ship_data]
var selected_ship_index: int = 0

func _on_left_button_pressed():
	selected_ship_index -= 1
	if selected_ship_index < 0:
		selected_ship_index = ships.size() - 1
		
func _on_right_button_pressed():
	selected_ship_index += 1
	if selected_ship_index >= ships.size():
		selected_ship_index = 0

		
func _process(_delta):
	_update_ui()
	
func _update_ui():
	_ship_icon.texture = ships[selected_ship_index].ship_icon
	_ship_name.text = ships[selected_ship_index].ship_name
	boost_meter.value = ships[selected_ship_index].boost_value
	speed_meter.value = ships[selected_ship_index].speed_value
	turning_meter.value = ships[selected_ship_index].turning_value 

# Get selected ship
	# Check if player owns it
	# Display START if they do
	# Display BUY if they don't 

func _update_action_button():
	pass
