extends Path2D

@onready var missile = preload("res://scenes/missle.tscn")
@onready var path_follow_2d = $PathFollow2D
@export var time_between_spawns = 3.0 
@onready var timer = $Timer


func _ready():
	# Set timer wait time 
	timer.wait_time = time_between_spawns
	

func _spawn_missle():
	# Load missile scene (only done once)
	var missile = preload("res://scenes/missle.tscn").instantiate()
	# Get location from path 
	path_follow_2d.progress_ratio = randf()
	# Set missile position to path position 
	missile.global_position = path_follow_2d.global_position
	# Add missile to scene 
	add_child(missile)
	
func _on_timer_timeout():
	# Spawn missle when time runs out 
	_spawn_missle()
