extends Button

# Need to rewrite entire ship select system before tackling this 
@onready var ship_select_manager = $"../ShipSelectManager"
const PLAYER_DATA = preload("res://resources/player_data.tres")
var ship_ownership: ShipOwnership

enum ShipOwnership
{
	OWNED,
	PURCHASEABLE
}

func _process(_delta):
	var selected_ship: ShipData = ship_select_manager.ships[ship_select_manager.selected_ship_index]
	if selected_ship.ship_name == "Nova":
		if PLAYER_DATA._does_player_own_ship(PLAYER_DATA.Ship.Blue):
			ship_ownership = ShipOwnership.OWNED
	
