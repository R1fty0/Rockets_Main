extends Node

func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ship_select.tscn")
	
func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
