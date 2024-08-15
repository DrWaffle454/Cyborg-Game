extends Control

func _ready():
	MainMenuMusic.play_music_level()

#Start Button
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Assets/Scenes/Game World/test_map.tscn")
	MainMenuMusic.stop_music()
	

#Options Button
func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://Assets/Scenes/Menu UI/volume_menu.tscn")
	

#Quit button
func _on_quit_button_pressed():
	get_tree().quit()

