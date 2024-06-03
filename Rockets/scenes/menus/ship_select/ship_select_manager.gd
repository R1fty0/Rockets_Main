extends Node
class_name ShipSelectManager

@export_category("Ship Resources")
@export var red_ship_data: ShipData
@export var green_ship_data: ShipData
@export var blue_ship_data: ShipData
@export var orange_ship_data: ShipData

@export_category("Player Inventory Resource")
@export var player_inventory: PlayerInventory

# List of ship resources.  
@onready var ships = [red_ship_data, blue_ship_data, green_ship_data, orange_ship_data]
# Index of selected ship. 
var selected_ship_index: int = 0

# References from Ship Visual Box. 
@onready var ship_name: Label = $"../ShipInfoBox/ShipName"
@onready var ship_icon: TextureRect = $"../ShipVisualBox/ShipIcon"
# References from Ship Info Box. 
@onready var turn_speed_meter = $"../ShipInfoBox/Meters/TurnSpeedMeter"
@onready var boost_multiplier_meter = $"../ShipInfoBox/Meters/BoostMultiplierMeter"
@onready var boost_charge_meter = $"../ShipInfoBox/Meters/BoostChargeMeter"

@onready var action_button = $"../ActionButton"

# Ship Price Visual
@onready var ship_price: Control = $"../ShipPrice"
@onready var price_label: Label = $"../ShipPrice/PriceLabel"

@onready var save_and_load_system: SaveAndLoadSystem = $"../SaveAndLoadSystem"

var current_action_button_function: ActionButtonFunction = ActionButtonFunction.PLAY
var selected_ship: ShipData

enum ActionButtonFunction
{
	PLAY,
	BUY
}

func _ready():
	save_and_load_system.load_data()

func _on_left_button_pressed():
	selected_ship_index -= 1
	if selected_ship_index < 0:
		selected_ship_index = ships.size() - 1
		
func _on_right_button_pressed():
	selected_ship_index += 1
	if selected_ship_index >= ships.size():
		selected_ship_index = 0

func _process(_delta):
	# Get the selected ship. 
	selected_ship = ships[selected_ship_index]
	# Display ship info to player. 
	show_ship_info()
	# Set function of action button.
	set_action_button_function()
	# Update action button visual. 
	update_action_button()
		
func show_ship_info():
	ship_icon.texture = selected_ship.image
	ship_name.text = selected_ship.name
	turn_speed_meter.value = selected_ship.turn_speed
	boost_multiplier_meter.value = selected_ship.boost_multiplier
	boost_charge_meter.value = selected_ship.boost_charge

func set_action_button_function():
	var ship_ownership = player_inventory.is_ship_owned(selected_ship)
	if ship_ownership:
		current_action_button_function = ActionButtonFunction.PLAY
	else:
		current_action_button_function = ActionButtonFunction.BUY
		
func update_action_button():
	match current_action_button_function:
		ActionButtonFunction.PLAY:
			# Hide ship price icon.
			ship_price.hide()
			# Set button text.
			action_button.text = "Play"
		ActionButtonFunction.BUY:
			# Show the price icon. 
			ship_price.show()
			# Set button text.
			action_button.text = "Buy"
			# Set the text of the price icon.
			price_label.text = str(selected_ship.cost)

func _on_action_button_button_down():
	if current_action_button_function == ActionButtonFunction.BUY:
		# Check if the player can buy the ship.
		var can_buy: bool = player_inventory.can_buy_ship(selected_ship)
		# Buy the ship. 
		if can_buy:
			player_inventory.set_ship_ownership(selected_ship, true)
			player_inventory.change_coin_balance(-selected_ship.cost)
			# Save player inventory. 
			save_and_load_system.save_data()
			current_action_button_function = ActionButtonFunction.PLAY
	elif current_action_button_function == ActionButtonFunction.PLAY:
		GameManager.selected_ship_resource = selected_ship
		GameManager.start_game()
