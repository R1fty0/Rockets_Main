extends Path2D

const MISSLE = preload("res://scenes/instantiables/missile/missle.tscn")
@onready var missile_path_follow = $MissilePathFollow
@export var time_between_spawns = 3.0 
@onready var missile_spawn_timer = $"../MissileSpawnTimer"
@onready var player = $"../../Player"



func _ready():
	# Set timer wait time 
	missile_spawn_timer.wait_time = time_between_spawns
	missile_spawn_timer.timeout.connect(_on_timer_timeout)

func _process(delta):
	global_position = player.global_position
	
func _spawn_missle():
	# Load missile scene 
	var missile = MISSLE.instantiate()
	# Get location from path 
	missile_path_follow.progress_ratio = randf()
	# Set missile position to path position 
	missile.global_position = missile_path_follow.global_position
	# Add missile to scene 
	add_child(missile)
	
func _on_timer_timeout():
	# Spawn missle when time runs out 
	_spawn_missle()
