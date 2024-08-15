extends Control 

func _ready():
	MainMenuMusic.play_music_level()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Assets/Scenes/Menu UI/main_menu.tscn")
