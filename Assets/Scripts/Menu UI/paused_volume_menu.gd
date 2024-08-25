extends Control

var is_toggled = false

#Sets the paused_volume_menu to invisible
func _ready():
	$AnimationPlayer.play("RESET")

func paused_volume_menu_open():
	is_toggled = !is_toggled  # Toggle the boolean value
	if is_toggled == true:
		$AnimationPlayer.play("volume_menu")
	else: 
		$AnimationPlayer.play("RESET")
