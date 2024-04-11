extends CharacterBody2D

# Data
@export var player_data: PlayerData

# Speed
@export var normal_speed = 100.0
@export var max_forward_speed = 200.0
@export var max_backward_speed = 200.0 

# Boosting
@export var boosting_acceleration = 5.0 
@export var boost_meter_drain = 4.0
@export var boost_meter_recharge = 2.0
@onready var boost_meter = $"../UI/BoostLabel/BoostMeter"



# Rotation
@export var turn_speed = 5.0 

var acceleration = 1.0 

func _ready():
	if boost_meter == null:
		print("Check the scene you are running! No boost meter found. ")
	# Fill boost meter 
	boost_meter.value = 100

func _physics_process(delta):
	# Move the spaceship forward 
	velocity = Vector2(0, 1).rotated(rotation) * normal_speed * acceleration
		
	# Handle turning 
	_turning(delta)
	# Handle boosting 
	_boosting()
	# Apply movement 
	move_and_slide()
	
func _turning(delta):
	# Turn left
	if Input.is_action_pressed("turn_left"):
		rotate(turn_speed * delta)
	# Turn right 
	if Input.is_action_pressed("turn_right"):
		rotate(turn_speed * -1 * delta)
	
func _boosting():
	if Input.is_action_pressed("boost_forward") && boost_meter.value >= boost_meter_drain:
		acceleration = boosting_acceleration 
		# Drain boost meter 
		boost_meter.value -= boost_meter_drain
	else:
		# Apply no acceleration 
		acceleration = 1
		# Recharge boost meter
		boost_meter.value += boost_meter_recharge
	

func _on_obstacle_collision_hitbox_body_entered(body):
	# End the game if the player is hit by a missle 
	if body.name == "Missle":
		%GameManager.is_player_dead = true
