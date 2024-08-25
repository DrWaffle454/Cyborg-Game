extends CharacterBody2D

const SPEED = 60.0

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var walk_sound = $AudioStreamPlayer2D
@onready var scream = $Scream

@onready var scream_sounds = [
	preload("res://Assets/Audio/Sound Effects/World Map/male-scream-81836.mp3"),
	preload("res://Assets/Audio/Sound Effects/World Map/male-scream-in-fear-123079.mp3"),
	preload("res://Assets/Audio/Sound Effects/World Map/wilhelm-1-86895.mp3"),
	preload("res://Assets/Audio/Sound Effects/World Map/male-scream-123080.mp3")
]

var currentHealth: int = 3
const maxHealth: int = 3
var last_scream_index = -1
var is_shooting = false

func _ready():
	# Set pitch_scale to speed up audio (e.g., 1.5 for 50% faster)
	walk_sound.pitch_scale = 1.7
	walk_sound.volume_db += 7.0
	randomize()

func _process(delta):
	if !scream.is_playing() and Input.is_action_pressed("scream"):
		play_random_scream()
	else:
		pass
	if Input.is_action_just_pressed("Shoot"):
		shoot()

func _physics_process(_delta):
	var direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)

	# Only play run or idle animations if not shooting
	if not is_shooting:
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

func shoot():
	is_shooting = true
	animated_sprite_2d.play("shoot")
	await(animated_sprite_2d, "animation_finished")
	is_shooting = false

func take_damage():
	currentHealth -= 1

func heal():
	currentHealth += 1

func die():
	get_tree().change_scene_to_file("res://Assets/Scenes/Menu UI/main_menu.tscn")

# Function to play a random scream sound, avoiding repetition
func play_random_scream():
	var random_index = randi() % scream_sounds.size()
	
	# Ensure the new sound is different from the last one
	while random_index == last_scream_index:
		random_index = randi() % scream_sounds.size()
	
	last_scream_index = random_index
	scream.stream = scream_sounds[random_index]
	scream.play()
