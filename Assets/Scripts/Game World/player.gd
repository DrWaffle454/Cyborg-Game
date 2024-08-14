extends CharacterBody2D

const SPEED = 300.0

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	var direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	
	# Normalize the direction to ensure consistent speed in all directions
	if direction != Vector2.ZERO:
		direction = direction.normalized()

	# Apply movement
	velocity.x = direction.x * SPEED
	velocity.y = direction.y * SPEED

	move_and_slide()
