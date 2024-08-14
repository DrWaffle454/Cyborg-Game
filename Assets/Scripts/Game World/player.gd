extends CharacterBody2D

const SPEED = 300.0

@onready var animated_sprite_2d = $AnimatedSprite2D


func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	var direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	
	# Face direction of movement and play correct animations
	if direction.x != 0:
		animated_sprite_2d.play("run")
		if direction.x < 0:
			animated_sprite_2d.flip_h = true
		elif direction.x > 0:
			animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.play("idle")
		
		
	# Normalize the direction to ensure consistent speed in all directions
	if direction != Vector2.ZERO:
		direction = direction.normalized()

	# Apply movement
	velocity.x = direction.x * SPEED
	velocity.y = direction.y * SPEED

	move_and_slide()
