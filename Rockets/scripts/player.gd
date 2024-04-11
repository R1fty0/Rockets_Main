extends CharacterBody2D

const NORMAL_SPEED = 100.0
const MAX_SPEED = 200.0
const TURN_SPEED = 5.0

const BOOST_ACCELERATION = 5.0
const NORMAL_ACCELERATION = 1.0

@export var player_data: PlayerData 

# References 
@onready var boost_meter = $"../UI/BoostLabel/BoostMeter"
@onready var timer := $RechargePauseTimer

enum BoostMode {
	RECHARGING,      #// Can boost, but not currently.
	BOOSTING,        #// Actively boosting
	RECHARGE_PAUSE,  #// Recharge pause
}

const MAX_BOOST = 1000.0
const BOOST_DRAIN_RATE = 400.0
const BOOST_RECHARGE_RATE = 200.0
const BOOST_RECHARGE_PAUSE_DURATION = 3.0
const BOOST_FACTOR_RECHARGING = 1.0 #// This is the default state, so probably keep this at 1.
const BOOST_FACTOR_BOOSTING = 4.0 #// Basic boost factor.
const BOOST_FACTOR_RECHARGE_PAUSE = 1.0  #// If you want the player to move slower when recharging boost, change this.

var boost_mode = BoostMode.RECHARGING
var boost_charge = 0.0

func _ready():
	# Fill boost meter 
	boost_meter.value = 100
	# Set boost recharge timer wait time
	timer.wait_time = BOOST_RECHARGE_PAUSE_DURATION
	
func _physics_process(delta):
	var input_dir = float(Input.is_action_pressed("boost_forward"))
	_turning(delta)
	var boost_factor = boost(delta)
	velocity = Vector2(0, 1).rotated(rotation) * input_dir * boost_factor * 100
	move_and_slide()
	print(str(velocity))

	
func _turning(delta):
	# Turn left
	if Input.is_action_pressed("turn_left"):
		rotate(TURN_SPEED * delta)
	# Turn right 
	if Input.is_action_pressed("turn_right"):
		rotate(TURN_SPEED * -1 * delta)

func _input(event) -> void:
	if Input.is_action_pressed("boost_forward") and boost_mode == BoostMode.RECHARGING:
		set_boost_mode(BoostMode.BOOSTING)
	elif Input.is_action_just_released("boost_forward") and boost_mode == BoostMode.BOOSTING:
		set_boost_mode(BoostMode.RECHARGE_PAUSE)

#// Call every frame
func boost(delta) -> float:
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

func set_boost_mode(new_mode):
	boost_mode = new_mode

	match boost_mode:
		BoostMode.RECHARGING:
			boost_charge = min(boost_charge, 0.0)
		BoostMode.RECHARGE_PAUSE:
			timer.start(BOOST_RECHARGE_PAUSE_DURATION)

func _on_obstacle_collision_hitbox_body_entered(body):
	# End the game if the player is hit by a missle 
	if body.name == "Missle":
		%GameManager.is_player_dead = true
