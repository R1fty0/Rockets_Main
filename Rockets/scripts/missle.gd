extends CharacterBody2D 

@export var missile_speed = 200.0
@export var turning_coefficent = 1
@export var lifetime = 15.0
@onready var player = get_node("/root/Game/Player")
@onready var timer = $Timer


func _ready():
	timer.wait_time = lifetime
	if turning_coefficent > 1:
		print("Turning coefficent of missle greater than 1. Expect weird homing behavior!")

func _physics_process(delta):
	if player == null:
		return
	_homing()
	
func _homing():
	rotation = lerp_angle(rotation, position.angle_to_point(player.position) + PI/2, turning_coefficent)
	velocity = position.direction_to(player.position) * missile_speed
	move_and_slide()

func _on_timer_timeout():
	# Destroy missle when timer runs out 
	queue_free()
