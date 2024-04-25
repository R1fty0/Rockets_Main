extends CharacterBody2D

# Issac wrote boosting code

enum BoostMode {
  RECHARGING,      # Can boost, but not currently.
  BOOSTING,        # Actively boosting
  RECHARGE_PAUSE,  # Recharge pause
}

const MAX_BOOST = 1000.0
const BOOST_DRAIN_RATE = 400.0 # Per second
const BOOST_RECHARGE_RATE = 200.0 # Per second
const BOOST_RECHARGE_PAUSE_DURATION = 2.0 # In seconds
const BOOST_FACTOR_RECHARGING = 1.0 # This is the default state, so probably keep this at 1.
const BOOST_FACTOR_BOOSTING = 8.0 # Basic boost speed factor.
const BOOST_FACTOR_RECHARGE_PAUSE = 1.0  # If you want the player to move slower when recharging boost, change this.

# Data
@export var player_data: PlayerData

# Speed
@export var normal_speed = 100.0
@export var max_forward_speed = 200.0
@export var max_backward_speed = 200.0 

# Boosting
@onready var boost_meter = $"../UI/BoostLabel/BoostMeter"

# Rotation
@export var turn_speed = 5.0 

var boost_mode = BoostMode.RECHARGING
var boost_charge = MAX_BOOST
var boost_factor = BOOST_FACTOR_RECHARGING

@onready var timer := $RechargePauseTimer


func _ready():
	if boost_meter == null:
		print("Check the scene you are running! No boost meter found. ")
	# Set boost meter to full
	boost_meter.value = 100
	set_boost_mode(BoostMode.RECHARGING)


func _input(event):
	# Boost
	if event.is_action_pressed("boost_forward") and boost_mode in [BoostMode.RECHARGING, BoostMode.RECHARGE_PAUSE]:
		set_boost_mode(BoostMode.BOOSTING)
	# Stop boosting, wait for pause before refilling boost meter
	elif event.is_action_released("boost_forward") and boost_mode == BoostMode.BOOSTING:
		set_boost_mode(BoostMode.RECHARGE_PAUSE)


func _process(delta):
	# Set the boost meter's value
	boost_meter.value = (boost_charge / MAX_BOOST) * 100.0


func _physics_process(delta):
	_turning(delta)
	var boost_factor = _boost_factor(delta)
	# Apply movement 
	velocity = Vector2(0, 1).rotated(rotation) * normal_speed * boost_factor
	move_and_slide()


func _turning(delta):
	# Turn left
	if Input.is_action_pressed("turn_left"):
		rotate(turn_speed * delta)
	# Turn right 
	if Input.is_action_pressed("turn_right"):
		rotate(turn_speed * -1 * delta)


func _boost_factor(delta) -> float:
	# Determine the current boost factor s
	var boost_factor = 1.0
	match boost_mode:
		BoostMode.RECHARGING:
			boost_factor = BOOST_FACTOR_RECHARGING
			boost_charge = min(boost_charge + BOOST_RECHARGE_RATE * delta, MAX_BOOST)
		
		BoostMode.BOOSTING:
			boost_factor = BOOST_FACTOR_BOOSTING
			boost_charge -= BOOST_DRAIN_RATE * delta
			if boost_charge < 0.0:
				set_boost_mode(BoostMode.RECHARGE_PAUSE)
		
		BoostMode.RECHARGE_PAUSE:
			boost_factor = BOOST_FACTOR_RECHARGE_PAUSE
			if timer.time_left == 0.0:
				set_boost_mode(BoostMode.RECHARGING)
	
	return boost_factor


func _on_obstacle_collision_hitbox_body_entered(body):
	# End the game if the player is hit by a missle 
	if body.name == "Missile":
		%GameManager.is_player_dead = true


func set_boost_mode(new_mode):
	# Set the boost mode to a given mode 
	boost_mode = new_mode
	
	match boost_mode:
		BoostMode.RECHARGING:
			boost_charge = clamp(boost_charge, 0.0, MAX_BOOST)
		BoostMode.RECHARGE_PAUSE:
			timer.start(BOOST_RECHARGE_PAUSE_DURATION)
