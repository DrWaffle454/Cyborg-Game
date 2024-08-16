extends Control

func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
func pauseCheck():
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
		resume()

func _on_resume_pressed():
	resume()

func _on_volume_pressed():
	pass # Replace with function body.
	

#Unpauses the game, then changes to main menu scene
func _on_quit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Assets/Scenes/Menu UI/main_menu.tscn")
func _process(delta):
	pauseCheck()
