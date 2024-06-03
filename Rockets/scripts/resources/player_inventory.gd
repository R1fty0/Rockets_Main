extends Resource
class_name PlayerInventory 

@export var coin_balance: int = 0
@export var high_score: float = 0.00
@export var most_missiles_avoided: int = 0
@export var most_coins_collected: int = 0

# Dictionary containing the name of each ship and whether the player owns it or not. 
var ships: Dictionary = {
	"Orion": true,
	"Nova": false,
	"Frontier": false,
	"Discovery": false 
}

# Get a ship from the list of ships. 
func get_ship(ship: ShipData):
	for _ship in ships.keys():
		var name: String = _ship
		# Find the ship with the same name as the ship given. 
		if ship.name == name:
			# Return the ship object
			return _ship
	
# Check if the player owns a ship. 
func is_ship_owned(ship: ShipData) -> bool:
	var _ship = get_ship(ship)
	if ships[_ship]: 
		return true
	else:
		return false
		
func set_ship_ownership(ship:ShipData, owned: bool):
	var _ship = get_ship(ship)
	ships[_ship] = owned

# Check if the player can buy a ship. 
func can_buy_ship(ship: ShipData) -> bool:
	if ship.cost <= coin_balance:
		return true
	else:
		return false

# Change the coin balance by a specific amount. 
func change_coin_balance(amount: int):
	coin_balance += amount
