extends CharacterBody2D

# ~~~~~~~~~~~~~~~~~ #
# The constants: Change variables here, not in later code in script #
const SPEED := 25
var direction = Vector2.ZERO
var movement_timer = 5
# ~~~~~~~~~~~~~~~~~ #

# Variables via children objects
@onready var animated_sprite_2d = $AnimatedSprite2D

@onready var ray_cast_right = $RayCast_right
@onready var ray_cast_left = $RayCast_left
@onready var ray_cast_up = $RayCast_up
@onready var ray_cast_down = $RayCast_down

@onready var timer = $Timer

func _ready():
	set_random_direction()


func _process(delta):
	
	# Faces the right direction and doesn't run into walls
	if ray_cast_right.is_colliding():
		direction.x = -1
		animated_sprite_2d.flip_h = true
	elif ray_cast_left.is_colliding():
		direction.x = 1
		animated_sprite_2d.flip_h = false
	elif ray_cast_down.is_colliding():
		direction.y = 1
	elif ray_cast_up.is_colliding():
		direction.y = -1
		
	direction = direction.normalized()
		
	movement_timer -= delta
	if movement_timer <= 0:
		set_random_direction()
		movement_timer = 5
			
	velocity = direction * SPEED
	if direction.x != 0 or direction.y != 0:
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
	move_and_slide()
	
func _on_timer_timeout():
	pass
	
func set_random_direction():
	var angle = randf() * 2 * PI
	direction = Vector2(cos(angle), sin(angle)).normalized()
