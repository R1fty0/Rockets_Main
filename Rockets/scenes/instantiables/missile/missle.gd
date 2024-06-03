extends CharacterBody2D 

@export var missile_speed = 200.0
@export_range(0.01, 0.5) var turning_coefficent = 0.10
@export var lifetime = 15.0
@onready var player: CharacterBody2D = get_node("/root/Game/Player")
@onready var timer = $Timer
const EXPLOSION = preload("res://scenes/instantiables/explosion.tscn")

func _ready():
	timer.wait_time = lifetime
	if turning_coefficent > 1:
		print("Turning coefficent of missle greater than 1. Expect weird homing behavior!")

func _physics_process(delta):
	if player == null:
		return
	_homing(delta)
	
func _homing(delta):
	rotation = lerp_angle(rotation, position.angle_to_point(player.position) + PI/2, turning_coefficent)
	velocity = position.direction_to(player.position) * missile_speed
	move_and_slide()

func _on_timer_timeout():
	# Destroy missle when timer runs out 
	var explosion = EXPLOSION.instantiate()
	explosion.global_position = global_position
	add_child(explosion)
	explosion.play("boom")
	await explosion.animation_finished
	GameManager.missiles_avoided += 1
	explosion.queue_free()
	queue_free()

func _on_hitbox_area_entered(area):
	var explosion = EXPLOSION.instantiate()
	explosion.global_position = global_position
	add_child(explosion)
	explosion.play("boom")
	await explosion.animation_finished
	explosion.queue_free()
	# Hit a missile. 
	if area.name == "Hitbox":
		GameManager.missiles_avoided += 1
		queue_free()
	# Hit the player. 
	elif area.name == "Hurtbox":
		GameManager.end_game()
		
