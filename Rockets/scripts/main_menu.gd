extends CanvasLayer


@onready var scene_transition: AnimationPlayer = $SceneTransition

const SHIP_SELECT = preload("res://scenes/ship_select.tscn")

# The scene to be loaded next
var next_scene: PackedScene

# Add setting scene once complete 


func _on_play_pressed():
	print("transition")
	next_scene = SHIP_SELECT
	begin_scene_transition()


func _on_quit_pressed():
	get_tree().quit()


func _on_settings_pressed():
	pass # Replace with function body.
	

func begin_scene_transition():
	scene_transition.play("fade_out")


func _on_scene_transition_animation_finished(anim_name):
	if next_scene != null:
		get_tree().change_scene_to_packed(next_scene)
