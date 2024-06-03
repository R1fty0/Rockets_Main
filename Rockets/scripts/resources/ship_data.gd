extends Resource
class_name ShipData

@export var name: String 
@export var image: Texture2D
@export var cost: int 

@export_range(0,25) var turn_speed: int
@export_range(0,4) var boost_multiplier: int
@export_range(0,4) var boost_charge: int 
