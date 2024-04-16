extends CharacterBody2D

const NORMAL_SPEED: float = 100.0
const BOOST_SPEED: float = 200.0
const TURN_SPEED: float = 5.0 

const BOOST_COOLDOWN: float = 3.0 
const BOOST_DRAIN_RATE: float = 2.0
const BOOST_RECHARGE_RATE: float = 4.0

@onready var current_speed: float = 0.0
@onready var turning_speed_coefficent: float = 0.0 

@onready var turn_direction: TurningDirection = TurningDirection.NONE
@onready var boost_state: BoostState = BoostState.NOT_BOOSTING

@onready var recharge_pause_timer = $RechargePauseTimer
@onready var boost_meter = $"../UI/BoostLabel/BoostMeter"

enum TurningDirection
{
	NONE,
	LEFT,
	RIGHT
}

enum BoostState
{
	NOT_BOOSTING,
	BOOSTING,
	RECHARGING
}


func _ready():
	current_speed = NORMAL_SPEED
	boost_meter.value = 100
	recharge_pause_timer.wait_time = BOOST_COOLDOWN
	
func _physics_process(delta):
	input()
	_move()
	_turning(delta)
	


func _boosting():
	match boost_state:
		BoostState.NOT_BOOSTING: 
			current_speed = NORMAL_SPEED
		BoostState.BOOSTING:
			# Apply boost 
			current_speed = BOOST_SPEED
			boost_meter.value -= BOOST_DRAIN_RATE
			# Stop boosting when meter is drained, invoke cooldown
			if boost_meter.value <= 0.0:
				boost_state = BoostState.RECHARGING
				recharge_pause_timer.start()
		BoostState.RECHARGING:
			current_speed = NORMAL_SPEED
			boost_meter.value += BOOST_RECHARGE_RATE

func _move():
	velocity = Vector2(0, 1).rotated(rotation) * current_speed
	move_and_slide()
	
# Made my own input function, will learn about Godot's built in system soon 
func input():
	# Boost input
	if Input.is_action_pressed("boost_forward"):
		boost_state == BoostState.BOOSTING
		
	# Turn input 
	if Input.is_action_pressed("turn_left"):
		turn_direction = TurningDirection.LEFT
	elif Input.is_action_pressed("turn_right"):
		turn_direction = TurningDirection.RIGHT		
	else:
		turn_direction = TurningDirection.NONE	

func _turning(delta):
	if turn_direction == TurningDirection.NONE:
		return
	# Determine turning direction 
	if turn_direction == TurningDirection.LEFT:
		turning_speed_coefficent = -1
	else: 
		turning_speed_coefficent = 1
	# Apply rotation 
	rotate(TURN_SPEED * turning_speed_coefficent * delta)

func _on_obstacle_collision_hitbox_body_entered(body):
	# End the game if the player is hit by a missle 
	if body.name == "Missle":
		%GameManager.is_player_dead = true


func _on_recharge_pause_timer_timeout():
	boost_state = BoostState.NOT_BOOSTING
