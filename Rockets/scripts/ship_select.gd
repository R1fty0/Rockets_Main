extends CanvasLayer

@onready var scene_transition = $SceneTransition

# Called when the node enters the scene tree for the first time.
func _ready():
	scene_transition.play("fade_out")


