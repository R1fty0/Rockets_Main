extends Node

@onready var audio_stream_player = $AudioStreamPlayer

func _input(event):
	if event.is_action_pressed("click"):
		audio_stream_player.play()
