extends CanvasLayer




func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/ship_select.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_settings_pressed():
	pass # Replace with function body.
