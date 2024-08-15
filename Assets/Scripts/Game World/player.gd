extends CharacterBody2D

const SPEED = 60.0

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var walk_sound = $AudioStreamPlayer2D

func _ready():
	# Set pitch_scale to speed up audio (e.g., 1.5 for 50% faster)
	walk_sound.pitch_scale = 1.7
	walk_sound.volume_db += 7.0

func _physics_process(_delta):
	var direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	
	if direction.x != 0 or direction.y != 0:
		animated_sprite_2d.play("run")
		if direction.x < 0:
			animated_sprite_2d.flip_h = true
		elif direction.x > 0:
			animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.play("idle")
		
	if direction != Vector2.ZERO:
		direction = direction.normalized()

	velocity.x = direction.x * SPEED
	velocity.y = direction.y * SPEED

	move_and_slide()

	if direction != Vector2.ZERO:
		if not walk_sound.playing:
			walk_sound.play()
	else:
		if walk_sound.playing:
			walk_sound.stop()
