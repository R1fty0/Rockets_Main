extends CharacterBody2D

@export var speed = 100.0
@export var drag_factor = 2
@onready var player = $"../Player"

var current_velocity = Vector2.ZERO

func _ready():
	current_velocity = speed * Vector2.RIGHT.rotated(rotation).normalized()
	

func _physics_process(delta):
	var direction := Vector2.RIGHT.rotated(rotation).normalized()
	
	if player != null:
		direction = global_position.direction_to(player.global_position)
		
	var desired_velocity = direction * speed
	var previous_velocity = current_velocity
	var change = (desired_velocity - current_velocity) * drag_factor
	current_velocity += change
	velocity = current_velocity
	look_at(global_position + current_velocity)
	move_and_slide()
