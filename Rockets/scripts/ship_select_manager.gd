extends Node

# Resources 
@export var red_ship_data: ShipData
@export var green_ship_data: ShipData
@export var blue_ship_data: ShipData
@export var orange_ship_data: ShipData

# UI References
@onready var ship_name = $"../ShipInfoBox/ShipName"
@onready var ship_icon = $"../ShipVisualBox/ShipIcon"

# Meters
@onready var speed_meter = $"../ShipInfoBox/SpeedMeter"
@onready var boost_meter = $"../ShipInfoBox/BoostMeter"
@onready var turning_meter = $"../ShipInfoBox/TurningMeter"

enum Ship
{
	Red,
	Blue, 
	Orange,
	Green
}

var ships = [red_ship_data, blue_ship_data, green_ship_data, orange_ship_data]
var selected_ship_index: int = 0

func _on_left_button_pressed():
	selected_ship_index -= 1
	if selected_ship_index <= 0:
		selected_ship_index = ships.size()
		
func _on_right_button_pressed():
	selected_ship_index += 1
	if selected_ship_index >= ships.size():
		selected_ship_index = 0
