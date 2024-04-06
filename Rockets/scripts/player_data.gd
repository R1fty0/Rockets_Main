extends Resource
class_name PlayerData

@export var coin_balance: int = 0

enum Ship
{
	Red,
	Blue, 
	Orange,
	Green
}

@export var ships_owned: Dictionary = {
	Ship.Blue: true,
	Ship.Green: false,
	Ship.Orange: false,
	Ship.Red: false	
} 

func _can_player_afford_ship(coin_cost: int) -> bool: 
	if (coin_balance < coin_cost):
		return false
	else:
		return true 

# Check if the ship is already owned by the player
func _does_player_own_ship(ship_name: Ship) -> bool:
	var ship_to_check = ship_name
	var ownership_status = ships_owned[ship_name]
	if ownership_status:
		return true
	else:
		return false 

# Enable the player to buy a ship 
func _buy_ship(ship_name: Ship, coin_cost: int):
	# Check if the player owns and can afford the ship. 
	if !_does_player_own_ship(ship_name) && _can_player_afford_ship(coin_cost):
		# Buy the ship
		var ship_ownership = ships_owned[ship_name]
		ship_ownership = true
		coin_balance -= coin_cost
	
# Add and remove coins from the player's balance 
func _modify_coin_balance(amount: int, add: bool):
	if add:
		coin_balance += amount
	else:
		coin_balance -= amount 
