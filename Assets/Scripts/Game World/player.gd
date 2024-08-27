extends CharacterBody2D

const SPEED = 60.0
const SHOOT_ANIMATION_DURATION = 1.0  # The total duration of the shoot animation
const FLIP_DURATION = 0.5  # Duration during which flipping is allowed

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var walk_sound = $AudioStreamPlayer2D
@onready var scream = $Scream
@onready var shoot_timer = $Shooting/shoot_timer  # Assuming shoot_timer is already a node in the scene tree
@onready var flip_timer = $Shooting/flip_timer  # Assuming flip_timer is already a node in the scene tree
@onready var shotgun_noise = $Shooting/ShotgunBlast
var is_shooting = false
var allow_flipping = true

@onready var scream_sounds = [
	preload("res://Assets/Audio/Sound Effects/World Map/male-scream-81836.mp3"),
	preload("res://Assets/Audio/Sound Effects/World Map/male-scream-in-fear-123079.mp3"),
	preload("res://Assets/Audio/Sound Effects/World Map/wilhelm-1-86895.mp3"),
	preload("res://Assets/Audio/Sound Effects/World Map/male-scream-123080.mp3")
]

var currentHealth: int = 3
const maxHealth: int = 3
var last_scream_index = -1

func _ready():
	# Set pitch_scale to speed up audio (e.g., 1.5 for 50% faster)
	walk_sound.pitch_scale = 1.7
	walk_sound.volume_db += 7.0
	randomize()

	# Ensure timers are set to one_shot
	shoot_timer.one_shot = true
	flip_timer.one_shot = true

func _process(delta):
	if !scream.is_playing() and Input.is_action_pressed("scream"):
		play_random_scream()

	if Input.is_action_just_pressed("Shoot"):
		shoot()
		shotgun_noise.play()

func _physics_process(_delta):
	var direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	
	#Manages character model flipping while shooting
	if allow_flipping and direction.x != 0:
		if direction.x < 0:
			animated_sprite_2d.flip_h = true
		elif direction.x > 0:
			animated_sprite_2d.flip_h = false

	if is_shooting == false:
		if direction.x != 0 or direction.y != 0:
			animated_sprite_2d.play("run")
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
	if not is_shooting:
		is_shooting = true
		allow_flipping = true
		animated_sprite_2d.play("shoot")
		
		# Start the flip timer for the first half of the animation
		flip_timer.start(FLIP_DURATION)
		
		# Start the shoot timer for the full duration of the shoot animation
		shoot_timer.start(SHOOT_ANIMATION_DURATION)

func _on_flip_timer_timeout():
	allow_flipping = false

func _on_shoot_timer_timeout():
	is_shooting = false
	allow_flipping = true  # Reset flipping to be allowed for the next shoot

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
