extends CanvasLayer
class_name MainMenu


func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/ship_select/ship_select.tscn")
	
func _on_quit_pressed():
	get_tree().quit()


