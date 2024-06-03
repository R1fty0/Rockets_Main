extends Control
class_name Transition 

@export var anim_player: AnimationPlayer

# Might need to change to enter_tree()
func _ready():
	GameManager.scene_changed.connect(play)

func play():
	# Play the beginning of the scene transition. 
	anim_player.play("start")
	# Wait for the beginning of transition to finish before playing the end of the transition. 
	await anim_player.animation_finished
	anim_player.play("end")	
	
