extends Path2D

@onready var missile = preload("res://scenes/missle.tscn")
@onready var missile_path_follow = $MissilePathFollow
@export var time_between_spawns = 3.0 
@onready var missile_timer = $MissileTimer



func _ready():
	# Set timer wait time 
	missile_timer.wait_time = time_between_spawns
	

func _spawn_missle():
	# Load missile scene (only done once)
	var missile = preload("res://scenes/missle.tscn").instantiate()
	# Get location from path 
	missile_path_follow.progress_ratio = randf()
	# Set missile position to path position 
	missile.global_position = missile_path_follow.global_position
	# Add missile to scene 
	add_child(missile)
	
func _on_timer_timeout():
	# Spawn missle when time runs out 
	_spawn_missle()
