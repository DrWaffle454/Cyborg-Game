extends Node

# ~~~~~~~~~~~~~~~~~ #
# The constants: Change variables here, not in later code in script #
const SPEED := 45
var direction_x := 1
var direction_y := 1
# ~~~~~~~~~~~~~~~~~ #

# Variables via children objects
@onready var animated_sprite_2d = $AnimatedSprite2D

@onready var ray_cast_right = $RayCast_right
@onready var ray_cast_left = $RayCast_left
@onready var ray_cast_up = $RayCast_up
@onready var ray_cast_down = $RayCast_down

@onready var timer = $Timer

# Does everything
func _process(delta):
	
	# Faces the right direction and doesn't run into walls
	if ray_cast_right.is_colliding():
		direction_x = -1
		animated_sprite_2d.flip_h = true
	elif ray_cast_left.is_colliding():
		direction_x = 1
		animated_sprite_2d.flip_h = false
	elif ray_cast_down.is_colliding():
		direction_y = 1
	elif ray_cast_up.is_colliding():
		direction_y = -1
		
	# Calls upon the timer to add a delay to calling a function, returns int range [1,2]
	var direction = timer.start()
	# 1 == x, 2 == y #
	
	# if x axis was chosen
	if direction == 1:
		var direction_direction_x = randi_range(-1,1)
		if direction_direction_x == 1:
			animated_sprite_2d.position.x += direction_x * SPEED * delta
		elif direction_direction_x == -1:
			animated_sprite_2d.position.x += (-1) * (direction_x * SPEED * delta)
			
	# if y axis was chosen
	elif direction == 2:
		var direction_direction_y = randi_range(-1,1)
		if direction_direction_y == 1:
			animated_sprite_2d.position.y += direction_y * SPEED * delta
		elif direction_direction_y == -1:
			animated_sprite_2d.position.y += (-1) * (direction_y * SPEED * delta)
	
func _on_timer_timeout():
	# Chooses randomly between x or y
	var ran_direction = randi_range(1,2)
	return ran_direction
